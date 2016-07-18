//
//  FNRTCNotify.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-14.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNRTCNotify.h"
#import "FNRTCArgs.h"

#import "CMD.h"
#import "McpRequest.h"

#import "RtcInviteReqArgs.pb.h"
#import "RtcReplyReqArgs.pb.h"
#import "RtcUpdateReqArgs.pb.h"

NSString *const NOTIFY_RTC_INVITE = @"BOPRtcInvite";
NSString *const NOTIFY_RTC_REPLY = @"BOPRtcReply";
NSString *const NOTIFY_RTC_UPDATE = @"BOPRtcUpdate";
NSString *const NOTIFY_AV_INVITE = @"BOPAVInvite";

@implementation FNRTCNotify

+ (void)startObserve
{
    [self stopObserve];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleRtcInviteNotify:)
                                                 name:[NSString stringWithFormat:@"%d", CMD_RTC_INVITE]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleRtcReplyNotify:)
                                                 name:[NSString stringWithFormat:@"%d", CMD_RTC_REPLY]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleRtcUpdateNotify:)
                                                 name:[NSString stringWithFormat:@"%d", CMD_RTC_UPDATE]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAVNotify:)
                                                 name:[NSString stringWithFormat:@"%d", CMD_NOTIFY_INFO]
                                               object:nil];
}

+ (void)stopObserve
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"%d", CMD_RTC_INVITE]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"%d", CMD_RTC_REPLY]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"%d", CMD_RTC_UPDATE]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"%d", CMD_NOTIFY_INFO]
                                                  object:nil];
}

+ (void)handleRtcInviteNotify:(NSNotification *)note
{
    NSData *data = (NSData *)[note object];
    PacketObject *packetObject = [McpRequest parse:data];
    RtcInviteReqArgs *args = (RtcInviteReqArgs *)[packetObject args];
    FNRtcInviteRequest *notifyArgs = [[FNRtcInviteRequest alloc] initWithPBArgs:args];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_RTC_INVITE object:notifyArgs];
}

+ (void)handleRtcReplyNotify:(NSNotification *)note
{
    NSData *data = (NSData *)[note object];
    PacketObject *packetObject = [McpRequest parse:data];
    RtcReplyReqArgs *args = (RtcReplyReqArgs *)[packetObject args];
    FNRtcReplyRequest *notifyArgs = [[FNRtcReplyRequest alloc] initWithPBArgs:args];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_RTC_REPLY object:notifyArgs];
}

+ (void)handleRtcUpdateNotify:(NSNotification *)note
{
    NSData *data = (NSData *)[note object];
    PacketObject *packetObject = [McpRequest parse:data];
    RtcUpdateReqArgs *args = (RtcUpdateReqArgs *)[packetObject args];
    FNRtcUpdateRequest *notifyArgs = [[FNRtcUpdateRequest alloc] initWithPBArgs:args];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_RTC_UPDATE object:notifyArgs];
}

+ (void)handleAVNotify:(NSNotification *)note
{
    NSData *data = (NSData *)[note object];
    PacketObject *packetObject = [McpRequest parse:data];
    AVNotifyInfo *args = (AVNotifyInfo *)[packetObject args];
    FNAVNotifyInfoNotifyArgs *notifyArgs = [[FNAVNotifyInfoNotifyArgs alloc] initWithPBArgs:args];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_AV_INVITE object:notifyArgs];
}

@end
