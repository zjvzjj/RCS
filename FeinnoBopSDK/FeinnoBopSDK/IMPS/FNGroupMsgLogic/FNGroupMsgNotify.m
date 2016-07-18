//
//  FNGroupMsgNotify.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-14.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNGroupMsgNotify.h"
#import "FNGroupMsgLogic.h"
#import "FNAccountNotify.h"

#import "FNGroupMsgTable.h"

NSString *const NOTIFY_HAS_NEW_GROUP_MSG = @"BOPHasGroupMsgs";

@implementation FNGroupMsgNotify

+ (void)startObserve
{
    [self stopObserve];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNewMsgNotify)
                                                 name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupMsg]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNewMsgNotify)
                                                 name:NOTIFY_RECONNECT_SUCCESSED
                                               object:nil];
}

+ (void)stopObserve
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupMsg]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NOTIFY_RECONNECT_SUCCESSED
                                                  object:nil];
}

+ (void)handleNewMsgNotify
{
    FNPullMsgRequest *pullMsgReq = [[FNPullMsgRequest alloc] init];
    pullMsgReq.count = FN_PULL_MSG_COUNT_DEFAULT;

    [FNGroupMsgLogic getMsg:pullMsgReq callback:^(NSArray *msgList) {
        if ([msgList count] > 0)
        {
            for (int i = 0; i < [msgList count]; i++)
            {
                FNGroupMsgTable *msg = [msgList objectAtIndex:i];
                NSLog(@"post groupmsg notify syncId : %lld, msgId : %@", msg.syncId, msg.msgId);
            }
            // 广播
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_HAS_NEW_GROUP_MSG
                                                                object:msgList];
        }
    }];
}

@end
