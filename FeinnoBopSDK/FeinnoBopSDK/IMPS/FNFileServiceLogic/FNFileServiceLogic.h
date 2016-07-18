//
//  FNFileServiceLogic.h
//  FeinnoChunleiSDK
//
//  Created by doujinkun on 15/1/21.
//  Copyright (c) 2015年 feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNFileServiceArgs.h"

@class FNSharedFileInfo;
@class FNFileUploadRequest;
@class FNFileUploadResponse;
@class FNFileDownloadRequest;
@class FNFileDownloadResponse;

/**
 *  BOP 平台文件服务逻辑，用于富文本消息和共享文件的上传下载操作
 */
@interface FNFileServiceLogic : NSObject

/**
 *  一对多消息文件上传操作
 *
 *  @param uploadFileReq 文件上传的请求信息
 *  @param mtCallback    上传后的主线程的回调方法
 */
- (void)uploadMultiFiles:(FNMultiFileUploadRequest *)uploadFileReq
                callback:(void (^)(FNFileUploadResponse *))mtCallback;

/**
 *  文件上传操作
 *
 *  @param uploadFileReq 文件上传的请求信息
 *  @param mtCallback    上传后的主线程回调方法
 */
- (void)uploadFile:(FNFileUploadRequest *)uploadFileReq
          callback:(void(^)(FNFileUploadResponse *rspArgs))mtCallback;

/**
 *  由服务器生成的图片或者视频文件的缩略图，可以下载用于预览
 *
 *  @param fileRequest    下载文件的请求
 *  @param mtCallback     文件下载完成后的主线程回调方法
 */
- (void)downloadFile:(FNFileDownloadRequest *)fileRequest
            callback:(void(^)(FNFileDownloadResponse *rspArgs))mtCallback;

/**
 *  由服务器生成的图片或者视屏文件的缩略图，可以下载用于预览
 *
 *  @param fileRequest    下载文件的请求
 *  @param mtCallback     文件下载完成后的主线程回调方法
 */
- (void)downloadFileThumb:(FNFileDownloadRequest *)fileRequest
                 callback:(void(^)(FNFileDownloadResponse *rspArgs))mtCallback;

@end
