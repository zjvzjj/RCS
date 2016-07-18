//
//  NotifyLogic.m
//  feinno-sdk-imps
//
//  Created by doujinkun on 14-9-12.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNNotifyLogic.h"
#import "FNMsgBasicLogic.h"
#import "FNNotifyArgs.h"
#import "FNMsgArgs.h"

#import "FNAccountNotify.h"

#import "FNUserTable.h"
#import "FNSystemNotifyTable.h"

#import "FNUserConfig.h"

#import "CMD.h"
#import "McpRequest.h"

#import "BodyMaker+MessageBodyMaker.h"
#import "BodyMaker+NotifyBodyMaker.h"
#import "NewMsgNotifyArgs.pb.h"
#import "SysNotify.pb.h"

NSString *const NOTIFY_SYSTEM_NOTIFY = @"BOPSystemNotify";

@implementation FNNotifyLogic

+ (void)startObserve
{
    [self stopObserve];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNewMsgNotify:)
                                                 name:[NSString stringWithFormat:@"%d", CMD_NEW_MSG_NOTIFY]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNewNotify)
                                                 name:NOTIFY_RECONNECT_SUCCESSED
                                               object:nil];
}

+ (void)stopObserve
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"%d", CMD_NEW_MSG_NOTIFY]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NOTIFY_RECONNECT_SUCCESSED
                                                  object:nil];
}

+ (void)handleNewMsgNotify:(NSNotification *)note
{
    //TODO:判断appkey和token的状态
    NSData *data = (NSData *)[note object];
    PacketObject *packetObject = [McpRequest parse:data];
    NewMsgNotifyArgs *args = (NewMsgNotifyArgs *)packetObject.args;
    NSLog(@"receive NTF:%@", args);
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    switch (args.event)
    {
        case EventTypePrivate:
        {
            [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeMsg] object:nil userInfo:nil];
            break;
        }
        case EventTypePG:
        {
            [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupMsg] object:nil userInfo:nil];
            break;
        }
        case EventTypeNtf:
        {
            [self handleNewNotify];
            break;
        }
        default:
            break;
    }
}

+ (void)handleNewNotify
{
    //TODO:判断appkey和token的状态
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        void(^ntfMsgCallback)(FNPullNotifyResponse *rspArgs) = ^(FNPullNotifyResponse *rspArgs) {
            NSLog(@"get notify statue %d",rspArgs.statusCode);
        if (200 == rspArgs.statusCode)
        {
            [FNUserTable setSyncId:EventTypeNtf syncId:rspArgs.syncID];
            
            for (int i = 0; i < rspArgs.notifyList.count; i++)
            {
                FNNotifyEntity *msgEntity = (FNNotifyEntity *)rspArgs.notifyList[i];
                NSLog(@"notify type %@",msgEntity.notifyType);
                if ([msgEntity.notifyType isEqualToString:FNNtfFCNewTheme])
                {
                    [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeNewTheme] object:msgEntity userInfo:nil];
                }
                else if ([msgEntity.notifyType isEqualToString:FNNtfFCNewComment])
                {
                    [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeNewComment] object:msgEntity userInfo:nil];
                }
                else if ([msgEntity.notifyType isEqualToString:FNNtfApproveInvite])
                {
                    [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeApprove] object:msgEntity userInfo:nil];
                }
                else if ([msgEntity.notifyType isEqualToString:FNNtfRefuseInvite])
                {
                    [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeRefuse] object:msgEntity userInfo:nil];
                }
                else if ([msgEntity.notifyType isEqualToString:FNNtfJoinGroup])
                {
                    [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeJoin] object:msgEntity userInfo:nil];
                }
                else if ([msgEntity.notifyType isEqualToString:FNNtfExitGroup])
                {
                    [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeExit] object:msgEntity userInfo:nil];
                }
                else if ([msgEntity.notifyType isEqualToString:FNChangeGroupOwner])
                {
                    [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupOwnerChange] object:msgEntity userInfo:nil];
                }
                else if ([msgEntity.notifyType isEqualToString:FNGroupMemberNameChange])
                {
                    [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupMemberNameChange] object:msgEntity userInfo:nil];
                }
                else if ([msgEntity.notifyType isEqualToString:FNGroupMemberPortraitUrlChange])
                {
                    [nc postNotificationName:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupMemberPortraitUrlChange] object:msgEntity userInfo:nil];
                }
                else if ([msgEntity.notifyType isEqualToString:FNNtfSystem])
                {
                    FNSystemNotifyArgs *sysNotity = [[FNSystemNotifyArgs alloc] initWithPBArgs:[SysNotify parseFromData:msgEntity.notifyBody]];
                    
                    FNSystemNotifyTable *systemNotify = [[FNSystemNotifyTable alloc] init];
                    systemNotify.fromUserId = msgEntity.sourceID;
                    systemNotify.msgId = sysNotity.msgId;
                    systemNotify.title = sysNotity.title;
                    systemNotify.msgType = sysNotity.msgType;
                    systemNotify.sendDate = sysNotity.sendDate;
                    systemNotify.readStatus = MsgUnread;
                    systemNotify.msgBody = sysNotity.msgBody;
                    
                    [FNSystemNotifyTable insert:systemNotify];
                    
                    if (sysNotity.msgId > [FNUserTable getSyncId:EventTypeSysMsg])
                    {
                        [FNUserTable setSyncId:EventTypeSysMsg
                                        syncId:sysNotity.msgId];
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_SYSTEM_NOTIFY object:sysNotity];
                }
            }
        }
    };
    
    FNPullNotifyRequest *pullNotifyReq = [[FNPullNotifyRequest alloc] init];
    pullNotifyReq.count = FN_PULL_MSG_COUNT_DEFAULT;
    [self getNotify:pullNotifyReq callback:ntfMsgCallback];
}

