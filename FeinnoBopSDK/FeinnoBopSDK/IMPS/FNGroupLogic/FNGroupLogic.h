//
//  GroupLogic.h
//  feinno-sdk-imps
//
//  Created by doujinkun on 14/11/11.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNGroupArgs.h"

/**
 *  群组逻辑类，包含群组的业务逻辑操作方法
 */
@interface FNGroupLogic : NSObject

/**
 *  创建群组
 *
 *  @param createGroupRequest 创建群组的请求参数
 *  @param callback           创建群组的回调
 */
+ (void)createGroup:(FNCreateGroupRequest *)createGroupRequest
           callback:(void(^)(FNCreateGroupResponse *rspArgs))callback;

/**
 *  设置群信息操作
 *
 *  @param setGroupInfoRequest 设置群信息的请求参数
 *  @param callback            设置群信操作的回调
 */
+ (void)setGroupInfo:(FNSetGroupInfoRequest *)setGroupInfoRequest
            callback:(void(^)(FNSetGroupInfoResponse *rspArgs))callback;

/**
 *  重置群成员昵称操作
 *
 *  @param setGroupMemberInfoRequest 重置群成员信息的请求参数
 *  @param callback                  重置群成员昵称的应答
 */
+ (void)setGroupMemberInfo:(FNSetGroupMemberInfoRequest *)setGroupMemberInfoRequest
                  callback:(void(^)(FNSetGroupMemberInfoResponse *rspArgs))callback;

/**
 *  邀请加入群，群主可以直接邀请，群成员邀请需要群主审批，被邀请人不需要操作
 *
 *  @param inviteJoinGroupRequest 邀请加入群的请求参数
 *  @param callback               邀请加入群的回调
 */
+ (void)inviteJoinGroup:(FNInviteJoinGroupRequest *)inviteJoinGroupRequest
               callback:(void(^)(FNInviteJoinGroupResponse *rspArgs))callback;

/**
 *  处理审批
 *
 *  @param handleApproveInviteJoinReq 审批的请求
 *  @param callback                   审批的回调
 */
+ (void)handleApproveInvite:(FNHandleApproveInviteJoinRequest *)handleApproveInviteJoinReq
                   callback:(void(^)(FNHandleApproveInviteJoinResponse *rspArgs))callback;

/**
 *  踢出群操作
 *
 *  @param kickOutGroupRequest 踢出群操作的请求参数
 *  @param callback            踢出群操作的回调
 */
+ (void)kickOutGroup:(FNKickOutGroupRequest *)kickOutGroupRequest
            callback:(void(^)(FNKickOutGroupResponse *rspArgs))callback;

/**
 *  批量踢出群操作
 *
 *  @param kickOutGroupRequest 批量踢出群操作的请求参数
 *  @param callback            批量踢出群操作的回调
 */
+ (void)batchKickOutGroup:(FNBatchKickOutGroupRequest *)kickOutGroupRequest
                 callback:(void(^)(FNBatchKickOutGroupResponse *rspArgs))callback;

/**
 *  删除群组，只有群创建者可以成功删除
 *
 *  @param delGroupRequest 删除群组的请求参数
 *  @param callback        删除群组的回调
 */
+ (void)delGroup:(FNDeleteGroupRequest *)delGroupRequest
        callback:(void(^)(FNDeleteGroupResponse *rspArgs))callback;

/**
 *  退出群组
 *
 *  @param exitGroupRequest 退出群组的请求参数
 *  @param callback         退出群组的回调
 */
+ (void)exitGroup:(FNExitGroupRequest *)exitGroupRequest
         callback:(void(^)(FNExitGroupResponse *rspArgs))callback;

/**
 *  获取群组列表
 *
 *  @param getGroupListRequest 获取群组列表的请求参数
 *  @param callback            获取群组列表的回调
 */
+ (void)getGroupList:(FNGetGroupListRequest *)getGroupListRequest
            callback:(void(^)(FNGetGroupListResponse *rspArgs))callback;

/**
 *  获取群成员列表
 *
 *  @param getGroupMemberListRequest 获取群文件列表的请求参数
 *  @param callback                  获取群文件列表的回调
 */
+ (void)getGroupMemberList:(FNGetGroupMemberListRequest *)getGroupMemberListRequest
                  callback:(void(^)(FNGetGroupMemberListResponse *rspArgs))callback;

/**
 *  上传群文件
 *
 *  @param uploadReq 上传群文件的请求
 *  @param callback  上传群文件的回调
 */
+ (void)uploadGroupSharedFile:(FNUploadGroupSharedFileRequest *)uploadReq
                     callback:(void(^)(FNUploadGroupSharedFileResponse *rspArgs))callback;

/**
 *  下载群文件
 *
 *  @param downloadReq 下载群文件的请求
 *  @param callback    下载群文件的回调
 */
+ (void)downloadGroupSharedFile:(FNDownloadGroupSharedFileRequest *)downloadReq
                       callback:(void(^)(FNDownloadGroupSharedFileResponse *rspArgs))callback;

/**
 *  获取群文件列表
 *
 *  @param getFileListReq 获取群文件列表的请求参数
 *  @param callback       获取群文件列表的回调
 */
+ (void)getGroupSharedFileList:(FNGetGroupSharedFileListRequest *)getFileListReq
                      callback:(void(^)(FNGetGroupSharedFileListResponse *rspArgs))callback;

/**
 *  删除某个群文件
 *
 *  @param delReq   删除某个群文件的请求参数
 *  @param callback 删除群文件的回调
 */
+ (void)delGroupSharedFile:(FNDelGroupSharedFileRequest *)delReq
                  callback:(void(^)(FNDelGroupSharedFileResponse *rspArgs))callback;

/**
 *  变更群主
 *
 *  @param createGroupRequest 创建群主的请求参数
 *  @param callback           创建群主的回调
 */
+ (void)changeGroupOwner:(FNChangeGroupOwnerRequest *)changeOwnerRequest
                callback:(void(^)(FNChangeGroupOwnerResponse *rspArgs))callback;

@end
