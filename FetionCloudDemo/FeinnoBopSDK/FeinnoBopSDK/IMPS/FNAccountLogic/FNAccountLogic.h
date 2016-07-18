//
//  AccountLogic.h
//  feinno-sdk-imps
//
//  Created by yaodongsheng on 14-7-22.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNAccountArgs.h"

/**
 *  用户账户逻辑类，包含用户账户的注册、登录、注销、密码管理等方法
 */
@interface FNAccountLogic : NSObject

/**
 *  获取单例
 *
 *  @return FNAccountLogic对象
 */
+ (instancetype)sharedInstance;

/**
 *  设置token 用来激活sdk
 *
 *  @param token  token
 *  @param userid userid（bopid）
 */
+ (void)setToken:(NSString *)token userId:(NSString *)userid;
/**
 *  注销登录
 *
 *  @param callback 注销登录的回调
 */
+ (void)logout:(void(^)(FNLogoutResponse *rspArgs))callback;

/**
 *  更新push token
 *
 *  @param updateReq 更新push token的请求参数
 *  @param callback  更新push token的回调
 */
+ (void)updateDeviceInfo:(FNUpdateDeviceInfoReqest *)updateReq
                callback:(void (^)(FNUpdateDeviceInfoResponse *updateRsp))callback;

/**
 *  删除push token
 *
 *  @param callback  删除push token的回调
 */
+ (void)deleteDeviceInfo:(void (^)(FNUpdateDeviceInfoResponse *deleteRsp))callback;

/**
 *  首次登录发送问候语
 *
 *  @param request  请求类
 *  @param callback 回调响应
 */
+ (void)sendWelcomeLanguage:(FNSendWelcomeLanguageRequest *)request
                   callback:(void(^)(FNSendWelcomeLanguageResponse *rspArgs))callback;

/**
 *  首次登录发送群问候语
 *
 *  @param request
 *  @param callback 回调响应
 */
+ (void)sendGroupWelcomeLanguage:(FNSendWelcomeLanguageRequest *)request
                        callback:(void(^)(FNSendWelcomeLanguageResponse *rspArgs))callback;
@end
