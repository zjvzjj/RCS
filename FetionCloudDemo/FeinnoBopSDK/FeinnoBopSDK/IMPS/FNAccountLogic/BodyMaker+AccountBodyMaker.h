//
//  BodyMaker+AccountBodyMaker.h
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/2/9.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "BodyMaker.h"

@interface BodyMaker (AccountBodyMaker)

+ (NSData *)makeVerifyCertPicReqArgs:(NSString *)certPicKey
                         verifyValue:(NSString *)verifyValue;

+ (NSData *)makeRegisterReqArgs:(int32_t)regType
                       regValue:(NSString *)regValue
                       password:(NSString *)pwd
                     certPicKey:(NSString *)cpKey
                   certPicValue:(NSString *)cpValue;

+ (NSData *)makeSmsRegisterReqArgs:(int32_t)regType
                            userId:(NSString *)userid
                          password:(NSString *)pwd
                            smsKey:(NSString *)smsKey
                           smsCode:(NSString *)smsCode;

+ (NSData *)makeModifyPwdReqArgs:(int32_t)regType
                        regValue:(NSString *)regValue
                          newPwd:(NSString *)newPwd;

+ (NSData *)makeResetPwdReqArgs:(int32_t)regType
                       regValue:(NSString *)regValue;

+ (NSData *)makeReg2ReqArgs:(int32_t)loginType
                 loginValue:(NSString *)loginValue
                   password:(NSString *)pwd
                   platform:(NSString *)platform
                    version:(NSString *)version
                machineCode:(NSString *)machineCode
                 verifyType:(int32_t)verifyCode
                 sdkVersion:(NSString *)sdkVersion;

+ (NSData *)makeKeepAliveArgs:(long)sysSyncId;

+ (NSData *)makeUpdateDeviceInfoReqArgs:(NSString *)userId
                             clientType:(NSString *)clientType
                          clientVersion:(NSString *)clientVersion
                                  token:(NSString *)token;

+ (NSData *)makeSendWelcomeLanguageReqArgs:(int32_t)isFirstLogin;

@end
