//
//  FNAccountArgs.h
//  FeinnoBopSDK
//
//  Created by wangshuying on 15/1/29.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MakeCertPicRspRets;
@class VerifyCertPicRspRets;
@class RegisterWithCertPicRspRets;
@class LoginWithPwdRspRets;
@class ModifyPwdRspRets;
@class ResetPwdRspRets;
@class StatusRspArgs;
@class UpdateDeviceInfoRspArgs;
@class SendWelcomeLanguageRspArgs;

#pragma mark -
#pragma mark 图形验证码

/**
 *  获取图片验证码的应答类
 */
@interface FNGetCertPicResponse : NSObject

// 获取图验的返回码：200 成功  500 服务器错误
@property (nonatomic, readonly) int32_t statusCode;

// 获取图验的图片类型：0 JPG  1 PNG  2 JPEG
@property (nonatomic, readonly) int32_t picType;

// 对应图片验证码的唯一key
@property (nonatomic, readonly) NSString *certPicKey;

// 图片数据
@property (nonatomic, readonly) NSData *certPicData;

// 图片上显示的字符串
@property (nonatomic, readonly) NSString *certPicValue;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(MakeCertPicRspRets *)pbArgs;

@end

/**
 *  对已获取图形验证码的有效性进行校验的请求类
 */
@interface FNVerifyCertPicRequest : NSObject

// 对应图片验证码的唯一key
@property (nonatomic) NSString *certPicKey;

// 验证码对应的输入值
@property (nonatomic) NSString *verifyValue;

@end

/**
 *  对已获取图形验证码的有效性进行校验的应答类
 */
@interface FNVerifyCertPicResponse : NSObject

// 校验操作的返回码 200 成功   401 验证未通过   500 服务器内部错误
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(VerifyCertPicRspRets *)pbArgs;

@end


#pragma mark -
#pragma mark 注册

/**
 *  账户注册的请求类
 */
@interface FNRegisterRequest : NSObject

// 注册账户的用户名
@property (nonatomic) NSString *userID;

// 注册账户的密码
@property (nonatomic) NSString *pwd;

// 验证码
@property (nonatomic) NSString *verificationCode;

@end

/**
 *  账户注册的应答类
 */
@interface FNRegisterResponse : NSObject

// 注册返回码：200 成功  400 注册类型不支持  420 图验失败  430 用户已存在  500 服务器内部错误
@property (nonatomic, readonly) int32_t statusCode;

// BOP 平台唯一标示
@property (nonatomic, readonly) NSString *bopUID;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(RegisterWithCertPicRspRets *)pbArgs;

@end


#pragma mark -
#pragma mark 修改密码

/**
 *  修改密码的请求类
 */
@interface FNModifyPwdRequest : NSObject

// 原密码
@property (nonatomic) NSString *oldPwd;

// 新密码
@property (nonatomic) NSString *theNewPwd;

@end

/**
 *  修改密码的应答类
 */
@interface FNModifyPwdResponse : NSObject

// 修改密码的返回码：200 成功  400 不支持的验证类型  404 账号不存在  500 服务器错误
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(ModifyPwdRspRets *)pbArgs;

@end

/**
 *  重置密码的请求类
 */
@interface FNResetPwdRequest : NSObject

// 要重置密码的用户名
@property (nonatomic) NSString *userID;

@end

/**
 *  重置密码的应答类
 */
@interface FNResetPwdResponse : NSObject

// 重置密码请求的返回码: 200 成功  400 不支持的登录类型  404 账户不存在  500 服务器错误
@property (nonatomic, readonly) int32_t statusCode;

// 重置后的新密码
@property (nonatomic, readonly) NSString *theNewPwd;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(ResetPwdRspRets *)pbArgs;
@end


#pragma mark -
#pragma mark 登录

/**
 *  密码登录的请求类
 */
@interface FNLoginWithPwdReqest : NSObject

// 登录用户名，必填
@property (nonatomic) NSString *userID;

// 登录用户的密码，必填
@property (nonatomic) NSString *pwd;

// 登录用户的昵称，必填
@property (nonatomic) NSString *nickname;

// 设备标识码
@property (nonatomic) NSString *machineCode;

// 验证类型，与pwd属性组合使用，0为密码验证 1为token验证，由SDK与UI协定
@property (nonatomic) int32_t verifyType;

@end

/**
 *  登录请求的应答类
 */
@interface FNLoginWithPwdResponse : NSObject

// 登录的返回码：200 成功 400 参数错误  401 密码错误  404 账户不存在  500 服务器错误
@property (nonatomic, assign) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(LoginWithPwdRspRets *)pbArgs;

@end

/**
 *  注销登录的应答类
 */
@interface FNLogoutResponse : NSObject

// 注销登录的状态码
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs;

@end

@class BNKickNotifyArgs;

/**
 *  被踢下线的通知类
 */
@interface FNKickNotifyArgs : NSObject

/**
 *   eventType有3种值，对应了不同的含义。
 *   other-device-kicked: 在其他设备登录
 *   custom: 用户被踢下线
 *   password-changed: 由于密码变更被踢下线
 */
// 被踢操作的类型
@property (nonatomic, readonly) NSString *eventType;

// 通知信息的描述
@property (nonatomic, readonly) NSString *notifyDesc;

// 踢人方的客户端类型
@property (nonatomic, readonly) int32_t clientType;

// 踢人方的客户端版本号
@property (nonatomic, readonly) NSString *clientVersion;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(BNKickNotifyArgs *)pbArgs;

@end


#pragma mark -
#pragma mark 推送

/**
 *  更新PUSH Token信息的请求类
 */
@interface FNUpdateDeviceInfoReqest : NSObject

// 登录用户名
@property (nonatomic) NSString *userID;

// 客户端类型
@property (nonatomic) NSString *clientType;

// 客户端版本号
@property (nonatomic) NSString *clientVersion;

// 设备token
@property (nonatomic) NSString *token;

@end

/**
 *  更新PUSH Token信息的应答类
 */
@interface FNUpdateDeviceInfoResponse : NSObject

// 返回码：200 成功  500 服务器错误
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(UpdateDeviceInfoRspArgs *)pbArgs;

@end

/**
 *  首次登录时发送给sever的请求类
 */
@interface FNSendWelcomeLanguageRequest : NSObject

// 是否第一次登录
@property (nonatomic) int32_t isFirstLogin;

@end

/**
 *  首次登录时发送给sever的响应类
 */
@interface FNSendWelcomeLanguageResponse : NSObject

// 返回码：200 成功  500 服务器错误
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(SendWelcomeLanguageRspArgs *)pbArgs;

@end
