//
//  FNGroupNotify.m
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-13.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNGroupNotify.h"
#import "FNGroupMsgLogic.h"

#import "FNGroupArgs.h"
#import "FNMsgArgs.h"
#import "FNNotifyArgs.h"

#import "FNGroupTable.h"
#import "FNGroupMembersTable.h"
#import "FNGroupMsgTable.h"
#import "FNRecentConversationTable.h"
#import "FNGroupNotifyTable.h"
#import "FNUserTable.h"
#import "FNGroupMsgTable.h"

#import "CMD.h"
#import "McpRequest.h"
#import "Utility.h"

#import "GroupListChangedArgs.pb.h"
#import "ApproveInviteJoinNtfArgs.pb.h"
#import "RefuseInviteJoinGroupNtfArgs.pb.h"
#import "UserJoinGroupNtfArgs.pb.h"
#import "UserExitGroupNtfArgs.pb.h"
#import "ChangeGroupOwnerNtfArgs.pb.h"
#import "GroupMemberNameChangeNtfArgs.pb.h"
#import "GroupMemberPortraitChangeNtfArgs.pb.h"

#import "FNSystemConfig.h"
#import "FNUserConfig.h"

NSString *const NOTIFY_GROUP_LIST_CHANGED = @"BOPGroupListChanged";
NSString *const NOTIFY_APPROVE_INVITE_JOIN_GROUP = @"BOPApproveInviteJoinGroup";
NSString *const NOTIFY_REFUSE_INVITE_JOIN_GROUP = @"BOPRefuseInviteJoinGroup";
NSString *const NOTIFY_JOIN_GROUP = @"BOPJoinGroup";
NSString *const NOTIFY_EXIT_GROUP = @"BOPExitGroup";
NSString *const NOTIFY_OWNER_CHANGE_GROUP = @"BOPGroupOwnerChange";
NSString *const NOTIFY_GROUP_MEMBERNAME_CHANGE = @"BOPGroupMemberNameChange";
NSString *const NOTIFY_GROUP_MEMBERPROTRAITURL_CHANGE = @"BOPGroupMemberProtraitUrlChange";

@implementation FNGroupNotify

+ (void)startObserve
{
    [self stopObserve];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleGroupListChangedNotify:)
                                                 name:[NSString stringWithFormat:@"%d", CMD_GROUP_LIST_CHAGE_NTF]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleApproveInviteNotify:)
                                                 name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeApprove]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleRefuseInviteNotify:)
                                                 name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeRefuse]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleJoinNotify:)
                                                 name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeJoin]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleExitNotify:)
                                                 name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeExit]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleGroupOwnerChangeNotify:)
                                                 name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupOwnerChange]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleGroupMemberNameChangeNotify:)
                                                 name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupMemberNameChange]
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleGroupMemberProtraitUrlChangeNotify:)
                                                 name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupMemberPortraitUrlChange]
                                               object:nil];
}

+ (void)stopObserve
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"%d", CMD_GROUP_LIST_CHAGE_NTF]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeApprove]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeRefuse]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeJoin]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeExit]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupOwnerChange]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupMemberNameChange]
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:[NSString stringWithFormat:@"notify_%ld", (long)NotifyTypeGroupMemberPortraitUrlChange]
                                                  object:nil];
}

+ (void)handleGroupListChangedNotify:(NSNotification *)note
{
    NSData *data = (NSData *)[note object];
    PacketObject *packetObject = [McpRequest parse:data];
    GroupListChangedArgs *args = (GroupListChangedArgs *)[packetObject args];
    FNGroupListChangeNotifyArgs *notifyArgs = [[FNGroupListChangeNotifyArgs alloc] initWithPBArgs:args];
    
    if ([args.actionType isEqualToString:@"kick"] || [args.actionType isEqualToString:@"delete"])
    {
        [FNGroupTable delete:args.groupId];
        [FNGroupMembersTable delete:nil groupId:args.groupId];
        [FNGroupMsgTable deleteByGroupId:args.groupId];
        [FNRecentConversationTable delete:args.groupId];
    }
    else
    {
        //这个地方不需要群头像？
        FNGroupTable *newGroup = [[FNGroupTable alloc] init];
        newGroup.groupId = args.groupId;
        newGroup.groupName = args.groupName;
        newGroup.groupType = args.groupType;
        [FNGroupTable insert:newGroup];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_GROUP_LIST_CHANGED object:notifyArgs];
    NSDictionary *notify = [NSDictionary dictionaryWithObjectsAndKeys:args.groupId,@"groupId",args.groupName,@"groupName",args.actionType,@"type", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"groupListChange" object:notify];
}

