//
//  FNFileServiceLogic.m
//  FeinnoChunleiSDK
//
//  Created by doujinkun on 15/1/21.
//  Copyright (c) 2015年 feinno. All rights reserved.
//

#import "FNFileServiceLogic.h"

#import "FNServerConfig.h"
#import "FNSystemConfig.h"
#import "FNUserConfig.h"

#import <CommonCrypto/CommonDigest.h>
#import "BOPGDataXMLNode.h"

#import "BOPAFNetWorking.h"
#import "FNMsgArgs.h"
#import "NSData+DataEncrypt.h"
#import "NSString+Extension.h"

#import "FNUploadOperation.h"
#import "NSMutableArray+AddObject.h"

#define FileHashDefaultChunkSizeForReadingData (1024*8) // 求取文件MD5值的块大小
#ifndef FILE_BLOCK_SIZE
#define FILE_BLOCK_SIZE (1024*8*4*2)  // 固定分块的大小64K，服务器建议每次上传4K的整数倍，且不超过64K
#endif

#ifndef FILE_SIZE_BOUNDARY
#define FILE_SIZE_BOUNDARY (FILE_BLOCK_SIZE*30) // 30倍的块大小，超过之后用大文件处理的方式处理
#endif

#define HTTP_TIMEOUT_INTERVAL 60

static NSInteger startIndexOfRange(NSString *range)
{
    NSArray *array = [range componentsSeparatedByString:@"-"];
    return [[array firstObject] integerValue];
}

@interface FNResponseData : NSObject
{
    NSString *range;
    NSData *data;
}

@property (nonatomic, retain) NSString *range;
@property (nonatomic, retain) NSData *data;

@end

@implementation FNResponseData

@synthesize range;
@synthesize data;

- (NSComparisonResult)compareRange:(FNResponseData *)anotherResponseData
{
    return startIndexOfRange(range) <= startIndexOfRange(anotherResponseData.range) ? NSOrderedAscending : NSOrderedDescending;
}

@end


static NSMutableDictionary *fileIdUrlDict;

@interface FNFileServiceLogic ()
{
    id uploadSync;
    id downloadSync;
    
    dispatch_queue_t fileUploadQueue;
    dispatch_queue_t fileDownloadQueue;
    
    NSMutableArray *responsedDatas;
    NSMutableArray *downloadedRanges;
    
    int totalBlockCount;
    int finishedBlockCount;
}

@end

@implementation FNFileServiceLogic


#pragma  mark - 一对多信息文件的上传

- (void)uploadMultiFiles:(FNMultiFileUploadRequest *)uploadFileReq
                callback:(void (^)(FNFileUploadResponse *))mtCallback
{
    if (uploadFileReq.filePath == nil || [uploadFileReq.filePath length] == 0)
    {
        FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:-1 fileInfo:nil errorInfo:@"filePath为空"];
        mtCallback(rsp);
        return;
    }
    FNUploadOperation *operationQueue = [FNUploadOperation shareUploadQueue];
    NSBlockOperation *uploadBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        // 文件服务逻辑
        NSString *md5 = [FNFileServiceLogic getFileMD5WithPath:uploadFileReq.filePath];
        
        [self getMultiCheckResult:NO
                         fileType:uploadFileReq.fileType
                               sp:uploadFileReq.sp
                             ssic:uploadFileReq.ssic
                          targets:uploadFileReq.tids
                              MD5:md5
                         callback:^(FNFileUploadResponse *rspArgs)  {
                             NSLog(@"check file exist completed!");
                             if (404 == rspArgs.statusCode)
                             {
                                 // 移除对应的所有操作及请求头
                                 [operationQueue removeMultiRequestCurrentTime:uploadFileReq];
                                 if ([rspArgs.fileInfo.downloadURL isEqualToString:@""])
                                 {
                                     [self uploadMultiFilesInBlocks:uploadFileReq
                                                                MD5:md5
                                                           callback:mtCallback];
                                     
                                 }
                             }
                             else if (200 == rspArgs.statusCode)
                             {
                                 // 移除对应的所有操作及请求头
                                 [operationQueue removeMultiRequestCurrentTime:uploadFileReq];
                                 NSLog(@"file already exists in server");
                                 
                                 FNSharedFileInfo *fileInfo = rspArgs.fileInfo;
                                 fileInfo.fileId = md5;
                                 fileInfo.filePath = uploadFileReq.filePath;
                                 fileInfo.fileName = uploadFileReq.filePath.lastPathComponent;
                                 fileInfo.fileType = uploadFileReq.filePath.pathExtension;
                                 fileInfo.fileSize = getFileSizeFromPath(uploadFileReq.filePath.UTF8String);
                                 
                                 FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:rspArgs.statusCode fileInfo:fileInfo errorInfo:nil];
                                 mtCallback(rsp);
                             }
                             else
                             {
                                 
                                 FNSharedFileInfo *fileInfo = [[FNSharedFileInfo alloc] init];
                                 fileInfo.fileId = md5;
                                 fileInfo.filePath = uploadFileReq.filePath;
                                 fileInfo.fileName = uploadFileReq.filePath.lastPathComponent;
                                 fileInfo.fileType = uploadFileReq.filePath.pathExtension;
                                 fileInfo.fileSize = getFileSizeFromPath(uploadFileReq.filePath.UTF8String);
                                 
                                 FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:rspArgs.statusCode fileInfo:fileInfo errorInfo:nil];
                                 mtCallback(rsp);
                             }
                         }];
        
        
    }];
    [operationQueue.requestArray addObjectExceptSame:uploadFileReq];
    [operationQueue.callBackArray addObjectExceptSame:mtCallback];
    [operationQueue.uploadServer addObjectExceptSame:self];
    [operationQueue.opetationQueue addOperation:uploadBlockOperation];
}

