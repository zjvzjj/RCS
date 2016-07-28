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
    
    
    //_addBuddyArray = [[NSMutableArray alloc]init];
    
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
    
    if (name)
    {
        [DBManager initDBWithUserId:name];
    }
    
    [FNUserInfo ShareStaticConst].localNum = name;
    [FNUserConfig initWithUserid:@"500015"];
    
    [FNDBManager initDB:@"500015"];
    
    NSString *password = [[CurrentUserTable getLastUser] password];
    
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

- (void)registerAvListener
{
}

- (void)registerGroupListener
{
}

//服务端推送好友操作事件监听器
- (void)registerBuddyEventListener
{
    //__weak typeof(self) weakSelf = self;
    [globalRcsApi setBuddyEventListener:^(rcs_state*R, BuddyEventSession* s){
        
        _buddyInviterId = [NSString stringWithUTF8String:s->from_user];
        NSLog(@"_buddyInbiterId================%s",s->from_user);
        
        [DBManager initDBWithUserId:[FNUserInfo ShareStaticConst].localNum];
        
        
        //收到被添加请求，发送通知
        if (s->op == 6) {
            
            
            _addBuddyArray = [[NSMutableArray alloc]init];
            
            UserInfo * u = s->user_info;
            
            NSString *str1 = [NSString  stringWithFormat:@"%d",u->user_id];
            ContactRequestTable *table = [ContactRequestTable getWithUserId:str1];
            table.userId = [NSString stringWithFormat:@"%d",u->user_id];
            table.nickName = [NSString stringWithUTF8String:u->nickname];
            table.username = [NSString stringWithUTF8String:u->username];
            
            //            NSLog(@"请求的好友数量%d----%d",_addBuddyArray.count,s->op);
            //                  NSLog(@"请求的好友名字----%@----%@",table.nickName,table.username);
            //            [_addBuddyArray addObject:table];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addbuddy" object:table];
            
        }
        
    }];
    
}


//服务端推送好友列表事件监听器
- (void)registerBuddyListListener
{
    // __weak typeof(self) weakSelf = self;
    
    if (!_buddyIDArray) {
        
        _buddyIDArray = [[NSMutableArray alloc]init];
        
    }
    
    [globalRcsApi setBuddyListListener:^(rcs_state*R, BuddyListSession* s)
     {
         int i = 0;
         while (1 && s->full)
         {
             BuddyInfo* p = s->full[i++];
             if (p == NULL) {
                 break;
             }
             //[weakSelf AddLogNs:[NSString stringWithFormat:@"buddy %d:%d", i, p->user_id]];
             _buddyRemoteId = p->user_id;
             
             NSNumber *number = [[NSNumber alloc]initWithInt:_buddyRemoteId];
             
             [_buddyIDArray addObject:number];
             
             [FNUserInfo ShareStaticConst].buddyIDArray = _buddyIDArray;
             
             [DBManager initDBWithUserId:[FNUserInfo ShareStaticConst].localNum];
             
             ContactDataTable *table = [ContactDataTable getWithUserId:[NSString stringWithFormat:@"%@",number]];
             
             if (p->action == 1) {
                 NSLog(@"add");
             }else if (p->action == 2){
                 NSLog(@"dele");
             }else if (p->action == 3){
                 NSLog(@"update'");
             }
             
             if (!table.userId)
             {
                 ContactDataTable *table = [[ContactDataTable alloc] init];
                 table.userId = [NSString stringWithFormat:@"%@",number];
                 [ContactDataTable insert:table];
             }
         }
         
         i = 0;
         while (1 && s->partial)
         {
             BuddyInfo* p = s->partial[i++];
             if (p == NULL) {
                 break;
             }
             
             _buddyRemoteId = p->user_id;
             
             NSNumber *number = [[NSNumber alloc]initWithInt:_buddyRemoteId];
             
             if (p->action == 2) {
                 
                 NSLog(@"hah");
                 
                 [_buddyIDArray removeObject:number];
                 
                 
                 [ContactDataTable del:[NSString stringWithFormat:@"%@",number]];
             }else if (p->action == 1){
                 
                 [_buddyIDArray addObject:number];
                 
                 ContactDataTable *table = [ContactDataTable getWithUserId:[NSString stringWithFormat:@"%@",number]];
                 
                 if (!table.userId)
                 {
                     ContactDataTable *table = [[ContactDataTable alloc] init];
                     table.userId = [NSString stringWithFormat:@"%@",number];
                     [ContactDataTable insert:table];
                 }
                 
                 
             }else if (p->action == 3){
                 
                 NSLog(@"do what");
                 
             }
             
             [FNUserInfo ShareStaticConst].buddyIDArray = _buddyIDArray;
             
             //ContactDataTable *table = [ContactDataTable getWithUserId:[NSString stringWithFormat:@"%@",number]];
             
             //             if (!table.userId)
             //             {
             //                 ContactDataTable *table = [[ContactDataTable alloc] init];
             //                 table.userId = [NSString stringWithFormat:@"%@",number];
             //                 [ContactDataTable insert:table];
             //             }
             
             NSLog(@"do what....");
             
         }
     }];
    
}


