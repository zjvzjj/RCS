//
//  AccountLogic.m
//  feinno-sdk-imps
//
//  Created by yaodongsheng on 14-7-22.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNAccountLogic.h"
#import "FNUserTable.h"

#import "FNAccountNotify.h"
#import "FNNotifyLogic.h"
#import "FNMsgNotify.h"
#import "FNGroupMsgNotify.h"
#import "FNGroupNotify.h"
#import "FNAccountNotify.h"
#import "FNNotifyLogic.h"

#import "FNServerConfig.h"
#import "FNSystemConfig.h"
#import "FNUserConfig.h"

#import "FNDBManager.h"

// net request
#import "CMD.h"
#import "McpRequest.h"
#import "BOPReachability.h"

// protocol
#import "BodyMaker+AccountBodyMaker.h"
#import "MakeCertPicRspRets.pb.h"
#import "RegisterWithCertPicRspRets.pb.h"
#import "RegisterWithSmsRspRets.pb.h"
#import "LoginArgs.pb.h"
#import "LoginWithPwdRspRets.pb.h"
#import "ModifyPwdRspRets.pb.h"
#import "ResetPwdRspRets.pb.h"
#import "StatusRspArgs.pb.h"
#import "KeepAliveResult.pb.h"
#import "UpdateDeviceInfoRspArgs.pb.h"

// utils
#import "NSData+DataEncrypt.h"
#import "Utility.h"
#import "NSString+Extension.h"

// login token
#import "SignInfoV4Serializer.h"
#import "SignInfoV4.h"
#import "GTMBase64.h"

#define CONNECT_TIMES_MAX 3

static FNAccountLogic *instance = nil;

@interface FNAccountLogic ()

@property (nonatomic, strong) NSTimer *keepAliveTimer;
@property (nonatomic, strong) NSTimer *keepAliveTimeoutTimer;
@property (nonatomic, strong) NSTimer *connectTimer;
@property (nonatomic, assign) NSUInteger connectTimes;
@property (nonatomic, strong) FNLoginWithPwdReqest *loginRequest;
@property (nonatomic, strong) BOPReachability *reachability;

@end

@implementation FNAccountLogic

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil)
        {
            instance = [[FNAccountLogic alloc] init];
        }
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.connectTimes = 0;
        self.reachability = [BOPReachability reachabilityWithHostName:@"www.baidu.com"];
        [self.reachability startNotifier];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(recvNetworkChangedNotification:)
                                                     name:_kBOPReachabilityChangedNotification
                                                   object:nil];
    }
    return self;
}