- (void)uploadMultiFilesInBlocks:(FNMultiFileUploadRequest *)uploadFileReq
                             MD5:(NSString *)md5
                        callback:(void(^)(FNFileUploadResponse *))mtCallback
{
    NSLog(@"start upload file in blocks!");
    NSData *fileData = [NSData dataWithContentsOfFile:uploadFileReq.filePath];
    NSString *fileName = uploadFileReq.fileName;
    NSString *type = uploadFileReq.fileType;
    NSString *sp = uploadFileReq.sp;
    NSArray *tids = uploadFileReq.tids;
    NSString *ssic = uploadFileReq.ssic;
    BOOL resume = NO;
    long fileSize = fileData.length; //getFileSizeFromPath([filePath UTF8String]);
    totalBlockCount = (int)(fileSize / FILE_BLOCK_SIZE + 1);
    finishedBlockCount = 0;
    
    NSString *uploadUrlStr = getMultiUploadUri(fileSize, type, sp, tids, fileName, md5);
    long nextStartPos = 0L;
    
    // 留作断点续传的扩展
    if (resume)
    {
        NSString *cache = [FNFileServiceLogic getFileUploadRecord:md5];
        if (cache)
        {
            nextStartPos = cache.length;
            [FNFileServiceLogic deleteFileUploadRecord:md5];
        }
    }
    
    __block NSString *downloadUrlStr = nil;
    if (!fileData)
    {
        FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:-1 fileInfo:nil errorInfo:@"上传文件为空"];
        mtCallback(rsp);
        return;
    }
    
    while (nextStartPos < fileSize)
    {
        if (resume)
        { //断点续传, 待完善
            [self getMultiCheckResult:resume
                             fileType:type
                                   sp:sp
                                 ssic:ssic
                              targets:tids
                                  MD5:md5
                             callback:^(FNFileUploadResponse *rspArgs){
                                 downloadUrlStr = rspArgs.fileInfo.downloadURL;
                                 [FNFileServiceLogic cacheFileUploadRecord:md5
                                                         nextStartPosition:nextStartPos
                                                                 uploadUrl:uploadUrlStr
                                                               downloadUrl:downloadUrlStr];
                             }];
            break;
        }
        
        long endPosition = (nextStartPos + FILE_BLOCK_SIZE <= fileSize ? (nextStartPos + FILE_BLOCK_SIZE) : fileSize) - 1;
        NSString *blockUploadUrlStr = [FNFileServiceLogic getBlockUploadUrl:uploadUrlStr rangeStart:nextStartPos rangeEnd:endPosition + 1];
        
        NSData *sentData = [fileData subdataWithRange:NSMakeRange(nextStartPos, endPosition - nextStartPos + 1)];
        
        [self getMultiUploadResult:blockUploadUrlStr
                              ssic:ssic
                       contentType:type
                          fileSize:fileSize
                          sentData:sentData
                          fileName:fileName
                              tids:tids
                          callback:mtCallback];
        
        
        nextStartPos = endPosition + 1;
        
        if (nextStartPos >= fileSize)
        {
            NSLog(@"upload completed!");
        }
        else if (resume)
        { // 断点续传
            [FNFileServiceLogic cacheFileUploadRecord:md5 nextStartPosition:endPosition uploadUrl:uploadUrlStr downloadUrl:downloadUrlStr];
        }
    }
}

- (void)getMultiUploadResult:(NSString *)urlStr
                        ssic:(NSString *)ssic
                 contentType:(NSString *)contentType
                    fileSize:(long)size
                    sentData:(NSData *)data
                    fileName:(NSString *)fileName
                        tids:(NSArray *)tids
                    callback:(void(^)(FNFileUploadResponse *))mtCallback
{
    //这一部分代码可以抽出来，提高传大文件的效率
    if (fileIdUrlDict == nil)
    {
        fileIdUrlDict = [[NSMutableDictionary alloc] init];
    }
    
    if (data && [data length] > 0)
    {
        NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // use BOPAFHTTPRequestOperation
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        [req setHTTPBody:data];
        [req setHTTPMethod:@"POST"];
        [req setTimeoutInterval:HTTP_TIMEOUT_INTERVAL];
        
        [req setValue:[NSString stringWithFormat:@"iOS %@", [FNSystemConfig getVersion]] forHTTPHeaderField:@"x-feinno-agent"];
        [req setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
        [req setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        
        NSDictionary *cookieInfo = @{NSHTTPCookiePath:url.path, NSHTTPCookieName:@"ssic",NSHTTPCookieValue:ssic, NSHTTPCookieDomain:url.host};
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        [cookieStorage setCookie:cookie];
        
        BOPAFHTTPRequestOperation *op = [[BOPAFHTTPRequestOperation alloc] initWithRequest:req];
        op.completionQueue = fileUploadQueue;
        
        [op setCompletionBlockWithSuccess:^(BOPAFHTTPRequestOperation *operation, id responseObject) {
            @synchronized(uploadSync) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                int statusCode = (int)httpResponse.statusCode;
                NSError *err = [[NSError alloc] init];
                BOPGDataXMLDocument *doc = [[BOPGDataXMLDocument alloc] initWithData:operation.responseData
                                                                             options:0
                                                                               error:&err];
                BOPGDataXMLElement *root = doc.rootElement;
                
                if (200 == statusCode)
                {
                    ++finishedBlockCount;
                    NSLog(@"\nfile : %@\nupload count: %d", fileName, finishedBlockCount);
                    
                    NSString *errorInfo = nil;
                    FNSharedFileInfo *fileInfo = nil;
                    
                    NSArray *files = [root elementsForName:@"file"];
                    if (1 == files.count)
                    {
                        NSString *fileId = [[[files firstObject] attributeForName:@"id"] stringValue];
                        NSString *downloadURL = [[[files firstObject] attributeForName:@"url"] stringValue];
                        if (![NSString isNullString:fileId] && ![NSString isNullString:downloadURL])
                        {
                            [fileIdUrlDict setObject:downloadURL forKey:fileId];
                        }
                        if (finishedBlockCount == totalBlockCount)
                        {
                            fileInfo = [[FNSharedFileInfo alloc] init];
                            fileInfo.fileId = fileId;
                            fileInfo.downloadURL = [fileIdUrlDict objectForKey:fileId];
                            //                            fileInfo.filePath = filePath;
                            fileInfo.fileName = fileName;
                            fileInfo.fileType = [fileName pathExtension]; //TODO: 改类型
                            fileInfo.fileSize = size;
                            
                            FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:statusCode fileInfo:fileInfo errorInfo:errorInfo];
                            // 主线程回调
                            mtCallback(rsp);
                        }
                    }
                    else
                    {
                        NSLog(@"parse HTTP response error, upload failed in progress!");
                        errorInfo = @"解析HTTP应答出错，上传文件过程中失败!";
                        FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:statusCode fileInfo:fileInfo errorInfo:errorInfo];
                        // 主线程回调
                        mtCallback(rsp);
                    }
                }
                else if (250 == statusCode)
                {
                    BOPGDataXMLNode *rootNode = [root attributeForName:@"resultcode"];
                    int resultCode = [[rootNode stringValue] intValue];
                    
                    NSString *errorInfo = nil;
                    switch (resultCode)
                    {
                        case 250:
                            NSLog(@"upload file failed!");
                            errorInfo = @"返回码：250, 上传文件失败";
                            break;
                        case 400:
                            NSLog(@"upload bad format request!");
                            errorInfo = @"返回码：400, 请求格式错误";
                            break;
                        case 401:
                            NSLog(@"upload credential error!");
                            errorInfo = @"返回码：401, 文件凭证错误";
                            break;
                        case 404:
                            NSLog(@"upload invalid URL request!");
                            errorInfo = @"返回码：404, 不合法的URL请求";
                            break;
                        case 500:
                            NSLog(@"upload server inner error!");
                            errorInfo = @"返回码：500, 服务器内部错误";
                            break;
                        default:
                            errorInfo = @"上传文件失败";
                            break;
                    }
                    
                    FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:resultCode fileInfo:nil errorInfo:errorInfo];
                    mtCallback(rsp);
                }
            }
        }
                                  failure:^(BOPAFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"post file data in block error: %@", error);
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                                      int32_t statusCode = (int32_t)httpResponse.statusCode;
                                      FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:statusCode fileInfo:nil errorInfo:[error description]];
                                      mtCallback(rsp);
                                      
                                  }];
        
        [op start];
        
    }
}

