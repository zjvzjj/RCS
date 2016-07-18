//
//  BodyMaker+RTCBodyMaker.h
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-14.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BodyMaker.h"

@interface BodyMaker (RTCBodyMaker)

+ (NSData *)makeRtcInviteReqArgs:(NSString *)peerId
                          callId:(NSString *)callId
                             sdp:(NSString *)sdp;

+ (NSData *)makeRtcReplyReqArgs:(NSString *)peerId
                         callId:(NSString *)callId
                            sdp:(NSString *)sdp
                     statusCode:(int32_t)statusCode;

+ (NSData *)makeRtcUpdateReqArgs:(NSString *)peerId
                          callId:(NSString *)callId
                          action:(int32_t)action;

@end