+ (void)pwdLogin:(FNLoginWithPwdReqest *)loginReq
        callback:(void (^)(FNLoginWithPwdResponse *))callback
{
    if ([NSString isNullString:loginReq.userID] ||
        [NSString isNullString:loginReq.pwd] ||
        [NSString isNullString:loginReq.nickname])
    {
        NSLog(@"feinno login check parameters is null :userID:%@,token:%@,nickname:%@",loginReq.userID,loginReq.pwd,loginReq.nickname);
        FNLoginWithPwdResponse *rsp = [[FNLoginWithPwdResponse alloc] init];
        rsp.statusCode = 400;
        callback(rsp);
        return;
    }
    [FNAccountLogic sharedInstance];
    [FNUserConfig getInstance].loginStatus = FNLoginStatusConnecting;
    instance.loginRequest = loginReq;

    NSString *userId = [Utility userIdWithAppKey:loginReq.userID];
    
    [Utility initMcpRequest];
    
    // 重新登录时先释放掉已有的socket
    [[McpRequest sharedInstance] disConnect];
    
    NSString *response = nil;
    if (loginReq.verifyType == 1)
    {
        response = loginReq.pwd;
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *time = [dateFormatter stringFromDate:[NSDate date]];
        response = [FNAccountLogic encrypt:userId
                                  password:loginReq.pwd
                               encryptTime:time];
    }

    int32_t loginType = [self getLoginType:userId];
    NSData *body = [BodyMaker makeReg2ReqArgs:loginType loginValue:userId password:response platform:@"iOS" version:[FNSystemConfig getVersion] machineCode:@"000000" verifyType:loginReq.verifyType sdkVersion:@""];
    
    [[McpRequest sharedInstance] send:CMD_REG2 userid:userId body:body callback:^(NSData *data)
     {
         NSLog(@"feinno %@ login back",response);
        if ( nil != data )
        {
            PacketObject *packetObject = [McpRequest parse:data];
            LoginWithPwdRspRets *rspArgs = (LoginWithPwdRspRets *)packetObject.args;
            FNLoginWithPwdResponse *loginRsp = [[FNLoginWithPwdResponse alloc] initWithPBArgs:rspArgs];
            
            // 成功则开始心跳,并初始化
            if (200 == loginRsp.statusCode)
            {
                NSLog(@"feinno %@ login success - connectTimes %lu",userId,(unsigned long)instance.connectTimes);
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_RECONNECT_SUCCESSED object:nil];
//                //TODO:分离
//                if (instance.connectTimes > 0)
//                {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_RECONNECT_SUCCESSED object:nil];
//                }
//                else
//                {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"BopConnectSuccess" object:nil];
//                }
                
                [instance stopConnectTimer];
                instance.connectTimes = 0;

                // 初始化配置
                [FNUserConfig initWithUserid:loginReq.userID];
                [FNUserConfig setCStr:loginReq.pwd];
//                [FNUserConfig setCStr:rspArgs.credencial];//暂时不要用
                [FNUserConfig setNickName:loginReq.nickname];
                [FNUserConfig updateLoginStatus:FNLoginStatusOnline];

                [instance startKeepAlive];

                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(onKickOff)
                                                             name:NOTIFY_KICKED
                                                           object:nil];
                [FNAccountNotify startObserve];
                [FNNotifyLogic startObserve];
                [FNMsgNotify startObserve];
                [FNGroupMsgNotify startObserve];
                [FNGroupNotify startObserve];
                
                // 写user表  数据持久化，写入DB
                [FNDBManager initDB:loginReq.userID];
                FNUserTable *userInfo = [FNUserTable get];
                if (userInfo == nil)
                {
                    userInfo = [[FNUserTable alloc] init];
                }
                userInfo.userId = loginReq.userID;
                
                [FNUserTable insert:userInfo];
            }
            else
            {
                //TODO:TOKEN失效
                [FNUserConfig updateLoginStatus:FNLoginStatusOffline];
                NSLog(@"feinno %@ login error : %d ",loginReq.userID,loginRsp.statusCode);
            }
            
            callback(loginRsp);
        }
        else
        {
            NSLog(@"feinno %@ login error data nil",loginReq.userID);
            [FNUserConfig updateLoginStatus:FNLoginStatusOffline];
            callback(nil);
        }
    }];
}

+ (void)setToken:(NSString *)token userId:(NSString *)userid
{
    FNLoginStatus logStatus = [FNUserConfig getInstance].loginStatus;
    if ( FNLoginStatusOnline == logStatus)
    {
        //判断切换帐号
        if ([[FNUserConfig getInstance].userID isEqualToString:userid])
        {
            NSLog(@"feinno the userId %@ isequalto last userid ,return",userid);
            return;
        }
        else
        {
            NSLog(@" feinno the userId %@ not equal last userid %@ ,start set token :%@",userid,[FNUserConfig getInstance].userID,token);
            [FNAccountLogic logout:^(FNLogoutResponse *rspArgs){
                NSLog(@"feinno logout rsp: %d", rspArgs.statusCode);
            }];
            
            FNLoginWithPwdReqest *loginReq = [[FNLoginWithPwdReqest alloc] init];
            loginReq.userID = userid;
            loginReq.pwd = token;
            loginReq.verifyType = 1;
            loginReq.nickname = [Utility userIdWithoutAppKey:userid];//TODO:传入的真实昵称
            [FNAccountLogic pwdLogin:loginReq callback:^(FNLoginWithPwdResponse *loginRsp){
                //TODO:根据具体情况发送通知
                if (loginRsp.statusCode == 200)
                {
        
                }
                else
                {
                    //发送错误通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:TOKEN_ERROR object:[NSString stringWithFormat:@"%d",loginRsp.statusCode]];
                }
            }];
        }
    }
    else
    {
        NSLog(@" feinno %@ offline ,start setToken : %@",userid,token);
        FNLoginWithPwdReqest *loginReq = [[FNLoginWithPwdReqest alloc] init];
        loginReq.userID = userid;
        loginReq.pwd = token;
        loginReq.verifyType = 1;
        loginReq.nickname = userid;
        [FNAccountLogic pwdLogin:loginReq callback:^(FNLoginWithPwdResponse *loginRsp){
            //TODO:根据具体情况发送通知
            if (loginRsp.statusCode == 200)
            {

            }
            else
            {
                //发送错误通知
               [[NSNotificationCenter defaultCenter] postNotificationName:TOKEN_ERROR object:[NSString stringWithFormat:@"%d",loginRsp.statusCode]];
            }
        }];
    }
}