- (void)registerMsgListener
{
    __weak typeof(self) weakSelf = self;
    
    //服务端推送SINGLE(一对一聊天)、GROUP(群组聊天)、PUBLIC_ACCOUNT(公众账号消息)、BROADCAST(广播消息)、DIRECTED(定向消息)文本消息事件监听器
    
    [globalRcsApi setMsgTextListener:^(rcs_state*R, MessageTextSession* s)
     {
         //[weakSelf AddLogC:s->content];
         NSLog(@"content=======%s",s->content);
         
         
         // MessageEntity * m = [MessageEntity new];
         // m.imdn_id = [NSString stringWithFormat:@"%@",s->imdn_id];
         //----------------------------------------------------------------------------------
         
         FNMsgTable *message = [[FNMsgTable alloc] init];
         message.syncId = [FNUserTable getSyncId:EventTypePrivate];
         message.msgId = [NSString stringWithFormat:@"%s",s->imdn_id];
         message.tid = [NSString stringWithFormat:@"%s",s->to];
         message.msgType = FNMsgTypePlain;
         message.msgAttribute = [NSString stringWithFormat:@"%d",s->is_burn];
         message.contentType = FNMsgTypePlain;
         message.content = [NSString stringWithUTF8String:s->content];
         message.senderNickname = @"JACK";
         message.senderId = [NSString stringWithFormat:@"%s",s->from];
         
         message.senderProtraitUrl =@"path";
         message.sendStatus = MsgSendSuccess;
         message.readStatus = MsgAlreadyRead;
         message.flag = MsgReceiveFlag;
         message.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
         [FNMsgTable insert:message];
         
         //------------------------------------------------------------------------------
         
         // [[FNUserInfo ShareStaticConst].messageArray addObject:m];
         
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:message];
         
         // [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_HAS_NEW_MSG object:message];
         
         if(s->need_report)
         {
             NSString* from = [NSString stringWithUTF8String:s->from];
             NSString* messageId = [NSString stringWithUTF8String:s->imdn_id];
             [globalRcsApi msgsendreport:R number:from messageId:messageId reportType:ReportTypeDELIVERED directedType:DirectedTypeNONE callback:^(rcs_state* R, MessageResult *s) {
                 if (s->error_code == 200) {
                     //[weakSelf AddLogC:"send report ok"];
                     NSLog(@"send report ok");
                 }
                 else
                 {
                     //[weakSelf AddLogC:"send report failed"];
                     NSLog(@"send report failed");
                 }
             }];
         }
     }];
    
    /*    服务端推送BURN(已焚)、DELIVERED(已送达)、FILE_PROGRESS(文件上传/下载进度)、GROUP_DELIVERED(群组消息已送达)、
     *   GROUP_READ(群组消息已读)、GROUP_WITH_DRAW(群组消息撤销)、READ(已读)、TYPING(正在输入)、UPDATE_MSG_ID(更新消息 ID)、
     *    WITH_DRAW(撤回)、消息报告事件监听器
     */
    [globalRcsApi setMsgReportListener:^(rcs_state*R, MessageReportSession* s)
     {
         //[weakSelf AddLogC:"receive MessageReportSession"];
         NSLog(@"receice MessageReportSession");
         
     }];
    
    // 服务端推送彩云文件消息事件监听器
    [globalRcsApi setMsgCloudfileListener:^(rcs_state*R, MessageCloudFileSession* s)
     {
         //[weakSelf AddLogC:"receive MessageCloudFileSession"];
         NSLog(@"receive MessageCloudFileSession");
     }];
    
    // 服务端推送商店表情消息事件监听器
    [globalRcsApi setMsgEmoticonListener:^(rcs_state*R, MessageEmoticonSession* s)
     {
         //[weakSelf AddLogC:"receive MessageEmoticonSession"];
         NSLog(@"receice MessageEmoticonSession ");
     }];
    
    // 服务端推送自定义消息,SDK直接透传不处理事件监听器
    [globalRcsApi setMsgCustomListener:^(rcs_state*R, MessageCustomSession* s)
     {
         // [weakSelf AddLogNs:[NSString stringWithFormat:@"receive custom msg, data:%s, data_id:%s, data_type:%d", s->data, s->data_id, s->data_type]];
         NSLog(@"receive custom msg, data:%s, data_id:%s, data_type:%d", s->data, s->data_id, s->data_type);
     }];
    
    // 服务端推送富文本消息事件监听器
    [globalRcsApi setMsgFtListener:^(rcs_state*R, MessageFTSession* s)
     {
         
         NSLog(@"receive MessageFtSession");
         
         if(!s->is_report && s->file_size > 0)
         {
             NSString* messageId = [NSString stringWithUTF8String:s->imdn_id];
             NSString* transferId = [NSString stringWithUTF8String:s->transfer_id];
             
             NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             
             NSString *filePath = [docPaths objectAtIndex:0];
             
             UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
             
             NSString * filename = [NSString stringWithFormat:@"%lld", recordTime];
             
             NSString* newfilePath = [NSString stringWithFormat:@"%@/%@", filePath,filename];
             
             FNMsgTable *message = [[FNMsgTable alloc] init];
             message.syncId = [FNUserTable getSyncId:EventTypePrivate];
             message.msgId = [NSString stringWithFormat:@"%s",s->imdn_id];
             message.tid = [NSString stringWithFormat:@"%s",s->to];
             message.msgAttribute = [NSString stringWithFormat:@"%d",s->is_burn];
             //message.content = [NSString stringWithUTF8String:s->content];
             message.senderNickname = @"嘿";
             message.senderId = [NSString stringWithFormat:@"%s",s->from];
             message.senderProtraitUrl =@"path";
             
             
             
             if (s->content_type == 2) {
                 
                 message.msgType = FNMsgTypePic;
                 message.contentType = FNMsgTypePic;
                 newfilePath = [newfilePath stringByAppendingString:@".jpg"];
                 NSData *data = [NSData dataWithContentsOfFile:newfilePath];
                 message.fileWidth =[UIImage imageWithData:data].size.width;
                 message.fileHeight = [UIImage imageWithData:data].size.height;
                 
                 
             }else if (s->content_type == 3){
                 
                 message.msgType = FNMsgTypeAudio;
                 message.contentType = FNMsgTypeAudio;
                 newfilePath = [newfilePath stringByAppendingString:@".amr"];
                 //message.playTime = 6;
                 // message.bitrate = 2;
                 
                 
                 
             }else if (s->content_type == 8){
                 
                 message.msgType = FNMsgTypeVideo;
                 message.contentType = FNMsgTypeVideo;
                 newfilePath = [newfilePath stringByAppendingString:@".mp4"];
                 //message.playTime = 6;
                 // message.bitrate = 2;
                 
                 
             }else{
                 
                 NSLog(@"other");
                 
             }
             
             NSString *fullPath = [[[FNUserConfig getInstance].filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%s",s->file_name]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
             
             message.fileId =@"";
             message.fileName = filename;
             message.fileSize = s->file_size;
             message.savePath = fullPath;
             message.thumbPath = fullPath;
             
             //message.playTime = 6;
             // message.bitrate = 2;
             
             message.sendStatus = MsgSendSuccess;
             message.readStatus = MsgAlreadyRead;
             message.flag = MsgSendFlag;
             message.receiveStatus = MsgReceiveSuccess;
             message.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
             
        
             //下载富文本文件
             [globalRcsApi msgfetchfile:R number:weakSelf.localNum
                              messageId:messageId
                               chatType:s->chat_type
                               filePath:fullPath
                            contentType:s->content_type
                               fileName:@""
                             transferId:transferId
                                  start:0
                               fileSize:s->file_size
                                   hash:@""
                                 isBurn:s->is_burn
                               callback:^(rcs_state* R, MessageResult *s) {
                                   if (s->error_code == 200) {
                                       NSURL *url = [NSURL fileURLWithPath:fullPath];
                                       AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:url options:nil];
                                       CMTime time = audioAsset.duration;
                                       NSTimeInterval seconds = CMTimeGetSeconds(time);
                                       NSLog(@"fetch file ok");
                                       message.playTime = seconds;
                                       [FNMsgTable insert:message];
                                       
                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:message];
                                       
                                   }
                                   else
                                   {
                                       NSLog(@"fetch file failed");
                                   }
                               }];
         }
         
     }];
    
}



