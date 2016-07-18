//
//  FNNotifyArgs.h
//  FeinnoBopSDK
//
//  Created by wangshuying on 15/1/29.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PullNotifyResults;
@class SysNotify;

/**
 *  拉取通知的请求类
 */
@interface FNPullNotifyRequest : NSObject

// 本次拉取消息的数量, 当count = 0时缺省设置为10条
@property (nonatomic) int32_t count;

// 是否删除服务器端所有历史通知，YES 是，NO 否
@property (nonatomic, assign) BOOL deleteHistoryMsg;

@end

@interface FNSendSimplemsgNotify : NSObject

@property (nonatomic) NSString *fromBopId;

@property (nonatomic) NSString *message;

@end

/**
 *  拉取通知的应答类
 */
@interface FNPullNotifyResponse : NSObject

// 拉取消息的应答状态码： 200 成功    500 服务器错误
@property (nonatomic, readonly) int32_t statusCode;

// 拉取到的消息，该数组内存储的是 FNNotifyEntity 类
@property (nonatomic, readonly) NSArray *notifyList;

// 是否拉取完成
@property (nonatomic, readonly) BOOL isCompleted;

// 消息的syncID
@property (nonatomic, readonly) int64_t syncID;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(PullNotifyResults *)pbArgs;

@end

/**
 *  通知实体类
 */
@interface FNNotifyEntity : NSObject

// 通知来源的ID
@property (nonatomic) NSString *sourceID;

// 通知的目标ID
@property (nonatomic) NSString *tid;

// 通知类型
@property (nonatomic) NSString *notifyType;

///通知的id
@property (nonatomic) NSString *notifyId;

// 通知体
@property (nonatomic) NSData *notifyBody;

@end

/**
 *  系统通知类
 */
@interface FNSystemNotifyArgs : NSObject

// 系统通知的ID
@property (nonatomic, readonly) int64_t msgId;

// 系统通知的类型 SystemNotifyTextPlain纯文本  SystemNotifyTextUrl纯文本+URL  SystemNotifyRichTextUrl富文本+URL
@property (nonatomic, readonly) SystemNotifyType msgType;

// 对应于msgType的msgBody的格式
// 1:纯文本无格式
// 2:<sysnotify><text>hello wrold</text><url>www.baidu.com</url></sysnotify>
// 3:<sysnotify><text>hello wrold</text><fileurl>http:ncfp:8080/download</fileurl><url>www.baidu.com</url></sysnotify>
@property (nonatomic, readonly) NSString *msgBody;

// 系统消息的标题
@property (nonatomic, readonly) NSString *title;

// 系统消息的发送时间
@property (nonatomic, readonly) NSString *sendDate;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(SysNotify *)pbArgs;

@end
