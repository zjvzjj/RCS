//
//  FNAccountArgs.m
//  FeinnoBopSDK
//
//  Created by wangshuying on 15/1/29.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNAccountArgs.h"

#import "GTMBase64.h"

#import "MakeCertPicRspRets.pb.h"
#import "VerifyCertPicRspRets.pb.h"
#import "RegisterWithCertPicRspRets.pb.h"
#import "LoginWithPwdRspRets.pb.h"
#import "ModifyPwdRspRets.pb.h"
#import "ResetPwdRspRets.pb.h"
#import "BNKickNotifyArgs.pb.h"
#import "StatusRspArgs.pb.h"
#import "UpdateDeviceInfoRspArgs.pb.h"
#import "SendWelcomeLanguageRspArgs.pb.h"


#pragma mark -
#pragma mark 图形验证码

@interface FNGetCertPicResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) int32_t picType;
@property (nonatomic, readwrite) NSString *certPicKey;
@property (nonatomic, readwrite) NSData *certPicData;
@property (nonatomic, readwrite) NSString *certPicValue;

@end

@implementation FNGetCertPicResponse

- (instancetype)initWithPBArgs:(MakeCertPicRspRets *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
        _picType = pbArgs.picType;
        _certPicData = [GTMBase64 decodeString:pbArgs.certPicBase64Str];
        _certPicKey = pbArgs.certPicKey;
        _certPicValue = pbArgs.certPicValue;
    }
    return self;
}

@end

@implementation FNVerifyCertPicRequest

@end

@interface FNVerifyCertPicResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNVerifyCertPicResponse

- (instancetype)initWithPBArgs:(VerifyCertPicRspRets *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
    }
    
    return self;
}

@end


#pragma mark -
#pragma mark 注册

@implementation FNRegisterRequest

@end

@interface FNRegisterResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *bopUID;

@end

@implementation FNRegisterResponse

- (instancetype)initWithPBArgs:(RegisterWithCertPicRspRets *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
        _bopUID = pbArgs.bopUid;
    }
    return self;
}

@end


#pragma mark -
#pragma mark 修改密码

@implementation FNModifyPwdRequest

@end

@interface FNModifyPwdResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNModifyPwdResponse

- (instancetype)initWithPBArgs:(ModifyPwdRspRets *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
    }
    return self;
}

@end

@implementation FNResetPwdRequest

@end

@interface FNResetPwdResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *theNewPwd;

@end

@implementation FNResetPwdResponse

- (instancetype)initWithPBArgs:(ResetPwdRspRets *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
        _theNewPwd = pbArgs.newPwd;
    }
    return self;
}

@end


#pragma mark -
#pragma mark 登录

@implementation FNLoginWithPwdReqest

@end

@interface FNLoginWithPwdResponse ()

@end

@implementation FNLoginWithPwdResponse

- (instancetype)initWithPBArgs:(LoginWithPwdRspRets *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
//        _credential = pbArgs.credencial;
    }
    return self;
}

@end

@interface FNLogoutResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNLogoutResponse

- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
    }
    return self;
}
@end

@interface FNKickNotifyArgs ()

@property (nonatomic, readwrite) NSString *eventType;
@property (nonatomic, readwrite) NSString *notifyDesc;
@property (nonatomic, readwrite) int32_t clientType;
@property (nonatomic, readwrite) NSString *clientVersion;

@end

@implementation FNKickNotifyArgs

- (instancetype)initWithPBArgs:(BNKickNotifyArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _eventType = pbArgs.eventType;
        _notifyDesc = pbArgs.notifyDesc;
        _clientType = pbArgs.clientType;
        _clientVersion =  pbArgs.clientVersion;
    }
    return self;
}

@end


#pragma mark -
#pragma mark 推送

@implementation FNUpdateDeviceInfoReqest

@end

@implementation FNUpdateDeviceInfoResponse

- (instancetype)initWithPBArgs:(UpdateDeviceInfoRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
    }
    return self;
}

@end

#pragma mark -
#pragma mark 首次登录

@implementation FNSendWelcomeLanguageRequest

@end

@implementation FNSendWelcomeLanguageResponse

- (instancetype)initWithPBArgs:(UpdateDeviceInfoRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
    }
    return self;
}

@end