+ (void)logout:(void(^)(FNLogoutResponse *))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    [[McpRequest sharedInstance] send:CMD_UN_REG userid:userid body:nil callback:^(NSData *data)
    {
        NSLog(@"feinno logout");
        // 注销后需要release掉原来的socket对象
        [[McpRequest sharedInstance] disConnect];
        
        [FNUserConfig getInstance].loginStatus = FNLoginStatusOffline;
        instance.loginRequest = nil;
        
        if (nil != data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            StatusRspArgs *rspArgs = (StatusRspArgs *)packetObject.args;
            
            FNLogoutResponse *logoutRsp = [[FNLogoutResponse alloc] initWithPBArgs:rspArgs];
            callback(logoutRsp);
        }
        else
        {
            callback(nil);
        }
    }];
    
    // 停止KeepAlive
    [instance stopKeepAliveTimer];
    [instance stopKeepAliveTimeoutTimer];
    [instance stopConnectTimer];
  
    [FNMsgNotify stopObserve];
    [FNGroupMsgNotify stopObserve];
    [FNGroupNotify stopObserve];
    [FNNotifyLogic stopObserve];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NOTIFY_KICKED
                                                  object:nil];
}

+ (void)updateDeviceInfo:(FNUpdateDeviceInfoReqest *)updateReq
                callback:(void (^)(FNUpdateDeviceInfoResponse *updateRsp))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeUpdateDeviceInfoReqArgs:updateReq.userID
                                               clientType:updateReq.clientType
                                            clientVersion:updateReq.clientVersion
                                                    token:updateReq.token];
    
    [[McpRequest sharedInstance] send:CMD_UPDATE_DEVICEINFO userid:userid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            UpdateDeviceInfoRspArgs *rspArgs = (UpdateDeviceInfoRspArgs *)packetObject.args;
            FNUpdateDeviceInfoResponse *updateRsp = [[FNUpdateDeviceInfoResponse alloc] initWithPBArgs:rspArgs];
            
            callback(updateRsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)deleteDeviceInfo:(void (^)(FNUpdateDeviceInfoResponse *deleteRsp))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    [[McpRequest sharedInstance] send:CMD_DELETE_DEVICEINFO userid:userid body:nil callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            UpdateDeviceInfoRspArgs *rspArgs = (UpdateDeviceInfoRspArgs *)packetObject.args;
            FNUpdateDeviceInfoResponse *updateRsp = [[FNUpdateDeviceInfoResponse alloc] initWithPBArgs:rspArgs];
            
            callback(updateRsp);
        }
        else
        {
            callback(nil);
        }
    }];
}
//是否还做重连的机制
+ (void)autoReconnect
{
    if (instance.connectTimes == CONNECT_TIMES_MAX)
    {
        [FNUserConfig updateLoginStatus:FNLoginStatusWaitReconnect];
        instance.connectTimes = 0;
        return;
    }
    if ([FNUserConfig getInstance].loginStatus == FNLoginStatusKickoff)
    {
        instance.connectTimes = 0;
        return;
    }
    
    [[McpRequest sharedInstance] disConnect];
    instance.connectTimes++;
    NSTimeInterval interval = FNConnectTimeoutFirst;
    if (instance.connectTimes == 2)
    {
        interval = FNConnectTimeoutSecond;
    }
    else if (instance.connectTimes == 3)
    {
        interval = FNConnectTimeoutThird;
    }
    if (instance.connectTimer)
    {
        [instance.connectTimer invalidate];
    }
    instance.connectTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                             target:self
                                                           selector:@selector(autoReconnect)
                                                           userInfo:nil
                                                            repeats:NO];
    [FNAccountLogic pwdLogin:instance.loginRequest callback:^(FNLoginWithPwdResponse *loginRsp) {
    }];
}

