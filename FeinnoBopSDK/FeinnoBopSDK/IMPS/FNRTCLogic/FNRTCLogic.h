//
//  FNRTCLogic.h
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-14.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNRTCArgs.h"

@interface FNRTCLogic : NSObject

/**
 *  主叫邀请音视频会话
 *
 *  @param inviteReq 主叫邀请音视频会话的请求
 *  @param callback  主叫邀请音视频会话的回调
 */
+ (void)rtcInvite:(FNRtcInviteRequest *)inviteReq
         callback:(void(^)(FNRtcInviteResponse *rspArgs))callback;

/**
 *  被叫处理音视频会话请求
 *
 *  @param replyReq 被叫处理音视频会话请求的请求参数
 *  @param callback 被叫处理音视频会话请求的回调
 */
+ (void)rtcReply:(FNRtcReplyRequest *)replyReq
        callback:(void(^)(FNRtcReplyResponse *rspArgs))callback;

/**
 *  音视频会话变更
 *
 *  @param updateReq 音视频会话变更的请求
 *  @param callback  音视频会话变更的回调
 */
+ (void)rtcUpdate:(FNRtcUpdateRequest *)updateReq
         callback:(void(^)(FNRtcUpdateResponse *rspArgs))callback;

@end
