//
//  FNFileServiceArgs.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-4.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNFileServiceArgs.h"

@implementation FNMultiFileUploadRequest

@end

@implementation FNSharedFileInfo

@end

@implementation FNFileUploadRequest

@end

@interface FNFileUploadResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) FNSharedFileInfo *fileInfo;
@property (nonatomic, readwrite) NSString *errorInfo;

@end

@implementation FNFileUploadResponse

- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileInfo:(FNSharedFileInfo *)fileInfo
                      errorInfo:(NSString *)error
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
        _fileInfo = fileInfo;
        _errorInfo = error;
    }
    return self;
}

@end

@implementation FNFileDownloadRequest

@end

@interface FNFileDownloadResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) FNSharedFileInfo *fileInfo;
@property (nonatomic, readwrite) NSString *errorInfo;

@end

@implementation FNFileDownloadResponse

- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileInfo:(FNSharedFileInfo *)fileInfo
                      errorInfo:(NSString *)error
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
        _fileInfo = fileInfo;
        _errorInfo = error;
    }
    return self;
}

@end
