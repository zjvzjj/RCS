//
//  FNGroupTable.h
//  feinno-sdk-db
//
//  Created by doujinkun on 14/11/13.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  群组表模型
 */
@interface FNGroupTable : NSObject

/**
 *  群组的ID
 */
@property (nonatomic) NSString *groupId;

/**
 *  群组的名字
 */
@property (nonatomic, copy) NSString *groupName;

/**
 *  群组的头像
 */
@property (nonatomic, copy) NSString *groupProtaitUrl;

/**
 *  群组类型，区分普通群和讨论组，1为普通群 2为讨论组
 */
@property (nonatomic, assign) unsigned int groupType;

/**
 *  本用户在群组的昵称
 */
@property (nonatomic) NSString *userNickname;

/**
 *  本用户在群组中的身份
 */
@property (nonatomic) int32_t identity;

/**
 *  本用户在群中的设置
 */
@property (nonatomic) int32_t config;

/**
 *  查询某个群的信息
 *
 *  @param groupId   要查询的群的ID
 *  @param groupType 要查询的类型，1群，2讨论组
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (NSMutableArray *)get:(NSString *)groupId
              groupType:(int32_t)groupType;

/**
 *  查询某个群的信息
 *
 *  @param groupId   要查询的群的ID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (NSMutableArray *)get:(NSString *)groupId;

/**
 *  插入一条群信息的记录
 *
 *  @param groupInfo 群信息的模型参数
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)insert:(FNGroupTable *)groupInfo;

/**
 *  更新群信息
 *
 *  @param groupId 要更新的群的id
 *
 *  @param groupName 设置的群的新的名称
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)update:(NSString *)groupId
     groupName:(NSString *)groupName;

/**
 *  更新群头像
 *
 *  @param groupId         群id
 *  @param groupProtaitUrl 群头像
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)update:(NSString *)groupId groupProtaitUrl:(NSString *)groupProtaitUrl;

/**
 *  更新群配置
 *
 *  @param groupId     群id
 *  @param groupConfig 群配置
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)update:(NSString *)groupId groupConfig:(int32_t)groupConfig;

/**
 *  删除一个群的信息
 *
 *  @param groupId 要删除的群的ID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)delete:(NSString *)groupId;

/**
 *  清空群信息表
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)clearAll;

/**
 *  清空群/讨论组
 *
 *  @param groupType 类型
 *
 *  @return 操作是否成功
 */
+ (BOOL)clear:(int32_t)groupType;

@end
