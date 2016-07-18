//
//  FNGroupArgs.m
//  FeinnoBopSDK
//
//  Created by wangshuying on 15/1/29.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNGroupArgs.h"

#import "CreateGroupResult.pb.h"
#import "StatusRspArgs.pb.h"
#import "GetGroupListResults.pb.h"
#import "GetGroupMemberListResults.pb.h"
#import "ApproveInviteJoinNtfArgs.pb.h"
#import "HandleApproveInviteJoinResults.pb.h"
#import "RefuseInviteJoinGroupNtfArgs.pb.h"
#import "UserJoinGroupNtfArgs.pb.h"
#import "UserExitGroupNtfArgs.pb.h"
#import "GetGroupFileCredencialResults.pb.h"
#import "ChangeGroupOwnerNtfArgs.pb.h"
#import "GroupListChangedArgs.pb.h"
#import "SetGroupMemberInfoRspArgs.pb.h"
#import "GroupMemberNameChangeNtfArgs.pb.h"
#import "BatchKickOutGroupReqArgs.pb.h"
#import "BatchKickOutGroupRspArgs.pb.h"
#import "GroupMemberPortraitChangeNtfArgs.pb.h"


#pragma mark -
#pragma mark 创建、设置

@implementation FNCreateGroupRequest

@end

@interface FNCreateGroupResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *groupID;

@end

@implementation FNCreateGroupResponse

- (instancetype)initWithPBArgs:(CreateGroupResult *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.reCode;
        _groupID = pbArgs.groupId;
    }
    return self;
}

@end

@implementation FNSetGroupInfoRequest

@end

@interface FNSetGroupInfoResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNSetGroupInfoResponse

- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
    }
    return self;
}

@end

@implementation FNChangeGroupOwnerRequest

@end

@interface FNChangeGroupOwnerResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNChangeGroupOwnerResponse

- (instancetype)initWithRspArgs:(int32_t)statusCode
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
    }
    return self;
}

@end

@implementation FNSetGroupMemberInfoRequest

@end

@implementation FNSetGroupMemberInfoResponse

- (instancetype)initWithRspArgs:(int32_t)statusCode
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
    }
    return self;
}

@end


#pragma mark -
#pragma mark 加入、退出

@implementation FNInviteJoinGroupRequest

@end

@interface FNInviteJoinGroupResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNInviteJoinGroupResponse

- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
    }
    return self;
}

@end

@implementation FNInviteJoinGroupInfo

@end

@implementation FNHandleApproveInviteJoinRequest

@end

@implementation FNHandleApproveInviteJoinRequestItem

@end

@interface FNHandleApproveInviteJoinResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNHandleApproveInviteJoinResponse

- (instancetype)initWithPBArgs:(HandleApproveInviteJoinResponse *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
    }
    return self;
}

@end

@implementation FNKickOutGroupRequest

@end

@interface FNKickOutGroupResponse ()

@property (nonatomic) int32_t statusCode;

@end

@implementation FNKickOutGroupResponse

- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs
{
    self = [super init];
    if (self) {
        _statusCode = pbArgs.retCode;
    }
    return self;
}

@end

@implementation FNBatchKickOutGroupRequest

@end

@implementation FNBatchKickOutGroupResponse

- (instancetype)initWithPBArgs:(BatchKickOutGroupRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (BatchKickOutGroupRspArgs_MemberResult *element in pbArgs.resultList)
        {
            FNBatchKickOutGroupMemberResult *result = [[FNBatchKickOutGroupMemberResult alloc] initWithPBArgs:element];
            [list addObject:result];
        }
        _resultList = [NSArray arrayWithArray:list];
    }
    return self;
}

@end

@implementation FNBatchKickOutGroupMemberResult

- (instancetype)initWithPBArgs:(BatchKickOutGroupRspArgs_MemberResult *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
        _userId = pbArgs.userId;
    }
    return self;
}

@end

@implementation FNDeleteGroupRequest

@end

@interface FNDeleteGroupResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNDeleteGroupResponse

- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
    }
    return self;
}

@end

@implementation FNExitGroupRequest

@end

@interface FNExitGroupResponse ()

@property (nonatomic, readwrite) int32_t statusCode;

@end

@implementation FNExitGroupResponse

- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.retCode;
    }
    return self;
}

@end


#pragma mark -
#pragma mark 获取

@implementation FNGetGroupListRequest

@end

@interface FNGetGroupListResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSArray *groupList;

@end

@implementation FNGetGroupListResponse

- (instancetype)initWithPBArgs:(GetGroupListResults *)pbArgs{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.reCode;
        _groupList = [[NSMutableArray alloc] init];
        
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (GetGroupListResultsGroupInfo *element in pbArgs.groupList)
        {
            FNGroupInfo * groupInfo = [[FNGroupInfo alloc] initWithPBArgs:element];
            [list addObject:groupInfo];
        }
        _groupList = [NSArray arrayWithArray:list];
    }
    return self;
}

