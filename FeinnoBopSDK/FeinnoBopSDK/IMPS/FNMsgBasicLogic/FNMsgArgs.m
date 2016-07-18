//
//  FNMsgArgs.m
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/2/2.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNMsgArgs.h"
#import "SendMsgResults.pb.h"
#import "PullMsgResults.pb.h"
#import "DelMsgResult.pb.h"
#import "GetRoamingMsgResults.pb.h"
#import "SendSimpleMsgNotify.pb.h"

@implementation FNGetRoamingMsgRequest

@end

@interface FNGetRoamingMsgResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSArray *msgList;

@end

@implementation FNGetRoamingMsgResponse

- (instancetype)initWithPBArgs:(GetRoamingMsgResults *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
        _msgType = pbArgs.msgType;
        _lastRmsId = pbArgs.lastRmsId;
        
        
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < pbArgs.msgRspArgsList.count; i++)
        {
            GetRoamingMsgResultsMsgEntityArgs *rMsg = (GetRoamingMsgResultsMsgEntityArgs *)[pbArgs.msgRspArgsList objectAtIndex:i];
            
            // 这样是否可以释放PB占用的内存？
            FNMsgEntity *msg = [[FNMsgEntity alloc] init];
            msg.peerID = [rMsg.fromBopId copy];
            msg.sendDate = [rMsg.sendDate copy];
            msg.msgId = [rMsg.msg.msgId copy];
            msg.msgType = [rMsg.msg.msgType copy];
            msg.msgAttribute = [rMsg.msg.msgAttribute copy];
            msg.msgContent = [rMsg.msg.msgContent copy];
            msg.senderNickname = [rMsg.msg.senderNickname copy];
            msg.source = [rMsg.msg.senderId copy];
            msg.extend = [rMsg.msg.extend copy];
            msg.syncID = rMsg.msg.syncId;
            
            [temp addObject:msg];
        }
        pbArgs = nil;
        _msgList = [NSArray arrayWithArray:temp];
    }
    
    return self;
}

@end

@implementation FNMsgEntity

@end

@implementation FNSendTextMsgRequest

@end

@interface FNSendMsgResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *reason;
@property (nonatomic, readwrite) NSString *msgID;
@property (nonatomic, readwrite) NSString *sendDate;
@property (nonatomic, readwrite) int64_t syncID;

@end

@implementation FNSendMsgResponse

- (instancetype)initWithPBArgs:(SendMsgResults *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
        _reason = pbArgs.reason;
        _msgID = pbArgs.msgId;
        _sendDate = pbArgs.sendTime;
        _syncID = pbArgs.syncId;
    }
    
    return self;
}

- (instancetype)initWithStatusCode:(int32_t)statusCode
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
    }
    return self;
}

@end

@implementation FNSendRichTextMsgRequest

@end

@implementation FNSendRichTextMsgResponse

@end

@implementation FNPullMsgRequest

@end

@interface FNPullMsgResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSArray *msgList;

@end

@implementation FNPullMsgResponse

- (instancetype)initWithPBArgs:(PullMsgResults *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
        _isCompleted = pbArgs.isCompleted;
        _syncID = pbArgs.syncId;
        
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < pbArgs.readMsgRspArgsList.count; i++)
        {
            PullMsgResultsMsgEntityArgs *rMsg = (PullMsgResultsMsgEntityArgs *)[pbArgs.readMsgRspArgsList objectAtIndex:i];
            
            // 这样是否可以释放PB占用的内存？
            FNMsgEntity *msg = [[FNMsgEntity alloc] init];
            msg.peerID = [rMsg.fromBopId copy];
            msg.sendDate = [rMsg.sendDate copy];
            msg.msgId = [rMsg.msg.msgId copy];
            msg.msgType = [rMsg.msg.msgType copy];
            msg.msgAttribute = [rMsg.msg.msgAttribute copy];
            msg.msgContent = [rMsg.msg.msgContent copy];
            msg.senderNickname = [rMsg.msg.senderNickname copy];
            msg.senderId = [rMsg.msg.senderId copy];
            msg.sendPortraitUrl = [rMsg.sendClientPortraitUrl copy];
            msg.extend = [rMsg.msg.extend copy];
            msg.syncID = rMsg.msg.syncId;
            
            [temp addObject:msg];
        }
        pbArgs = nil;
        _msgList = [NSArray arrayWithArray:temp];
    }
    
    return self;
}

@end

@implementation FNDelMsgRequest

@end

@interface FNDelMsgResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNDelMsgResponse

- (instancetype)initWithPBArgs:(DelMsgResult *)pbArgs
{
    self = [super init];
    if (self) {
        _statusCode = pbArgs.statusCode;
    }
    
    return self;
}

@end

@implementation FNSendSimpleMsgRequest

@end

@interface FNSendSimpleMsgResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNSendSimpleMsgResponse

- (instancetype)initWithStatusCode:(int32_t)statusCode
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
    }
    return self;
}

@end

@implementation FNSendSimpleMsgNtfItem

- (instancetype)initWithPBArgs:(SendSimpleMsgNotify *)pbArgs
{
    self = [super init];
    if (self)
    {
        _sourceUserId = pbArgs.fromBopId;
        _message = pbArgs.message;
    }
    return self;
}

@end
