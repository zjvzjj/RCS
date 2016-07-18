//
//  HeaderMaker.h
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-8-25.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PacketHeader.h"

@interface HeaderMaker : NSObject

+ (NSData *)makeRequestHeaderWithCmd:(uint32_t)cmd
                          bodyLength:(uint16_t)length
                             version:(uint8_t)version
                              userId:(NSString *)userId
                                 seq:(uint16_t)seq
                                flag:(uint8_t)flag
                          clientType:(uint16_t)clientType
                       clientVersion:(uint16_t)clientVersion;

@end
