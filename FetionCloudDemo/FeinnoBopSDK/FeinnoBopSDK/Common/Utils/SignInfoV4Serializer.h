//
//  SignInfoV4Serializer.h
//  FeinnoBopSDK
//
//  Created by zym on 15/3/17.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SignInfoV4;

@interface SignInfoV4Serializer : NSObject

+ (NSData *)serialize:(SignInfoV4 *)info;

+ (SignInfoV4 *)deSerialize : (NSData *)buffer offset:(int32_t)offset;

+ (void) putIntDotNet : (Byte *)buffer input:(int32_t)info index:(int32_t)index;

+ (void) putLongDotNet : (Byte *)buffer input:(int64_t)info index:(int32_t)index;

+ (int32_t) getIntDoNet : (Byte *)buffer index:(int32_t)index;

+ (int64_t) getLongDoNet : (Byte *)buffer index:(int32_t)index;

@end
