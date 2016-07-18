//
//  BodyMaker+ContactBodyMaker.m
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-9-9.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "BodyMaker+ContactBodyMaker.h"
#import "GetAddressListReqArgs.pb.h"
#import "UpAddressListReqArgs.pb.h"
#import "DelAddressListReqArgs.pb.h"
#import "AddressInfo.pb.h"
#import "AddresslistIdDetailCombo.pb.h"
#import "GetRelationShipReqArgs.pb.h"
#import "GetPresenceArgs.pb.h"
#import "IsRegisterReqArgs.pb.h"
#import "UploadBuddyListArgs.pb.h"

@implementation BodyMaker (ContactBodyMaker)

+ (NSData *)makeGetAddressListReqArgs:(BOOL)isDetail
                       addressListIds:(NSArray *)ids
                   startAddressListId:(NSString *)startAddressListId
                                count:(int32_t)count
{
    GetAddressListReqArgs_Builder *builder = [[GetAddressListReqArgs_Builder alloc] init];
    builder.isDetail = isDetail;
    [builder setAddresslistIdsArray:ids];
    builder.startAddresslistId = startAddressListId;
    builder.countNum = count;
    
    GetAddressListReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeUpAddressListReqArgs:(NSString *)type
                         addressList:(NSArray *)list
{
    UpAddressListReqArgs_Builder *builder = [[UpAddressListReqArgs_Builder alloc] init];
    builder.type = type;
    
    NSMutableArray *combos = [NSMutableArray array];
    for (int i = 0; i < [list count]; i++)
    {
        NSDictionary *contactInfo = [list objectAtIndex:i];
        AddressInfo_Builder *builder = [[AddressInfo_Builder alloc] init];
        builder.name = [contactInfo objectForKey:@"name"];
        builder.mobile = [contactInfo objectForKey:@"phone"];
        builder.email = [contactInfo objectForKey:@"email"];
        
        AddresslistIdDetailCombo_Builder *comboBuilder = [[AddresslistIdDetailCombo_Builder alloc]  init];
        comboBuilder.addresslistId = [[[contactInfo objectForKey:@"phone"] componentsSeparatedByString:@","] firstObject];
        comboBuilder.addresslistDetail = [builder build].data;
        comboBuilder.type = type;
        [combos addObject:[comboBuilder build]];
    }
    [builder setAddressListArray:combos];
    
    UpAddressListReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeDelAddressListReqArgs:(NSArray *)addressIds
{
    DelAddressListReqArgs_Builder *builder = [[DelAddressListReqArgs_Builder alloc] init];
    [builder setAddressIdsArray:addressIds];
    
    DelAddressListReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeGetRelationshipReqArgs:(int32_t)extendNo
                              targetId:(NSString *)targetId
                           startUserId:(NSString *)startUserId
{
    GetRelationShipReqArgs_Builder *builder = [[GetRelationShipReqArgs_Builder alloc] init];
    builder.extentNo = extendNo;
    builder.targetUserId = targetId;
    builder.startUserId = startUserId;
    
    GetRelationShipReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeGetPresenceReqArgs:(NSArray *)userList
{
    GetPresenceArgs_Builder *builder = [[GetPresenceArgs_Builder alloc] init];
    [builder setUserListArray:userList];
    
    GetPresenceArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeIsRegisterReqArgs:(NSArray *)userIds
{
    IsRegisterReqArgs_Builder *builder = [[IsRegisterReqArgs_Builder alloc] init];
    [builder setDestIdsArray:userIds];
    
    IsRegisterReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeUploadBuddyListReqArgs:(NSString *)ownerId
                      buddyListVersion:(NSString *)version
                             buddyList:(NSArray *)list
{
    UploadBuddyListArgs_Builder *builder = [[UploadBuddyListArgs_Builder alloc] init];
    builder.ownerId = ownerId;
    builder.buddyListVersion = version;
    [builder setBuddyListArray:list];
    
    UploadBuddyListArgs *args = [builder build];
    return args.data;
}

@end
