//
//  GroupLogic.m
//  feinno-sdk-imps
//
//  Created by doujinkun on 14/11/11.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNGroupLogic.h"
#import "FNFileServiceLogic.h"

#import "FNUserTable.h"
#import "FNGroupTable.h"
#import "FNGroupMembersTable.h"

#import "FNUserConfig.h"
#import "FNServerConfig.h"
#import "FNSystemConfig.h"
#import "Utility.h"

#import "McpRequest.h"
#import "CMD.h"

#import "CreateGroupResult.pb.h"
#import "StatusRspArgs.pb.h"
#import "GetGroupFileCredencialResults.pb.h"
#import "GetGroupListResults.pb.h"
#import "GetGroupMemberListResults.pb.h"
#import "ChangeGroupOwnerResults.pb.h"
#import "SetGroupMemberInfoRspArgs.pb.h"
#import "BatchKickOutGroupRspArgs.pb.h"
#import "BodyMaker+GroupBodyMaker.h"

#import "BOPAFHTTPRequestOperation.h"
#import "BOPAFHTTPRequestOperationManager.h"
#import "BOPGDataXMLNode.h"

@implementation FNGroupLogic

+ (void)createGroup:(FNCreateGroupRequest *)createGroupRequest
           callback:(void(^)(FNCreateGroupResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeCreateGroupReq:createGroupRequest.groupName
                                     groupConfig:createGroupRequest.groupConfig
                                       groupType:createGroupRequest.groupType
                                        nickName:createGroupRequest.groupName
                                groupPortraitUrl:createGroupRequest.groupPortraitUrl];
    
    [[McpRequest sharedInstance] send:CMD_CREATE_GROUP userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            CreateGroupResult *rspArgs = (CreateGroupResult *)packetObject.args;
            
            if (rspArgs.reCode == 200)
            {
                NSLog(@"create group success with group id:%@!", rspArgs.groupId);
                //操作数据库
                FNGroupTable *gpTable = [[FNGroupTable alloc] init];
                gpTable.groupId = rspArgs.groupId;
                gpTable.groupName = createGroupRequest.groupName;
                gpTable.groupType = createGroupRequest.groupType;
                gpTable.identity = 0;
                gpTable.userNickname = createGroupRequest.nickname;
                gpTable.groupProtaitUrl = createGroupRequest.groupPortraitUrl;
                [FNGroupTable insert:gpTable];
            }
            
            FNCreateGroupResponse *result = [[FNCreateGroupResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)setGroupInfo:(FNSetGroupInfoRequest *)setGroupInfoRequest
            callback:(void(^)(FNSetGroupInfoResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeSetGroupInfo:setGroupInfoRequest.groupID
                                     groupName:setGroupInfoRequest.groupName
                                        config:setGroupInfoRequest.groupConfig
                              groupPortraitUrl:setGroupInfoRequest.groupPortraitUrl
                                   updateField:setGroupInfoRequest.updateFieldFlags];
    
    [[McpRequest sharedInstance] send:CMD_SET_GROUP_INFO userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            StatusRspArgs *rspArgs = (StatusRspArgs *)packetObject.args;
            
            if (rspArgs.retCode == 200)
            {
                if (setGroupInfoRequest.updateFieldFlags == 1)
                {
                    [FNGroupTable update:setGroupInfoRequest.groupID groupName:setGroupInfoRequest.groupName];
                }
                else if (setGroupInfoRequest.updateFieldFlags == 2)
                {
                    [FNGroupTable update:setGroupInfoRequest.groupID groupConfig:setGroupInfoRequest.groupConfig];
                }
                else if (setGroupInfoRequest.updateFieldFlags == 4)
                {
                    [FNGroupTable update:setGroupInfoRequest.groupID groupProtaitUrl:setGroupInfoRequest.groupPortraitUrl];
                }
            }
            FNSetGroupInfoResponse *result = [[FNSetGroupInfoResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)setGroupMemberInfo:(FNSetGroupMemberInfoRequest *)setGroupMemberInfoRequest
                  callback:(void(^)(FNSetGroupMemberInfoResponse *rspArgs))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeSetGroupMemberInfoReq:setGroupMemberInfoRequest.groupId
                                                 userId:[Utility userIdWithAppKey:setGroupMemberInfoRequest.userId]
                                             memberName:setGroupMemberInfoRequest.memberName
                                       updateFieldFlags:setGroupMemberInfoRequest.updateFieldFlags
                                      memberPortraitUrl:setGroupMemberInfoRequest.memberPortraitUrl];
    
    [[McpRequest sharedInstance] send:CMD_SET_GROUP_MEMBERINFO userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            SetGroupMemberInfoRspArgs *rspArgs = (SetGroupMemberInfoRspArgs *)packetObject.args;
            
            if (rspArgs.statusCode == 200)
            {
                if (setGroupMemberInfoRequest.updateFieldFlags == 1)
                {
                    [FNGroupMembersTable updateGroupMemberNickName:setGroupMemberInfoRequest.memberName memberId:[Utility userIdWithoutAppKey:setGroupMemberInfoRequest.userId] groupId:setGroupMemberInfoRequest.groupId];
                }
                else if (setGroupMemberInfoRequest.updateFieldFlags == 2)
                {
                    [FNGroupMembersTable updateGroupMemberProtaitUrl:setGroupMemberInfoRequest.memberPortraitUrl memberId:[Utility userIdWithoutAppKey:setGroupMemberInfoRequest.userId] groupId:setGroupMemberInfoRequest.groupId];
                }
                
            }
            FNSetGroupMemberInfoResponse *result = [[FNSetGroupMemberInfoResponse alloc] initWithRspArgs:rspArgs.statusCode];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)inviteJoinGroup:(FNInviteJoinGroupRequest *)inviteJoinGroupRequest
               callback:(void(^)(FNInviteJoinGroupResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    //add by lixing
    for ( NSInteger i=0; i<inviteJoinGroupRequest.groupInfoArray.count; ++i )
    {
        FNInviteJoinGroupInfo *info = [inviteJoinGroupRequest.groupInfoArray objectAtIndex:i];
        info.invitedUserID = [Utility userIdWithAppKey:info.invitedUserID];
    }
    //end
    NSData *body = [BodyMaker makeInviteJoinGroup:inviteJoinGroupRequest.groupInfoArray];
    
    [[McpRequest sharedInstance] send:CMD_INVITE_JOIN_GROUP userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            StatusRspArgs *rspArgs = (StatusRspArgs *)packetObject.args;
            
            if (rspArgs.retCode == 200)
            {
                for (FNInviteJoinGroupInfo *info in inviteJoinGroupRequest.groupInfoArray)
                {
                    // 操作数据库
                    FNGroupMembersTable *groupMembersTable = [[FNGroupMembersTable alloc] init];
                    groupMembersTable.groupId = info.groupID;
                    groupMembersTable.identity = 1;
                    groupMembersTable.memberID = [Utility userIdWithoutAppKey:info.invitedUserID];
                    groupMembersTable.memberNickName = info.userNickname;
                    groupMembersTable.memberProtaitUrl = info.userPortraitUrl;
                    
                    [FNGroupMembersTable insert:groupMembersTable];
                }
            }
            
            FNInviteJoinGroupResponse *result = [[FNInviteJoinGroupResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)handleApproveInvite:(FNHandleApproveInviteJoinRequest *)handleApproveInviteJoinReq
                   callback:(void (^)(FNHandleApproveInviteJoinResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeHandleApproveInviteJoin:handleApproveInviteJoinReq.groupId
                                                 sourceId:handleApproveInviteJoinReq.sourceId
                             mutableHandleApproveItemList:handleApproveInviteJoinReq.mutableHandleApproveItemList];
    
    [[McpRequest sharedInstance] send:CMD_HANDLE_APPROVE_INVITE_JOIN userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            HandleApproveInviteJoinResponse *rspArgs = (HandleApproveInviteJoinResponse *)packetObject.args;
            
            FNHandleApproveInviteJoinResponse *result = [[FNHandleApproveInviteJoinResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)kickOutGroup:(FNKickOutGroupRequest *)kickOutGroupRequest
            callback:(void(^)(FNKickOutGroupResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSString *kickUserId = [Utility userIdWithAppKey:kickOutGroupRequest.kickedUserID];
    NSData *body = [BodyMaker makeKickOutGroup:kickOutGroupRequest.groupID kickedUserId:kickUserId];
    
    [[McpRequest sharedInstance] send:CMD_KICKOUT_GROUP userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            StatusRspArgs *rspArgs = (StatusRspArgs *)packetObject.args;
            
            if (rspArgs.retCode == 200)
            {
                // 从数据库中删除成员
                [FNGroupMembersTable delete:[Utility userIdWithoutAppKey:kickOutGroupRequest.kickedUserID] groupId:kickOutGroupRequest.groupID];
            }
            FNKickOutGroupResponse *result = [[FNKickOutGroupResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)batchKickOutGroup:(FNBatchKickOutGroupRequest *)kickOutGroupRequest
                 callback:(void(^)(FNBatchKickOutGroupResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    
//    NSData *body = [BodyMaker makeBatchKickOutGroup:kickOutGroupRequest.groupID kickedUserIds:kickOutGroupRequest.kickedUserIDList];
    NSData *body = [BodyMaker makeBatchKickOutGroup:kickOutGroupRequest.groupID kickedUserIds:[Utility userIdListWithAppkeys:kickOutGroupRequest.kickedUserIDList]];
    
    [[McpRequest sharedInstance] send:CMD_BATCH_KICKOUT_GROUP userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            BatchKickOutGroupRspArgs *rspArgs = (BatchKickOutGroupRspArgs *)packetObject.args;
            
            if (rspArgs.statusCode == 200)
            {
                // 从数据库中删除成员
                for (BatchKickOutGroupRspArgs_MemberResult *element in rspArgs.resultList)
                {
                    if (element.statusCode == 200)
                    {
                        [FNGroupMembersTable delete:[Utility userIdWithoutAppKey:element.userId] groupId:kickOutGroupRequest.groupID];
                    }
                }
            }
            FNBatchKickOutGroupResponse *result = [[FNBatchKickOutGroupResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)delGroup:(FNDeleteGroupRequest *)delGroupRequest
        callback:(void(^)(FNDeleteGroupResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeDelGroupReq:delGroupRequest.groupID];
    
    [[McpRequest sharedInstance] send:CMD_DELETE_GROUP userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            StatusRspArgs *rspArgs = (StatusRspArgs *)packetObject.args;
            
            if (rspArgs.retCode == 200)
            {
                // 操作数据库
                [FNGroupTable delete:delGroupRequest.groupID];
                [FNGroupMembersTable delete:nil groupId:delGroupRequest.groupID];
            }
            
            FNDeleteGroupResponse *result = [[FNDeleteGroupResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)exitGroup:(FNExitGroupRequest *)exitGroupRequest
         callback:(void(^)(FNExitGroupResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeExitGroupReq:exitGroupRequest.groupID];
    
    [[McpRequest sharedInstance] send:CMD_EXIT_GROUP userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            StatusRspArgs *rspArgs = (StatusRspArgs *)packetObject.args;
            
            if (rspArgs.retCode == 200)
            {
                // 操作数据库
                [FNGroupTable delete:exitGroupRequest.groupID];
                [FNGroupMembersTable delete:nil groupId:exitGroupRequest.groupID];
            }
            
            FNExitGroupResponse *result = [[FNExitGroupResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)getGroupList:(FNGetGroupListRequest *)getGroupListRequest
            callback:(void(^)(FNGetGroupListResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeGetGroupList:getGroupListRequest.groupType
                              groupListVersion:(int32_t)[FNUserTable getGroupListVersion]];
    
    [[McpRequest sharedInstance] send:CMD_GET_GROUP_LIST userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            GetGroupListResults *rspArgs = (GetGroupListResults *)packetObject.args;
            NSLog(@"get group list : %d", rspArgs.reCode);
            
            if (rspArgs.reCode == 200)
            {
                if (rspArgs.groupListVersion != (int32_t)[FNUserTable getGroupListVersion] ||
                    ([rspArgs.groupList count] != 0 &&
                     [rspArgs.groupList count] != [[FNGroupTable get:nil groupType:getGroupListRequest.groupType] count]))
                {
                    [FNUserTable setGroupListVersion:rspArgs.groupListVersion];
                    [FNGroupTable clear:getGroupListRequest.groupType];
                }
                NSLog(@"get group list success!");
                for (int i = 0; i < rspArgs.groupList.count; i++)
                {
                    //写入群列表数据库
                    GetGroupListResultsGroupInfo *groupInfo = ((GetGroupListResultsGroupInfo *)[rspArgs.groupList objectAtIndex:i]);
                    FNGroupTable *gpTable = [[FNGroupTable alloc] init];
                    gpTable.groupId = groupInfo.groupId;
                    gpTable.groupName = groupInfo.groupName;
                    gpTable.groupType = groupInfo.groupType > 0 ? groupInfo.groupType : getGroupListRequest.groupType;
                    gpTable.userNickname = [FNUserConfig getInstance].nickname;//
                    gpTable.groupProtaitUrl = groupInfo.groupPortraitUrl;
                    gpTable.config = groupInfo.groupConfig;
                    [FNGroupTable insert:gpTable];
                }
            }
            
            FNGetGroupListResponse *result = [[FNGetGroupListResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)getGroupMemberList:(FNGetGroupMemberListRequest *)getGroupMemberListRequest
                  callback:(void(^)(FNGetGroupMemberListResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeGetGroupMemberList:getGroupMemberListRequest.groupID];
    
    [[McpRequest sharedInstance] send:CMD_GET_GROUP_MEMBER userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            GetGroupMemberListResults *rspArgs = (GetGroupMemberListResults *)packetObject.args;
            
            if (rspArgs.reCode == 200)
            {
                NSLog(@"feinno get group member list with gpId: %@ success", getGroupMemberListRequest.groupID);
                [FNGroupMembersTable delete:nil groupId:getGroupMemberListRequest.groupID];
                for (int j = 0; j < rspArgs.groupMembers.count; j++)
                {
                    FNGroupMembersTable *gpMTable = [[FNGroupMembersTable alloc] init];
                    GetGroupMemberListResultsGroupMemberInfo *info = ((GetGroupMemberListResultsGroupMemberInfo *)[rspArgs.groupMembers objectAtIndex:j]);
                    gpMTable.groupId = getGroupMemberListRequest.groupID;//
                    gpMTable.memberID = [Utility userIdWithoutAppKey:info.userId];
                    gpMTable.memberNickName = info.groupNickName;
                    gpMTable.identity = info.identity;
                    gpMTable.memberProtaitUrl = info.groupMemberPortraitUrl;
                    [FNGroupMembersTable insert:gpMTable];
                }
            }
            
            FNGetGroupMemberListResponse *result = [[FNGetGroupMemberListResponse alloc] initWithPBArgs:rspArgs];
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)getGroupFileCredencial:(FNGetGroupFileCredentialRequest *)getGroupFileCredencialRequest
                      callback:(void(^)(FNGetGroupFileCredentialResponse *))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeGetGroupFileCredentialReq:getGroupFileCredencialRequest.groupID];
    
    [[McpRequest sharedInstance] send:CMD_GET_GROUP_FILE_CREDENCIAL userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            GetGroupFileCredencialResults *rspArgs = (GetGroupFileCredencialResults *)packetObject.args;
            
            FNGetGroupFileCredentialResponse *result = [[FNGetGroupFileCredentialResponse alloc] initWithPBArgs:rspArgs];
            
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)uploadGroupSharedFile:(FNUploadGroupSharedFileRequest *)uploadReq
                     callback:(void(^)(FNUploadGroupSharedFileResponse *))callback
{
    FNGetGroupFileCredentialRequest *gpCReq = [[FNGetGroupFileCredentialRequest alloc] init];
    gpCReq.groupID = uploadReq.groupID;
    
    [FNGroupLogic getGroupFileCredencial:gpCReq callback:^(FNGetGroupFileCredentialResponse *rsp) {
        if (200 == rsp.statusCode)
        {
            FNFileUploadRequest *fileServiceReq = [[FNFileUploadRequest alloc] init];
            fileServiceReq.sp = @"2";
            fileServiceReq.fileType = @"FILE";
            fileServiceReq.tid = uploadReq.groupID;
            fileServiceReq.filePath = uploadReq.filePath;
            fileServiceReq.ssic = rsp.credential;
            fileServiceReq.fileName = [uploadReq.filePath lastPathComponent];
            
            FNFileServiceLogic *fileService = [[FNFileServiceLogic alloc] init];
            
            [fileService uploadFile:fileServiceReq callback:^(FNFileUploadResponse *rspArgs) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    FNUploadGroupSharedFileResponse *uploadRsp = [[FNUploadGroupSharedFileResponse alloc] initWithRspArgs:rspArgs.statusCode fileInfo:rspArgs.fileInfo errorInfo:rspArgs.errorInfo];
                    
                    callback(uploadRsp);
                });
            }];
        }
        else
        {
            FNUploadGroupSharedFileResponse *uploadRsp = [[FNUploadGroupSharedFileResponse alloc] initWithRspArgs:rsp.statusCode fileInfo:nil errorInfo:@"get group credential failed!"];
            
            callback(uploadRsp);
        }
    }];
}

+ (void)downloadGroupSharedFile:(FNDownloadGroupSharedFileRequest *)downloadReq
                       callback:(void(^)(FNDownloadGroupSharedFileResponse *))callback
{
    FNGetGroupFileCredentialRequest *gpCReq = [[FNGetGroupFileCredentialRequest alloc] init];
    gpCReq.groupID = downloadReq.groupID;
    
    [FNGroupLogic getGroupFileCredencial:gpCReq callback:^(FNGetGroupFileCredentialResponse *rsp) {
        if (200 == rsp.statusCode)
        {
            FNFileServiceLogic *fileService = [[FNFileServiceLogic alloc] init];
            FNFileDownloadRequest *req = [[FNFileDownloadRequest alloc] init];
            req.fileInfo = downloadReq.fileInfo;
            req.credential = rsp.credential;
            
            [fileService downloadFile:req callback:^(FNFileDownloadResponse *rspArgs) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    FNDownloadGroupSharedFileResponse *downloadRsp = [[FNDownloadGroupSharedFileResponse alloc] initWithRspArgs:rspArgs.statusCode fileInfo:rspArgs.fileInfo errorInfo:rspArgs.errorInfo];
                    
                    callback(downloadRsp);
                });
            }];
        }
        else
        {
            FNDownloadGroupSharedFileResponse *downloadRsp = [[FNDownloadGroupSharedFileResponse alloc] initWithRspArgs:rsp.statusCode fileInfo:nil errorInfo:@"get group credential failed!"];
            
            callback(downloadRsp);
        }
    }];
}

+ (void)getGroupSharedFileList:(FNGetGroupSharedFileListRequest *)getFileListReq
                      callback:(void(^)(FNGetGroupSharedFileListResponse *))callback
{
    FNGetGroupFileCredentialRequest *gpCReq = [[FNGetGroupFileCredentialRequest alloc] init];
    gpCReq.groupID = getFileListReq.groupID;
    
    [FNGroupLogic getGroupFileCredencial:gpCReq callback:^(FNGetGroupFileCredentialResponse *rsp) {
        if (200 == rsp.statusCode)
        {
            NSString *urlStr = [[FNServerConfig getInstance].fileServiceAddress stringByAppendingString:@"getfilelist"];
            NSURL *url = [NSURL URLWithString:urlStr];
            
            BOPAFHTTPRequestOperationManager *manager = [[BOPAFHTTPRequestOperationManager alloc] init];
            [[manager requestSerializer] setValue:[NSString stringWithFormat:@"iOS %@", [FNSystemConfig getVersion]] forHTTPHeaderField:@"x-feinno-agent"];
            [[manager requestSerializer] setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
            
            NSString *groupFileCre = rsp.credential;
            
            NSDictionary *cookieInfo = @{NSHTTPCookiePath:url.path, NSHTTPCookieName:@"ssic",NSHTTPCookieValue:groupFileCre, NSHTTPCookieDomain:url.host};
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            [cookieStorage setCookie:cookie];
            
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            manager.responseSerializer = [BOPAFHTTPResponseSerializer serializer];
            
            // 请求
            [manager GET:urlStr parameters:nil success: ^(BOPAFHTTPRequestOperation *operation, id responseObject) {
                NSArray *fileList = [FNGroupLogic parseXMLData:operation.responseData source:getFileListReq.groupID];
                
                FNGetGroupSharedFileListResponse *rspArgs = [[FNGetGroupSharedFileListResponse alloc] initWithRspArgs:rsp.statusCode
                                                                                                             fileList:fileList
                                                                                                            errorInfo:nil];
                
                callback(rspArgs);
                
            }
                 failure: ^(BOPAFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                 }];
            
        }
        else
        {
            FNGetGroupSharedFileListResponse *rspArgs = [[FNGetGroupSharedFileListResponse alloc] initWithRspArgs:rsp.statusCode
                                                                                                         fileList:nil
                                                                                                        errorInfo:@"get group credential failed!"];
            callback(rspArgs);
        }
    }];
}

+ (void)delGroupSharedFile:(FNDelGroupSharedFileRequest *)delReq
                  callback:(void(^)(FNDelGroupSharedFileResponse *))callback
{
    FNGetGroupFileCredentialRequest *gpCReq = [[FNGetGroupFileCredentialRequest alloc] init];
    gpCReq.groupID = delReq.groupID;
    
    [FNGroupLogic getGroupFileCredencial:gpCReq callback:^(FNGetGroupFileCredentialResponse *rsp) {
        if (200 == rsp.statusCode)
        {
            NSString *actionStr = [NSString stringWithFormat:@"delete?id=%@", delReq.fileID];
            NSString *urlStr = [[FNServerConfig getInstance].fileServiceAddress stringByAppendingString:actionStr];
            
            int32_t rc = rsp.statusCode;
            NSLog(@"get group file credencial return code:%d", rc);
            
            NSURL *url = [NSURL URLWithString:urlStr];
            NSString *fileCre = rsp.credential;
            
            BOPAFHTTPRequestOperationManager *manager = [[BOPAFHTTPRequestOperationManager alloc] init];
            [[manager requestSerializer] setValue:[NSString stringWithFormat:@"iOS %@", [FNSystemConfig getVersion]] forHTTPHeaderField:@"x-feinno-agent"];
            [[manager requestSerializer] setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
            
            NSDictionary *cookieInfo = @{NSHTTPCookiePath:url.path, NSHTTPCookieName:@"ssic",NSHTTPCookieValue:fileCre, NSHTTPCookieDomain:url.host};
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            [cookieStorage setCookie:cookie];
            
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            manager.responseSerializer = [BOPAFHTTPResponseSerializer serializer];
            
            // 请求
            [manager GET:urlStr parameters:nil success: ^(BOPAFHTTPRequestOperation *operation, id responseObject) {
                int32_t statusCode = 0;
                NSString *error;
                if (!operation.responseData)
                {
                    statusCode = 501;
                }
                else
                {
                    NSError *err = [[NSError alloc] init];
                    BOPGDataXMLDocument *doc = [[BOPGDataXMLDocument alloc] initWithData:operation.responseData options:0 error:&err];
                    BOPGDataXMLElement *root = doc.rootElement;
                    BOPGDataXMLNode *rootNode = [root attributeForName:@"resultcode"];
                    
                    statusCode = [[rootNode stringValue] intValue];
                    
                    if (200 == statusCode)
                    {
                        NSLog(@"delete shared file success!");
                        error = nil;
                    }
                    else
                    {
                        NSLog(@"delete shared file failed with status code:%d", statusCode);
                        error = @"get no http data, delete shared file failed";
                    }
                }
                
                FNDelGroupSharedFileResponse *rspArgs = [[FNDelGroupSharedFileResponse alloc] initWithRspArgs:statusCode errorInfo:error];
                callback(rspArgs);
                
            }
                 failure: ^(BOPAFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"%@", error);
                 }];
            
        }
        else
        {
            FNDelGroupSharedFileResponse *rspArgs = [[FNDelGroupSharedFileResponse alloc] initWithRspArgs:rsp.statusCode errorInfo:@"get group credential failed!"];
            
            callback(rspArgs);
        }
    }];
}

+ (NSArray *)parseXMLData:(NSData *)xmlData source:(NSString *)source
{
    NSError *err = [[NSError alloc] init];
    BOPGDataXMLDocument *doc = [[BOPGDataXMLDocument alloc] initWithData:xmlData options:0 error:&err];
    BOPGDataXMLElement *root = doc.rootElement;
    BOPGDataXMLNode *rootNode = [root attributeForName:@"resultcode"];
    
    int32_t statusCode = [[rootNode stringValue] intValue];
    NSMutableArray *fileList = nil;
    if (200 == statusCode)
    {
        NSArray *files = [root elementsForName:@"file"];
        if (files.count > 0)
        {
            // 解析群文件信息
            fileList = [[NSMutableArray alloc] init];
            for (BOPGDataXMLElement *file in files)
            {
                FNSharedFileInfo *fileInfo = [[FNSharedFileInfo alloc] init];
                fileInfo.fileId = [[file attributeForName:@"id"] stringValue];
                fileInfo.fileName = [[file attributeForName:@"filename"] stringValue];
                fileInfo.fileSize = [[[file attributeForName:@"size"] stringValue] intValue];
                fileInfo.creator = [[file attributeForName:@"creator"] stringValue];
                fileInfo.downloadURL = [[file attributeForName:@"download-url"] stringValue];
                fileInfo.source = source;
                
                [fileList addObject:fileInfo];
            }
        }
    }
    
    return fileList;
}

+ (void)changeGroupOwner:(FNChangeGroupOwnerRequest *)changeOwnerRequest
                callback:(void(^)(FNChangeGroupOwnerResponse *rspArgs))callback
{
    NSString *uid = [FNUserConfig getInstance].userIDWithKey;
    
    NSString *toUid = [Utility userIdWithAppKey:changeOwnerRequest.userId];
    NSData *body = [BodyMaker makeChangeGroupOwner:changeOwnerRequest.groupId userId:toUid];
    
    [[McpRequest sharedInstance] send:CMD_GROUP_CHANGE_OWNER userid:uid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            ChangeGroupOwnerResults *rspArgs = (ChangeGroupOwnerResults *)packetObject.args;
            
            if (rspArgs.statusCode == 200)
            {
                NSLog(@"change group owner name success with group id:%d!", rspArgs.statusCode);
                
                [FNGroupMembersTable update:changeOwnerRequest.groupId memberId:[Utility userIdWithoutAppKey:uid] groupOwnerId:[Utility userIdWithoutAppKey:changeOwnerRequest.userId]];
            }
            
            FNChangeGroupOwnerResponse *result = [[FNChangeGroupOwnerResponse alloc] initWithRspArgs:rspArgs.statusCode];
            
            callback(result);
        }
        else
        {
            callback(nil);
        }
    }];
}

@end