+ (void)handleApproveInviteNotify:(NSNotification *)note
{
    FNNotifyEntity *entity = (FNNotifyEntity *)[note object];
    FNApproveInviteJoinGroupNtfArgs *approveInviteNtf = [[FNApproveInviteJoinGroupNtfArgs alloc] initWithPBArgs:[ApproveInviteJoinNtfArgs parseFromData:entity.notifyBody]];
    
    // 写db
    for (FNApproveInviteJoinNtfIetm *item in approveInviteNtf.approveList)
    {
        FNGroupNotifyTable *notify = [[FNGroupNotifyTable alloc] init];
        notify.msgId = entity.notifyId;
        notify.msgType = entity.notifyType;
        notify.groupId = approveInviteNtf.groupID;
        notify.groupName = approveInviteNtf.groupName;
        notify.sourceUserId = [Utility userIdWithoutAppKey:entity.sourceID];
        notify.targetUserId = [Utility userIdWithoutAppKey:item.invitedUserID];
        notify.targetUserNickname = item.invitedGroupNickName;
        notify.memberProtraitUrl = item.invitedUserPortraitUrl;
        notify.handleFlag = MsgUnread;
        notify.handleResult = ApproveInvite;
        notify.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
        notify.sortKey = [FNUserTable getSyncId:EventTypeNtf];
        
        [FNGroupNotifyTable insert:notify];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_APPROVE_INVITE_JOIN_GROUP object:approveInviteNtf];
}

+ (void)handleRefuseInviteNotify:(NSNotification *)note
{
    FNNotifyEntity *entity = (FNNotifyEntity *)[note object];
    FNRefuseInviteJoinGroupNtfArgs *refuseInviteNtf = [[FNRefuseInviteJoinGroupNtfArgs alloc] initWithPBArgs:[RefuseInviteJoinGroupNtfArgs parseFromData:entity.notifyBody]];
    
    // 写db
    for (FNRefuseInviteJoinNtfItem *item in refuseInviteNtf.refuseList)
    {
        FNGroupNotifyTable *notify = [[FNGroupNotifyTable alloc] init];
        notify.msgId = entity.notifyId;
        notify.msgType = entity.notifyType;
        notify.groupId = refuseInviteNtf.groupID;
        notify.groupName = refuseInviteNtf.groupName;
        notify.sourceUserId = [Utility userIdWithoutAppKey:entity.sourceID];
        notify.targetUserId = [Utility userIdWithoutAppKey:item.invitedUserID];
        notify.targetUserNickname = item.invitedUserName;
        notify.handleFlag = MsgUnread;
        notify.handleResult = RefuseInvite;
        notify.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
        notify.sortKey = [FNUserTable getSyncId:EventTypeNtf];
        
        [FNGroupNotifyTable insert:notify];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFUSE_INVITE_JOIN_GROUP object:refuseInviteNtf];
}

+ (void)handleJoinNotify:(NSNotification *)note
{
    FNNotifyEntity *entity = (FNNotifyEntity *)[note object];
    FNJoinGroupNtfItem *item = [[FNJoinGroupNtfItem alloc] initWithPBArgs:[UserJoinGroupNtfArgs parseFromData:entity.notifyBody]];
    
    FNGroupNotifyTable *notify = [[FNGroupNotifyTable alloc] init];
    notify.msgId = entity.notifyId;
    notify.msgType = entity.notifyType;
    notify.groupId = item.groupId;
    notify.groupName = item.groupName;
    notify.sourceUserId = [Utility userIdWithoutAppKey:item.sourceUserId];
    notify.sourceUserNickname = item.sourceUserNickname;
    notify.targetUserId = [Utility userIdWithoutAppKey:item.invitedUserId];
    notify.targetUserNickname = item.invitedUserNickname;
    notify.memberProtraitUrl = item.invitePortraitUrl;
    notify.handleFlag = MsgUnread;
    notify.handleResult = JoinGroup;
    notify.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
    notify.sortKey = [FNUserTable getSyncId:EventTypeNtf];
    
    [FNGroupNotifyTable insert:notify];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_JOIN_GROUP object:item];
}

