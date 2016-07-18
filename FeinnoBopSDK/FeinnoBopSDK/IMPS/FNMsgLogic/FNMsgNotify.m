//
//  FNMsgNotify.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-13.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNMsgNotify.h"
#import "FNMsgLogic.h"
#import "FNAccountNotify.h"

#import "SendSimpleMsgNotify.pb.h"

#import "CMD.h"
#import "McpRequest.h"

NSString *const NOTIFY_HAS_NEW_MSG = @"BOPHasMsgs";
NSString *const NOTIFY_HAS_NEW_SIMPLE_MSG = @"BOPHasSimpleMsgs";

@implementation FNMsgNotify

+ (void)startObserve
{
    [self stopObserve];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNewMsgNotify)
                                                 name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeMsg]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNewMsgNotify)
                                                 name:NOTIFY_RECONNECT_SUCCESSED
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNewSimpleMsgNotify:)
                                                 name:[NSString stringWithFormat:@"%d", CMD_SIMPLE_MSG_NOTIFY]
                                               object:nil];
}

+ (void)stopObserve
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeMsg]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NOTIFY_RECONNECT_SUCCESSED
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"%d", CMD_SIMPLE_MSG_NOTIFY]
                                                  object:nil];
}

+ (void)handleNewMsgNotify
{
    FNPullMsgRequest *pullMsgReq = [[FNPullMsgRequest alloc] init];
    pullMsgReq.count = FN_PULL_MSG_COUNT_DEFAULT;
    [FNMsgLogic getMsg:pullMsgReq callback:^(NSArray *msgList) {
        if ([msgList count] > 0)
        {
            // 广播
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_HAS_NEW_MSG
                                                                object:msgList];
            
        }
    }];
}

+ (void)handleNewSimpleMsgNotify:(NSNotification *)note
{
    NSData *data = (NSData *)[note object];
    PacketObject *packetObject = [McpRequest parse:data];
    SendSimpleMsgNotify *args = (SendSimpleMsgNotify *)packetObject.args;
    FNSendSimpleMsgNtfItem *item = [[FNSendSimpleMsgNtfItem alloc] initWithPBArgs:args];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_HAS_NEW_SIMPLE_MSG
                                                        object:item];
    NSLog(@"receive simple message NTF:%@", args);
}

@end
