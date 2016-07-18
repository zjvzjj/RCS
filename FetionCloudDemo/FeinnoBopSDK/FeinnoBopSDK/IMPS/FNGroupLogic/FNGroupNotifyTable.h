//
//  FNGroupNotifyTable.h
//  FeinnoBopSDK-db
//
//  Created by doujinkun on 15/3/18.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通知类的model
 */
@interface FNGroupNotifyTable : NSObject

// 通知的消息类型
@property (nonatomic) NSString *msgType;

// 群组的ID
@property (nonatomic) NSString *groupId;

//群组的名字
@property (nonatomic) NSString *groupName;

//群组的头像（或者加入者）
@property (nonatomic) NSString *memberProtraitUrl;

// 源用户的ID，如推荐加入群的推荐人ID
@property (nonatomic) NSString *sourceUserId;

// 源用户的昵称，如推荐加入群的推荐人昵称
@property (nonatomic) NSString *sourceUserNickname;

// 被推荐人的ID
@property (nonatomic) NSString *targetUserId;

// 被推荐人的昵称
@property (nonatomic) NSString *targetUserNickname;

// 消息的ID
@property (nonatomic) NSString *msgId;

///通知处理标记：0、未处理；1、已处理
@property (nonatomic) int32_t handleFlag;

// 处理结果：1、同意；2、拒绝
@property (nonatomic) int32_t handleResult;

// 通知的时间
@property (nonatomic) NSString *createDate;

// 消息的syncID，用于消息排序
@property (nonatomic) int64_t sortKey;

/**
 *  查询某种类型的通知
 *  @param msgType 通知消息的类型
 *  @return 返回的查询结果
 */
+ (NSArray *)get:(int32_t)msgType;

/**
 *  插入一条通知记录
 *  @param notify 插入的通知model
 *  @return 返回的操作结果
 */
+ (BOOL)insert:(FNGroupNotifyTable *)notify;

/**
 *  删除某一条通知消息
 *  @param messageId 消息的ID
 *  @return 返回的操作结果
 */
+ (BOOL)delete:(NSString *)messageId;

/**
 *  清空该表
 *  @return 返回的操作结果
 */
+ (BOOL)clearAll;

@end