+ (void)getNotify:(FNPullNotifyRequest *)pullNotifyReq
         callback:(void(^)(FNPullNotifyResponse *rsp))callback
{
    //TODO:判断appkey和token的状态
    int64_t syncId = [FNUserTable getSyncId:EventTypeNtf];
    if (pullNotifyReq.deleteHistoryMsg)
    {
        syncId = 9223372036854775807;
    }

    NSData *body = [BodyMaker makePullNotifyReqArgs:(pullNotifyReq.count == 0 ? FN_PULL_MSG_COUNT_DEFAULT : pullNotifyReq.count)
                                             syncId:syncId];
    int32_t cmd = CMD_GET_NOTIFY;
    NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    
    [[McpRequest sharedInstance] send:cmd userid:sender body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parseWithData:data
                                                               key:[FNUserConfig getInstance].cStr];
            PullNotifyResults *rspArgs = (PullNotifyResults *)packetObject.args;
            FNPullNotifyResponse *rsp = [[FNPullNotifyResponse alloc] initWithPBArgs:rspArgs];
            NSLog(@"pull notify count : %lu", (unsigned long)[rsp.notifyList count]);
            
            // 写通知db
            [FNUserTable setSyncId:EventTypeNtf syncId:rsp.syncID];
            callback(rsp);
            
            // 删除服务端消息
            FNDelMsgRequest *delMsgReq = [[FNDelMsgRequest alloc] init];
            delMsgReq.syncID = [FNUserTable getSyncId:EventTypeNtf];
            [self delMsg:delMsgReq callback:^(FNDelMsgResponse *rspArgs) {
                if (200 == rspArgs.statusCode)
                {
                    NSLog(@"del server notify success");
                    if (!rsp.isCompleted && [rsp.notifyList count] > 0)
                    {
                        [self getNotify:pullNotifyReq callback:callback];
                    }
                    else
                    {
                        if (!rsp.isCompleted)
                        {
                            [FNUserTable setSyncId:EventTypeNtf syncId:rsp.syncID];
                            [self getNotify:pullNotifyReq callback:callback];
                        }
                        else
                        {
                            [FNUserTable setSyncId:EventTypeNtf syncId:0];
                        }
                    }
                }
                else
                {
                    NSLog(@"del server notify failed");
                }
            }];
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)delMsg:(FNDelMsgRequest *)delMsgReq
      callback:(void(^)(FNDelMsgResponse *rspArgs))callback;
{
    NSData *body = [BodyMaker makeDelMsgReqArgs:delMsgReq.syncID];
    int32_t cmd = CMD_DEL_NOTIFY;
    NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    
    [[McpRequest sharedInstance] send:cmd userid:sender body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            DelMsgResult *rspArgs = (DelMsgResult *)packetObject.args;
            FNDelMsgResponse *rsp = [[FNDelMsgResponse alloc] initWithPBArgs:rspArgs];
            
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

@end
