//
//  FNGroupArgs.h
//  FeinnoBopSDK
//
//  Created by wangshuying on 15/1/29.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreateGroupResult;
@class StatusRspArgs;
@class BatchKickOutGroupRspArgs;
@class BatchKickOutGroupRspArgs_MemberResult;
@class GetGroupListResults;
@class GetGroupListResultsGroupInfo;
@class GetGroupMemberListResults;
@class GetGroupMemberListResultsGroupMemberInfo;
@class ApproveInviteJoinNtfArgs;
@class ApproveInviteJoinNtfArgsNtfItem;
@class HandleApproveInviteJoinResponse;
@class RefuseInviteJoinGroupNtfArgs;
@class RefuseInviteJoinGroupNtfArgs_NtfItem;
@class UserJoinGroupNtfArgs;
@class UserExitGroupNtfArgs;
@class GetGroupFileCredencialResults;
@class FNSharedFileInfo;
@class ChangeGroupOwnerNtfArgs;
@class GroupMemberNameChangeNtfArgs;
@class GroupMemberPortraitChangeNtfArgs;

#pragma mark -
#pragma mark 创建、设置

/**
 *  创建群请求类
 */
@interface FNCreateGroupRequest : NSObject

// 创建群的初始名称
@property (nonatomic) NSString *groupName;

// 群类型，取值：1 群、2 讨论组
@property (nonatomic) int32_t groupType;

// 用户昵称
@property (nonatomic) NSString *nickname;

// 群配置，bit1 是否为阅后即焚群,bit2 接收不提示(免打扰)
@property (nonatomic) int32_t groupConfig;

//群头像
@property (nonatomic) NSString *groupPortraitUrl;

@end

/**
 *  创建群应答类
 */
@interface FNCreateGroupResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// 创建群的ID
@property (nonatomic, readonly) NSString *groupID;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(CreateGroupResult *)pbArgs;

@end

/**
 *  设置群信息请求类
 */
@interface FNSetGroupInfoRequest : NSObject

// 群ID
@property (nonatomic) NSString *groupID;

// 群名称
@property (nonatomic) NSString *groupName;

// 群配置(免打扰)
@property (nonatomic) int32_t groupConfig;

//群头像
@property (nonatomic) NSString *groupPortraitUrl;

// 群配置，bit1 更新群名称，bit2更新群配置 bit4更改群组头像url
@property (nonatomic) int32_t updateFieldFlags;

@end

/**
 *  设置群信息应答类
 */
@interface FNSetGroupInfoResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs;

@end

/**
 *  变更群主请求类
 */
@interface FNChangeGroupOwnerRequest : NSObject

// 需要变更群的id
@property (nonatomic) NSString *groupId;

// 需要变更的新群主id
@property (nonatomic) NSString *userId;

@end

/**
 *  变更群主应答类
 */
@interface FNChangeGroupOwnerResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

- (instancetype)initWithRspArgs:(int32_t)statusCode;

@end

/**
 *  重置群组成员昵称请求类
 */
@interface FNSetGroupMemberInfoRequest : NSObject

// 群组id
@property (nonatomic) NSString *groupId;

// 需要更改昵称的群成员id
@property (nonatomic) NSString *userId;

// 更改的新昵称
@property (nonatomic) NSString *memberName;

// 更新的群成员新头像
@property (nonatomic) NSString *memberPortraitUrl;

//更新标志 bit1 更改群成员昵称 bit2 更改群成员头像
@property (nonatomic) int32_t updateFieldFlags;

@end

/**
 *  重置群组成员昵称应答类
 */
@interface FNSetGroupMemberInfoResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

- (instancetype)initWithRspArgs:(int32_t)statusCode;

@end


#pragma mark -
#pragma mark 加入、退出

/**
 *  邀请加入群请求类
 */
@interface FNInviteJoinGroupRequest : NSObject

// FNInviteJoinGroupInfo的集合
@property (nonatomic) NSMutableArray *groupInfoArray;

@end

/**
 *  邀请加入群的消息
 */
@interface FNInviteJoinGroupInfo : NSObject

// 群ID
@property (nonatomic) NSString *groupID;

// 邀请加入群的用户ID
@property (nonatomic) NSString *invitedUserID;

// 邀请加入群的用户昵称
@property (nonatomic) NSString *userNickname;

//群头像
@property (nonatomic) NSString *userPortraitUrl;

@end

/**
 *  邀请加入群的应答类
 */
@interface FNInviteJoinGroupResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs;

@end

/**
 *  处理审批邀请请求类
 */
@interface FNHandleApproveInviteJoinRequest : NSObject

// 群组唯一标识
@property (nonatomic) NSString *groupId;

// 群组中主动邀请好友入群的人的唯一标识
@property (nonatomic) NSString *sourceId;

