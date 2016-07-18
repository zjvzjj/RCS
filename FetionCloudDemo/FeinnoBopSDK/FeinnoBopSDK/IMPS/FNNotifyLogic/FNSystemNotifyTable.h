//
//  FNSystemNotifyTable.h
//  FeinnoBopSDK
//
//  Created by zym on 15/4/3.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  系统消息表
 */
@interface FNSystemNotifyTable : NSObject

/**
 *  消息来源
 */
@property (nonatomic) NSString *fromUserId;

/**
 *  消息的id，全局唯一，用来排序或排重
 */
@property (nonatomic) int64_t msgId;

/**
 *  消息体类型
 */
@property (nonatomic) int32_t msgType;

/**
 *  通知标题
 */
@property (nonatomic) NSString *title;

/**
 *  通知的发送时间
 */
@property (nonatomic) NSString *sendDate;

/**
 *  通知的具体内容
 */
@property (nonatomic) NSString *msgBody;

/**
 *  是否已读标记： MsgAlreadyRead MsgUnread
 */
@property (nonatomic) int32_t readStatus;

/**
 *  通过msgId从本地数据表中获取某一条系统消息
 *
 *  @param msgId 消息的msgId
 *
 *  @return 返回操作结果
 */
+ (FNSystemNotifyTable *)get:(int64_t)msgId;

/**
 *  获取该用户的所有的系统消息
 *
 *  @return 返回操作结果
 */
+ (NSMutableArray *)getList;

/**
 *  将消息通知存储到本地数据表中
 *
 *  @param systemNotify 消息通知
 *
 *  @return 返回的操作结果
 */
+ (BOOL)insert:(FNSystemNotifyTable *)systemNotify;

/**
 *  将本地消息表中的某一条消息
 *
 *  @param msgId 消息的id
 *
 *  @return 返回的操作结果
 */
+ (BOOL)delete:(int64_t)msgId;

/**
 *  清空该表
 *
 *  @return 返回操作结果
 */
+ (BOOL)clearAll;

@end
