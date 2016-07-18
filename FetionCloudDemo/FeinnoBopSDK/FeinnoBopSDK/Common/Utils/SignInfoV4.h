//
//  SignInfoV4.h
//  FeinnoBopSDK
//
//  Created by zym on 15/3/17.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignInfoV4 : NSObject

@property (nonatomic) int32_t noce;
@property (nonatomic) NSDate *createTime;
@property (nonatomic) NSDate *expireTime;
@property (nonatomic) int64_t userIp;
@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *indexId;
@property (nonatomic) int32_t indexCaps;

- (instancetype)initSingnInfoV4;

/*!
 *  判断凭证是否过期，如果返回ture，则凭证不可用
 *
 *  @return ture为凭证过期
 */
- (Boolean)isExpired;

/*!
 *  序列化用户信息为字节数组
 *
 *  @return 自己数组
 */

- (NSData *)toBinary;

- (SignInfoV4 *)fromBinary:(NSData *)buffer;

@end