- (void)getMultiCheckResult:(BOOL)resume
                   fileType:(NSString *)type
                         sp:(NSString *)sp
                       ssic:(NSString *)ssic
                    targets:(NSArray *)targets
                        MD5:(NSString *)md5
                   callback:(void (^)(FNFileUploadResponse *))callback
{
    NSString *urlStr = [[self getMultiCheckFileExistUri:type sp:sp tids:targets MD5:md5] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    BOPAFHTTPRequestOperationManager *manager = [[BOPAFHTTPRequestOperationManager alloc] init];
    [[manager requestSerializer] setValue:[NSString stringWithFormat:@"iOS %@", [FNSystemConfig getVersion]] forHTTPHeaderField:@"x-feinno-agent"];
    [[manager requestSerializer] setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [[manager requestSerializer] setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    
    NSDictionary *cookieInfo = @{NSHTTPCookiePath:url.path,
                                 NSHTTPCookieName:@"ssic",
                                 NSHTTPCookieValue:ssic,
                                 NSHTTPCookieDomain:url.host};
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookie:cookie];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [BOPAFHTTPResponseSerializer serializer];
    
    // 请求
    [manager GET:urlStr parameters:nil success: ^(BOPAFHTTPRequestOperation *operation, id responseObject) {
        NSError *err = [[NSError alloc] init];
        BOPGDataXMLDocument *doc = [[BOPGDataXMLDocument alloc] initWithData:operation.responseData options:0 error:&err];
        BOPGDataXMLElement *root = doc.rootElement;
        BOPGDataXMLNode *rootNode = [root attributeForName:@"resultcode"];
        FNSharedFileInfo *fileInfo = [[FNSharedFileInfo alloc]init];
        
        int32_t statusCode = [[rootNode stringValue] intValue];
        NSString *error = nil;
        switch (statusCode)
        {
            case 200:
            {
                NSLog(@"file already exists!");
                NSArray *files = [root elementsForName:@"file"];
                if (1 == files.count)
                {
                    NSString *downloadURL = [[files[0] attributeForName:@"downloadurl"] stringValue];
                    fileInfo.downloadURL = downloadURL;
                }
                else
                {
                    error = @"parse error!";
                    NSLog(@"parse error!");
                }
                break;
            }
            case 404:
                NSLog(@"need to send file!");
                fileInfo.downloadURL = @"";
                break;
            case 400:
                error = @"check request format error!";
                NSLog(@"request format error!");
                break;
            case 401:
                error = @"check Credential error!";
                NSLog(@"Credential error!");
                break;
            case 500:
                error = @"check server inner error!";
                NSLog(@"server inner error!");
                break;
            default:
                break;
        }
        
        FNFileUploadResponse *rspArgs = [[FNFileUploadResponse alloc]initWithRspArgs:statusCode fileInfo:fileInfo errorInfo:error];
        
        callback(rspArgs);
    }
         failure: ^(BOPAFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"get check result error: %@", error);
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
             int32_t statusCode = (int32_t)httpResponse.statusCode;
             
             FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:statusCode fileInfo:nil errorInfo:[error description]];
             callback(rsp);
         }];
}


- (NSString *)getMultiCheckFileExistUri:(NSString *)type
                                     sp:(NSString *)sp
                                   tids:(NSArray *)tids
                                    MD5:(NSString *)md5
{
    NSString *checkUrl = [[FNServerConfig getInstance].fileServiceAddress stringByAppendingString:@"CheckFileExist"];
    NSString *uri = [NSString stringWithFormat:@"%@?MD5=%@&type=%@&sp=%@&tids=%@", checkUrl, md5, type, sp, tids];
    
    return uri;
}

NSString *getMultiUploadUri(long fileSize, NSString *type, NSString *sp, NSArray *tids, NSString *fileName, NSString *md5)
{
    NSString *uploadUrl = [[FNServerConfig getInstance].fileServiceAddress stringByAppendingString:@"blockupload"];
    NSString *uri = [NSString stringWithFormat:@"%@?id=%@&filesize=%ld&type=%@&sp=%@&tids=%@", uploadUrl, md5, fileSize, type, sp, tids];
    
    // 当为上传共享文件时要填写文件名fileName
    if ([type isEqualToString:@"FILE"])
    {
        uri = [NSString stringWithFormat:@"%@&filename=%@", uri, fileName];
    }
    
    return uri;
}



#pragma mark  一对一 信息文件的上传

