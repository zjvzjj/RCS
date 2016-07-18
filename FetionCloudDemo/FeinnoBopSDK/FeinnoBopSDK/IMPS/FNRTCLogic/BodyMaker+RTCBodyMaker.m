//
//  BodyMaker+RTCBodyMaker.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-14.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "BodyMaker+RTCBodyMaker.h"
#import "RtcInviteReqArgs.pb.h"
#import "RtcReplyReqArgs.pb.h"
#import "RtcUpdateReqArgs.pb.h"

@implementation BodyMaker (RTCBodyMaker)

+ (NSData *)makeRtcInviteReqArgs:(NSString *)peerId
                          callId:(NSString *)callId
                             sdp:(NSString *)sdp
{
    RtcInviteReqArgs_Builder *builder = [[RtcInviteReqArgs_Builder alloc] init];
    RtcInviteReqArgs_CallInfo_Builder * infoBuilder = [[RtcInviteReqArgs_CallInfo_Builder alloc] init];
    infoBuilder.peerUserId = peerId;
    infoBuilder.callId = callId;
    builder.callInfo = [infoBuilder build];
    builder.sdp = sdp;
    
    RtcInviteReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeRtcReplyReqArgs:(NSString *)peerId
                         callId:(NSString *)callId
                            sdp:(NSString *)sdp
                     statusCode:(int32_t)statusCode
{
    RtcReplyReqArgs_Builder *builder = [[RtcReplyReqArgs_Builder alloc] init];
    RtcReplyReqArgs_CallInfo_Builder * infoBuilder = [[RtcReplyReqArgs_CallInfo_Builder alloc] init];
    infoBuilder.peerUserId = peerId;
    infoBuilder.callId = callId;
    builder.callInfo = [infoBuilder build];
    builder.sdp = sdp;
    builder.statusCode = statusCode;
    
    RtcReplyReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeRtcUpdateReqArgs:(NSString *)peerId
                          callId:(NSString *)callId
                          action:(int32_t)action
{
    RtcUpdateReqArgs_Builder *builder = [[RtcUpdateReqArgs_Builder alloc] init];
    RtcUpdateReqArgs_CallInfo_Builder * infoBuilder = [[RtcUpdateReqArgs_CallInfo_Builder alloc] init];
    infoBuilder.peerUserId = peerId;
    infoBuilder.callId = callId;
    builder.callInfo = [infoBuilder build];
    builder.action = action;
    
    RtcUpdateReqArgs *args = [builder build];
    return args.data;
}

@end
