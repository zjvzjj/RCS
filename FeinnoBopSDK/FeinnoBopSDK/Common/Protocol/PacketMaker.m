//
//  PacketMaker.m
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-8-27.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "PacketMaker.h"

@implementation PacketMaker

+ (NSData *)compose:(NSData *)header body:(NSData *)body {
    NSMutableData *data=[[NSMutableData alloc] init];
    
    [data appendData:header];
    [data appendData:body];
    
    return data;
}

@end
