//
//  FNRTCArgs.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-14.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNRTCArgs.h"

#import "RtcInviteReqArgs.pb.h"
#import "RtcReplyReqArgs.pb.h"
#import "RtcUpdateReqArgs.pb.h"
#import "RtcInviteRspArgs.pb.h"
#import "RtcReplyRspArgs.pb.h"
#import "RtcUpdateRspArgs.pb.h"
#import "AVNotifyInfo.pb.h"

@implementation FNCallInfo

- (instancetype)initWithPBArgs:(NSString *)peerId callId:(NSString *)callId;
{
    self = [super init];
    if (self)
    {
        _peerID =peerId;
        _callID = callId;
    }
    return self;
}

@end

@implementation FNRtcInviteRequest

- (instancetype)initWithPBArgs:(RtcInviteReqArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _callInfo = [[FNCallInfo alloc] initWithPBArgs:pbArgs.callInfo.peerUserId
                                                callId:pbArgs.callInfo.callId];;
        _sdp = pbArgs.sdp;
    }
    return self;
}

@end

@interface FNRtcInviteResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNRtcInviteResponse

- (instancetype)initWithPBArgs:(RtcInviteRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
    }
    return self;
}

@end

@implementation FNRtcReplyRequest

- (instancetype)initWithPBArgs:(RtcReplyReqArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _replyCode = pbArgs.statusCode;
        _callInfo = [[FNCallInfo alloc] initWithPBArgs:pbArgs.callInfo.peerUserId
                                                callId:pbArgs.callInfo.callId];
        _sdp = pbArgs.sdp;
    }
    return self;
}

@end

@interface FNRtcReplyResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNRtcReplyResponse

- (instancetype)initWithPBArgs:(RtcReplyRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
    }
    return self;
}

@end

@implementation FNRtcUpdateRequest

- (instancetype)initWithPBArgs:(RtcUpdateReqArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _callInfo = [[FNCallInfo alloc] initWithPBArgs:pbArgs.callInfo.peerUserId
                                                callId:pbArgs.callInfo.callId];;
        _action = pbArgs.action;
    }
    return self;
}

@end

@interface FNRtcUpdateResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNRtcUpdateResponse

- (instancetype)initWithPBArgs:(RtcUpdateRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
    }
    return self;
}

@end

@interface FNAVNotifyInfoNotifyArgs ()

@property (nonatomic, readwrite) NSString *notifyType;
@property (nonatomic, readwrite) NSString *notifyBody;
@property (nonatomic, readwrite) NSString *msgId;

@end

@implementation FNAVNotifyInfoNotifyArgs

- (instancetype)initWithPBArgs:(AVNotifyInfo *)pbArgs
{
    self = [super init];
    if (self)
    {
        _notifyType = pbArgs.notifyType;
        _notifyBody = pbArgs.notifyBody;
        _msgId = pbArgs.msgId;
    }
    return self;
}

@end