- (void)uploadFile:(FNFileUploadRequest *)uploadFileReq
          callback:(void (^)(FNFileUploadResponse *))mtCallback
{
    if (uploadFileReq.filePath == nil || [uploadFileReq.filePath length] == 0)
    {
        FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:-1 fileInfo:nil errorInfo:@"filePath为空"];
        mtCallback(rsp);
        return;
    }
    FNUploadOperation *operationQueue = [FNUploadOperation shareUploadQueue];
    NSBlockOperation *uploadBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        // 文件服务逻辑
        NSString *md5 = [FNFileServiceLogic getFileMD5WithPath:uploadFileReq.filePath];
        
        [self getCheckResult:NO
                    fileType:uploadFileReq.fileType
                          sp:uploadFileReq.sp
                        ssic:uploadFileReq.ssic
                      target:uploadFileReq.tid
                         MD5:md5
                    callback:^(FNFileUploadResponse *rspArgs) {
                        NSLog(@"check file exist completed!");
                        if (404 == rspArgs.statusCode)
                        {
                            // 移除对应的所有操作及请求头
                            [operationQueue removeRequestCurrentTime:uploadFileReq];
                            if ([rspArgs.fileInfo.downloadURL isEqualToString:@""])
                            {
                                //真正的实现上传
                                [self uploadFileInBlocks:uploadFileReq
                                                     MD5:md5
                                                callback:mtCallback];
                            }
                        }
                        else if (200 == rspArgs.statusCode)
                        {
                            
                            // 移除对应的所有操作及请求头
                            [operationQueue removeRequestCurrentTime:uploadFileReq];
                            NSLog(@"file already exists in server");
                            
                            // 文件上传响应的fileInfo
                            FNSharedFileInfo *fileInfo = rspArgs.fileInfo;
                            fileInfo.fileId = md5;
                            fileInfo.filePath = uploadFileReq.filePath;
                            fileInfo.fileName = uploadFileReq.fileType;
                            fileInfo.fileType = uploadFileReq.filePath.pathExtension;
                            fileInfo.fileSize = getFileSizeFromPath(uploadFileReq.filePath.UTF8String);
                            fileInfo.source = uploadFileReq.tid;
                            
                            FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:rspArgs.statusCode fileInfo:fileInfo errorInfo:nil];
                            
                            
                            NSDictionary *dataInfo = [[NSDictionary alloc] initWithObjectsAndKeys:uploadFileReq.msgId,@"msgId",fileInfo.filePath,@"filePath",uploadFileReq.fileType,@"contentType",[NSString stringWithFormat:@"%ld",fileInfo.fileSize],@"fileSize",@"1",@"finishedBlockCount",@"1",@"totalBlockCount",fileInfo.fileName,@"fileName",fileInfo.source,@"tid",nil];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadResult" object:dataInfo];
                            
                            mtCallback(rsp);
                        }
                        
                        //                        else if(rspArgs.statusCode==504)//假如504是请求超时
                        //                        {
                        //                            // TCP/IP 协议大文件自动分包传送,服务端拼包,出现保丢失拼包失败舍弃整个包,返回code,标注发送失败
                        //                            //重新发送请求
                        //                            [self uploadFile:uploadFileReq callback:mtCallback];
                        //                        }
                        else
                        {
                            FNSharedFileInfo *fileInfo = [[FNSharedFileInfo alloc] init];
                            fileInfo.fileId = md5;
                            fileInfo.filePath = uploadFileReq.filePath;
                            fileInfo.fileName = uploadFileReq.filePath.lastPathComponent;
                            fileInfo.fileType = uploadFileReq.filePath.pathExtension;
                            fileInfo.fileSize = getFileSizeFromPath(uploadFileReq.filePath.UTF8String);
                            fileInfo.source = uploadFileReq.tid;
                            
                            FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:rspArgs.statusCode fileInfo:fileInfo errorInfo:nil];
                            mtCallback(rsp);
                        }
                        
                    }];
        
    }];
    
    [operationQueue.requestArray addObjectExceptSame:uploadFileReq];
    [operationQueue.callBackArray addObjectExceptSame:mtCallback];
    [operationQueue.uploadServer addObjectExceptSame:self];
    [operationQueue.opetationQueue addOperation:uploadBlockOperation];
}

- (void)uploadFileInBlocks:(FNFileUploadRequest *)uploadFileReq
                       MD5:(NSString *)md5
                  callback:(void(^)(FNFileUploadResponse *))mtCallback
{
    NSLog(@"start upload file in blocks!");
    NSData *fileData = [NSData dataWithContentsOfFile:uploadFileReq.filePath];
    NSString *fileName = uploadFileReq.filePath.lastPathComponent;
    NSString *filePath = uploadFileReq.filePath;
    NSString *msgId = uploadFileReq.msgId;
    NSString *type = uploadFileReq.fileType;//uploadFileReq.filePath.pathExtension;
    NSString *sp = uploadFileReq.sp;
    NSString *tid = uploadFileReq.tid;
    NSString *ssic = uploadFileReq.ssic;
    BOOL resume = NO;
    long fileSize = fileData.length; //getFileSizeFromPath([filePath UTF8String]);
    
    totalBlockCount = (int)(fileSize / FILE_BLOCK_SIZE + 1);
    finishedBlockCount = 0;
    
    NSString *uploadUrlStr = getUploadUri(fileSize, type, sp, tid, fileName, md5);
    long nextStartPos = 0L;
    
    // 留作断点续传的扩展
    if (resume)
    {
        NSString *cache = [FNFileServiceLogic getFileUploadRecord:md5];
        if (cache)
        {
            nextStartPos = cache.length;
            [FNFileServiceLogic deleteFileUploadRecord:md5];
        }
    }
    
    __block NSString *downloadUrlStr = nil;
    
    if (!fileData)
    {
        FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:-1 fileInfo:nil errorInfo:@"上传文件为空"];
        mtCallback(rsp);
        return;
    }
    
    while (nextStartPos < fileSize)
    {
        if (resume)
        { //断点续传, 待完善
            [self getCheckResult:resume
                        fileType:type
                              sp:sp
                            ssic:ssic
                          target:tid
                             MD5:md5
                        callback:^(FNFileUploadResponse *rspArgs) {
                            downloadUrlStr = rspArgs.fileInfo.downloadURL;
                            [FNFileServiceLogic cacheFileUploadRecord:md5 nextStartPosition:nextStartPos uploadUrl:uploadUrlStr downloadUrl:downloadUrlStr];
                        }];
            //            }
            break;
        }
        
        long endPosition = (nextStartPos + FILE_BLOCK_SIZE <= fileSize ? (nextStartPos + FILE_BLOCK_SIZE) : fileSize) - 1;
        NSString *blockUploadUrlStr = [FNFileServiceLogic getBlockUploadUrl:uploadUrlStr rangeStart:nextStartPos rangeEnd:endPosition + 1];
        
        NSData *sentData = [fileData subdataWithRange:NSMakeRange(nextStartPos, endPosition - nextStartPos + 1)];
        
        [self getUploadResult:blockUploadUrlStr
                         ssic:ssic
                  contentType:type
                     fileSize:fileSize
                     filePath:filePath
                        msgId:msgId
                     sentData:sentData
                     fileName:fileName
                          tid:tid
                     callback:mtCallback];
        
        nextStartPos = endPosition + 1;
        
        if (nextStartPos >= fileSize)
        {
            NSLog(@"upload completed!");
        }
        else if (resume)
        { // 断点续传
            [FNFileServiceLogic cacheFileUploadRecord:md5 nextStartPosition:endPosition uploadUrl:uploadUrlStr downloadUrl:downloadUrlStr];
        }
    }
}


