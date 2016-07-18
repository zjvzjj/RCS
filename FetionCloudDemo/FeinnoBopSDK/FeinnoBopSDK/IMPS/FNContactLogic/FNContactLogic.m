//
//  ContactLogic.m
//  feinno-sdk-imps
//
//  Created by wangshuying on 14-9-9.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNContactLogic.h"
#import "FNContactTable.h"

#import "FNUserConfig.h"

#import "CMD.h"
#import "McpRequest.h"

#import "BodyMaker+ContactBodyMaker.h"
#import "GetAddressListRspArgs.pb.h"
#import "AddresslistIdDetailCombo.pb.h"
#import "AddressInfo.pb.h"
#import "GetRelationShipRspArgs.pb.h"
#import "IsRegisterRspArgs.pb.h"

#import "NSString+Extension.h"

@implementation FNContactLogic

+ (void)getAddressList:(FNGetAddressListRequest *)getAddressListReq
              callback:(void(^)(FNGetAddressListResponse *rspArgs))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeGetAddressListReqArgs:getAddressListReq.isDetail
                                         addressListIds:getAddressListReq.addressListIDs
                                     startAddressListId:getAddressListReq.startAddressListID
                                                  count:getAddressListReq.count];
    
    [[McpRequest sharedInstance] send:CMD_GET_ADDRESS_LIST userid:userid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            GetAddressListRspArgs *rspArgs = (GetAddressListRspArgs *)packetObject.args;
            FNGetAddressListResponse *rsp = [[FNGetAddressListResponse alloc] initWithPBArgs:rspArgs];
            
            if (200 == rsp.statusCode)
            {
                if ([NSString isNullString:getAddressListReq.startAddressListID])
                {
                    [FNContactTable clearAll];
                }
                for (int i = 0; i < rsp.addressListCombo.count; i++)
                {
                    FNAddressListDetailCombo *infos = (FNAddressListDetailCombo *)rsp.addressListCombo[i];
                    AddressInfo *info = [AddressInfo parseFromData:infos.addressListDetail];
                    
                    FNContactTable *table = [[FNContactTable alloc] init];
                    if (getAddressListReq.isDetail)
                    {
                        table.name = info.name;
                        table.mobileNo = info.mobile;
                        table.email = info.email;
                    }
                    else
                    {
                        table.name = infos.addressListID;
                    }
                    
                    [FNContactTable insert:table];
                }
                
                if (!rsp.isEnd && [rsp.addressListCombo count] > 0)
                {
                    getAddressListReq.startAddressListID = rsp.nextAddressListID;
                    [self getAddressList:getAddressListReq callback:callback];
                }
                else
                {
                    callback(rsp);
                }
            }
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)upAddressList:(FNUpAddressListRequest *)upAddressListReq
             callback:(void(^)(FNUpAddressListResponse *rspArgs))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeUpAddressListReqArgs:upAddressListReq.dataType
                                           addressList:upAddressListReq.addressList];
    
    [[McpRequest sharedInstance] send:CMD_UP_ADDRESSLIST userid:userid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            SimpleRspArgs *rspArgs = (SimpleRspArgs *)packetObject.args;
            FNUpAddressListResponse *rsp = [[FNUpAddressListResponse alloc] initWithPBArgs:rspArgs];
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)delAddressList:(FNDelAddressListRequest *)delAddressListReq
              callback:(void(^)(FNDelAddressListResponse *rspArgs))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeDelAddressListReqArgs:delAddressListReq.tids];
    
    [[McpRequest sharedInstance] send:CMD_DEL_ADDRESS_LIST userid:userid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            SimpleRspArgs *rspArgs = (SimpleRspArgs *)packetObject.args;
            FNDelAddressListResponse *rsp = [[FNDelAddressListResponse alloc] initWithPBArgs:rspArgs];
            
            if (200 == rsp.statusCode)
            {
                for (int i = 0; i < delAddressListReq.tids.count; i++)
                {
                    [FNContactTable delete:delAddressListReq.tids[i]];
                }
            }
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)getRelationship:(FNGetRelationshipRequest *)getRelationsReq
               callback:(void(^)(FNGetRelationshipResponse *rspArgs))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeGetRelationshipReqArgs:getRelationsReq.extentNo targetId:getRelationsReq.tid startUserId:getRelationsReq.startID];
    
    [[McpRequest sharedInstance] send:CMD_GET_RELATIONSHIP userid:userid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            GetRelationShipRspArgs *rspArgs = (GetRelationShipRspArgs *)packetObject.args;
            FNGetRelationshipResponse *rsp = [[FNGetRelationshipResponse alloc] initWithPBArgs:rspArgs];
            
            if (200 == rsp.statusCode)
            {
                for (int i = 0; i < rsp.relations.count; i++)
                {
                    FNAddressListRelationsEntity *infos = (FNAddressListRelationsEntity *)rsp.relations[i];
                    FNContactTable *table = [FNContactTable get:infos.userID];
                    table.version = infos.version;
                    [FNContactTable insert:table];
                }
                
                if (!rsp.isEnd)
                {
                    getRelationsReq.startID = rsp.nextUID;
                    [self getRelationship:getRelationsReq callback:callback];
                }
                else
                {
                    callback(rsp);
                }
            }
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)getPresence:(FNGetPresenceRequest *)presenceReq
           callback:(void(^)(FNGetPresenceResponse *rspArgs))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeGetPresenceReqArgs:presenceReq.tidList];
    
    [[McpRequest sharedInstance] send:CMD_GET_ONLINE_STATUS userid:userid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            GetPresenceResult *rspArgs = (GetPresenceResult *)packetObject.args;
            FNGetPresenceResponse *rsp = [[FNGetPresenceResponse alloc] initWithPBArgs:rspArgs];
            
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)isRegisterUser:(FNIsRegisterRequest *)isRegReq
              callback:(void(^)(FNIsRegisterResponse *rspArgs))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeIsRegisterReqArgs:isRegReq.tids];
    
    [[McpRequest sharedInstance] send:CMD_IS_REGISTER userid:userid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            IsRegisterRspArgs *rspArgs = (IsRegisterRspArgs *)packetObject.args;
            FNIsRegisterResponse *rsp = [[FNIsRegisterResponse alloc] initWithPBArgs:rspArgs];
            
            if (200 == rsp.statusCode)
            {
                for (int i = 0; i < rsp.registerStatus.count; i++)
                {
                    FNContactTable *table = [FNContactTable get:((FNRegisterStatusCombo *)rsp.registerStatus[i]).userID];
                    table.registerStatus = ((FNRegisterStatusCombo *)rsp.registerStatus[i]).registerStatus;
                    [FNContactTable insert:table];
                }
            }
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)uploadBuddyList:(FNUploadBuddyListRequest *)uploadBuddyListReq
               callback:(void(^)(FNUploadBuddyListResponse *rspArgs))callback
{
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeUploadBuddyListReqArgs:userid
                                        buddyListVersion:uploadBuddyListReq.buddyListVersion
                                               buddyList:uploadBuddyListReq.buddyList];
    
    [[McpRequest sharedInstance] send:CMD_UPLOAD_BUDDYLIST userid:userid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            UploadBuddyListResult *rspArgs = (UploadBuddyListResult *)packetObject.args;
            FNUploadBuddyListResponse *rsp = [[FNUploadBuddyListResponse alloc] initWithPBArgs:rspArgs];
            
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

@end
