//
//  FNRecentConversationTable.h
//  FeinnoBopSDK-db
//
//  Created by zym on 15/2/3.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNEnum.h"

/**
 *  最近会话列表模型
 */
@interface FNRecentConversationTable : NSObject

/**
 *  最近一天会话目标对象的ID
 */
@property (nonatomic, retain) NSString *targetId;

/**
 *  最近会话目标对象的name
 */
@property (nonatomic, retain) NSString *targetName;

/**
 *   最近会话目标对象的头像
 */
@property (nonatomic, retain) NSString *targetProtraitUrl;

/**
 *  最近一条会话的发送者昵称
 */
@property (nonatomic, retain) NSString *senderNickname;

/**
 *  最近一条会话的内容
 */
@property (nonatomic, retain) NSString *content;

/**
 *  最近一条会话的msgId
 */
@property (nonatomic, retain) NSString *msgId;

/**
 *  最近一条会话的发送状态
 */
@property (nonatomic) int32_t sendStatus;

/**
 *  该会话对象的未读会话条数
 */
@property (nonatomic) int64_t unreadMsgCount;

/**
 *  用于消息排序和本地排重
 */
@property (nonatomic) int64_t syncId;

/**
 *  最近一条会话的活动时间
 */
@property (nonatomic, retain) NSString *lastActiveDate;

/**
 *  最近一条会话的内容类型
 */
@property (nonatomic, retain) NSString *msgType;

/**
 *  消息类型，两人消息还是群消息等
 */
@property (nonatomic) EventType eventType;

/**
 *  查询最近会话的信息列表
 *
 *  @return 返回一个最近会话数组的数组，数组内存储的是FNRecentConversationTable类型的参数
 */
+ (NSMutableArray *)get;

/**
 *  获取最近会话列表目标id的消息
 *
 *  @param tid 目标id
 *
 *  @return 返回一个最近会话数组的数组，数组内存储的是FNRecentConversationTable类型的参数
 */
+ (NSMutableArray *)getByTid:(NSString *)tid;

/**
 *  更新最近会话消息内容
 *
 *  @param msgContent 更新的消息内容
 *  @param tid 目标id
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)updateContent:(NSString *)msgContent tid:(NSString *)tid;

/**
 *  更新最会会话消息的发送状态
 *
 *  @param sendStatus 消息的发送状态
 *  @param msgId      消息id
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)updateSendStatus:(int32_t)sendStatus syncId:(int64_t)syncId msgId:(NSString *)msgId;

/**
 *  插入一条最近会话记录
 *
 *  @param info 插入的最近会话信息的模型参数
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)insert:(FNRecentConversationTable *)info;

/**
 *  删除一条最近会话的记录
 *
 *  @param targetId 最近会话的的接收者ID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)delete:(NSString *)targetId;

/**
 *  清空最近会话表
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)clearAll;

/**
 *  更新未读消息数量字段，将其置0
 *
 *  @param targetId 最近会话的的接收者ID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)updateUnReadCount:(NSString *)targetId;

/**
 *  设置实力对象中的unreadMsgCount，由SDK调用
 *
 *  @return 返回得到的数值
 */
- (int64_t)setUnreadMsgCount;

@end