- (void)getUploadResult:(NSString *)urlStr
                   ssic:(NSString *)ssic
            contentType:(NSString *)contentType
               fileSize:(long)size
               filePath:(NSString *)filePath
                  msgId:(NSString *)msgId
               sentData:(NSData *)data
               fileName:(NSString *)fileName
                    tid:(NSString *)tid
               callback:(void(^)(FNFileUploadResponse *))mtCallback
{
    //这一部分代码可以抽出来，提高传大文件的效率
    if (fileIdUrlDict == nil)
    {
        fileIdUrlDict = [[NSMutableDictionary alloc] init];
    }
    
    if (data && [data length] > 0)
    {
        NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // use BOPAFHTTPRequestOperation
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        [req setHTTPBody:data];
        [req setHTTPMethod:@"POST"];
        // 设置超时时长
        [req setTimeoutInterval:HTTP_TIMEOUT_INTERVAL];
        
        [req setValue:[NSString stringWithFormat:@"iOS %@", [FNSystemConfig getVersion]] forHTTPHeaderField:@"x-feinno-agent"];
        [req setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
        [req setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        
        // BOPAFN can not set cookie manually
        NSDictionary *cookieInfo = @{NSHTTPCookiePath:url.path, NSHTTPCookieName:@"ssic",NSHTTPCookieValue:ssic, NSHTTPCookieDomain:url.host};
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        [cookieStorage setCookie:cookie];
        
        BOPAFHTTPRequestOperation *op = [[BOPAFHTTPRequestOperation alloc] initWithRequest:req];
        op.completionQueue = fileUploadQueue;
        
        [op setCompletionBlockWithSuccess:^(BOPAFHTTPRequestOperation *operation, id responseObject) {
            @synchronized(uploadSync) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                int statusCode = (int)httpResponse.statusCode;
                NSError *err = [[NSError alloc] init];
                BOPGDataXMLDocument *doc = [[BOPGDataXMLDocument alloc] initWithData:operation.responseData
                                                                             options:0
                                                                               error:&err];
                BOPGDataXMLElement *root = doc.rootElement;
                
                if (200 == statusCode)
                {
                    ++finishedBlockCount;
                    NSLog(@"\nfile : %@\nupload count: %d", fileName, finishedBlockCount);
                    
                    //业务层需求
                    NSDictionary *dataInfo = [[NSDictionary alloc] initWithObjectsAndKeys:contentType,@"contentType",msgId,@"msgId",filePath,@"filePath",[NSString stringWithFormat:@"%ld",size],@"fileSize",[NSString stringWithFormat:@"%d",finishedBlockCount],@"finishedBlockCount",[NSString stringWithFormat:@"%d",totalBlockCount],@"totalBlockCount",fileName,@"fileName",tid,@"tid",nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadResult" object:dataInfo];
                    
                    NSString *errorInfo = nil;
                    FNSharedFileInfo *fileInfo = nil;
                    
                    NSArray *files = [root elementsForName:@"file"];
                    if (1 == files.count)
                    {
                        NSString *fileId = [[[files firstObject] attributeForName:@"id"] stringValue];
                        NSString *downloadURL = [[[files firstObject] attributeForName:@"url"] stringValue];
                        if (![NSString isNullString:fileId] && ![NSString isNullString:downloadURL])
                        {
                            [fileIdUrlDict setObject:downloadURL forKey:fileId];
                        }
                        if (finishedBlockCount == totalBlockCount)
                        {
                            fileInfo = [[FNSharedFileInfo alloc] init];
                            fileInfo.fileId = fileId;
                            fileInfo.downloadURL = [fileIdUrlDict objectForKey:fileId];
                            //                            fileInfo.filePath = filePath;
                            fileInfo.fileName = fileName;
                            fileInfo.fileType = [fileName pathExtension]; //TODO: 改类型
                            fileInfo.fileSize = size;
                            //                            source = tid;
                            
                            FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:statusCode fileInfo:fileInfo errorInfo:errorInfo];
                            // 主线程回调
                            mtCallback(rsp);
                        }
                    }
                    else
                    {
                        NSLog(@"parse HTTP response error, upload failed in progress!");
                        errorInfo = @"解析HTTP应答出错，上传文件过程中失败!";
                        FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:statusCode fileInfo:fileInfo errorInfo:errorInfo];
                        // 主线程回调
                        mtCallback(rsp);
                    }
                }
                else if (250 == statusCode)
                {
                    BOPGDataXMLNode *rootNode = [root attributeForName:@"resultcode"];
                    int resultCode = [[rootNode stringValue] intValue];
                    
                    NSString *errorInfo = nil;
                    switch (resultCode)
                    {
                        case 250:
                            NSLog(@"upload file failed!");
                            errorInfo = @"返回码：250, 上传文件失败";
                            break;
                        case 400:
                            NSLog(@"upload bad format request!");
                            errorInfo = @"返回码：400, 请求格式错误";
                            break;
                        case 401:
                            NSLog(@"upload credential error!");
                            errorInfo = @"返回码：401, 文件凭证错误";
                            break;
                        case 404:
                            NSLog(@"upload invalid URL request!");
                            errorInfo = @"返回码：404, 不合法的URL请求";
                            break;
                        case 500:
                            NSLog(@"upload server inner error!");
                            errorInfo = @"返回码：500, 服务器内部错误";
                            break;
                        default:
                            errorInfo = @"上传文件失败";
                            break;
                    }
                    
                    FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:resultCode fileInfo:nil errorInfo:errorInfo];
                    mtCallback(rsp);
                }
            }
        }
                                  failure:^(BOPAFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"post file data in block error: %@", error);
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                                      int32_t statusCode = (int32_t)httpResponse.statusCode;
                                      FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:statusCode fileInfo:nil errorInfo:[error description]];
                                      mtCallback(rsp);
                                  }];
        
        [op start];
        
    }
}


