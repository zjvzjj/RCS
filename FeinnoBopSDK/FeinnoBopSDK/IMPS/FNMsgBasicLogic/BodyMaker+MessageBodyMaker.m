//
//  BodyMaker+MessageBodyMaker.m
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-9-11.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "BodyMaker+MessageBodyMaker.h"
#import "SendMsgReqArgs.pb.h"
#import "PullMsgReqArgs.pb.h"
#import "DelMsgReqArgs.pb.h"
#import "FNMsgArgs.h"
#import "FNMultiMsgEnty.h"
#import "SendMultiMsgReqArgs.pb.h"
#import "GetRoamingMsgReqArgs.pb.h"
#import "SendSimpleMsgReqArgs.pb.h"

@implementation BodyMaker (MessageBodyMaker)

+(NSData *)makeRoamingMsgReqArgs:(int32_t)pageSize
                          peerId:(NSString *)peerId
                       lastRmsId:(NSString *)lastRmsId
                         msgType:(int32_t )msgType
{
    GetRoamingMsgReqArgs_Builder *builder = [[GetRoamingMsgReqArgs_Builder alloc]init];
    builder.peerId = peerId;
    builder.lastRmsId =lastRmsId;
    builder.msgType = msgType;
    builder.pageSize =pageSize;
    GetRoamingMsgReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeSendMultiMsgReqArgs:(NSString *)sender
                          msgEntity:(FNMultiMsgEnty *)msgEntity
{
    SendMultiMsgReqArgs_Builder *builder = [[SendMultiMsgReqArgs_Builder alloc] init];
    builder.fromBopId = sender;
    [builder setToBopIdArray:msgEntity.peerIDs];
    
    MsgEntitysBuilder *msgBuilder = [[MsgEntitysBuilder alloc] init];
    msgBuilder.msgId = msgEntity.msgId;
    msgBuilder.syncId = msgEntity.syncID;
    msgBuilder.msgType = msgEntity.msgType;
    msgBuilder.msgAttribute = msgEntity.msgAttribute;
    if (msgEntity.senderNickname)
    {
        [msgBuilder setSenderNickName:msgEntity.senderNickname];
    }
    
    msgBuilder.msgContent = msgEntity.msgContent;
    
    if (msgEntity.source)
    {
        msgBuilder.senderId = msgEntity.source;
    }
    if (msgEntity.extend)
    {
        [msgBuilder setExtendArray: @[msgEntity.extend]];
    }
    
    builder.msg = [msgBuilder build];
    
    SendMultiMsgReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeSendMsgReqArgs:(NSString *)sender
                     msgEntity:(FNMsgEntity *)msgEntity
{
    SendMsgReqArgsBuilder *builder = [[SendMsgReqArgsBuilder alloc] init];
    builder.fromBopId = sender;
    builder.toUserId = msgEntity.peerID;
    if (msgEntity.sendPortraitUrl)
    {
        builder.sendClientPortraitUrl = msgEntity.sendPortraitUrl;
    }
    
    SendMsgReqArgsMsgEntityBuilder *msgBuilder = [[SendMsgReqArgsMsgEntityBuilder alloc] init];
    msgBuilder.msgId = msgEntity.msgId;
    msgBuilder.syncId = msgEntity.syncID;
    msgBuilder.msgType = msgEntity.msgType;
    msgBuilder.msgAttribute = msgEntity.msgAttribute;
    if (msgEntity.senderNickname)
    {
        msgBuilder.senderNickname = msgEntity.senderNickname;
    }
    msgBuilder.msgContent = msgEntity.msgContent;

    if (msgEntity.senderId)
    {
        msgBuilder.senderId = msgEntity.senderId;
    }
    if (msgEntity.sendPortraitUrl)
    {
        
    }
    if (msgEntity.extend)
    {
        msgBuilder.extend = msgEntity.extend;
    }
    msgBuilder.pushDesc = msgEntity.pushDesc;
  
    builder.msg = [msgBuilder build];
    
    SendMsgReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makePullMsgReqArgs:(int32_t)count
                        syncId:(int64_t)syncId
{
    PullMsgReqArgs_Builder *builder = [[PullMsgReqArgs_Builder alloc] init];
    builder.count = count;
    builder.syncId = syncId;
    
    PullMsgReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeDelMsgReqArgs:(int64_t)syncId
{
    DelMsgReqArgs_Builder *builder = [[DelMsgReqArgs_Builder alloc] init];
    builder.syncId = syncId;
    
    DelMsgReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeSendSimpleMsgReqArgs:(NSString *)toBopId msg:(NSString *)msg
{
    SendSimpleMsgReqArgs_Builder *builder = [[SendSimpleMsgReqArgs_Builder alloc] init];
    builder.toBopId = toBopId;
    builder.msg = msg;
    
    SendSimpleMsgReqArgs *args = [builder build];
    
    return args.data;
}

@end
