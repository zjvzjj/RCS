//
//  PacketParse.h
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-8-28.
//  Copyright (c) 2014年 feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PacketHeader.h"
#import "PacketObject.h"

@interface PacketParser : NSObject
{
    NSMutableDictionary* argClassNames;
}

@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) PacketObject *packetObject;

- (id)init;
- (id)initWithBytes:(uint8_t *)bytes length:(uint16_t)length;
- (id)initWithData:(NSData *)data;

- (void)loadArgClassNames;

- (PacketObject *)parse;
- (PacketObject *)parseWithKey:(NSString *)key;
- (ResponseHeader)parseHeader;
- (NSObject *)parseBodyWithKey:(NSString *)key;

@end
