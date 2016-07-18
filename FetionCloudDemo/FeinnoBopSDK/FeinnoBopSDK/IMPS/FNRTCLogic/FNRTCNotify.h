//
//  FNRTCNotify.h
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-14.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  主叫邀请联系人建立音视频会话的请求通知
 *
 *  其通知的object为FNRtcInviteRequest类型的对象
 */
extern NSString *const NOTIFY_RTC_INVITE;

/**
 *  被叫对音视频会话进行回复的请求通知
 *
 *  其通知的object为FNRtcReplyRequest类型的对象
 */
extern NSString *const NOTIFY_RTC_REPLY;

/**
 *  会话变更的请求通知
 *
 *  其通知的object为FNRtcUpdateRequest类型的对象
 */
extern NSString *const NOTIFY_RTC_UPDATE;

/**
 *  音视频通知
 *
 *  其通知的object为FNAVNotifyInfoNotifyArgs类型的对象
 */
extern NSString *const NOTIFY_AV_INVITE;

@interface FNRTCNotify : NSObject

/**
 *  注册通知。希望监听NOTIFY_RTC_INVITE、NOTIFY_RTC_REPLY、NOTIFY_RTC_UPDATE、NOTIFY_AV_INVITE通知时，需要调用此函数。
 */
+ (void)startObserve;

/**
 *  注销通知。如果监听了NOTIFY_RTC_INVITE、NOTIFY_RTC_REPLY、NOTIFY_RTC_UPDATE、NOTIFY_AV_INVITE通知，注销登录时需要调用此函数。
 */
+ (void)stopObserve;

@end
