//
//  McpRequest.h
//  feinno-sdk-net
//
//  Created by wangshuying on 14-8-27.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PacketObject.h"

@interface McpRequest : NSObject

+ (McpRequest *)sharedInstance;
- (id)initWithIp:(NSString *)ip
            port:(uint16_t)port;

- (void)connect;
- (void)disConnect;

- (void)send:(uint32_t)cmd
      userid:(NSString *)userid
        body:(NSData *)body
    callback:(void(^)(NSData *data))callback;

+ (PacketObject *)parse:(NSData *)data;
+ (PacketObject *)parseWithData:(NSData *)data
                            key:(NSString *)key;

@end