- (void)registerGroupListListener
{
    //__weak typeof(self) weakSelf = self;
    [globalRcsApi setGroupListListener:^(rcs_state*R, GroupListSession* s)
     {
         //[weakSelf AddLogC:"call GroupListListener"];
         
         NSLog(@"%d,%s,%d",s->sid,s->user,s->sync_mode);
         
     }];
}

//服务端推送群组详细信息事件监听器
- (void)registerGroupInfoListener
{
    //__weak typeof(self) weakSelf = self;
    [globalRcsApi setGroupInfoListener:^(rcs_state*R, GroupSession* s)
     {
         //[weakSelf AddLogC:"call GroupInfoListener"];
         
     }];
}

//服务端推送INVITED(被邀请入群)、QUIT(退出群)、BOOTED(被踢出群)、
// CONFIRMED(群邀请处理结果)、DISMISSED(群被解散)、TRANSFER(被提升为管理员)群操作事件监听器
//描述的事件都是与当前用户有关的信息
- (void)registerGroupEventListener
{
    // __weak typeof(self) weakSelf = self;
    [globalRcsApi setGroupEventListener:^(rcs_state*R, GroupEventSession* s)
     {
         //[weakSelf AddLogC:"call GroupEventListener"];
     }];
}

//服务端推送群组通知的信息 这个类型中,描述的是群组其他人发生的和自己无关,不需要额外处理群操作事件监听器
- (void)registerGroupNotifyListener
{
    //__weak typeof(self) weakSelf = self;
    [globalRcsApi setGroupNotifyListener:^(rcs_state*R,  GroupNotificationSession* s)
     {
         //[weakSelf AddLogC:"call GroupNotifyListener"];
     }];
}


- (void)registerListeners
{
    
    [self registerMsgListener];
    [self registerAvListener];
    [self registerBuddyEventListener];
    [self registerBuddyListListener];
}



@end
