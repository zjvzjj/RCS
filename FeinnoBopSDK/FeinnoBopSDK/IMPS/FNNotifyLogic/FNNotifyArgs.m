//
//  FNNotifyArgs.m
//  FeinnoBopSDK
//
//  Created by wangshuying on 15/1/29.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNNotifyArgs.h"

#import "PullNotifyResults.pb.h"
#import "SysNotify.pb.h"

@implementation FNPullNotifyRequest

@end

@implementation FNSendSimplemsgNotify

@end

@interface FNPullNotifyResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSArray *notifyList;
@property (nonatomic, readwrite) BOOL isCompleted;
@property (nonatomic, readwrite) int64_t syncID;

@end

@implementation FNPullNotifyResponse

- (instancetype)initWithPBArgs:(PullNotifyResults *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
        _isCompleted = pbArgs.isCompleted;
        _syncID = pbArgs.syncId;
        
        NSMutableArray *tmp = [NSMutableArray array];
        for (int i = 0; i < pbArgs.argsListList.count; i++)
        {
            FNNotifyEntity *notify = [[FNNotifyEntity alloc] init];
            PullNotifyResults_NotifyMsgSArgs *arg = [pbArgs.argsListList objectAtIndex:i];
            notify.sourceID = arg.sourceId;
            notify.tid = arg.tid;
            notify.notifyType = arg.notifyType;
            notify.notifyId = arg.notifyId;
            notify.notifyBody = arg.notifyBody;
            
            tmp[i] = notify;
        }
        _notifyList = tmp;
    }
    return self;
}

@end

@implementation FNNotifyEntity

@end

@interface FNSystemNotifyArgs ()

@property (nonatomic, readwrite) int64_t msgId;
@property (nonatomic, readwrite) SystemNotifyType msgType;
@property (nonatomic, readwrite) NSString *msgBody;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *sendDate;

@end

@implementation FNSystemNotifyArgs

- (instancetype)initWithPBArgs:(SysNotify *)pbArgs
{
    self = [super init];
    if (self)
    {
        _msgId = pbArgs.msgId;
        _msgType = pbArgs.msgType;
        _msgBody = pbArgs.msgBody;
        _title = pbArgs.title;
        _sendDate = pbArgs.sendDate;
    }
    
    return self;
}

@end
