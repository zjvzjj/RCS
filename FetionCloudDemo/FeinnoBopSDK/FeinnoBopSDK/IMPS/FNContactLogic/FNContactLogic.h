//
//  ContactLogic.h
//  feinno-sdk-imps
//
//  Created by doujinkun on 14-9-9.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNContactArgs.h"

/**
 *   联系人逻辑类，包含联系人的业务逻辑操作方法
 */
@interface FNContactLogic : NSObject

/**
 *  获取联系人列表信息的方法
 *
 *  @param getAddressListReq 获取联系人信息的请求参数
 *  @param callback          获取联系人信息的回调
 */
+ (void)getAddressList:(FNGetAddressListRequest *)getAddressListReq
              callback:(void(^)(FNGetAddressListResponse *rspArgs))callback;

/**
 *  上传或者更新联系人的方法
 *
 *  @param upAddressListReq 上传或者更新联系人的请求参数
 *  @param callback         上传或者更新联系人的回调
 */
+ (void)upAddressList:(FNUpAddressListRequest *)upAddressListReq
             callback:(void(^)(FNUpAddressListResponse *rspArgs))callback;

/**
 *  删除联系人的方法
 *
 *  @param delAddressListReq 删除联系人的请求参数
 *  @param callback          删除联系人的回调
 */
+ (void)delAddressList:(FNDelAddressListRequest *)delAddressListReq
              callback:(void(^)(FNDelAddressListResponse *rspArgs))callback;

/**
 *  查询关系链的方法
 *
 *  @param getRelationsReq 查询关系链的请求参数
 *  @param callback        查询关系链的回调
 */
+ (void)getRelationship:(FNGetRelationshipRequest *)getRelationsReq
               callback:(void(^)(FNGetRelationshipResponse *rspArgs))callback;

/**
 *  查询在线状态的方法
 *  @param presenceReq 查询在线状态的请求参数
 *  @param callback    查询在线状态的回调
 */
+ (void)getPresence:(FNGetPresenceRequest *)presenceReq
           callback:(void(^)(FNGetPresenceResponse *rspArgs))callback;

/**
 *  查询用户注册状态的方法
 *
 *  @param isRegReq 查询用户注册状态的请求
 *  @param callback 查询用户注册状态的回调
 */
+ (void)isRegisterUser:(FNIsRegisterRequest *)isRegReq
              callback:(void(^)(FNIsRegisterResponse *rspArgs))callback;

/**
 *  上传好友列表的方法
 *  @param uploadBuddyListReq 上传好友列表的请求参数
 *  @param callback           上传好友列表的回调
 */
+ (void)uploadBuddyList:(FNUploadBuddyListRequest *)uploadBuddyListReq
               callback:(void(^)(FNUploadBuddyListResponse *rspArgs))callback;

@end
