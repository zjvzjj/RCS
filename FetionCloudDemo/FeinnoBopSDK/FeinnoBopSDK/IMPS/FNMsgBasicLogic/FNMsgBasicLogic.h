//
//  FNMsgBasicLogic.h
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/3/24.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

// 缺省的拉取消息数
extern const int32_t FN_PULL_MSG_COUNT_DEFAULT;

@interface FNMsgBasicLogic : NSObject

/**
 *  获取富文本消息的消息类型
 *
 *  @param filePath 文件的沙盒路径或者文件名
 *
 *  @return 返回的内容字符串
 */
+ (NSString *)getMsgTypeByMIMEType:(NSString *)filePath;

/**
 *  获取富文本消息的文件类型
 *
 *  @param filePath 文件的沙盒路径或者文件名
 *
 *  @return 返回的内容字符串
 */
+ (NSString *)getFileTypeByMIMEType:(NSString *)filePath;

/**
 *  生成GUID，由SDK调用
 *
 *  @return 返回的GUID字符串
 */
+ (NSString *)generateUUID;

/**
 *  消息体的加密方法，由SDK调用
 *
 *  @param data 消息体的数据
 *  @param sKey 加密key
 *
 *  @return 返回的加密数据
 */
+ (NSData *)enceyptMsgBody:(NSData *)data key:(NSString *)sKey;

@end