- (void)getCheckResult:(BOOL)resume
              fileType:(NSString *)type
                    sp:(NSString *)sp
                  ssic:(NSString *)ssic
                target:(NSString *)target
                   MD5:(NSString *)md5
              callback:(void (^)(FNFileUploadResponse *))callback
{
    NSString *urlStr = [[self getCheckFileExistUri:type sp:sp tid:target MD5:md5] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    BOPAFHTTPRequestOperationManager *manager = [[BOPAFHTTPRequestOperationManager alloc] init];
    // request-header fields 允许客户端传递关于request和客户端的附加信息到服务端，
    [[manager requestSerializer] setValue:[NSString stringWithFormat:@"iOS %@", [FNSystemConfig getVersion]] forHTTPHeaderField:@"x-feinno-agent"];
    [[manager requestSerializer] setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [[manager requestSerializer] setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    
    NSDictionary *cookieInfo = @{NSHTTPCookiePath:url.path,
                                 NSHTTPCookieName:@"ssic",
                                 NSHTTPCookieValue:ssic,
                                 NSHTTPCookieDomain:url.host};
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookie:cookie];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [BOPAFHTTPResponseSerializer serializer];
    
    // get 请求就可以
    [manager GET:urlStr parameters:nil success: ^(BOPAFHTTPRequestOperation *operation, id responseObject) {
        NSError *err = [[NSError alloc] init];
        // 返回类型是xml
        BOPGDataXMLDocument *doc = [[BOPGDataXMLDocument alloc] initWithData:operation.responseData options:0 error:&err];
        BOPGDataXMLElement *root = doc.rootElement;
        BOPGDataXMLNode *rootNode = [root attributeForName:@"resultcode"];
        
        FNSharedFileInfo *fileInfo = [[FNSharedFileInfo alloc] init];
        
        int32_t statusCode = [[rootNode stringValue] intValue];
        NSString *error = nil;
        switch (statusCode)
        {
            case 200:
            {
                // 每次都是一个文件,
                NSLog(@"file already exists!");
                NSArray *files = [root elementsForName:@"file"];
                if (1 == files.count)
                {
                    //
                    NSString *downloadURL = [[files[0] attributeForName:@"downloadurl"] stringValue];
                    fileInfo.downloadURL = downloadURL;
                }
                else
                {
                    error = @"parse error!";
                    NSLog(@"parse error!");
                }
                break;
            }
            case 404:
                NSLog(@"need to send file!");
                fileInfo.downloadURL = @"";
                break;
            case 400:
                error = @"check request format error!";
                NSLog(@"request format error!");
                break;
            case 401:
                error = @"check Credential error!";
                NSLog(@"Credential error!");
                break;
            case 500:
                error = @"check server inner error!";
                NSLog(@"server inner error!");
                break;
            default:
                break;
        }
        // callback
        
        FNFileUploadResponse *rspArgs = [[FNFileUploadResponse alloc] initWithRspArgs:statusCode fileInfo:fileInfo errorInfo:error];
        callback(rspArgs);
    }
         failure: ^(BOPAFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"get check result error: %@", error);
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
             int32_t statusCode = (int32_t)httpResponse.statusCode;
             FNFileUploadResponse *rsp = [[FNFileUploadResponse alloc] initWithRspArgs:statusCode fileInfo:nil errorInfo:[error description]];
             callback(rsp);
         }];
}


#pragma mark -
#pragma mark 下载

- (void)downloadFile:(FNFileDownloadRequest *)fileRequest
            callback:(void(^)(FNFileDownloadResponse *))mtCallback
{
    FNSharedFileInfo *fileInfo = fileRequest.fileInfo;
    NSString *ssic = fileRequest.credential;
    
    fileDownloadQueue = dispatch_queue_create("bop_file_download", NULL);
    dispatch_async(fileDownloadQueue, ^{
        NSString *filePath = [[FNUserConfig getInstance].filePath stringByAppendingPathComponent:fileInfo.fileName.lastPathComponent];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            fileRequest.fileInfo.filePath = filePath;
            FNFileDownloadResponse *rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:200 fileInfo:fileRequest.fileInfo errorInfo:nil];
            mtCallback(rsp);
            return;
        }
        
        totalBlockCount = (int)(fileInfo.fileSize / FILE_BLOCK_SIZE + 1);
        finishedBlockCount = 0;
        
        __block long startPos = 0L;
        __block long endPos = (fileInfo.fileSize < FILE_BLOCK_SIZE ? fileInfo.fileSize : FILE_BLOCK_SIZE) - 1;
        __block int statusCode = 0;
        
        // 先默认使用CMC路径
        NSString *downloadUrl = [[[fileInfo.downloadURL componentsSeparatedByString:@";"] firstObject] componentsSeparatedByString:@"|"][1];
        NSURL *url = [NSURL URLWithString:[downloadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"fileservice download url : %@", url);
        
        while (startPos < endPos && endPos < fileInfo.fileSize)
        {
            NSString *tmpUrl = [FNFileServiceLogic getBlockDownloadUrl:downloadUrl
                                                            rangeStart:startPos
                                                              rangeEnd:endPos +1];
            BOPAFHTTPRequestOperationManager *manager = [[BOPAFHTTPRequestOperationManager alloc] init];
            // 设置cookie
            NSDictionary *cookieInfo = @{NSHTTPCookiePath:url.path,
                                         NSHTTPCookieName:@"ssic",
                                         NSHTTPCookieValue:ssic,
                                         NSHTTPCookieDomain:url.host};
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            [cookieStorage setCookie:cookie];
            // 设置timeout
            // 请求超时
            // 读超时
            
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            manager.responseSerializer = BOPAFHTTPResponseSerializer.serializer;
            manager.completionQueue = fileDownloadQueue;
            
            // 请求
            [manager GET:tmpUrl parameters:nil success: ^(BOPAFHTTPRequestOperation *operation, id responseObject) {
                @synchronized(downloadSync) {
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                    statusCode = (int)httpResponse.statusCode;
                    if (200 == statusCode && operation.responseData.length)
                    {
                        ++finishedBlockCount;
                        NSLog(@"\nfile : %@\ndownload count: %d", fileRequest.fileInfo.fileName, finishedBlockCount);
                        NSString *range = [[httpResponse allHeaderFields] objectForKey:@"x-feinno-range"];
                        
                        [self downloadHandler:totalBlockCount
                                    blockData:operation.responseData
                                    fileRange:range
                                     filePath:filePath];
                        if (finishedBlockCount >= totalBlockCount)
                        {
                            NSLog(@"write data to file to complete download!");
                            // 主线程回调
                            fileRequest.fileInfo.filePath = filePath;
                            FNFileDownloadResponse *rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:statusCode fileInfo:fileRequest.fileInfo errorInfo:nil];
                            mtCallback(rsp);
                            return;
                        }
                    }
                    else if (250 == statusCode)
                    {
                        NSError *err = [[NSError alloc] init];
                        BOPGDataXMLDocument *doc = [[BOPGDataXMLDocument alloc] initWithData:operation.responseData options:0 error:&err];
                        BOPGDataXMLElement *root = doc.rootElement;
                        BOPGDataXMLNode *rootNode = [root attributeForName:@"resultcode"];
                        
                        int resultCode = [[rootNode stringValue] intValue];
                        NSString *errorInfo = nil;
                        switch (resultCode)
                        {
                            case 404:
                                NSLog(@"download thumb invalid url or file expired!");
                                errorInfo = @"URL不合法或者文件已过期！";
                                break;
                            case 400:
                                NSLog(@"download thumb request format error!");
                                errorInfo = @"请求格式错误!";
                                break;
                            case 401:
                                NSLog(@"download thumb Credential error!");
                                errorInfo = @"文件凭证错误！";
                                break;
                            case 500:
                                NSLog(@"download thumb server inner error!");
                                errorInfo = @"服务器内部错误！";
                                break;
                            default:
                                break;
                        }
                        
                        // 主线程回调
                        FNFileDownloadResponse *rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:resultCode fileInfo:nil errorInfo:errorInfo];
                        mtCallback(rsp);
                        return;
                    }
                }
            }
                 failure: ^(BOPAFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"downloadFile error: %@", error);
                     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                     int32_t statusCode = (int32_t)httpResponse.statusCode;
                     FNFileDownloadResponse *rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:statusCode fileInfo:nil errorInfo:[error description]];
                     mtCallback(rsp);
                 }];
            
            startPos = endPos + 1;
            endPos = (startPos + FILE_BLOCK_SIZE <= fileInfo.fileSize ? startPos + FILE_BLOCK_SIZE : fileInfo.fileSize) - 1;
        }
    });
}