// FNHandleApproveInviteJoinRequestItem集合
@property (nonatomic) NSMutableArray *mutableHandleApproveItemList;

@end

/**
 *  处理的审批邀请消息
 */
@interface FNHandleApproveInviteJoinRequestItem : NSObject

// 被邀请入群的人的唯一标识
@property (nonatomic) NSString *invitedUserId;

// 被邀请入群的群昵称
@property (nonatomic) NSString *invitedUserNickname;

// 存放BOOL类型，表示是否同意入群（yes为同意，no为拒绝）
@property (nonatomic) BOOL approveResult;

//邀请人的头像
@property (nonatomic) NSString *invitedPortraitUrl;

@end

/**
 *  处理的审批邀请应答类
 */
@interface FNHandleApproveInviteJoinResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(HandleApproveInviteJoinResponse *)pbArgs;

@end

/**
 *  剔出群成员请求类
 */
@interface FNKickOutGroupRequest : NSObject

// 群ID
@property (nonatomic) NSString *groupID;

// 被踢出的成员ID
@property (nonatomic) NSString *kickedUserID;

@end

/**
 *  踢出群成员应答类
 */
@interface FNKickOutGroupResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs;

@end

/**
 *  批量剔出群成员请求类
 */
@interface FNBatchKickOutGroupRequest : NSObject

// 群ID
@property (nonatomic) NSString *groupID;

// 被踢出的成员ID列表
@property (nonatomic) NSArray *kickedUserIDList;

@end

/**
 *  踢出群成员应答类
 */
@interface FNBatchKickOutGroupResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// 删除的群组成员对应的应答
@property (nonatomic) NSArray *resultList;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(BatchKickOutGroupRspArgs *)pbArgs;

@end

@interface FNBatchKickOutGroupMemberResult : NSObject

// 群组成员的userId
@property (nonatomic) NSString *userId;

// 删除的群组成员对应的应答码
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(BatchKickOutGroupRspArgs_MemberResult *)pbArgs;

@end
/**
 *  删除群的请求类
 */
@interface FNDeleteGroupRequest : NSObject

// 要删除的群的ID
@property (nonatomic) NSString *groupID;

@end

/**
 *  删除群的应答类
 */
@interface FNDeleteGroupResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs;

@end

/**
 *  退出群请求类
 */
@interface FNExitGroupRequest : NSObject

// 退出群ID
@property (nonatomic) NSString *groupID;

@end

/**
 *  退出群应答类
 */
@interface FNExitGroupResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// 初始化参数的方法
- (instancetype)initWithPBArgs:(StatusRspArgs *)pbArgs;

@end


#pragma mark -
#pragma mark 获取

/**
 *  获取群列表请求类
 */
@interface FNGetGroupListRequest : NSObject

// 群类型，取值：1 群、2 讨论组
@property (nonatomic) int32_t groupType;

@end

/**
 *  获取群列表应答类
 */
@interface FNGetGroupListResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// FNGroupInfo的集合
@property (nonatomic, readonly) NSArray *groupList;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GetGroupListResults *)pbArgs;
@end

/**
 *  获取群列表中的群消息
 */
@interface FNGroupInfo : NSObject

// 群类型，取值：1 群、2 讨论组
@property (nonatomic) int32_t groupType;

// 群ID
@property (nonatomic) NSString *groupID;

// 群名称
@property (nonatomic) NSString *groupName;

//群组配置
@property (nonatomic) int32_t groupConfig;

// 群头像
@property (nonatomic) NSString *groupPortraitUrl;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GetGroupListResultsGroupInfo *)pbArgs;

@end

/**
 *  获取群成员列表请求类
 */
@interface FNGetGroupMemberListRequest : NSObject

// 群ID
@property (nonatomic) NSString *groupID;

@end

/**
 *  获取群成员列表应答类
 */
@interface FNGetGroupMemberListResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// FNGroupMemberInfo的集合
@property (nonatomic, readonly) NSArray *memberArray;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GetGroupMemberListResults *)pbArgs;

@end

/**
 *  群成员信息
 */
@interface FNGroupMemberInfo : NSObject

@property (nonatomic) int32_t userConfig;

// 用户ID
@property (nonatomic) NSString *userID;

// 群成员昵称
@property (nonatomic) NSString *groupNickName;

// 用户身份，0创建者，1普通成员
@property (nonatomic) int32_t identity;

//群成员头像
@property (nonatomic) NSString *groupMemberPortraitUrl;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GetGroupMemberListResultsGroupMemberInfo *)pbArgs;

@end


#pragma mark -
#pragma mark 群文件

/**
 *  获取群证书请求类
 */
@interface FNGetGroupFileCredentialRequest : NSObject

// 获取群证书的群ID
@property (nonatomic) NSString *groupID;

@end

