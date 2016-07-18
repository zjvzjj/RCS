//
//  ServerConfig.m
//  feinno-sdk-imps
//
//  Created by doujinkun on 14-7-18.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNServerConfig.h"
#import "BOPReachability.h"

static FNServerConfig *instance = nil;

@interface FNServerConfig ()

@property (nonatomic, readwrite) NSString *serviceAddress;
@property (nonatomic, readwrite) NSString *fileServiceAddress;
@property (nonatomic, readwrite) NSString *appKey;
@property (nonatomic, readwrite) NSString *appId;
@property (nonatomic) BOPReachability *reachability;

@end

@implementation FNServerConfig

+ (instancetype)initWithServiceAddress:(NSString *)serviceAddress
                    fileServiceAddress:(NSString *)fileServiceAddress
                                appKey:(NSString *)appkey
                                 appId:(NSString *)appid
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FNServerConfig alloc] init];
        instance.environment = LoginEnvironmentProduction;
        instance.reachability = [BOPReachability reachabilityForInternetConnection];
        [instance.reachability startNotifier];
    });
    instance.serviceAddress = serviceAddress;
    instance.fileServiceAddress = [NSString stringWithFormat:@"%@%@%@", @"http://", fileServiceAddress, @"/ncfp/"];
    instance.appKey = appkey;
    instance.appId = appid;
    if ([serviceAddress rangeOfString:@"124.42.103"].location != NSNotFound)
    {
        instance.environment = LoginEnvironmentFunction;
    }
    
    return instance;
}

+ (instancetype)getInstance {
    if (!instance) {
        NSLog(@"FNServerConfig didn't init");
        return nil;
    }
    return instance;
}

@end
