//
//  BodyMaker+ContactBodyMaker.h
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-9-9.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BodyMaker.h"

@interface BodyMaker (ContactBodyMaker)

+ (NSData *)makeGetAddressListReqArgs:(BOOL)isDetail
                       addressListIds:(NSArray *)ids
                   startAddressListId:(NSString *)startAddressListId
                                count:(int32_t)count;

+ (NSData *)makeUpAddressListReqArgs:(NSString *)type
                         addressList:(NSArray *)list;

+ (NSData *)makeDelAddressListReqArgs:(NSArray *)addressIds;

+ (NSData *)makeGetRelationshipReqArgs:(int32_t)extendNo
                              targetId:(NSString *)targetId
                           startUserId:(NSString *)startUserId;

+ (NSData *)makeGetPresenceReqArgs:(NSArray *)userList;

+ (NSData *)makeIsRegisterReqArgs:(NSArray *)userIds;

+ (NSData *)makeUploadBuddyListReqArgs:(NSString *)ownerId
                      buddyListVersion:(NSString *)version
                             buddyList:(NSArray *)list;

@end
