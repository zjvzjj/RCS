//
//  MessageLogic.h
//  feinno-sdk-imps
//
//  Created by doujinkun on 14-10-13.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNMsgBasicLogic.h"
#import "FNMsgArgs.h"

/**
 *  消息逻辑类，包含消息、音视频请求的业务逻辑操作方法
 */
@interface FNMsgLogic : FNMsgBasicLogic

/**
 *  拉取历史消息
 *
 *  @param pullMsgReq 消息实体类参数，由UI层填写其中的成员变量
 *  @param callback   发送消息的回调
 */
+ (void) getHistory :(FNGetRoamingMsgRequest *)pullMsgReq
            callback:(void (^)(NSArray *msgList))callback;

/**
 *  发送文本消息
 *
 *  @param textMsgReq 消息实体类参数，由UI层填写其中的成员变量
 *  @param callback   发送消息的回调
 */
+ (void)sendTextMsg:(FNSendTextMsgRequest *)textMsgReq
           callback:(void (^)(FNSendMsgResponse *rspArgs))callback;

/**
 *  发送富文本消息
 *
 *  @param richTextMsgReq 发送富文本消息的请求参数
 *  @param callback       发送富文本消息的回调
 */
+ (void)sendRichTextMsg:(FNSendRichTextMsgRequest *)richTextMsgReq
               callback:(void(^)(FNSendRichTextMsgResponse *rspArgs))callback;

/**
 *  拉取两人消息的方法
 *
 *  @param pullMsgReq 拉取两人消息的请求参数
 *  @param callback   拉取两人消息的回调
 */
+ (void)getMsg:(FNPullMsgRequest *)pullMsgReq
      callback:(void(^)(NSArray *msgList))callback;

/**
 *  存储富文本消息（消息，最近会话）
 *
 *  @param richTextMsgReq 发送富文本消息的请求参数
 */
+ (void)saveRichTextMessage:(FNSendRichTextMsgRequest *)richTextMsgReq;

/**
 *  更新富文本消息
 *
 *  @param downloadUrl 下载链接
 *  @param fileId      文件id
 *  @param fileSize    文件大小
 *  @param fileWidth   文件宽度
 *  @param fileHeight  文件高度
 *  @param sendStatus  发送状态
 */
+ (void)updateLocalData:(NSString *)downloadUrl msgId:(NSString *)msgId fileId:(NSString *)fileId fileName:(NSString *)fileName  fileSize:(long)fileSize fileWidth:(long)fileWidth fileHeight:(long)fileHeight sendStatus:(int)sendStatus;

/**
 *  上传富文本文件的方法
 *
 *  @param filePath 文件路径
 *  @param fileType 文件类型
 *  @param tid      目标id
 *  @param callBack 上传完成的回调
 */
+ (void)uploadRichTextFilePath:(NSString *)filePath
                         msgId:(NSString *)msgId
                      fileType:(NSString *)fileType
                           tid:(NSString *)tid
                      callBack:(void (^)(FNFileUploadResponse *serviceRsp))msgCallBack;

/**
 *  发送透传消息
 *
 *  @param simpleMsgRequest 创建透传消息的请求参数
 *  @param callback         创建透传消息的回调
 */
+ (void)sendSimpleMsg:(FNSendSimpleMsgRequest *)simpleMsgRequest
             callback:(void (^) (FNSendSimpleMsgResponse *rspArgs))callback;

/**
 *  下载聊天信息中的富文本的缩略图文件
 *
 *  @param url      文件的下载地址
 *  @param fileSize 文件大小
 *  @param fileWidth 文件宽度
 *  @param fileHeight 文件高度
 *  @param syncId   消息的syncId
 *  @param fileName 文件名
 *  @param fileId   文件Id
 *  @param callback 下载源文件的回调
 */
+ (void)downloadThumbnail:(NSString *)url
                 fileSize:(long)fileSize
                fileWidth:(long)fileWidth
               fileHeight:(long)fileHeight
                   syncId:(int64_t)syncId
                 fileName:(NSString *)fileName
                   fileId:(NSString *)fileId
                 callback:(void(^)(FNFileDownloadResponse *rspArgs))callback;

/**
 *  下载聊天信息中的富文本的源文件
 *
 *  @param url      文件的下载地址
 *  @param fileSize 文件大小
 *  @param fileWidth 文件宽度
 *  @param fileHeight 文件高度
 *  @param syncId   消息的syncId
 *  @param fileType 文件类型
 *  @param fileName 文件名
 *  @param fileId   文件Id
 *  @param callback 下载源文件的回调
 */
+ (void)downloadSharedFile:(NSString *)url
                  fileSize:(long)fileSize
                 fileWidth:(long)fileWidth
                fileHeight:(long)fileHeight
                    syncId:(int64_t)syncId
                  fileType:(NSString *)fileType
                  fileName:(NSString *)fileName
                    fileId:(NSString *)fileId
                  callback:(void(^)(FNFileDownloadResponse *rspArgs))callback;

@end