/**
 *  获取群证书应答类
 */
@interface FNGetGroupFileCredentialResponse : NSObject

// 应答码
@property (nonatomic, readonly) int32_t statusCode;

// 群证书
@property (nonatomic, readonly) NSString *credential;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GetGroupFileCredencialResults *)pbArgs;

@end

/**
 *  上传群文件的请求类
 */
@interface FNUploadGroupSharedFileRequest : NSObject

// 要上传文件的路径
@property (nonatomic) NSString *filePath;

// 文件要上传到的群ID
@property (nonatomic) NSString *groupID;

@end

/**
 *  上传群文件的应答类
 */
@interface FNUploadGroupSharedFileResponse : NSObject

// 上传文件的返回码 200 成功
@property (nonatomic, readonly) int32_t statusCode;

// 上传文件后得到的文件信息
@property (nonatomic, readonly) FNSharedFileInfo *fileInfo;

// 出错时的错误信息描述
@property (nonatomic, readonly) NSString *errorInfo;

// 初始化该类，由SDK调用
- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileInfo:(FNSharedFileInfo *)fileInfo
                      errorInfo:(NSString *)error;

@end

/**
 *  下载群文件的请求类
 */
@interface FNDownloadGroupSharedFileRequest : NSObject

// 要下载文件所在的群ID
@property (nonatomic) NSString *groupID;

// 要下载群文件的文件信息
@property (nonatomic) FNSharedFileInfo *fileInfo;

@end

/**
 *  下载群文件的应答类
 */
@interface FNDownloadGroupSharedFileResponse : NSObject

// 下载群文件应答码
@property (nonatomic, readonly) int32_t statusCode;

// 下载完成后的文件在沙盒中的保存路径填充到请求类的fileInfo.filePath
@property (nonatomic, readonly) FNSharedFileInfo *fileInfo;

// 下载文件失败时的错误描述信息
@property (nonatomic, readonly) NSString *errorInfo;

// 初始化该类，由SDK调用
- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileInfo:(FNSharedFileInfo *)fileInfo
                      errorInfo:(NSString *)error;

@end

/**
 *  获取群文件列表的请求类
 */
@interface FNGetGroupSharedFileListRequest : NSObject

// 上传群文件的群的ID
@property (nonatomic) NSString *groupID;

@end

/**
 *  获取群文件列表的应答类
 */
@interface FNGetGroupSharedFileListResponse : NSObject

// 上传结果的应答码
@property (nonatomic, readonly) int32_t statusCode;

// 群文件信息，数组内存储的是FNSharedFileInfo类
@property (nonatomic, readonly) NSArray *fileList;

// 错误信息描述
@property (nonatomic, readonly) NSString *errorInfo;

// 初始化该类，由SDK调用
- (instancetype)initWithRspArgs:(int32_t)statusCode
                       fileList:(NSArray *)list
                      errorInfo:(NSString *)error;

@end

/**
 *  删除群文件的请求类
 */
@interface FNDelGroupSharedFileRequest : NSObject

// 群文件所属的群ID
@property (nonatomic) NSString *groupID;

// 该文件对应的文件ID
@property (nonatomic) NSString *fileID;

@end

/**
 *  删除群文件的应答类
 */
@interface FNDelGroupSharedFileResponse : NSObject

// 上传结果的应答码
@property (nonatomic, readonly) int32_t statusCode;

// 错误信息描述
@property (nonatomic, readonly) NSString *errorInfo;

// 初始化该类，由SDK调用
- (instancetype)initWithRspArgs:(int32_t)statusCode
                      errorInfo:(NSString *)error;

@end


#pragma mark -
#pragma mark 通知

@class GroupListChangedArgs;

/**
 *  群列表改变通知类
 */
@interface FNGroupListChangeNotifyArgs : NSObject

// 群ID
@property (nonatomic, readonly) NSString *groupId;

// 群名称
@property (nonatomic, readonly) NSString *groupName;

// 变更的动作类型，目前支持 join：加入群  kick：踢出群  delete：群删除
@property (nonatomic, readonly) NSString *actionType;

// 群类型，取值：1 群、2 讨论组
@property (nonatomic, readonly) int32_t groupType;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GroupListChangedArgs *)pbArgs;

@end

/**
 *  管理员审批邀请加入群的通知类
 */
@interface FNApproveInviteJoinGroupNtfArgs : NSObject

// 邀请加入的群ID
@property (nonatomic, readonly) NSString *groupID;

// 邀请人的ID
@property (nonatomic, readonly) NSString *sourcerUserID;

// 邀请列表，数组内是FNApproveInviteJoinNtfIetm类
@property (nonatomic, readonly) NSArray *approveList;

// 邀请加入的群名称
@property (nonatomic, readonly) NSString *groupName;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(ApproveInviteJoinNtfArgs *)pbArgs;

