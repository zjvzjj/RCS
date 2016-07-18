//
//  FNRTCLogic.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-14.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNRTCLogic.h"
#import "FNMsgBasicLogic.h"

#import "CMD.h"
#import "McpRequest.h"
#import "BodyMaker+RTCBodyMaker.h"

#import "FNUserConfig.h"

@implementation FNRTCLogic

+ (void)rtcInvite:(FNRtcInviteRequest *)inviteReq
         callback:(void(^)(FNRtcInviteResponse *))callback
{
    inviteReq.callInfo.callID = [FNMsgBasicLogic generateUUID];
    NSData *body = [BodyMaker makeRtcInviteReqArgs:inviteReq.callInfo.peerID callId:inviteReq.callInfo.callID sdp:inviteReq.sdp];
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    
    [[McpRequest sharedInstance] send:CMD_RTC_INVITE userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parseWithData:data
                                                               key:[FNUserConfig getInstance].cStr];
            RtcInviteRspArgs *rspArgs = (RtcInviteRspArgs *)packetObject.args;
            FNRtcInviteResponse *rsp = [[FNRtcInviteResponse alloc] initWithPBArgs:rspArgs];
            
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

// statusCode 200:接受 420:设备不支持音视频 603:拒绝
+ (void)rtcReply:(FNRtcReplyRequest *)replyReq
        callback:(void(^)(FNRtcReplyResponse *))callback
{
    replyReq.callInfo.callID = [FNMsgBasicLogic generateUUID];
    NSData *body = [BodyMaker makeRtcReplyReqArgs:replyReq.callInfo.peerID callId:replyReq.callInfo.callID sdp:replyReq.sdp statusCode:replyReq.replyCode];
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    
    [[McpRequest sharedInstance] send:CMD_RTC_REPLY userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parseWithData:data
                                                               key:[FNUserConfig getInstance].cStr];
            RtcReplyRspArgs *rspArgs = (RtcReplyRspArgs *)packetObject.args;
            
            FNRtcReplyResponse *rsp = [[FNRtcReplyResponse alloc] initWithPBArgs:rspArgs];
            
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

// action 1:主叫确认会话 2:取消会话 3:挂断会话
+ (void)rtcUpdate:(FNRtcUpdateRequest *)updateReq
         callback:(void(^)(FNRtcUpdateResponse *))callback
{
    updateReq.callInfo.callID = [FNMsgBasicLogic generateUUID];
    NSData *body = [BodyMaker makeRtcUpdateReqArgs:updateReq.callInfo.peerID callId:updateReq.callInfo.callID action:updateReq.action];
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    
    [[McpRequest sharedInstance] send:CMD_RTC_UPDATE userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parseWithData:data
                                                               key:[FNUserConfig getInstance].cStr];
            RtcUpdateRspArgs *rspArgs = (RtcUpdateRspArgs *)packetObject.args;
            
            FNRtcUpdateResponse *rsp = [[FNRtcUpdateResponse alloc] initWithPBArgs:rspArgs];
            
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

@end
