//
//  SignInfoV4.m
//  FeinnoBopSDK
//
//  Created by zym on 15/3/17.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "SignInfoV4.h"
#import "SignInfoV4Serializer.h"

@implementation SignInfoV4

- (instancetype) initSingnInfoV4
{
    self = [super init];
    if (self) {
        self.noce = arc4random()%10000000;
        self.createTime = [[NSDate alloc] init];
        self.expireTime = [[NSDate alloc] initWithTimeIntervalSinceNow:10*60*1000];
    }
    
    return self;
}


- (Boolean)isExpired
{
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    if (self.expireTime <= currentDate) {
        return true;
    } else
        return false;
}


- (NSData *)toBinary
{
    return [SignInfoV4Serializer serialize:self];
}


- (SignInfoV4 *)fromBinary:(NSData *)buffer
{
    return [SignInfoV4Serializer deSerialize:buffer offset:0];
}
@end
