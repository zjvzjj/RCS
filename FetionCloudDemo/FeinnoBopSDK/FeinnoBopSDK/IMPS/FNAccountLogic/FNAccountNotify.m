//
//  FNAccountNotify.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-13.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNAccountNotify.h"
#import "FNAccountArgs.h"

#import "CMD.h"
#import "McpRequest.h"

#import "FNUserConfig.h"

NSString *const NOTIFY_KICKED = @"BOPKicked";
NSString *const NOTIFY_LOGIN_STATUS_CHANGED = @"BOPLoginStatusChanged";
NSString *const NOTIFY_RECONNECT_SUCCESSED = @"BOPReconnectSuccessed";
NSString *const NOTIFY_AUTORECONNECT = @"BOPAutoReconect";

@implementation FNAccountNotify

+ (void)startObserve
{
    [self stopObserve];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotify:)
                                                 name:[NSString stringWithFormat:@"%d", CMD_KICK_NOTIFY]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSocketError)
                                                 name:@"BOPSocketErrorNotify"
                                               object:nil];
}

+ (void)stopObserve
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"%d", CMD_KICK_NOTIFY]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"BOPSocketErrorNotify"
                                                  object:nil];
}

+ (void)handleNotify:(NSNotification *)note
{
    NSData *data = (NSData *)[note object];
    PacketObject *packetObject = [McpRequest parse:data];
    BNKickNotifyArgs *args = (BNKickNotifyArgs *)[packetObject args];
    FNKickNotifyArgs *notifyArgs = [[FNKickNotifyArgs alloc] initWithPBArgs:args];
    //让sdk account停止一切
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_KICKED object:notifyArgs];
    //业务层通知
    NSLog(@"FNAccountNotify receive kick post OTHER_TERMINAL_ONLINE");
    [[NSNotificationCenter defaultCenter] postNotificationName:OTHER_TERMINAL_ONLINE object:@"407"];
}

+ (void)handleSocketError
{
    NSLog(@"feinno FNAccountNotify receive SocketError");
    FNLoginStatus status = [FNUserConfig getInstance].loginStatus;
    if (status != FNLoginStatusKickoff)
    {
        NSLog(@"feinno FNAccountNotify handle SocketError");
         [FNUserConfig updateLoginStatus:FNLoginStatusWaitReconnect];
        [[NSNotificationCenter defaultCenter] postNotificationName:BOPNETWORK_ERROR object:@"bopNetworkError"];
    }
    else
    {
        NSLog(@"feinno loginStatus %lu",(unsigned long)status);
    }
}

@end