- (void)downloadFileThumb:(FNFileDownloadRequest *)fileRequest
                 callback:(void(^)(FNFileDownloadResponse *))mtCallback
{
    FNSharedFileInfo *fileInfo = fileRequest.fileInfo;
    NSString *ssic = fileRequest.credential;
    
    fileDownloadQueue = dispatch_queue_create("bop_file_download", NULL);
    dispatch_async(fileDownloadQueue, ^{
        NSString *filePath = [[FNUserConfig getInstance].thumbPath stringByAppendingPathComponent:(fileInfo.fileName ? fileInfo.fileName : fileInfo.fileId)];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            fileRequest.fileInfo.filePath = filePath;
            FNFileDownloadResponse *rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:200 fileInfo:fileRequest.fileInfo errorInfo:nil];
            mtCallback(rsp);
            return;
        }
        
        NSMutableData *bytes = [[NSMutableData alloc] init];
        
        __block int32_t statusCode = 0;
        
        BOPAFHTTPRequestOperationManager *manager = [[BOPAFHTTPRequestOperationManager alloc] init];
        // 设置cookie
        NSString *downloadUrl = [[[[fileInfo.downloadURL componentsSeparatedByString:@";"] firstObject] componentsSeparatedByString:@"|"][1] stringByAppendingString:@"&thumb=thumb-strong"]; //thumb-weak
        
        NSURL *url = [NSURL URLWithString:[downloadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"fileservice download thumb url : %@", url);
        
        NSDictionary *cookieInfo = @{NSHTTPCookiePath:url.path, NSHTTPCookieName:@"ssic",NSHTTPCookieValue:ssic, NSHTTPCookieDomain:url.host};
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        [cookieStorage setCookie:cookie];
        // 设置timeout
        // 请求超时
        // 读超时
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer = [BOPAFHTTPResponseSerializer serializer];
        
        // 请求
        [manager GET:downloadUrl parameters:nil success: ^(BOPAFHTTPRequestOperation *operation, id responseObject) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
            statusCode = (int32_t)httpResponse.statusCode;
            FNFileDownloadResponse *rsp;
            
            if (200 == statusCode)
            {
                [bytes appendData:operation.responseData];
                [[NSFileManager defaultManager] createFileAtPath:filePath contents:bytes attributes:nil];
                fileRequest.fileInfo.filePath = filePath;
                rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:statusCode fileInfo:fileRequest.fileInfo errorInfo:nil];
            }
            else if (250 == statusCode)
            {
                NSError *err = [[NSError alloc] init];
                BOPGDataXMLDocument *doc = [[BOPGDataXMLDocument alloc] initWithData:operation.responseData options:0 error:&err];
                BOPGDataXMLElement *root = doc.rootElement;
                BOPGDataXMLNode *rootNode = [root attributeForName:@"resultcode"];
                
                int32_t statusCode = [[rootNode stringValue] intValue];
                NSString *errorInfo = nil;
                switch (statusCode)
                {
                    case 404:
                        NSLog(@"download invalid url or file expired!");
                        errorInfo = @"URL不合法或者文件已过期！";
                        break;
                    case 400:
                        NSLog(@"download request format error!");
                        errorInfo = @"请求格式错误!";
                        break;
                    case 401:
                        NSLog(@"download Credential error!");
                        errorInfo = @"文件凭证错误！";
                        break;
                    case 500:
                        NSLog(@"download server inner error!");
                        errorInfo = @"服务器内部错误！";
                        break;
                    default:
                        break;
                }
                
                rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:statusCode fileInfo:nil errorInfo:errorInfo];
            }
            
            mtCallback(rsp);
        }
             failure: ^(BOPAFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"downloadFileThumb error: %@", error);
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                 statusCode = (int32_t)httpResponse.statusCode;
                 FNFileDownloadResponse *rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:statusCode fileInfo:nil errorInfo:[error description]];
                 mtCallback(rsp);
             }];
    });
}

