//
//  BodyMaker+NotifyBodyMaker.h
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-13.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BodyMaker.h"

@interface BodyMaker (NotifyBodyMaker)

+ (NSData *)makePullNotifyReqArgs:(int32_t)count
                           syncId:(int64_t)syncId;

+ (NSData *)makeSendSimpleMsgNotify:(NSString *)fromBopId msg:(NSString *)msg;

@end
