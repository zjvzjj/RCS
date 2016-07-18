//
//  FNMsgBasicLogic.m
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/3/24.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNMsgBasicLogic.h"
#import "NSData+DataEncrypt.h"

const int32_t FN_PULL_MSG_COUNT_DEFAULT = 10;

@implementation FNMsgBasicLogic

// 同步方式获取MIMEType 再获取最终的类型
+ (NSString *)getMsgTypeByMIMEType:(NSString *)filePath
{
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLResponse *rsp = nil;
    [NSURLConnection sendSynchronousRequest:req returningResponse:&rsp error:nil];
    
    NSString *mimeType = [rsp MIMEType];
    NSString *fileType = [(NSString *)[[mimeType componentsSeparatedByString:@"/"] firstObject] lowercaseString];
    
    // @"FILE" @"IMG" @"AUDIO" @"VIDEO"
    if ([fileType isEqualToString:@"image"])
    {
        fileType = FNMsgTypePic;
    }
    else if ([fileType isEqualToString:@"audio"])
    {
        fileType = FNMsgTypeAudio;
    }
    else if ([fileType isEqualToString:@"video"])
    {
        fileType = FNMsgTypeVideo;
    }
    else
    {
        fileType = FNMsgTypeFile;
    }
    
    return fileType;
}

+ (NSString *)getFileTypeByMIMEType:(NSString *)filePath
{
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLResponse *rsp = nil;
    NSError *error = nil;
    [NSURLConnection sendSynchronousRequest:req returningResponse:&rsp error:&error];
    
    NSString *mimeType = [rsp MIMEType];
    NSString *fileType = [(NSString *)[[mimeType componentsSeparatedByString:@"/"] firstObject] lowercaseString];
    
    // @"FILE" @"IMG" @"AUDIO" @"VIDEO"
    if ([fileType isEqualToString:@"image"])
    {
        fileType = @"IMG";
    }
    else if ([fileType isEqualToString:@"audio"])
    {
        fileType = @"AUDIO";
    }
    else if ([fileType isEqualToString:@"video"])
    {
        fileType = @"VIDEO";
    }
    else
    {
        fileType = @"FILE";
    }
    
    return fileType;
}

+ (NSString *)generateUUID
{
//    int32_t n1=arc4random();
//    int32_t n2=arc4random();
//    int32_t n3=arc4random();
//    int32_t n4=arc4random();
//    
//    if (n1>>24<16) {
//        n1+=0x10000000;
//    }
//    
//    if (n2>>24<16) {
//        n2+=0x10000000;
//    }
//    
//    if (n3>>24<16) {
//        n3+=0x10000000;
//    }
//    
//    if (n4>>24<16) {
//        n4+=0x10000000;
//    }
//    NSString *str = [NSString stringWithFormat:@"%8X%8X%8X%8X",n1,n2,n3,n4];
//    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    return str;
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUIDString = CFUUIDCreateString(kCFAllocatorDefault, UUID);
    NSString *result = [[NSString alloc] initWithString:(__bridge NSString *)UUIDString];
    CFRelease(UUID);
    CFRelease(UUIDString);
    return result;
}


#pragma mark -
#pragma mark 消息加密

// 相应的解密方法在PB协议解析层
+ (NSData *)enceyptMsgBody:(NSData *)data
                       key:(NSString *)sKey
{
    NSData *rspData = nil;
    if (sKey)
    {
        NSData *enCodeFormat = [[sKey dataUsingEncoding:NSUTF8StringEncoding] md5Digest];
        rspData = [data aes128EncryptWithKey:enCodeFormat];
    }
    
    return rspData;
}

@end
