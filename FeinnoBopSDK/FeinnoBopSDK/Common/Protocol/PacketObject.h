//
//  PacketObject.h
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-8-28.
//  Copyright (c) 2014年 feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PacketHeader.h"

@interface PacketObject : NSObject

@property (nonatomic) ResponseHeader header;
@property (nonatomic, retain) NSObject* args;

@end
