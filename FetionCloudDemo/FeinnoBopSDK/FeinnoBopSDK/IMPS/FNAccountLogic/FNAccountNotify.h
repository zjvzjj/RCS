//
//  FNAccountNotify.h
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-13.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  被踢下线通知
 *
 *  其通知的object为FNKickNotifyArgs类型对象
 */
extern NSString *const NOTIFY_KICKED;

/**
 *  个人在线状态变化通知
 *  
 *  其通知的object为FNLoginStatus的NSNumber对象
 */
extern NSString *const NOTIFY_LOGIN_STATUS_CHANGED;

/**
 *  断线重连通知
 */
extern NSString *const NOTIFY_RECONNECT_SUCCESSED;

/**
 *  锁屏后重连通知
 */
extern NSString *const NOTIFY_AUTORECONNECT;

@interface FNAccountNotify : NSObject

/**
 *  注册通知。希望监听NOTIFY_KICKED等通知时，需要调用此函数。
 */
+ (void)startObserve;

/**
 *  注销通知。如果监听了NOTIFY_KICKED等通知，注销登录时需要调用此函数。
 */
+ (void)stopObserve;

@end