- (void)downloadHandler:(long)blockCount
              blockData:(NSData *)data
              fileRange:(NSString *)fileRange
               filePath:(NSString *)filePath
{
    if (responsedDatas == nil)
    {
        responsedDatas = [[NSMutableArray alloc] initWithCapacity:1];
    }
    if (downloadedRanges == nil)
    {
        downloadedRanges = [[NSMutableArray alloc] initWithCapacity:1];
    }
    if (downloadedRanges && ![downloadedRanges containsObject:fileRange])
    {
        [downloadedRanges addObject:fileRange];
        FNResponseData *responseData = [[FNResponseData alloc] init];
        responseData.range = fileRange;
        responseData.data = data;
        [responsedDatas addObject:responseData];
    }
    
    if ([downloadedRanges count] > 0 && [downloadedRanges count] == blockCount)
    {
        NSMutableData *fileData = [NSMutableData dataWithCapacity:0];
        [responsedDatas sortUsingSelector:@selector(compareRange:)];
        for (FNResponseData *responseData in responsedDatas)
        {
            [fileData appendData:responseData.data];
        }
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileData attributes:nil];
        [downloadedRanges removeAllObjects];
        [responsedDatas removeAllObjects];
    }
}


#pragma mark -
#pragma mark 获取各种URL

- (NSString *)getCheckFileExistUri:(NSString *)type
                                sp:(NSString *)sp
                               tid:(NSString *)tid
                               MD5:(NSString *)md5
{
    NSString *checkUrl = [[FNServerConfig getInstance].fileServiceAddress stringByAppendingString:@"CheckFileExist"];
    NSString *uri = [NSString stringWithFormat:@"%@?MD5=%@&type=%@&sp=%@&tid=%@", checkUrl, md5, type, sp, tid];
    
    return uri;
}

NSString *getUploadUri(long fileSize, NSString *type, NSString *sp, NSString *tid, NSString *fileName, NSString *md5)
{
    NSString *uploadUrl = [[FNServerConfig getInstance].fileServiceAddress stringByAppendingString:@"blockupload"];
    NSString *uri = [NSString stringWithFormat:@"%@?id=%@&filesize=%ld&type=%@&sp=%@&tid=%@", uploadUrl, md5, fileSize, type, sp, tid];
    
    // 当为上传共享文件时要填写文件名fileName
    if ([type isEqualToString:@"FILE"])
    {
        uri = [NSString stringWithFormat:@"%@&filename=%@", uri, fileName];
    }
    
    return uri;
}

+ (NSString *)getBlockUploadUrl:(NSString *)url
                     rangeStart:(long)start
                       rangeEnd:(long)end
{
    return [NSString stringWithFormat:@"%@&range=%ld-%ld", url, start, end];
}

+ (NSString *)getBlockDownloadUrl:(NSString *)url
                       rangeStart:(long)start
                         rangeEnd:(long)end
{
    return [NSString stringWithFormat:@"%@&range=%ld-%ld", url, start, end];
}

- (NSString *)parseMutiplePicUrl:(NSString *)multipleUrl isp:(NSString *)isp
{
    NSString *url = nil;
    if (multipleUrl && ![multipleUrl isEqualToString:@""] && isp && [isp isEqualToString:@""])
    {
        NSString *tmp = [[[multipleUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"" withString:@""];
        NSArray *tmpArr = [tmp componentsSeparatedByString:@";"];
        if (tmpArr)
        {
            for (NSString *str in tmpArr)
            {
                NSArray *tmpArr2 = [str componentsSeparatedByString:@"\\|"];
                if (tmpArr2 && 2 == tmpArr2.count)
                {
                    if ([isp isEqualToString:tmpArr2[0]])
                    {
                        url = tmpArr2[1];
                        break;
                    }
                }
            }
        }
    }
    return url;
}


#pragma mark -
#pragma mark Tools

+ (NSString *)getFileMIMEType:(NSString *)filePath
{
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLResponse *rsp = nil;
    [NSURLConnection sendSynchronousRequest:req returningResponse:&rsp error:nil];
    
    return [rsp MIMEType];
}

+ (NSString *)getFileMD5WithData:(NSData *)data
{
    NSData *md5Data = [data md5Digest];
    NSString *md5Str = [md5Data bytesToHexString];
    return md5Str;
}

+ (NSString *)getFileMD5WithPath:(NSString *)path
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [self getFileMD5WithData:data];
}

long int getFileSizeFromPath(const char *path)
{
    FILE *file;
    long int size = 0;
    file = fopen(path, "r");
    if (file > 0)
    {
        fseek(file, 0, SEEK_END);
        size = ftell(file);
        fseek(file, 0, SEEK_SET);
        fclose(file);
    }
    return size;
}


#pragma mark -
#pragma mark TODO

+ (NSString *)getFileUploadRecord:(NSString *)filePath
{
    // TODO
    
    return nil;
}

+ (int)deleteFileUploadRecord:(NSString *)filePath
{
    //TODO
    return 0;
}

+ (int)cacheFileUploadRecord:fileId
           nextStartPosition:(int64_t)nextStartPos
                   uploadUrl:(NSString *)uploadUrlStr
                 downloadUrl:(NSString *)downloadUrlStr
{
    //TODO
    return 0;
}

@end
