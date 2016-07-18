//
//  FNMsgContent.m
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/3/26.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNMsgContent.h"

@implementation FNMsgContent

+ (instancetype)msgContentWithType:(MsgContentType)type
{
    FNMsgContent *msgContent;
    switch (type)
    {
        case TextMsg:
        {
            msgContent = [[FNTextMsgContent alloc] init];
            break;
        }
        case ImageMsg:
        {
            msgContent = [[FNImageMsgContent alloc] init];
            break;
        }
        case VideoMsg:
        {
            msgContent = [[FNVideoMsgContent alloc] init];
            break;
        }
        case AudioMsg:
        {
            msgContent = [[FNAudioMsgContent alloc] init];
            break;
        }
        case FileMsg:
        {
            msgContent = [[FNFileMsgContent alloc] init];
            break;
        }
        default:
            break;
    }
    
    return msgContent;
}

+ (instancetype)toObjectFromStr:(NSString *)str
                    withMsgType:(NSString *)msgType
{
    FNMsgContent *msgContent;
    if (str.length > 0)
    {
        if ([msgType isEqualToString:FNMsgTypePlain])
        {
            msgContent = [FNTextMsgContent toObjectFromStr:str];
        }
        else if ([msgType isEqualToString:FNMsgTypePic])
        {
            msgContent = [FNImageMsgContent toObjectFromStr:str];
        }
        else if ([msgType isEqualToString:FNMsgTypeAudio])
        {
            msgContent = [FNAudioMsgContent toObjectFromStr:str];
        }
        else if ([msgType isEqualToString:FNMsgTypeVideo])
        {
            msgContent = [FNVideoMsgContent toObjectFromStr:str];
        }
        else if ([msgType isEqualToString:FNMsgTypeVideo])
        {
            msgContent = [FNFileMsgContent toObjectFromStr:str];
        }
    }
    return msgContent;
}

// 写成protocol
- (NSString *)toJString
{
    return nil;
}

- (NSString *)contentType
{
    return nil;
}

- (NSString *)content
{
    return nil;
}

- (NSString *)fileId
{
    return nil;
}

- (NSString *)fileName
{
    return nil;
}

- (NSString *)filePath
{
    return nil;
}

- (NSData *)fileData{
    return nil;
}

- (NSString *)fileThumbPath
{
    return nil;
}

- (NSString *)fileDownloadUrl
{
    return nil;
}

- (long)fileSize
{
    return 0L;
}

- (long)fileWidth
{
    return 0L;
}

- (long)fileHeight
{
    return 0L;
}

- (long)duration
{
    return 0L;
}

- (long)bitrate
{
    return 0L;
}

- (void)setContentType:(NSString *)contentType
{
}

- (void)setContent:(NSString *)content
{
}

- (void)setFileId:(NSString *)fileId
{
}

- (void)setFileName:(NSString *)fileName
{
}

- (void)setFilePath:(NSString *)filePath
{
}

- (void)setFileData:(NSData *)fileData
{
}

- (void)setFileThumbPath:(NSString *)fileThumbPath
{
}

- (void)setFileDownloadUrl:(NSString *)fileDownloadUrl
{
}

- (void)setFileSize:(long)fileSize
{
}

- (void)setFileWidth:(long)fileWidth
{
}

- (void)setFileHeight:(long)fileHeight
{
}

- (void)setBitrate:(long)bitrate
{
}

- (void)setDuration:(long)duration
{
}

@end

@implementation FNTextMsgContent

@synthesize contentType = _contentType;
@synthesize content = _content;

- (NSString *)toJString
{
    NSString *jStr;
    if (self && self.contentType.length > 0)
    {
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:2];
        mDic[@"contentType"] = self.contentType;
        mDic[@"content"] = self.content;
        
        if ([NSJSONSerialization isValidJSONObject:mDic])
        {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:mDic options:0 error:&error];
            if (nil != data)
            {
                jStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
    }
    
    return jStr;
}

+ (instancetype)toObjectFromStr:(NSString *)str
{
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSMutableDictionary *mDic = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    FNTextMsgContent *common = [[FNTextMsgContent alloc] init];
    common.contentType = mDic[@"contentType"];
    common.content = mDic[@"content"];
    
    return common;
}

- (void)setContentType:(NSString *)contentType
{
    _contentType = [contentType copy];
}

- (void)setContent:(NSString *)content
{
    _content = [content copy];
}

- (NSString *)contentType
{
    return _contentType;
}

- (NSString *)content
{
    return _content;
}

@end

@implementation FNImageMsgContent

@synthesize fileId = _fileId;
@synthesize fileName = _fileName;
@synthesize filePath = _filePath;
@synthesize fileThumbPath = _fileThumbPath;
@synthesize fileDownloadUrl = _fileDownloadUrl;
@synthesize fileSize = _fileSize;
@synthesize fileData = _fileData;
@synthesize fileWidth = _fileWidth;
@synthesize fileHeight = _fileHeight;