@end

@implementation FNGroupInfo

- (instancetype)initWithPBArgs:(GetGroupListResultsGroupInfo *)pbArgs
{
    self = [super init];
    if (self)
    {
        _groupID = pbArgs.groupId;
        _groupName = pbArgs.groupName;
        _groupType = pbArgs.groupType;
        _groupConfig = pbArgs.groupConfig;
        _groupPortraitUrl = pbArgs.groupPortraitUrl;
    }
    return self;
}

@end

@implementation FNGetGroupMemberListRequest

@end

@interface FNGetGroupMemberListResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSArray *memberArray;

@end

@implementation FNGetGroupMemberListResponse

- (instancetype)initWithPBArgs:(GetGroupMemberListResults *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.reCode;
        _memberArray = [[NSMutableArray alloc] init];
        
        NSMutableArray *mList = [[NSMutableArray alloc] init];
        for (GetGroupMemberListResultsGroupMemberInfo *element in pbArgs.groupMembers)
        {
            FNGroupMemberInfo *memberInfo = [[FNGroupMemberInfo alloc] initWithPBArgs:element];
            [mList addObject:memberInfo];
        }
        
        _memberArray = [NSArray arrayWithArray:mList];
    }
    return self;
}

@end

@implementation FNGroupMemberInfo

- (instancetype)initWithPBArgs:(GetGroupMemberListResultsGroupMemberInfo *)pbArgs
{
    self = [super init];
    if (self)
    {
        _userID = pbArgs.userId;
        _userConfig = pbArgs.userConfig;
        _identity = pbArgs.identity;
        _groupNickName = pbArgs.groupNickName;
        _groupMemberPortraitUrl = pbArgs.groupMemberPortraitUrl;
    }
    return self;
}

@end


#pragma mark -
#pragma mark 群文件

@implementation FNGetGroupFileCredentialRequest

@end

@interface FNGetGroupFileCredentialResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *credential;

@end

@implementation FNGetGroupFileCredentialResponse

- (instancetype)initWithPBArgs:(GetGroupFileCredencialResults *)pbArgs
{
    self = [super init];
    if (self)
    {
        _statusCode = pbArgs.statusCode;
        _credential = [pbArgs.credential stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return self;
}

@end

@implementation FNUploadGroupSharedFileRequest

@end

@interface FNUploadGroupSharedFileResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) FNSharedFileInfo *fileInfo;
@property (nonatomic, readwrite) NSString *errorInfo;

@end

@implementation FNUploadGroupSharedFileResponse

- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileInfo:(FNSharedFileInfo *)fileInfo
                      errorInfo:(NSString *)error
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
        _fileInfo = fileInfo;
        _errorInfo = error;
    }
    return self;
}

@end

@implementation FNDownloadGroupSharedFileRequest

@end

@interface FNDownloadGroupSharedFileResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) FNSharedFileInfo *fileInfo;
@property (nonatomic, readwrite) NSString *errorInfo;

@end

@implementation FNDownloadGroupSharedFileResponse

- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileInfo:(FNSharedFileInfo *)fileInfo
                      errorInfo:(NSString *)error
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
        _fileInfo = fileInfo;
        _errorInfo = error;
    }
    return self;
}

@end

@implementation FNGetGroupSharedFileListRequest

@end

@interface FNGetGroupSharedFileListResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSArray *fileList;
@property (nonatomic, readwrite) NSString *errorInfo;

@end

@implementation FNGetGroupSharedFileListResponse

- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileList:(NSArray *)list
                      errorInfo:(NSString *)error
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
        _fileList = list;
        _errorInfo = error;
    }
    return self;
}

@end

@implementation FNDelGroupSharedFileRequest

@end

@interface FNDelGroupSharedFileResponse ()

@property (nonatomic, readwrite) int32_t statusCode;
@property (nonatomic, readwrite) NSString *errorInfo;

@end

@implementation FNDelGroupSharedFileResponse

- (instancetype)initWithRspArgs:(int32_t)statusCode
                      errorInfo:(NSString *)error
{
    self = [super init];
    if (self)
    {
        _statusCode = statusCode;
        _errorInfo = error;
    }
    return self;
}

@end


#pragma mark -
#pragma mark 通知

@interface FNGroupListChangeNotifyArgs ()

@property (nonatomic, readwrite) NSString *groupId;
@property (nonatomic, readwrite) NSString *groupName;
@property (nonatomic, readwrite) NSString *actionType;
@property (nonatomic, readwrite) int32_t groupType;

@end

@implementation FNGroupListChangeNotifyArgs

