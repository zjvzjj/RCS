//
//  FNUserTable.h
//  feinno-sdk-db
//
//  Created by wangshuying on 14-8-22.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNEnum.h"

/**
 *  用户表的模型
 */
@interface FNUserTable : NSObject

// 当前登录用户的ID
@property (nonatomic, strong) NSString *currentLoginId;

// 用户的ID
@property (nonatomic, strong) NSString *userId;

// 用户的邮箱地址
@property (nonatomic, strong) NSString *email;

// 用户的手机号码
@property (nonatomic, assign) long mobileNo;

// 用户名
@property (nonatomic, strong) NSString *name;

// 群列表版本号
@property (nonatomic, assign) long groupListVersion;

// 两人的syncID
@property (nonatomic, assign) long privateSyncID;

// 群的syncID
@property (nonatomic, assign) long pgSyncID;

// 通知的syncID
@property (nonatomic, assign) long ntfSyncID;

// 系统消息的syncId
@property (nonatomic, assign) long sysSyncId;

/**
 *  查询当前登录用户的信息
 *
 *  @return 返回该类实例
 */
+ (instancetype)get;

/**
 *  插入一条用户信息记录
 *
 *  @param user 用户信息模型参数
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)insert:(FNUserTable *)user;

/**
 *  删除用户信息记录
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)delete;

/**
 *  设置用户的groupListVersion
 *
 *  @param groupListVersion 群组列表版本号
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)setGroupListVersion:(long)groupListVersion;

/**
 *  获取用户的groupListVersion
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (long)getGroupListVersion;

/**
 *  设置syncID，由SDK调用
 *
 *  @param event  syncID的类型
 *  @param syncId 更新的syncID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)setSyncId:(EventType)event
           syncId:(int64_t)syncId;

/**
 *  获取某种类型的syncID，由SDK调用
 *
 *  @param event 获取的syncID的类型
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (long)getSyncId:(EventType)event;

/**
 *  设置lastRmsId
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)setHistoryLastRmsId:(NSString *)lastRmsId;

/**
 *  获得拉取历史消息的lastRmsId
 *
 *  @return 返回参数，返回拉取历史消息的起始位置
 */
+ (NSString *)getHistoryLastRmsId;

@end