- (void)startKeepAlive
{
    NSTimeInterval time = 120;
    [self stopKeepAliveTimer];
    self.keepAliveTimer = [NSTimer scheduledTimerWithTimeInterval:time
                                                           target:self
                                                         selector:@selector(keepAlive)
                                                         userInfo:nil
                                                          repeats:NO];
}

- (void)keepAlive
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeKeepAliveArgs:[FNUserTable getSyncId:EventTypeSysMsg]];
    
    [[McpRequest sharedInstance] send:CMD_KEEP_ALIVE userid:userid body:body callback:^(NSData *data)
    {
        [self stopKeepAliveTimeoutTimer];

        if (nil != data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            KeepAliveResult *rspArgs = (KeepAliveResult *)packetObject.args;
            if (200 == rspArgs.statusCode)
            {
                [instance startKeepAlive];
                [FNUserConfig setCStr:rspArgs.credencial];
                NSLog(@"KeepAlive RspArgs: %@", rspArgs);
            }
        }
    }];
    
    self.keepAliveTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:120.0
                                                                  target:self
                                                                selector:@selector(onWaitKeepAliveTimeout)
                                                                userInfo:nil
                                                                 repeats:NO];
}

- (void)stopKeepAliveTimer
{
    if ([self.keepAliveTimer isValid])
    {
        [self.keepAliveTimer invalidate];
        self.keepAliveTimer = nil;
    }
}

- (void)stopKeepAliveTimeoutTimer
{
    if ([self.keepAliveTimeoutTimer isValid])
    {
        [self.keepAliveTimeoutTimer invalidate];
        self.keepAliveTimeoutTimer = nil;
    }
}

- (void)stopConnectTimer
{
    if ([self.connectTimer isValid])
    {
        [self.connectTimer invalidate];
        self.connectTimer = nil;
    }
}

- (void)onWaitKeepAliveTimeout
{
    [self stopKeepAliveTimer];
    [self stopKeepAliveTimeoutTimer];
    
    [FNUserConfig updateLoginStatus:FNLoginStatusOffline];
    [[McpRequest sharedInstance] disConnect];
    
    [FNAccountLogic autoReconnect];
//    [[NSNotificationCenter defaultCenter] postNotificationName:TOKEN_INVALID object:@"405"];
}

+ (void)onKickOff
{
    NSLog(@"FNAccountLogic handle kick");
    // 停止KeepAlive
    [FNUserConfig getInstance].loginStatus = FNLoginStatusKickoff;
    [instance stopKeepAliveTimer];
    [instance stopKeepAliveTimeoutTimer];
    [instance stopConnectTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NOTIFY_KICKED
                                                  object:nil];
}


#pragma mark -
#pragma mark 网络连接

- (void)recvNetworkChangedNotification:(NSNotification *)note
{
    BOPReachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[BOPReachability class]]);
    BOPNetworkStatus status = [curReach currentReachabilityStatus];
    if (status == BOPNotReachable)
    {
        [FNUserConfig updateLoginStatus:FNLoginStatusNetError];
    }
    else if ([FNUserConfig getInstance].loginStatus != FNLoginStatusConnecting)
    {
        //TODO:发通知
        [FNAccountLogic autoReconnect];
    }
}


#pragma mark -
#pragma mark 加密解密

