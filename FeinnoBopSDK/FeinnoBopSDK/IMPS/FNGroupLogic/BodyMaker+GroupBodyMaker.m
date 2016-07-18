//
//  BodyMaker+GroupBodyMaker.m
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/2/9.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "BodyMaker+GroupBodyMaker.h"

#import "CreateGroupArgs.pb.h"
#import "SetGroupInfoArgs.pb.h"
#import "SetGroupMemberInfoReqArgs.pb.h"
#import "InviteJoinGroupArgs.pb.h"
#import "HandleApproveInviteJoinRequestArgs.pb.h"
#import "KickOutGroupArgs.pb.h"
#import "BatchKickOutGroupReqArgs.pb.h"
#import "DelGroupArgs.pb.h"
#import "ExitGroupArgs.pb.h"
#import "GetGroupListArgs.pb.h"
#import "GetGroupMemberListArgs.pb.h"
#import "GetGroupFileCredencialArgs.pb.h"
#import "ChangeGroupOwnerArgs.pb.h"

#import "FNGroupArgs.h"

@implementation BodyMaker (GroupBodyMaker)

+ (NSData *)makeCreateGroupReq:(NSString *)groupName
                   groupConfig:(int32_t)groupConfig
                     groupType:(int32_t)gpType
                      nickName:(NSString *)nickName
              groupPortraitUrl:(NSString *)groupPortraitUrl
{
    CreateGroupArgsBuilder *builder = [[CreateGroupArgsBuilder alloc] init];
    builder.groupName = groupName;
    builder.groupConfig = groupConfig;
    builder.groupType = gpType;
    builder.nickName = nickName;
    builder.groupPortraitUrl = groupPortraitUrl;
    
    CreateGroupArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeSetGroupInfo:(NSString *)groupId
                   groupName:(NSString *)gpName
                      config:(int32_t)gpConfig
            groupPortraitUrl:(NSString *)groupPortraitUrl
                 updateField:(int32_t)updateField
{
    SetGroupInfoArgsBuilder *builder = [[SetGroupInfoArgsBuilder alloc] init];
    builder.groupId = groupId;
    builder.groupName = gpName;
    builder.groupConfig = gpConfig;
    builder.groupPortraitUrl = groupPortraitUrl;
    if (updateField == 1)
    {
        builder.updateFieldFlags = UpdateGroupFieldFlagsGroupName;
    }
    else if (updateField == 2)
    {
        builder.updateFieldFlags = UpdateGroupFieldFlagsGroupConfig;
    }
    else if (updateField == 4)
    {
        builder.updateFieldFlags = UpdateGroupFieldFlagsGroupPortraitUrl;
    }
    SetGroupInfoArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeSetGroupMemberInfoReq:(NSString *)groupId
                               userId:(NSString *)userId
                           memberName:(NSString *)memberName
                     updateFieldFlags:(NSInteger)updateFieldFlags
                    memberPortraitUrl:(NSString *)memberPortraitUrl
{
    SetGroupMemberInfoReqArgsBuilder *builder = [[SetGroupMemberInfoReqArgsBuilder alloc] init];
    builder.groupId = groupId;
    builder.userId = userId;
    builder.newName = memberName;
    builder.groupMemberPortraitUrl = memberPortraitUrl;
    if (updateFieldFlags == 1)
    {
        builder.updateFieldFlags = UpdateGroupMemberFieldFlagsGroupMemberName;
    }
    else if (updateFieldFlags == 2)
    {
        builder.updateFieldFlags = UpdateGroupMemberFieldFlagsGroupMemberPortraitUrl;
    }
    
    SetGroupMemberInfoReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeInviteJoinGroup:(NSArray *)gpInfos
{
    InviteJoinGroupArgsBuilder *builder = [[InviteJoinGroupArgsBuilder alloc] init];
    
    for (int i = 0; i < [gpInfos count]; i++)
    {
        InviteJoinGroupArgsInviteJoinGroupInfoBuilder *gpInfoBuilder = [[InviteJoinGroupArgsInviteJoinGroupInfoBuilder alloc] init];
        gpInfoBuilder.groupId = ((FNInviteJoinGroupInfo *)gpInfos[i]).groupID;
        gpInfoBuilder.invitedUserId = ((FNInviteJoinGroupInfo *)gpInfos[i]).invitedUserID;
        gpInfoBuilder.userNickName = ((FNInviteJoinGroupInfo *)gpInfos[i]).userNickname;
        gpInfoBuilder.userPortraitUrl = ((FNInviteJoinGroupInfo *)gpInfos[i]).userPortraitUrl;
        
        [builder addInviteJoinGroupInfo:[gpInfoBuilder build]];
    }
    
    InviteJoinGroupArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeHandleApproveInviteJoin:(NSString *)groupId
                               sourceId:(NSString *)sourceId
           mutableHandleApproveItemList:(NSMutableArray *)mutableHandleApproveItemList
{
    HandleApproveInviteJoinRequestArgsBuilder *builder = [[HandleApproveInviteJoinRequestArgsBuilder alloc] init];
    builder.groupId = groupId;
    builder.sourceId = sourceId;
    
    for (FNHandleApproveInviteJoinRequestItem *item in mutableHandleApproveItemList)
    {
        HandleApproveItemBuilder *itemBuilder= [[HandleApproveItemBuilder alloc] init];
        itemBuilder.invitedUserId = item.invitedUserId;
        itemBuilder.invitedUserNickname = item.invitedUserNickname;
        itemBuilder.approveResult = item.approveResult;
        itemBuilder.invitedPortraitUrl = item.invitedPortraitUrl;
        HandleApproveItem *itemArgs = [itemBuilder build];
        [builder addHandleApproveItem:itemArgs];
    }
    
    HandleApproveInviteJoinRequestArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeKickOutGroup:(NSString *)groupId
                kickedUserId:(NSString *)target
{
    KickOutGroupArgs_Builder *builder = [[KickOutGroupArgs_Builder alloc] init];
    builder.groupId = groupId;
    builder.kickedUserId = target;
    
    KickOutGroupArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeBatchKickOutGroup:(NSString *)groupId
                    kickedUserIds:(NSArray *)target
{
    BatchKickOutGroupReqArgs_Builder *builder = [[BatchKickOutGroupReqArgs_Builder alloc] init];
    builder.groupId = groupId;
    for (NSString *userId in target)
    {
        [builder addUserIdList:userId];
    }
    
    BatchKickOutGroupReqArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeDelGroupReq:(NSString *)groupId
{
    DelGroupArgs_Builder *builder = [[DelGroupArgs_Builder alloc] init];
    builder.groupId = groupId;
    
    DelGroupArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeExitGroupReq:(NSString *)groupId
{
    ExitGroupArgs_Builder *builder = [[ExitGroupArgs_Builder alloc] init];
    builder.groupId = groupId;
    
    ExitGroupArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeGetGroupList:(int32_t)groupType
            groupListVersion:(int32_t)version
{
    GetGroupListArgs_Builder *builder = [[GetGroupListArgs_Builder alloc] init];
    builder.groupType = groupType;
    builder.groupListVersion = version;
    
    GetGroupListArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeGetGroupMemberList:(NSString *)groupId
{
    GetGroupMemberListArgs_Builder *builder = [[GetGroupMemberListArgs_Builder alloc] init];
    builder.groupId = groupId;
    
    GetGroupMemberListArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeGetGroupFileCredentialReq:(NSString *)groupId
{
    GetGroupFileCredencialArgs_Builder *builder = [[GetGroupFileCredencialArgs_Builder alloc] init];
    builder.groupId = groupId;
    
    GetGroupFileCredencialArgs *args = [builder build];
    return args.data;
}

+ (NSData *)makeChangeGroupOwner:(NSString *)groupId userId:(NSString *)userId
{
    ChangeGroupOwnerArgs_Builder *builder = [[ChangeGroupOwnerArgs_Builder alloc] init];
    builder.groupId = groupId;
    builder.userId = userId;
    ChangeGroupOwnerArgs *args = [builder build];
    
    return args.data;
}

@end
