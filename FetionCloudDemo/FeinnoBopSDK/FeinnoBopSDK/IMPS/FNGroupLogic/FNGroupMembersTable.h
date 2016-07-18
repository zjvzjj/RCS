//
//  FNGroupMembersTable.h
//  feinno-sdk-db
//
//  Created by doujinkun on 14/11/21.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  群组/讨论组成员的模型
 */
@interface FNGroupMembersTable : NSObject

@property (nonatomic) NSString *ownerId;

/**
 *  群id
 */
@property (nonatomic, copy) NSString *groupId;

/**
 *  群成员的id
 */
@property (nonatomic, copy) NSString *memberID;

/** 
 *  群成员昵称
 */
@property (nonatomic, copy) NSString *memberNickName;

/**
 *  群成员头像
 */
@property (nonatomic, copy) NSString *memberProtaitUrl;

/**
 * 用户身份，0创建者，1普通成员
 */
@property (nonatomic) int32_t identity;

/**
 *  群名称
 */
@property (nonatomic) NSString *groupName;

/**
 *  根据群id获取群的信息列表
 *
 *  @param groupId 要查询群成员的群组ID
 *
 *  @return 获取的群组成员信息数组，数组内是FNGroupMemebersTable类型的变量
 */
+ (NSMutableArray *)get:(NSString *)groupId;

/**
 *  根据输入的名字获取群成员
 *
 *  @param memberNickName 群成员名字
 *  @param number         每页数量
 *  @param page           页数
 *  @param groupId        群id,置nil为所有群
 *
 *  @return 获取的群组成员信息数组，数组内是FNGroupMemebersTable类型的变量
 */
+ (NSMutableArray *)getGroupMemberByNickName:(NSString *)memberNickName number:(int32_t)number page:(int32_t)page groupId:(NSString *)groupId;

/**
 *  插入群信息记录
 *
 *  @param groupInfo 要插入的群信息模型信息
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)insert:(FNGroupMembersTable *)groupInfo;

/**
 *  根据群的id和要删除的群成员的id删除db中的群成员信息
 *
 *  @param memberID 要删除记录的群成员的ID, 当其为nil时，删除该群组所有成员
 *  @param groupId  要删除记录的群成员所在群组ID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)delete:(NSString *)memberID
       groupId:(NSString *)groupId;

/**
 *  更改群主信息
 *
 *  @param memberID 要更新记录的原群主的ID
 *  @param groupOwnerId 要更新记录的新群主的ID
 *  @param groupId  要更新记录的群主所在群组ID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)update:(NSString *)groupId
        memberId:(NSString *)memberId
    groupOwnerId:(NSString *)groupOwnerId;

/**
 *  更改群成员昵称
 *
 *  @param groupMemberNickName 群成员昵称
 *  @param memberId            群成员id
 *  @param groupId             群id
 *
 *  @return 返回参数，标志是否成功
 */
+ (BOOL)updateGroupMemberNickName:(NSString *)groupMemberNickName
                         memberId:(NSString *)memberId
                          groupId:(NSString *)groupId;

/**
 *  更新群成员头像
 *
 *  @param memberGroupProtaitUrl 群成员头像
 *  @param memberId        成员ID
 *  @param groupId         群id
 *
 *  @return 返回参数，标志是否成功
 */
+ (BOOL)updateGroupMemberProtaitUrl:(NSString *)memberGroupProtaitUrl
                           memberId:(NSString *)memberId
                            groupId:(NSString *)groupId;
/**
 *  清空群成员列表
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)clearAll;

@end
