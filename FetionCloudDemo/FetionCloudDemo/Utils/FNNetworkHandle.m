//
//  FNNetworkHandle.m
//  FANSZ
//
//  Created by feinno on 16/1/21.
//  Copyright © 2016年 FANSZ. All rights reserved.
//

#import "FNNetworkHandle.h"
#import "FNConfig.h"
#import "FNUserConfig.h"
#import "AFNetworking.h"
#import "CurrentUserTable.h"
#import "DBManager.h"

static FNNetworkHandle *instance = nil;

@interface FNNetworkHandle ()

@property (nonatomic, assign) NSUInteger connectTimes;
@property (nonatomic, strong) NSTimer *connectTimer;

@end

@implementation FNNetworkHandle

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil)
        {
            instance = [[FNNetworkHandle alloc] init];
            instance.connectTimes = 0;
        }
    });
    return instance;
}

+ (void)handelNetwork
{
    instance.connectTimes ++;
    if (instance.connectTimes < 2)
    {
        FNUserConfig *user = [FNUserConfig getInstance];
        NSLog(@"feinno handelNetwork user.loginStatus : %lu",(unsigned long)user.loginStatus);
        if (user.loginStatus == FNLoginStatusNetError)
        {
            instance.connectTimes = 0;
            return;
        }
       //TODO:判断app登录状态
//        if (![manager autoLogin])
//        {
//            instance.connectTimes = 0;
//            return;
//        }
        if (user.loginStatus == FNLoginStatusWaitReconnect || user.loginStatus == FNLoginStatusOffline)
        {
            NSLog(@"feinno call feixinLogin");
            NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"bopToken"];
            NSString *bopId = [[NSUserDefaults standardUserDefaults] objectForKey:@"bopId"];
            if (token.length > 0 && bopId.length > 0)
            {
                [FNConfig setAppToken:token userId:bopId];
            }
            else
            {
                [instance getAppToken];
            }
            
            
        }
    }
    else
    {
        instance.connectTimer = [NSTimer scheduledTimerWithTimeInterval:20
                                                                 target:self
                                                               selector:@selector(breakReconnect)
                                                               userInfo:nil
                                                                repeats:NO];
    }
    
}

+ (void)breakReconnect
{
    instance.connectTimes = 0;
    [FNUserConfig updateLoginStatus:FNLoginStatusOffline];
    if ([instance.connectTimer isValid])
    {
        [instance.connectTimer invalidate];
        instance.connectTimer = nil;
    }
}

- (void)getAppToken
{
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    NSString *password = [[CurrentUserTable getLastUser] password];
    
    if (name && password && ![password isEqualToString:@""])
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        // NSString *url = @"http://192.168.0.102:8080/as/user/login";
        NSString *url = @"http://221.176.28.117:8080/as/user/login";
        NSDictionary *parameter = @{@"uname":name,@"pwd":password,@"appkey":APP_KEY};
        
        NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager POST:encodingString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
            
            if (responseObject[@"code"] && [responseObject[@"code"] integerValue] == 2000)
            {
                [DBManager initDBWithUserId:name];
                
                CurrentUserTable *table = [CurrentUserTable getLastUser];
                if (table.account)
                {
                    table.userId = responseObject[@"cnt"][@"bopId"];
                    table.password = password;
                    table.account = name;
                    table.nickName = table.nickName;
                    [CurrentUserTable update:table];
                }
                else
                {
                    CurrentUserTable *table = [[CurrentUserTable alloc] init];
                    table.userId = responseObject[@"cnt"][@"bopId"];
                    table.password = password;
                    table.account = name;
                    [CurrentUserTable insert:table];
                    
                }
                
                [UserDefaults setObject:responseObject[@"cnt"][@"token"] forKey:@"bopToken"];
                [UserDefaults setObject:responseObject[@"cnt"][@"bopId"] forKey:@"bopId"];
                //设置
                [FNConfig setAppToken:responseObject[@"cnt"][@"token"] userId:responseObject[@"cnt"][@"bopId"]];
            }
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
@end