+ (void)handleExitNotify:(NSNotification *)note
{
    FNNotifyEntity *entity = (FNNotifyEntity *)[note object];
    FNExitGroupNtfItem *item = [[FNExitGroupNtfItem alloc] initWithPBArgs:[UserExitGroupNtfArgs parseFromData:entity.notifyBody]];
    
    FNGroupNotifyTable *notify = [[FNGroupNotifyTable alloc] init];
    notify.msgId = entity.notifyId;
    notify.msgType = entity.notifyType;
    notify.groupId = item.groupId;
    notify.groupName = item.groupName;
    notify.sourceUserId = [Utility userIdWithoutAppKey:item.sourceUserId];
    notify.sourceUserNickname = item.sourceUserNickname;
    notify.targetUserId = [Utility userIdWithoutAppKey:item.exitUserId];
    notify.targetUserNickname = item.exitUserNickname;
    notify.handleFlag = MsgUnread;
    notify.handleResult = item.exitType == 1 ? NormalExit : KickOut;
    notify.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
    notify.sortKey = [FNUserTable getSyncId:EventTypeNtf];
    
    [FNGroupNotifyTable insert:notify];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_EXIT_GROUP object:item];
}

+ (void)handleGroupOwnerChangeNotify:(NSNotification *)note
{
    FNNotifyEntity *entity = (FNNotifyEntity *)[note object];
    FNChangeGroupOwnerNtfItem *item = [[FNChangeGroupOwnerNtfItem alloc] initWithPBArgs:[ChangeGroupOwnerNtfArgs parseFromData:entity.notifyBody]];
    
    FNGroupNotifyTable *notify = [[FNGroupNotifyTable alloc] init];
    notify.msgId = entity.notifyId;
    notify.msgType = entity.notifyType;
    notify.groupId = item.groupId;
    notify.groupName = item.groupName;
//    notify.sourceUserId = item.sourceUserId;
//    notify.sourceUserNickname = item.sourceUserNickname;
    notify.targetUserId = [Utility userIdWithoutAppKey:item.userId];
//    notify.targetUserNickname = item.exitUserNickname;
    notify.handleFlag = MsgUnread;
//    notify.handleResult = item.exitType == 1 ? NormalExit : KickOut;
    notify.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
    notify.sortKey = [FNUserTable getSyncId:EventTypeNtf];
    
    [FNGroupNotifyTable insert:notify];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_OWNER_CHANGE_GROUP object:item];
}

+ (void)handleGroupMemberNameChangeNotify:(NSNotification *)note
{
    FNNotifyEntity *entity = (FNNotifyEntity *)[note object];
    FNGroupMemberNameChangeNtfItem *item = [[FNGroupMemberNameChangeNtfItem alloc] initWithPBArgs:[GroupMemberNameChangeNtfArgs parseFromData:entity.notifyBody]];
    
    FNGroupNotifyTable *notify = [[FNGroupNotifyTable alloc] init];
    notify.msgId = entity.notifyId;
    notify.msgType = entity.notifyType;
    notify.groupId = item.groupId;
    notify.groupName = item.groupName;
    notify.targetUserId = [Utility userIdWithoutAppKey:item.userId];
    notify.targetUserNickname = item.currentGroupMemberName;
    notify.handleFlag = MsgUnread;
    notify.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
    notify.sortKey = [FNUserTable getSyncId:EventTypeNtf];
    
    [FNGroupNotifyTable insert:notify];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_GROUP_MEMBERNAME_CHANGE object:item];
}

+ (void)handleGroupMemberProtraitUrlChangeNotify:(NSNotification *)note
{
    FNNotifyEntity *entity = (FNNotifyEntity *)[note object];
    FNGroupMemberPortraitUrlChangeNtfItem *item = [[FNGroupMemberPortraitUrlChangeNtfItem alloc] initWithPBArgs:[GroupMemberPortraitChangeNtfArgs parseFromData:entity.notifyBody]];
    
    FNGroupNotifyTable *notify = [[FNGroupNotifyTable alloc] init];
    notify.msgId = entity.notifyId;
    notify.msgType = entity.notifyType;
    notify.groupId = item.groupId;
    notify.groupName = item.groupName;
    notify.targetUserId = [Utility userIdWithoutAppKey:item.userId];
    notify.targetUserNickname = item.userNickname;
    notify.memberProtraitUrl = item.groupMemberPortraitUrl;
    notify.handleFlag = MsgUnread;
    notify.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
    notify.sortKey = [FNUserTable getSyncId:EventTypeNtf];
    
    [FNGroupNotifyTable insert:notify];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_GROUP_MEMBERPROTRAITURL_CHANGE object:item];
}
@end
