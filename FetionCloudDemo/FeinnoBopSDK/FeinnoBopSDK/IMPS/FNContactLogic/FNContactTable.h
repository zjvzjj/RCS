//
//  FNContactTable.h
//  feinno-sdk-db
//
//  Created by doujinkun on 14-8-25.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  联系人的模型，demo只演示存储联系人的姓名、手机号码和邮箱
 */
@interface FNContactTable : NSObject

// 联系人姓名
@property (nonatomic, copy) NSString *name;

// 联系人手机号
@property (nonatomic, copy) NSString *mobileNo;

// 联系人邮箱邮箱
@property (nonatomic, copy) NSString *email;

// 联系人的ID
@property (nonatomic, copy) NSString *userID;

// 联系人注册状态
@property (nonatomic, assign) int32_t registerStatus;

// 关系
@property (nonatomic, assign) int32_t relationship;

// 关联的userID
@property (nonatomic, copy) NSString *relationshipUserID;

// 扩展
@property (nonatomic, copy) NSString *extension;

// 版本号
@property (nonatomic, assign) int64_t version;

/**
 *  获取联系人信息列表
 *
 *  @return 获取的联系人信息数组，数组内是FNContactTable类型的变量
 */
+ (NSMutableArray *)get;

/**
 *  获取好友信息
 *
 *  @param userId 好友用户的ID
 *
 *  @return 返回的实例变量
 */
+ (instancetype)get:(NSString *)userId;

/**
 *  向联系人表内插入一条记录
 *
 *  @param contact 插入的模型参数
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)insert:(FNContactTable *)contact;

/**
 *  根据其手机号删除db中的联系人信息
 *
 *  @param mobileNo 被删除联系人的手机号
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)delete:(NSString *)mobileNo;

/**
 *  清空数据表
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)clearAll;

@end