- (NSString *)toJString
{
    NSString *jStr;
    if (self && self.contentType.length > 0)
    {
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:2];
        mDic[@"contentType"] = self.contentType ? self.contentType : @"";
        mDic[@"content"] = self.content ? self.content : @"";
        mDic[@"fileId"] = self.fileId ? self.fileId : @"";
        mDic[@"fileName"] = self.fileName ? self.fileName : @"";
        mDic[@"filePath"] = self.filePath ? self.filePath : @"";
//        mDic[@"fileData"] = self.fileData;
        mDic[@"fileThumbPath"] = self.fileThumbPath ? self.fileThumbPath : @"";
        mDic[@"fileDownloadUrl"] = self.fileDownloadUrl ? self.fileDownloadUrl : @"";
        mDic[@"fileSize"] = [NSNumber numberWithLong:self.fileSize];
        mDic[@"fileWidth"] = [NSNumber numberWithLong:self.fileWidth];
        mDic[@"fileHeight"] = [NSNumber numberWithLong:self.fileHeight];
        
        if ([NSJSONSerialization isValidJSONObject:mDic])
        {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:mDic options:0 error:&error];
            if (nil != data)
            {
                jStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
    }
    
    return [jStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

+ (instancetype)toObjectFromStr:(NSString *)str
{
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSMutableDictionary *mDic = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    FNImageMsgContent *common = [[FNImageMsgContent alloc] init];
    common.contentType = mDic[@"contentType"];
    common.content = mDic[@"content"];
    common.fileId = mDic[@"fileId"];
    common.fileName = mDic[@"fileName"];
    common.filePath = mDic[@"filePath"];
//    common.fileData = mDic[@"fileData"];
    common.fileThumbPath =  mDic[@"fileThumbPath"];
    common.fileDownloadUrl = mDic[@"fileDownloadUrl"];
    common.fileSize = ((NSNumber *)mDic[@"fileSize"]).longValue;
    common.fileWidth = ((NSNumber *)mDic[@"fileWidth"]).longValue;
    common.fileHeight = ((NSNumber *)mDic[@"fileHeight"]).longValue;
    
    return common;
}

- (void)setFileId:(NSString *)fileId
{
    _fileId = [fileId copy];
}

- (void)setFileName:(NSString *)fileName
{
    _fileName = [fileName copy];
}

- (void)setFilePath:(NSString *)filePath
{
    _filePath = [filePath copy];
}

- (void)setFileData:(NSData *)fileData{
    _fileData = fileData;//???
}

- (void)setFileThumbPath:(NSString *)fileThumbPath
{
    _fileThumbPath = [fileThumbPath copy];
}

- (void)setFileDownloadUrl:(NSString *)fileDownloadUrl
{
    _fileDownloadUrl = [fileDownloadUrl copy];
}

- (void)setFileSize:(long)fileSize
{
    _fileSize = fileSize;
}

- (void)setFileWidth:(long)fileWidth
{
    _fileWidth = fileWidth;
}

- (void)setFileHeight:(long)fileHeight
{
    _fileHeight = fileHeight;
}

- (NSString *)fileId
{
    return _fileId;
}

- (NSString *)fileName
{
    return _fileName;
}

- (NSString *)filePath
{
    return _filePath;
}

- (NSData *)fileData
{
    return _fileData;
}

- (NSString *)fileThumbPath
{
    return _fileThumbPath;
}

- (NSString *)fileDownloadUrl
{
    return _fileDownloadUrl;
}

- (long)fileSize
{
    return _fileSize;
}

- (long)fileWidth
{
    return _fileWidth;
}

- (long)fileHeight
{
    return _fileHeight;
}

@end

@implementation FNVideoMsgContent

@synthesize bitrate = _bitrate;
@synthesize duration = _duration;

- (NSString *)toJString
{
    NSString *jStr;
    if (self && self.contentType.length > 0)
    {
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:2];
        mDic[@"contentType"] = self.contentType ? self.contentType : @"";
        mDic[@"content"] = self.content ? self.content : @"";
        mDic[@"fileId"] = self.fileId ? self.fileId : @"";
        mDic[@"fileName"] = self.fileName ? self.fileName : @"";
        mDic[@"filePath"] = self.filePath ? self.filePath : @"";
//        mDic[@"fileData"] = self.fileData;
        mDic[@"fileThumbPath"] = self.fileThumbPath ? self.fileThumbPath : @"";
        mDic[@"fileDownloadUrl"] = self.fileDownloadUrl ? self.fileDownloadUrl : @"";
        mDic[@"fileSize"] = [NSNumber numberWithLong:self.fileSize];
        mDic[@"fileWidth"] = [NSNumber numberWithLong:self.fileWidth];
        mDic[@"fileHeight"] = [NSNumber numberWithLong:self.fileHeight];
        mDic[@"bitrate"] = [NSNumber numberWithLong:self.bitrate];
        mDic[@"duration"] = [NSNumber numberWithLong:self.duration];

        if ([NSJSONSerialization isValidJSONObject:mDic])
        {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:mDic options:0 error:&error];
            if (nil != data)
            {
                jStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
    }
    
    return [jStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

+ (instancetype)toObjectFromStr:(NSString *)str
{
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSMutableDictionary *mDic = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    FNVideoMsgContent *common = [[FNVideoMsgContent alloc] init];
    common.contentType = mDic[@"contentType"];
    common.content = mDic[@"content"];
    common.fileId = mDic[@"fileId"];
    common.fileName = mDic[@"fileName"];
    common.filePath = mDic[@"filePath"];
//    common.fileData = mDic[@"fileData"];
    common.fileThumbPath = mDic[@"fileThumbPath"];
    common.fileDownloadUrl = mDic[@"fileDownloadUrl"];
    common.fileSize = ((NSNumber *)mDic[@"fileSize"]).longValue;
    common.fileWidth = ((NSNumber *)mDic[@"fileWidth"]).longValue;
    common.fileHeight = ((NSNumber *)mDic[@"fileHeight"]).longValue;
    common.bitrate = ((NSNumber *)mDic[@"bitrate"]).longValue;
    common.duration = ((NSNumber *)mDic[@"duration"]).longValue;
    
    return common;
}

- (void)setBitrate:(long)bitrate
{
    _bitrate = bitrate;
}

- (void)setDuration:(long)duration
{
    _duration = duration;
}

- (long)bitrate
{
    return _bitrate;
}

- (long)duration
{
    return _duration;
}

@end

@implementation FNAudioMsgContent

- (NSString *)toJString
{
    NSString *jStr;
    if (self && self.contentType.length > 0)
    {
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:2];
        mDic[@"contentType"] = self.contentType ? self.contentType : @"";
        mDic[@"content"] = self.content ? self.content : @"";
        mDic[@"fileId"] = self.fileId ? self.fileId : @"";
        mDic[@"fileName"] = self.fileName ? self.fileName : @"";
        mDic[@"filePath"] = self.filePath ? self.filePath : @"";
//        mDic[@"fileData"] = self.fileData;
        mDic[@"fileThumbPath"] = self.fileThumbPath ? self.fileThumbPath : @"";
        mDic[@"fileDownloadUrl"] = self.fileDownloadUrl ? self.fileDownloadUrl : @"";
        mDic[@"fileSize"] = [NSNumber numberWithLong:self.fileSize];
        mDic[@"bitrate"] = [NSNumber numberWithLong:self.bitrate];
        mDic[@"duration"] = [NSNumber numberWithLong:self.duration];
        
        if ([NSJSONSerialization isValidJSONObject:mDic])
        {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:mDic options:0 error:&error];
            if (nil != data)
            {
                jStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
        
    }
    
    return [jStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

+ (instancetype)toObjectFromStr:(NSString *)str
{
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSMutableDictionary *mDic = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    FNAudioMsgContent *common = [[FNAudioMsgContent alloc] init];
    common.contentType = mDic[@"contentType"];
    common.content = mDic[@"content"];
    common.fileId = mDic[@"fileId"];
    common.fileName = mDic[@"fileName"];
    common.filePath = mDic[@"filePath"];
//    common.fileData = mDic[@"fileData"];
    common.fileThumbPath = mDic[@"fileThumbPath"];
    common.fileDownloadUrl = mDic[@"fileDownloadUrl"];
    common.fileSize = ((NSNumber *)mDic[@"fileSize"]).longValue;
    common.bitrate = ((NSNumber *)mDic[@"bitrate"]).longValue;
    common.duration = ((NSNumber *)mDic[@"duration"]).longValue;
    
    return common;
}

@end


@implementation FNFileMsgContent

- (NSString *)toJString
{
    NSString *jStr;
    if (self && self.contentType.length > 0)
    {
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:2];
        mDic[@"contentType"] = self.contentType ? self.contentType : @"";
        mDic[@"content"] = self.content ? self.content : @"";
        mDic[@"fileId"] = self.fileId ? self.fileId : @"";
        mDic[@"fileName"] = self.fileName ? self.fileName : @"";
        mDic[@"filePath"] = self.filePath ? self.filePath : @"";
//        mDic[@"fileData"] = self.fileData;
        mDic[@"fileDownloadUrl"] = self.fileDownloadUrl ? self.fileDownloadUrl : @"";
        mDic[@"fileSize"] = [NSNumber numberWithLong:self.fileSize];
        
        if ([NSJSONSerialization isValidJSONObject:mDic])
        {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:mDic options:0 error:&error];
            if (nil != data)
            {
                jStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
        
    }
    
    return [jStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

+ (instancetype)toObjectFromStr:(NSString *)str
{
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSMutableDictionary *mDic = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    FNFileMsgContent *common = [[FNFileMsgContent alloc] init];
    common.contentType = mDic[@"contentType"];
    common.content = mDic[@"content"];
    common.fileId = mDic[@"fileId"];
    common.fileName = mDic[@"fileName"];
    common.filePath = mDic[@"filePath"];
//    common.fileData = mDic[@"fileData"];
    common.fileDownloadUrl = mDic[@"fileDownloadUrl"];
    common.fileSize = ((NSNumber *)mDic[@"fileSize"]).longValue;
    
    return common;
}

@end