@end

/**
 *  群邀请审批的内容类
 */
@interface FNApproveInviteJoinNtfIetm : NSObject

// 被邀请者的用户ID
@property (nonatomic, readonly) NSString *invitedUserID;

// 邀请加入的群的群昵称
@property (nonatomic, readonly) NSString *invitedGroupNickName;

// 被邀请者的用户头像
@property (nonatomic, readonly) NSString *invitedUserPortraitUrl;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(ApproveInviteJoinNtfArgsNtfItem *)pbArgs;

@end

/**
 *  邀请某人入群后，管理员拒绝加入的通知类，通知到邀请者
 */
@interface FNRefuseInviteJoinGroupNtfArgs : NSObject

// 邀请时的群ID
@property (nonatomic, readonly) NSString *groupID;

// 邀请被拒绝的列表，数组内存放的是FNRefuseInviteJoinNtfItem类
@property (nonatomic, readonly) NSArray *refuseList;

// 邀请时的群名称
@property (nonatomic, readonly) NSString *groupName;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(RefuseInviteJoinGroupNtfArgs *)pbArgs;

@end

/**
 *  审批拒绝邀请的内容类
 */
@interface FNRefuseInviteJoinNtfItem : NSObject

// 被邀请者的ID
@property (nonatomic, readonly) NSString *invitedUserID;

// 被邀请者的用户名
@property (nonatomic, readonly) NSString *invitedUserName;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(RefuseInviteJoinGroupNtfArgs_NtfItem *)pbArgs;

@end

/**
 *  加入群组通知
 */
@interface FNJoinGroupNtfItem : NSObject

// 加入的群的ID
@property (nonatomic, readonly) NSString *groupId;

// 邀请者ID
@property (nonatomic, readonly) NSString *sourceUserId;

// 邀请者用户名
@property (nonatomic, readonly) NSString *sourceUserNickname;

// 被邀请者ID
@property (nonatomic, readonly) NSString *invitedUserId;

// 被邀请者用户名
@property (nonatomic, readonly) NSString *invitedUserNickname;

// 加入的群的名称
@property (nonatomic, readonly) NSString *groupName;

// 加入者的头像
@property (nonatomic, readonly) NSString *invitePortraitUrl;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(UserJoinGroupNtfArgs *)pbArgs;

@end

/**
 *  退出群组通知
 */
@interface FNExitGroupNtfItem : NSObject

// 退出的群的ID
@property (nonatomic, readonly) NSString *groupId;

// 退出类型，1 主动，2 被踢，被踢时sourceUserId和sourceUserNickname有效
@property (nonatomic, assign) int32_t exitType;

// 退出者ID
@property (nonatomic, readonly) NSString *exitUserId;

// 退出者用户名
@property (nonatomic, readonly) NSString *exitUserNickname;

// 踢人者ID
@property (nonatomic, readonly) NSString *sourceUserId;

// 踢人者用户名
@property (nonatomic, readonly) NSString *sourceUserNickname;

// 退出的群的名称
@property (nonatomic, readonly) NSString *groupName;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(UserExitGroupNtfArgs *)pbArgs;

@end

/*
 *  转让群主通知
 */
@interface FNChangeGroupOwnerNtfItem : NSObject

// 转让的群的ID
@property (nonatomic, readonly) NSString *groupId;

// 转让的群的名称
@property (nonatomic, readonly) NSString *groupName;

// 转让对象的ID
@property (nonatomic, readonly) NSString *userId;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(ChangeGroupOwnerNtfArgs *)pbArgs;

@end

/*
 *  重置群组成员昵称通知 
 */
@interface FNGroupMemberNameChangeNtfItem : NSObject

// 群组ID
@property (nonatomic, readonly) NSString *groupId;

// 群组名称
@property (nonatomic, readonly) NSString *groupName;

// 群成员之前的昵称
@property (nonatomic, readonly) NSString *oldGroupMemberName;

// 群成员重置后的昵称
@property (nonatomic, readonly) NSString *currentGroupMemberName;

// 群成员userid
@property (nonatomic, readonly) NSString *userId;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GroupMemberNameChangeNtfArgs *)pbArgs;

@end

@interface FNGroupMemberPortraitUrlChangeNtfItem : NSObject

// 群组ID
@property (nonatomic, readonly) NSString *groupId;

// 群组名称
@property (nonatomic, readonly) NSString *groupName;

// 群成员之前的昵称
@property (nonatomic, readonly) NSString *userNickname;

// 群成员重置后的头像
@property (nonatomic, readonly) NSString *groupMemberPortraitUrl;

// 群成员userid
@property (nonatomic, readonly) NSString *userId;

//初始化该类，由sdk调用
- (instancetype)initWithPBArgs:(GroupMemberPortraitChangeNtfArgs *)pbArgs;

@end
