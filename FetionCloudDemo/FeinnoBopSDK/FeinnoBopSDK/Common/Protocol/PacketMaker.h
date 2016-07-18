//
//  PacketMaker.h
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-8-27.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PacketHeader.h"

@interface PacketMaker : NSObject

+ (NSData*)compose:(NSData *)header body:(NSData*)body;

@end
