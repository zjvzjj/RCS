//
//  enum.h
//  feinno-sdk-protocol
//
//  Created by doujinkun on 14-10-31.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ISOLATE_ONLINE_YES 1
#define ISOLATE_ONLINE_NO 0

static const int32_t localErrorCode = -1;

// 登录环境
typedef NS_ENUM(NSInteger, LoginEnvironment) {
    LoginEnvironmentFunction = 0,   // 功能环境
    LoginEnvironmentProduction = 1, // 生产环境
};

// 登录类型
typedef NS_ENUM(NSInteger, LoginType) {
    LoginTypeMobile,            // 登录类型为手机
    LoginTypeEmail,             // 登录类型为邮箱
    LoginTypeUserName,          // 登录类型为用户名
    LoginTypeBOPID              // 登录类型为bop唯一ID标示
};

// 在线状态
typedef NS_ENUM(NSInteger, OnlineStatus) {
    OnlineStatusOff = 0,        // 用户不在线
    OnlineStatusOn = 400        // 用户在线
};

typedef NS_ENUM(NSUInteger, FNLoginStatus)
{
    FNLoginStatusConnecting = 0,       // 正在登录
    FNLoginStatusOnline = 1,           // 在线
    FNLoginStatusOffline = 2,          // 不在线
    FNLoginStatusKickoff = 3,          // 被踢下线
    FNLoginStatusWaitReconnect = 4,    // 掉线，等待重连
    FNLoginStatusNetError = 5,         // 网络断开
};

typedef NS_ENUM(NSUInteger, FNConnectTimeout)
{
    FNConnectTimeoutFirst = 15,
    FNConnectTimeoutSecond = 90,
    FNConnectTimeoutThird = 30,
};

// 消息类型
typedef NS_ENUM(NSInteger, EventType) {
    EventTypePrivate = 1,       // 两人消息
    EventTypePG = 2,            // 群组 或 讨论组 消息
    EventTypeNtf = 3,           // 通知消息
    EventTypeSysMsg = 4,        // 自动回复(待扩展)
    EventTypePublicPlatform = 5,// 平台消息(待扩展)
    EventTypeSMS = 6            // 短信(待扩展)
};

// 通知类型
typedef NS_ENUM(NSInteger, NotifyType) {
    NotifyTypeMsg = 1,                             // 两人消息
    NotifyTypeGroupMsg = 2,                        // 群组 或 讨论组 消息
    NotifyTypeNewTheme = 3,                        // 新动态
    NotifyTypeNewComment = 4,                      // 新评论
    NotifyTypeApprove = 5,                         // 同意加入群
    NotifyTypeRefuse = 6,                          // 拒绝加入群
    NotifyTypeJoin = 7,                            // 加入群组
    NotifyTypeExit = 8,                            // 退出群组
    NotifyTypeSystem = 9,                          // 系统通知
    NotifyTypeGroupOwnerChange = 10,               // 群主变更
    NotifyTypeGroupMemberNameChange = 11,          // 群成员昵称变更
    NotifyTypeGroupMemberPortraitUrlChange = 12,   // 群成员头像变更
};

// 消息的发送状态
typedef NS_ENUM(NSInteger, MsgSendStatus) {
    MsgSending = 0,             // 正在发送
    MsgSendSuccess = 1,         // 消息发送成功
    MsgSendFailed = 2,          // 消息发送失败
    MsgUploading = 3,           // 消息上传中
    MsgUploadSuccess = 4,       // 消息上传成功
    MsgUploadFailed = 5,        // 消息上传失败
    MsgDownloading = 6,         // 消息下载中
    MsgDownloadSuccess = 7,     // 消息下载成功
    MsgDownloadFailed = 8       // 消息下载失败
};

// 消息的读状态
typedef NS_ENUM(NSInteger, MsgReadStatus) {
    MsgAlreadyRead = 1,         // 消息已读
    MsgUnread = 2               // 消息未读
};

// 消息发送或者接收的标志
typedef NS_ENUM(NSInteger, MsgSendOrReceiveFlag) {
    MsgSendFlag = 1,            // 发送的消息标志
    MsgReceiveFlag = 2          // 接收到的消息标志
};

// 消息接收状态
typedef NS_ENUM(NSInteger, MsgReceiveStatus) {
    MsgUnreceive = 0,           // 消息未接收
    MsgReceiveSuccess = 1,      // 消息成功接收
    MsgReceiveFailed = 2        // 消息接收失败
};

