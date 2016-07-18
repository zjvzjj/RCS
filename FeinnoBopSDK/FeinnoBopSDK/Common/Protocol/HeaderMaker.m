//
//  HeaderMaker.m
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-8-25.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "HeaderMaker.h"

@implementation HeaderMaker

+ (NSData *)makeRequestHeaderWithCmd:(uint32_t)cmd
                          bodyLength:(uint16_t)length
                             version:(uint8_t)version
                              userId:(NSString *)userId
                                 seq:(uint16_t)seq
                                flag:(uint8_t)flag
                          clientType:(uint16_t)clientType
                       clientVersion:(uint16_t)clientVersion
{
    uint8_t uLen = [userId length];
    RequestHeader header;
    header.length = 21 + uLen + length;
    header.version = version;
    header.userId_unused = 0;
    header.cmd = cmd;
    header.seq = seq;
    header.offset = 21 + uLen;
    header.format = 0;
    header.flag = flag;
    header.clientType = clientType;
    header.clientVersion = clientVersion;
    header.blank = 0;
    
    NSLog(@"message length: %d, header length: %d", header.length, header.offset);
    
    NSMutableData *data = [[NSMutableData alloc] init];
    [data appendBytes:&header length:21];
    [data appendData:[userId dataUsingEncoding:NSUTF8StringEncoding]];
    
    return data;
}

@end