//
//  BodyMaker+NotifyBodyMaker.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-13.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "BodyMaker+NotifyBodyMaker.h"
#import "PullMsgReqArgs.pb.h"
#import "SendSimpleMsgNotify.pb.h"

@implementation BodyMaker (NotifyBodyMaker)

+ (NSData *)makePullNotifyReqArgs:(int32_t)count
                           syncId:(int64_t)syncId
{
    PullMsgReqArgs_Builder *builder = [[PullMsgReqArgs_Builder alloc] init];
    builder.count = count;
    builder.syncId = syncId;
    
    PullMsgReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeSendSimpleMsgNotify:(NSString *)fromBopId msg:(NSString *)msg
{
    SendSimpleMsgNotify_Builder *builder = [[SendSimpleMsgNotify_Builder alloc] init];
    
    builder.fromBopId = fromBopId;
    
    builder.message = msg;
    
    SendSimpleMsgNotify *args = [builder build];
    
    return args.data;
}
@end
