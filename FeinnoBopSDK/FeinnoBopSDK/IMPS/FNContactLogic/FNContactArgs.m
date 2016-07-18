//
//  FNContactArgs.m
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/2/2.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNContactArgs.h"

#import "GetAddressListRspArgs.pb.h"
#import "GetRelationShipRspArgs.pb.h"
#import "SimpleRspArgs.pb.h"
#import "IsRegisterRspArgs.pb.h"
#import "GetPresenceResult.pb.h"
#import "UploadBuddyListResult.pb.h"


#pragma mark -
#pragma mark 联系人列表上传、获取、删除

@implementation FNGetAddressListRequest

@end

@interface FNGetAddressListResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *retDescription;
@property (nonatomic, readwrite) BOOL isEnd;
@property (nonatomic, readwrite) NSString *nextAddressListID;
@property (nonatomic, readwrite) NSArray *addressListCombo;

@end

@implementation FNGetAddressListResponse

- (instancetype)initWithPBArgs:(GetAddressListRspArgs *)rspArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = rspArgs.retCode;
        _retDescription = rspArgs.retDesc;
        _isEnd = rspArgs.isEnd;
        _nextAddressListID = rspArgs.nextAddresslistId;
        
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < rspArgs.addressList.count; i++)
        {
            FNAddressListDetailCombo *combo = [[FNAddressListDetailCombo alloc] init];
            combo.addressListID = ((GetAddressListRspArgs_AddresslistIdDetailCombo *)[rspArgs.addressList objectAtIndex:i]).addresslistId;
            combo.type = ((GetAddressListRspArgs_AddresslistIdDetailCombo *)[rspArgs.addressList objectAtIndex:i]).type;
            combo.addressListDetail = ((GetAddressListRspArgs_AddresslistIdDetailCombo *)[rspArgs.addressList objectAtIndex:i]).addresslistDetail;
            
            [temp addObject:combo];
        }
        
        _addressListCombo = [NSArray arrayWithArray:temp];
    }
    
    return self;
}

@end

@implementation FNAddressListDetailCombo

@end

@implementation FNUpAddressListRequest

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.dataType = @"PB";
    }
    return self;
}

@end

@interface FNUpAddressListResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *retDescription;

@end

@implementation FNUpAddressListResponse

- (instancetype)initWithPBArgs:(SimpleRspArgs *)rspArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = rspArgs.retCode;
        _retDescription = rspArgs.retDesc;
    }
    return self;
}

@end

@implementation FNDelAddressListRequest

- (instancetype)initWithTids:(NSArray *)tids
{
    self = [super init];
    if (self)
    {
        _tids = tids;
    }
    return self;
}

@end

@interface FNDelAddressListResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *retDescription;

@end

@implementation FNDelAddressListResponse

- (instancetype)initWithPBArgs:(SimpleRspArgs *)rspArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = rspArgs.retCode;
        _retDescription = rspArgs.retDesc;
    }
    return self;
}

@end


#pragma mark -
#pragma mark 联系人列表查询

@implementation FNGetRelationshipRequest

@end

@interface FNGetRelationshipResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *retDescription;
@property (nonatomic, readwrite) int32_t extentNo;
@property (nonatomic, readwrite) NSString *tid;
@property (nonatomic, readwrite) BOOL isEnd;
@property (nonatomic, readwrite) NSString *nextUID;
@property (nonatomic, readwrite) NSArray *relations;

@end

@implementation FNGetRelationshipResponse

- (instancetype)initWithPBArgs:(GetRelationShipRspArgs *)rspArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = rspArgs.retCode;
        _retDescription = rspArgs.retDesc;
        _extentNo = rspArgs.extentNo;
        _isEnd = rspArgs.isEnd;
        _tid = rspArgs.targetUserId;
        _nextUID = rspArgs.nextUserId;
        
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < rspArgs.relations.count; i++)
        {
            FNAddressListRelationsEntity *rEntity = [[FNAddressListRelationsEntity alloc] init];
            rEntity.userID = ((GetRelationShipRspArgs_AddressListRelationsEntity *)[rspArgs.relations objectAtIndex:i]).userid;
            rEntity.addressListID = ((GetRelationShipRspArgs_AddressListRelationsEntity *)[rspArgs.relations objectAtIndex:i]).addresslistId;
            rEntity.version = ((GetRelationShipRspArgs_AddressListRelationsEntity *)[rspArgs.relations objectAtIndex:i]).version;
            
            [temp addObject:rEntity];
        }
        
        _relations = [NSArray arrayWithArray:temp];
    }
    return self;
}

@end

@implementation FNAddressListRelationsEntity

@end

@interface FNOnlineItem ()

@property (nonatomic, readwrite) NSString *userId;
@property (nonatomic, readwrite) OnlineStatus presenceValue;

@end

@implementation FNOnlineItem

- (instancetype)initWithUserId:(NSString *)userId
                  onlineStatus:(OnlineStatus)presenceValue
{
    self = [super init];
    if (self)
    {
        _userId = userId;
        _presenceValue = presenceValue;
    }
    
    return self;
}

@end

@implementation FNGetPresenceRequest

@end

@interface FNGetPresenceResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSArray *onlineStatusList;

@end

@implementation FNGetPresenceResponse

- (instancetype)initWithPBArgs:(GetPresenceResult *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
        
        NSMutableArray *mList = [NSMutableArray arrayWithCapacity:1];
        for (int i = 0; i < pbArgs.resList.count; i++)
        {
            GetPresenceResult_PresenceItem *pItem = [pbArgs.resList objectAtIndex:i];
            FNOnlineItem *item = [[FNOnlineItem alloc] initWithUserId:pItem.userId
                                                         onlineStatus:pItem.presenceValue];
            mList[i] = item;
        }
        _onlineStatusList = mList;
    }
    return self;
}

@end

@implementation FNIsRegisterRequest

- (instancetype)initWithTids:(NSArray *)tids
{
    self = [super init];
    if (self)
    {
        _tids = tids;
    }
    return self;
}

@end

@interface FNIsRegisterResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *retDescription;
@property (nonatomic, readwrite) NSArray *registerStatus;

@end

@implementation FNIsRegisterResponse

- (instancetype)initWithPBArgs:(IsRegisterRspArgs *)rspArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = rspArgs.retCode;
        _retDescription = rspArgs.retDesc;
        
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < rspArgs.regiserStatus.count; i++)
        {
            FNRegisterStatusCombo *rs = [[FNRegisterStatusCombo alloc] init];
            rs.userID = ((IsRegisterRspArgs_RegisterStatusCombo *)[rspArgs.regiserStatus objectAtIndex:i]).userId;
            rs.registerStatus = ((IsRegisterRspArgs_RegisterStatusCombo *)[rspArgs.regiserStatus objectAtIndex:i]).registerStatus;
            
            [temp addObject:rs];
        }
        
        _registerStatus = [NSArray arrayWithArray:temp];
    }
    return self;
}

@end

@implementation FNRegisterStatusCombo

@end


#pragma mark -
#pragma mark 好友列表上传

@implementation FNUploadBuddyListRequest

@end

@interface FNUploadBuddyListResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNUploadBuddyListResponse

- (instancetype)initWithPBArgs:(UploadBuddyListResult *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
    }
    
    return self;
}

@end
