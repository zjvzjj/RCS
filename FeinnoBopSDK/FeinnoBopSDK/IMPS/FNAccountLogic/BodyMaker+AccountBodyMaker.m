//
//  BodyMaker+AccountBodyMaker.m
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/2/9.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "BodyMaker+AccountBodyMaker.h"
#import "VerifyCertPicReqArgs.pb.h"
#import "ModifyPwdReqArgs.pb.h"
#import "RegisterWithCertPicReqArgs.pb.h"
#import "RegisterWithSmsReqArgs.pb.h"
#import "LoginArgs.pb.h"
#import "ResetPwdReqArgs.pb.h"
#import "KeepAliveArgs.pb.h"
#import "UpdateDeviceInfoReqArgs.pb.h"
#import "SendWelcomeLanguageReqArgs.pb.h"

@implementation BodyMaker (AccountBodyMaker)

+ (NSData *)makeVerifyCertPicReqArgs:(NSString *)certPicKey
                         verifyValue:(NSString *)verifyValue
{
    VerifyCertPicReqArgs_Builder *builder = [[VerifyCertPicReqArgs_Builder alloc] init];
    builder.certPicKey = certPicKey;
    builder.verifyValue = verifyValue;
    
    VerifyCertPicReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeRegisterReqArgs:(int32_t)regType
                       regValue:(NSString *)regValue
                       password:(NSString *)pwd
                     certPicKey:(NSString *)cpKey
                   certPicValue:(NSString *)cpValue
{
    RegisterWithCertPicReqArgs_Builder *builder = [[RegisterWithCertPicReqArgs_Builder alloc] init];
    builder.regType = regType;
    builder.regValue = regValue;
    builder.pwd = pwd;
    builder.certPicKey = cpKey;
    builder.certPicValue = cpValue;
    
    RegisterWithCertPicReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeSmsRegisterReqArgs:(int32_t)regType
                            userId:(NSString *)userid
                          password:(NSString *)pwd
                            smsKey:(NSString *)smsKey
                           smsCode:(NSString *)smsCode
{
    RegisterWithSmsReqArgs_Builder *builder = [[RegisterWithSmsReqArgs_Builder alloc] init];
    builder.regType = regType;
    builder.regValue = userid;
    builder.pwd = pwd;
    builder.smsKey = smsKey;
    builder.smsValue = smsCode;
    
    RegisterWithSmsReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeModifyPwdReqArgs:(int32_t)regType
                        regValue:(NSString *)regValue
                          newPwd:(NSString *)newPwd
{
    ModifyPwdReqArgs_Builder *buidler = [[ModifyPwdReqArgs_Builder alloc] init];
    buidler.regType = regType;
    buidler.regValue = regValue;
    buidler.passwd = newPwd;
    ModifyPwdReqArgs *args = [buidler build];
    
    return args.data;
}

+ (NSData *)makeResetPwdReqArgs:(int32_t)regType
                       regValue:(NSString *)regValue
{
    ResetPwdReqArgs_Builder *builder = [[ResetPwdReqArgs_Builder alloc] init];
    builder.regType = regType;
    builder.regValue = regValue;
    ResetPwdReqArgs *args = [builder build];
    
    return args.data;
}

+ (NSData *)makeReg2ReqArgs:(int32_t)loginType
                 loginValue:(NSString *)loginValue
                   password:(NSString *)pwd
                   platform:(NSString *)platform
                    version:(NSString *)version
                machineCode:(NSString *)machineCode
                 verifyType:(int32_t)verifyCode
                 sdkVersion:(NSString *)sdkVersion
{
    LoginArgs_Builder *builder = [[LoginArgs_Builder alloc] init];
    builder.loginType = loginType;
    builder.loginValue = loginValue;
    builder.pwd = pwd;
    builder.machineCode = machineCode;
    builder.verifyCode = verifyCode;
    builder.sdkVersion = sdkVersion;
    
    LoginArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeKeepAliveArgs:(long)sysSyncId
{
    KeepAliveArgs_Builder *builder = [[KeepAliveArgs_Builder alloc] init];
    builder.sysMsgId = sysSyncId;
    
    KeepAliveArgs *args = builder.build;    
    return args.data;
}

+ (NSData *)makeUpdateDeviceInfoReqArgs:(NSString *)userId
                             clientType:(NSString *)clientType
                          clientVersion:(NSString *)clientVersion
                                  token:(NSString *)token
{
    UpdateDeviceInfoReqArgs_Builder *builder = [[UpdateDeviceInfoReqArgs_Builder alloc] init];
    builder.userId = userId;
    builder.clientType = clientType;
    builder.clientVersion = clientVersion;
    builder.token = token;
    
    UpdateDeviceInfoReqArgs *args = builder.build;
    return args.data;
}

+ (NSData *)makeSendWelcomeLanguageReqArgs:(int32_t)isFirstLogin
{
    SendWelcomeLanguageReqArgs_Builder *builder = [[SendWelcomeLanguageReqArgs_Builder alloc] init];
    builder.isFirstLogin = isFirstLogin;
    
    SendWelcomeLanguageReqArgs *args = builder.build;
    return args.data;
}

@end
