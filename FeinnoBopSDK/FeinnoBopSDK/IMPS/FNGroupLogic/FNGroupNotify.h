//
//  FNGroupNotify.h
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-13.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通知群列表变更
 *
 *  其通知的object为FNGroupListChangeNotifyArgs类型对象
 */
extern NSString *const NOTIFY_GROUP_LIST_CHANGED;

/**
 *  邀请加入群组的邀请通知，接收到通知之后请调用FNGroupLogic内的 handleApproveInvite:callback: 方法
 *
 *  其通知的object为FNApproveInviteJoinGroupNtfArgs类型对象
 */
extern NSString *const NOTIFY_APPROVE_INVITE_JOIN_GROUP;

/**
 *  管理员拒绝用户邀请某人入群的通知，接收到通知之后请调用UI做相应的通知处理
 *
 *  其通知的object为FNRefuseInviteJoinGroupNtfArgs类型对象
 */
extern NSString *const NOTIFY_REFUSE_INVITE_JOIN_GROUP;

/**
 *  成员加入群组通知
 *
 *  其通知的object为FNJoinGroupNtfItem类型对象
 */
extern NSString *const NOTIFY_JOIN_GROUP;

/**
 *  成员退出群组通知
 *
 *  其通知的object为FNExitGroupNtfItem类型对象
 */
extern NSString *const NOTIFY_EXIT_GROUP;

/**
 *  群主变更通知
 */
extern NSString *const NOTIFY_OWNER_CHANGE_GROUP;

/**
 *  群成员昵称变更通知
 */
extern NSString *const NOTIFY_GROUP_MEMBERNAME_CHANGE;

/**
 *  群成员头像变更通知
 */
extern NSString *const NOTIFY_GROUP_MEMBERPROTRAITURL_CHANGE;

@interface FNGroupNotify : NSObject

/**
 *  注册通知。希望监听NOTIFY_GROUP_LIST_CHANGED、NOTIFY_APPROVE_INVITE_JOIN_GROUP、NOTIFY_REFUSE_INVITE_JOIN_GROUP等通知时，需要调用此函数。
 */
+ (void)startObserve;

/**
 *  注销通知。如果监听了NOTIFY_GROUP_LIST_CHANGED、NOTIFY_APPROVE_INVITE_JOIN_GROUP、NOTIFY_REFUSE_INVITE_JOIN_GROUP等通知，注销登录时需要调用此函数。
 */
+ (void)stopObserve;

@end