- (instancetype)initWithPBArgs:(GroupListChangedArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _groupId = pbArgs.groupId;
        _groupName = pbArgs.groupName;
        _actionType = pbArgs.actionType;
        _groupType = pbArgs.groupType;
    }
    return self;
}

@end

@implementation FNApproveInviteJoinGroupNtfArgs

- (instancetype)initWithPBArgs:(ApproveInviteJoinNtfArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _groupID = pbArgs.groupId;
        _sourcerUserID = pbArgs.sourceUser;
        _groupName = pbArgs.groupName;
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (ApproveInviteJoinNtfArgsNtfItem *item in pbArgs.approveList)
        {
            FNApproveInviteJoinNtfIetm *it = [[FNApproveInviteJoinNtfIetm alloc] initWithPBArgs:item];
            
            [mArr addObject:it];
        }
        _approveList = mArr;
    }
    return self;
}

@end

@implementation FNApproveInviteJoinNtfIetm

- (instancetype)initWithPBArgs:(ApproveInviteJoinNtfArgsNtfItem *)pbArgs
{
    self = [super init];
    if (self) {
        _invitedUserID = pbArgs.invitedUserId;
        _invitedGroupNickName = pbArgs.invitedGroupNickName;
        _invitedUserPortraitUrl = pbArgs.invitedUserPortraitUrl;
    }
    
    return self;
}

@end

@implementation FNRefuseInviteJoinGroupNtfArgs

- (instancetype)initWithPBArgs:(RefuseInviteJoinGroupNtfArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _groupID = pbArgs.groupId;
        _groupName = pbArgs.groupName;

        NSMutableArray *mArr = [NSMutableArray array];
        for (RefuseInviteJoinGroupNtfArgs_NtfItem *item in pbArgs.refuseList)
        {
            FNRefuseInviteJoinNtfItem *it = [[FNRefuseInviteJoinNtfItem alloc] initWithPBArgs:item];
            [mArr addObject:it];
        }
        _refuseList = mArr;
    }
    return self;
}

@end

@implementation FNRefuseInviteJoinNtfItem

- (instancetype)initWithPBArgs:(RefuseInviteJoinGroupNtfArgs_NtfItem *)pbArgs
{
    self = [super init];
    if (self)
    {
        _invitedUserID = pbArgs.invitedUserId;
        _invitedUserName = pbArgs.invitedUserName;
    }
    return self;
}

@end

@implementation FNJoinGroupNtfItem

- (instancetype)initWithPBArgs:(UserJoinGroupNtfArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _groupId = pbArgs.groupId;
        _sourceUserId = pbArgs.sourceUserId;
        _sourceUserNickname = pbArgs.sourceUserNickname;
        _invitedUserId = pbArgs.invitedUserId;
        _invitedUserNickname = pbArgs.invitedUserNickname;
        _groupName = pbArgs.groupName;
        _invitePortraitUrl = pbArgs.invitedUserPortraitUrl;
    }
    return self;
}

@end

@implementation FNExitGroupNtfItem

- (instancetype)initWithPBArgs:(UserExitGroupNtfArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _groupId = pbArgs.groupId;
        _exitType = pbArgs.exitType;
        _exitUserId = pbArgs.exitUserId;
        _exitUserNickname = pbArgs.exitUserNickname;
        _sourceUserId = pbArgs.sourceUserId;
        _sourceUserNickname = pbArgs.sourceUserNickname;
        _groupName = pbArgs.groupName;
    }
    return self;
}

@end

@implementation FNChangeGroupOwnerNtfItem

- (instancetype)initWithPBArgs:(ChangeGroupOwnerNtfArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _groupId = pbArgs.groupId;
        _groupName = pbArgs.groupName;
        _userId = pbArgs.userId;
    }
    return self;
}

@end

@implementation FNGroupMemberNameChangeNtfItem

- (instancetype)initWithPBArgs:(GroupMemberNameChangeNtfArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _groupId = pbArgs.groupId;
        _groupName = pbArgs.groupName;
        _oldGroupMemberName = pbArgs.oldGroupMemberName;
        _currentGroupMemberName = pbArgs.newGroupMemberName;
        _userId = pbArgs.userId;
    }
    return self;
}

@end

@implementation FNGroupMemberPortraitUrlChangeNtfItem

- (instancetype)initWithPBArgs:(GroupMemberPortraitChangeNtfArgs *)pbArgs
{
    self = [super init];
    if (self)
    {
        _groupId = pbArgs.groupId;
        _groupName = pbArgs.groupName;
        _userNickname = pbArgs.userNickname;
        _groupMemberPortraitUrl = pbArgs.groupMemberPortraitUrl;
        _userId = pbArgs.userId;
    }
    return self;
}

@end
