//
//  FNRTCArgs.h
//  FeinnoBopSDK
//
//  Created by jiaoruixue on 15-8-14.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RtcInviteReqArgs;
@class RtcReplyReqArgs;
@class RtcUpdateReqArgs;
@class RtcInviteRspArgs;
@class RtcReplyRspArgs;
@class RtcUpdateRspArgs;
@class RtcInviteReqArgs_CallInfo;
@class RtcReplyReqArgs_CallInfo;
@class RtcUpdateReqArgs_CallInfo;
@class AVNotifyInfo;

/**
 *  主叫邀请的信息类
 */
@interface FNCallInfo : NSObject

// 会话对端账号
@property (nonatomic, copy) NSString *peerID;

// 会话唯一ID，由SDK赋值，UI不需要处理
@property (nonatomic, copy) NSString *callID;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(NSString *)peerId callId:(NSString *)callId;

@end

/**
 *  主叫邀请联系人建立音视频会话的请求类
 */
@interface FNRtcInviteRequest : NSObject

// 会话信息，包含对端账号和会话ID
@property (nonatomic, strong) FNCallInfo *callInfo;

// sdp信息，用于建立媒体平面
@property (nonatomic, copy) NSString *sdp;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(RtcInviteReqArgs *)pbArgs;

@end

/**
 *  主叫邀请联系人建立音视频会话的应答类
 */
@interface FNRtcInviteResponse : NSObject

// 操作的返回码：200 成功    500 服务器内部错误
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(RtcInviteRspArgs *)pbArgs;

@end

/**
 *  被叫对音视频会话进行回复的请求类
 */
@interface FNRtcReplyRequest : NSObject

// 被叫的应答结果：200 用户接受  420 设备不支持音视频会话  603 用户拒绝
@property (nonatomic) int32_t replyCode;

// 会话信息，包含对端账号和会话ID
@property (nonatomic,strong) FNCallInfo *callInfo;

// sdp信息，用于建立媒体平面
@property (nonatomic, copy) NSString *sdp;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(RtcReplyReqArgs *)pbArgs;

@end

/**
 *  被叫对音视频会话进行回复的应答类
 */
@interface FNRtcReplyResponse : NSObject

// 操作的返回码：200 成功   404 会话不存在   500 服务器内部错误
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(RtcReplyRspArgs *)pbArgs;

@end

/**
 *  音视频会话变更的请求类
 */
@interface FNRtcUpdateRequest : NSObject

// 会话信息，包含对端账号和会话ID
@property (nonatomic,strong) FNCallInfo *callInfo;

// action 1:主叫确认会话 2:取消会话 3:挂断会话
@property (nonatomic) int32_t action;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(RtcUpdateReqArgs *)pbArgs;

@end

/**
 *  音视频会话变更的应答类
 */
@interface FNRtcUpdateResponse : NSObject

// 操作的返回码：200 成功   404 会话不存在   500 服务器内部错误
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(RtcUpdateRspArgs *)pbArgs;

@end

/**
 *  notifInfo 通知类
 */
@interface FNAVNotifyInfoNotifyArgs : NSObject

// 通知类型
@property (nonatomic, readonly) NSString *notifyType;

// 通知体
@property (nonatomic, readonly) NSString *notifyBody;

// 消息的ID
@property (nonatomic, readonly) NSString *msgId;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(AVNotifyInfo *)pbArgs;

@end