// 消息内容的类型
typedef NS_ENUM(NSInteger, MsgContentType) {
    TextMsg = 1,                // 文本消息
    ImageMsg = 2,               // 图片消息
    VideoMsg = 3,               // 视频消息
    AudioMsg = 4,               // 音频消息
    FileMsg = 5                 // 文件消息
};

// 系统通知类型
typedef NS_ENUM(NSInteger, SystemNotifyType) {
    SystemNotifyTextPlain = 1,   // 文本的系统通知
    SystemNotifyTextUrl = 2,     // 带链接系统通知
    SystemNotifyRichTextUrl = 3  // 富文本系统通知
};

// 组类型
typedef NS_ENUM(NSInteger, GroupType) {
    PGGroup = 1,                // 群组
    DGGroup = 2                 // 讨论组
};

// 群组通知类型
typedef NS_ENUM(NSInteger, GroupNotifyType) {
    ApproveInvite = 1,          // 接受邀请
    RefuseInvite = 2,           // 拒绝邀请
    JoinGroup = 3,              // 加入群组
    NormalExit = 4,             // 正常退出群组
    KickOut = 5,                // 被踢出群组
};

// 朋友圈主题类型
typedef NS_ENUM(NSInteger, FCThemeType) {
    TEXTMESSAGE = 1,            // 文本主题
    IMAGEMESSAGE = 2,           // 图片主题
    VIDEOMESSAGE = 3,           // 视频主题
    AUDIOMESSAGE = 4            // 音频主题
};

// 朋友圈拉取首页的标志
static const int64_t FIRSTPAGE = -1;

static NSString * const FNMsgTypePlain = @"text/plain";
static NSString * const FNMsgTypePic = @"text/pic";
static NSString * const FNMsgTypeAudio = @"text/audio";
static NSString * const FNMsgTypeFile = @"text/file";
static NSString * const FNMsgTypeVideo = @"text/video";
static NSString * const FNMsgTypeLocation = @"text/location";

// 需要监听一下名称的通知
// 通过邀请加入通知名
static NSString * const FNNtfApproveInvite = @"ApproveInviteJoinNtfArgs";
// 拒绝邀请加入通知名
static NSString * const FNNtfRefuseInvite = @"RefuseInviteJoinGroupNtfArgs";
// 加入群组通知名
static NSString * const FNNtfJoinGroup = @"InviteJoinGroupArgs";
// 退出群组通知名
static NSString * const FNNtfExitGroup = @"UserExitGroupNtfArgs";
// 群主变更通知
static NSString * const FNChangeGroupOwner = @"ChangeGroupOwnerNtfArgs";
// 群成员昵称变更通知
static NSString * const FNGroupMemberNameChange = @"GroupMemberNameChangeNtfArgs";
//群成员头像变更通知
static NSString * const FNGroupMemberPortraitUrlChange = @"GroupMemberPortraitChangeNtfArgs";
// 新朋友圈主题通知名
static NSString * const FNNtfFCNewTheme = @"NewFriendInfoNtfArgs";
// 朋友圈新评论通知名
static NSString * const FNNtfFCNewComment = @"NewCommentNtfArgs";
// 系统通知名
static NSString * const FNNtfSystem = @"SystemNotifyArgs";

//需要监听登录返回结构的通知
//参数错误
static NSString * const PARAMETER_ERROR = @"parameterError";
//token错误
static NSString * const TOKEN_ERROR = @"tokenError";
//账号不存在
static NSString * const USERID_INEXISTENCE = @"useridInExistence";
//appkey未定义
static NSString * const APPKEY_UNDEFINED = @"appkeyUndefined";
//appkey状态错误
static NSString * const APPKEY_ERROR = @"appkeyError";
//token失效
static NSString * const TOKEN_INVALID = @"tokenInvalid";
//认证失败
static NSString * const AUTH_FAILURE = @"authFailure";

//需要监听在线状态的通知
//其它终端上线
static NSString * const OTHER_TERMINAL_ONLINE = @"otherTerminalOnline";
//SDK网络断开
static NSString * const BOPNETWORK_ERROR = @"bopNetworkError";
//移动设备网络断开
static NSString * const NETTWORK_ERROR = @"networkError";

