//
//  FNConfig.m
//  FeinnoBopSDK
//
//  Created by 姜晓光 on 16/1/11.
//  Copyright © 2016年 Feinno. All rights reserved.
//

#import "FNConfig.h"
#import "FNServerConfig.h"
#import "FNAccountLogic.h"
#import "FNUserConfig.h"
#import "FNDBManager.h"

@implementation FNConfig

+ (void)initWithAppKey:(NSString *)appkey AppId:(NSString *)appid isLaunchLogFile:(BOOL)islaunch SeverEnviroment:(LoginEnvironment)severEnviroment
{
    if (!appkey)
    {
        NSLog(@"feinno error : AppKey is nil !!!");
        return;
    }
    if (!appid)
    {
        NSLog(@"feinno error : AppId is nil !!!");
        return;
    }
    if (severEnviroment == LoginEnvironmentProduction)
    {
        [FNServerConfig initWithServiceAddress:@"221.176.31.144:8020"
                            fileServiceAddress:@"221.176.28.116:80"
                                        appKey:appkey
                                         appId:appid];
        [FNServerConfig getInstance].environment = LoginEnvironmentProduction;
  
    }
    else if (severEnviroment == LoginEnvironmentFunction)
    {
        [FNServerConfig initWithServiceAddress:@"124.42.103.253:8014"
                            fileServiceAddress:@"124.42.103.250:8080"
                                        appKey:appkey
                                         appId:appid];
        [FNServerConfig getInstance].environment = LoginEnvironmentFunction;
    }
    if (islaunch)
    {
        [FNServerConfig getInstance].isLaunchLogFile = YES;
    }
    else
    {
        [FNServerConfig getInstance].isLaunchLogFile = NO;
    }
}

+ (void)setAppToken:(NSString *)appToken userId:(NSString *)userid
{
    if (!appToken)
    {
        NSLog(@"feinno apptoken is null");
    }
    else if (!userid)
    {
        NSLog(@"feinno appid is null");
    }
    else
    {
        [FNAccountLogic setToken:appToken userId:userid];
    }
}

+ (void)initDataBase:(NSString *)userId
{
    [FNUserConfig initWithUserid:userId];
    [FNDBManager initDB:userId];
}

@end