+ (NSString *)encrypt:(NSString *)userId
             password:(NSString*)password
          encryptTime:(NSString*)encryptTime
{
    NSData *pwd = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSData *pwdBytes = [[pwd md5Digest] md5Digest];
    NSString *pwdHexStr = [pwdBytes bytesToHexString];
    
    NSString *response = [NSString stringWithFormat:@"%@%@", pwdHexStr, encryptTime];
    
    NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aesKey = pwdBytes;

    NSData *aesData = [data aes128EncryptWithKey:aesKey];
    NSString *aesResponse = [aesData bytesToHexString];
    
    return aesResponse;
}

+ (NSString *)modifyPwdEncrypt:(NSString *)oldPwd
                   newPassword:(NSString *)newPwd
{
    NSData *key = [[[oldPwd dataUsingEncoding:NSUTF8StringEncoding] md5Digest] md5Digest];
    NSData *value = [newPwd dataUsingEncoding:NSUTF8StringEncoding];
    NSString *aesResponse = [[value aes128EncryptWithKey:key] bytesToHexString];
    
    return aesResponse;
}

+ (int32_t)getLoginType:(NSString *)loginName
{
    LoginType type = 0;
    NSString *uid = loginName;
    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    //    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    NSString *mobileNoRegex = @"^(1(([35][0-9])|(47)|[8][0126789]))\\d{8}$";
    
    //    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex];
    //
    //    if ([mobileNoTest evaluateWithObject:uid]) {
    //        type = 1;
    //    } else if ([emailTest evaluateWithObject:uid]) {
    //        type = 2;
    //    } else {
    //        type = 3;
    //    }
    NSError *error = nil;
    NSRegularExpression *mRegex = [NSRegularExpression regularExpressionWithPattern:mobileNoRegex
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    NSRange mRangeOfFirstMatch = [mRegex rangeOfFirstMatchInString:uid
                                                           options:0
                                                             range:NSMakeRange(0, uid.length)];
    
    if (!NSEqualRanges(mRangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        type = LoginTypeMobile;
        return type;
    }
    NSRegularExpression *eRegex = [NSRegularExpression regularExpressionWithPattern:emailRegex
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    NSRange eRangeOfFirstMatch = [eRegex rangeOfFirstMatchInString:uid
                                                           options:0
                                                             range:NSMakeRange(0, [uid length])];
    if (!NSEqualRanges(eRangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        type = LoginTypeEmail;
        return type;
    }
    
    type = LoginTypeUserName;
    
    return type;
}

#pragma mark -
#pragma mark 首次登录

+ (void)sendWelcomeLanguage:(FNSendWelcomeLanguageRequest *)request
           callback:(void(^)(FNSendWelcomeLanguageResponse *rspArgs))callback
{
    int32_t cmd = CMD_SEND_WELCOMELANGUAGE;
    NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeSendWelcomeLanguageReqArgs:request.isFirstLogin];
    
    [[McpRequest sharedInstance] send:cmd userid:sender body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            SendWelcomeLanguageRspArgs *rspArgs = (SendWelcomeLanguageRspArgs *)packetObject.args;
            FNSendWelcomeLanguageResponse *result = [[FNSendWelcomeLanguageResponse alloc] initWithPBArgs:rspArgs];
            
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
    
}

+ (void)sendGroupWelcomeLanguage:(FNSendWelcomeLanguageRequest *)request
                   callback:(void(^)(FNSendWelcomeLanguageResponse *rspArgs))callback
{
    int32_t cmd = CMD_SEND_GROUPWELCOMElANGUAGE;
    NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeSendWelcomeLanguageReqArgs:request.isFirstLogin];
    
    [[McpRequest sharedInstance] send:cmd userid:sender body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            SendWelcomeLanguageRspArgs *rspArgs = (SendWelcomeLanguageRspArgs *)packetObject.args;
            FNSendWelcomeLanguageResponse *result = [[FNSendWelcomeLanguageResponse alloc] initWithPBArgs:rspArgs];
            
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
    
}

@end
