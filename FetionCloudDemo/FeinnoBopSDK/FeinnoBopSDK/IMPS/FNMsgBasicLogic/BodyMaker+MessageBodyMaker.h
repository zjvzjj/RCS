//
//  BodyMaker+MessageBodyMaker.h
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-9-11.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BodyMaker.h"
#import "FNMsgArgs.h"

@class FNMultiMsgEnty;

@interface BodyMaker (MessageBodyMaker)

+(NSData *)makeRoamingMsgReqArgs:(int32_t)pageSize
                          peerId:(NSString *)peerId
                       lastRmsId:(NSString *)lastRmsId
                         msgType:(int32_t )msgType;

+ (NSData *)makeSendMultiMsgReqArgs:(NSString *)sender
                          msgEntity:(FNMultiMsgEnty *)msgEntity;

+ (NSData *)makeSendMsgReqArgs:(NSString *)sender
                     msgEntity:(FNMsgEntity *)msgEntity;

+ (NSData *)makePullMsgReqArgs:(int32_t)count
                        syncId:(int64_t)syncId;

+ (NSData *)makeDelMsgReqArgs:(int64_t)syncId;

+ (NSData *)makeSendSimpleMsgReqArgs:(NSString *)toBopId msg:(NSString *)msg;

@end
