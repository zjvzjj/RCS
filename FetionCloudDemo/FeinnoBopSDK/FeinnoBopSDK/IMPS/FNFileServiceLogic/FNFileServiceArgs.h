//
// FNFileServiceArgs.h
// FeinnoBopSDK
//
// Created by jiaoruixue on 15-8-4.
// Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  一对多消息 文件服务的请求类
 */
@interface FNMultiFileUploadRequest : NSObject

// 要上传文件的沙盒路径，不能为nil
@property (nonatomic, copy) NSString *filePath;

// 要上传文件的名称，包含扩展名
@property (nonatomic, copy) NSString *fileName;

// 要上传文件的数据
@property (nonatomic, strong) NSData *fileData;

/**
 *  要上传文件的类型，根据文件服务系统协议，取值可以为以下几种：
 *  @“FILE” @“IMG” @“AUDIO” @“VIDEO” @“QR” (二维码) @“BG"(背景）
 *  @“FILE” 为上传共享文件时的必选类型
 *  @“IMG” @“AUDIO” 和 @“VIDEO” 是聊天会话时富文本消息的相应类型
 */
@property (nonatomic, copy) NSString *fileType;

// 获取上传文件的凭证，两人聊天的富文本消息的凭证为个人登录时获取的个人凭证
// 群共享文件的凭证需要根据信令单独获取
@property (nonatomic, copy) NSString *ssic;

// 文件服务的服务码，取值可以为以下几种：
// @“1” 两人会话富文本， @“2” 群/讨论组富文本
@property (nonatomic, copy) NSString *sp;  //TODO: 删除

// 文件发送的对象id 组
@property (nonatomic, strong) NSArray  *tids;

@end


/**
 *  BOP文件服务 文件上传、下载操作的文件信息类
 */
@interface FNSharedFileInfo : NSObject

// 文件的沙盒路径
@property (nonatomic, copy) NSString *filePath;

// 文件的ID，由SDK赋值，UI不需要处理
@property (nonatomic, copy) NSString *fileId;

// 文件的大小，由SDK赋值，UI不需要处理
@property (nonatomic) long fileSize;

// 文件的宽度
@property (nonatomic) long fileWidth;

// 文件的高度
@property (nonatomic) long fileHeight;

// 文件名称
@property (nonatomic, copy) NSString *fileName;

// 获取到的文件下载地址
@property (nonatomic, copy) NSString *downloadURL;

// 文件类型，由SDK赋值，UI不需要处理
@property (nonatomic, copy) NSString *fileType;

// 文件的上传者
@property (nonatomic, copy) NSString *creator;

// 文件的来源, 如某个群的群共享文件，那么source为群ID
@property (nonatomic, copy) NSString *source;

@end

/**
 *  文件上传服务的请求类
 */
@interface FNFileUploadRequest : NSObject

// 要上传文件的沙盒路径，不能为nil
@property (nonatomic, copy) NSString *filePath;

// 要上传文件的名称，包含扩展名
@property (nonatomic, copy) NSString *fileName;

//要上传文件的数据
@property (nonatomic, strong) NSData *fileData;

//要上传文件的msgid
@property (nonatomic, copy) NSString *msgId;

/**
 *  要上传文件的类型，根据文件服务系统协议，取值可以为以下几种：
 *  @“FILE” @“IMG” @“AUDIO” @“VIDEO” @“QR” (二维码) @“BG"(背景）
 *  @“FILE” 为上传共享文件时的必选类型
 *  @“IMG” @“AUDIO” 和 @“VIDEO” 是聊天会话时富文本消息的相应类型
 */
@property (nonatomic, copy) NSString *fileType;

// 获取上传文件的凭证，两人聊天的富文本消息的凭证为个人登录时获取的个人凭证
// 群共享文件的凭证需要根据信令单独获取
@property (nonatomic, copy) NSString *ssic;

// 文件服务的服务码，取值可以为以下几种：
// @“1” 两人会话富文本， @“2” 群/讨论组富文本
@property (nonatomic, copy) NSString *sp;  //TODO: 删除

// 文件发送的对象id，如个人用户id 或者 群id
@property (nonatomic, copy) NSString *tid;

@end

/**
 *  文件服务 文件上传的应答类
 */
@interface FNFileUploadResponse : NSObject

// 请求的应答返回码
@property (nonatomic, readonly) int32_t statusCode;

// 文件信息类
@property (nonatomic, readonly) FNSharedFileInfo *fileInfo;

// 文件服务失败时，返回的错误描述
@property (nonatomic, readonly) NSString *errorInfo;

// 初始化该类，由SDK调用
- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileInfo:(FNSharedFileInfo *)fileInfo
                      errorInfo:(NSString *)error;

@end

/**
 *  下载文件的请求类
 */
@interface FNFileDownloadRequest : NSObject

// 文件信息类
@property (nonatomic, strong) FNSharedFileInfo *fileInfo;

// 下载文件的凭证
@property (nonatomic, copy) NSString *credential;

@end

/**
 *  文件服务 下载文件的应答类
 */
@interface FNFileDownloadResponse : NSObject

// 下载文件请求的应答码
@property (nonatomic, readonly) int32_t statusCode;

// 下载完成后的文件在沙盒中的保存路径
@property (nonatomic, readonly) FNSharedFileInfo *fileInfo;

// 下载文件失败时的错误描述信息
@property (nonatomic, readonly) NSString *errorInfo;

// 初始化该类，由SDK调用
- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileInfo:(FNSharedFileInfo *)fileInfo
                      errorInfo:(NSString *)error;

@end
