//
//  NotifyLogic.h
//  feinno-sdk-imps
//
//  Created by wangshuying on 14-9-12.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FNPullNotifyRequest;
@class FNPullNotifyResponse;

/**
 *  系统平台发送系统消息的通知
 *
 *  其通知的object为FNSystemNotifyArgs类型的对象
 */
extern NSString *const NOTIFY_SYSTEM_NOTIFY;

/**
 *  通知逻辑类，该类内部处理各类消息通知，UI只需实现其初始化方法
 */
@interface FNNotifyLogic : NSObject

/**
 *  注册通知
 */
+ (void)startObserve;

/**
 *  注销通知
 */
+ (void)stopObserve;

/**
 *  拉取通知的方法
 *
 *  @param pullNotifyReq 拉取通知的请求参数
 *  @param callback      拉取通知的回调
 */
+ (void)getNotify:(FNPullNotifyRequest *)pullNotifyReq
         callback:(void(^)(FNPullNotifyResponse *rsp))callback;

@end
