//
//  FNMsgNotify.h
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-13.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通知有新的消息
 *
 *  其通知的object为包含FNMsgTable类型的NSArray
 */
extern NSString *const NOTIFY_HAS_NEW_MSG;

/**
 *  通知有新的自定义消息
 *
 *  其通知的object为FNSendSimpleMsgNtfItem
 */
extern NSString *const NOTIFY_HAS_NEW_SIMPLE_MSG;

@interface FNMsgNotify : NSObject

/**
 *  注册通知。希望监听NOTIFY_HAS_NEW_MSG、NOTIFY_HAS_NEW_SIMPLE_MSG通知时，需要调用此函数。
 */
+ (void)startObserve;

/**
 *  注销通知。如果监听了NOTIFY_HAS_NEW_MSG、NOTIFY_HAS_NEW_SIMPLE_MSG通知，注销登录时需要调用此函数。
 */
+ (void)stopObserve;

@end
