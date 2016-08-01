//
//  AppDelegate.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "AppDelegate.h"
#import "BOPReachability.h"
#import "AFNetworking.h"
#import "UIView+Toast.h"

#import "FNConfig.h"
#import "FNAccountLogic.h"
#import "FNMsgNotify.h"
#import "FNGroupMsgNotify.h"
#import "FNGroupNotify.h"
#import "FNBundle.h"
#import "FNEnum.h"
#import "FNNetworkHandle.h"

#import "FNTabBarController.h"
#import "DBManager.h"
#import "CurrentUserTable.h"

#import "FNGroupLogic.h"
#import "SetNickNameController.h"
#import "FNUserInfo.h"
#import "MessageEntity.h"
#import "FNmsgTable.h"
#import "FNUserTable.h"
#import "FNSystemConfig.h"

#import "ContactDataTable.h"
#import "ContactRequestTable.h"
#import "FNDBManager.h"
#import "FNUserConfig.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#import "FNListener.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@property (nonatomic, retain)BOPReachability *reachability;
@end


RcsApi* globalRcsApi = NULL;
rcs_state* R = NULL;



@implementation AppDelegate


- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [FNBundle bundleWithName:@"FNBundle"];
    [FNNetworkHandle sharedInstance];
    
    //SDK初始化
    [FNConfig initWithAppKey:APP_KEY
                       AppId:@"com.feinno.www.FetionCloudDemo"
             isLaunchLogFile:YES
             SeverEnviroment:LoginEnvironmentProduction];
    
    //注册状态监听
    [self registerBopNotify];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recvNetworkChangedNotification:)
                                                 name:_kBOPReachabilityChangedNotification
                                               object:nil];
    
    
    
    
    /***************************************** RCSSDK *******************************************************/
    
    //    _localNum = @"+8615901435217";
    
    [FNUserInfo ShareStaticConst].localNum = _localNum;
    
    long long milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    printf("--------%lld \r\n", milliseconds);
    
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"/"];
    NSString *spath = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"spconfig"];
    
    globalRcsApi = [RcsApi shareInstance];
    R =[globalRcsApi newState:@"" appId:@"0" clientVendor:@"1" clientVersion:@"2" storagePath:path sysPath:spath ];
    
    
    milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    printf("%lld \r\n", milliseconds);
    
    
    
    //    [DBManager initDBWithUserId:_localNum];
    //
    //    ContactDataTable *table = [ContactDataTable getWithUserId:@"882224"];
    //    if (!table.userId) {
    //        table.userId = [NSString stringWithFormat:@"%@",@"882224"];
    ////        table.nickName = @"啦啦";
    ////        table.username = @"42424242";
    //        [ContactDataTable insert:table];
    //
    //    }else{
    //        table.userId = [NSString stringWithFormat:@"%@",@"88222451"];
    //        table.nickName = @"啦啦12";
    //        table.username = @"424242421";
    //        [ContactDataTable insert:table];
    //    }
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
    if (name)
    {
        [DBManager initDBWithUserId:name];
    }
    
    [FNUserInfo ShareStaticConst].localNum = name;
    [FNUserConfig initWithUserid:userId];
    
    [FNDBManager initDB:userId];
    
    if (password.length > 0)
    {
        
        
        R =[globalRcsApi newState:name appId:@"0" clientVendor:@"1" clientVersion:@"2" storagePath:path sysPath:spath ];
        
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"bopToken"];
        NSString *bopId = [[NSUserDefaults standardUserDefaults] objectForKey:@"bopId"];
        [FNConfig setAppToken:token userId:bopId];
        
        FNTabBarController *tabBar = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tabbarController"];
        self.window.rootViewController = tabBar;
        
        
        [globalRcsApi login:R username:_localNum password:password callback:^(rcs_state* R, LoginResult *s) {
            if (s->error_code == 200) {
                
                
            }
            
        }];
        
        
        //        if (![[CurrentUserTable getLastUser] nickName])
        //        {
        //            [self performSelector:@selector(setNick) withObject:nil afterDelay:1];
        //        }
    }
    
    [self registerListeners];
    
    return YES;
}

- (void)setNick
{
    [self.window.rootViewController performSegueWithIdentifier:@"setNickName" sender:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)registerBopNotify
{
    //token错误
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAppToken)
                                                 name:TOKEN_ERROR
                                               object:nil];
    //Token失效
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAppToken)
                                                 name:TOKEN_INVALID
                                               object:nil];
    //其他终端上线
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKickOff)
                                                 name:OTHER_TERMINAL_ONLINE
                                               object:nil];
    //SDK网络断开
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UserNetworkError:)
                                                 name:BOPNETWORK_ERROR
                                               object:nil];
}

- (void)UserNetworkError:(NSNotification *)errorNotify
{
    [self getAppToken];
    
    NSLog(@"errorNotify statue %@",errorNotify);
}

- (void)onKickOff
{
    UIAlertView *tipView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您的账号在其他地方登录" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"重新登录", nil];
    [tipView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self appLogout];
    }
    else if (buttonIndex == 1)
    {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"bopToken"];
        NSString *bopId = [[NSUserDefaults standardUserDefaults] objectForKey:@"bopId"];
        [FNConfig setAppToken:token userId:bopId];
        
        [self getAppToken];
    }
}

- (void)recvNetworkChangedNotification:(NSNotification *)note
{
    BOPReachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[BOPReachability class]]);
    BOPNetworkStatus status = [curReach currentReachabilityStatus];
    if (status == BOPNotReachable)
    {
        UIAlertView *tipView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络断开连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [tipView show];
    }
}

- (void)appLogout
{
    //账号在其他地方登录后，退出sdk
    [FNAccountLogic logout:^(FNLogoutResponse *rspArgs) {
        NSLog(@"logout rsp: %d", rspArgs.statusCode);
    }];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bopToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"bopId"];
    //重新登陆
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.window.rootViewController = [mainSB instantiateViewControllerWithIdentifier:@"LoginController"];
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
            
            NSLog(@"%@",responseObject);
            
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


#pragma mark - -------------------------------registerListener-------------------------------


- (void)registerListeners
{
    
    [[FNListener ShareStaticConst] getUserInfo];

    [[FNListener ShareStaticConst] registerBuddyListListener];
    [[FNListener ShareStaticConst] registerBuddyEventListener];
    [[FNListener ShareStaticConst] registerMsgListener];

}



@end
