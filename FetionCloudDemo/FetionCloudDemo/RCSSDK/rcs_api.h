/**
 * @file  rcs_api.h
 * @brief RCSAPI 包含了所有的RCS SDK的接口,包括SDK 初始化、RCS 能力接口、回调、通知等
 *  同时也可以多 SDK 实例同时使用，需要调用方维护好 rcs_state 的关系
 * @author http://www.interrcs.com/
 * @date 2016/4/20
 * @version 1.0.0
 * @copyright interrcs
 */

#ifndef _RCS_API_H
#define _RCS_API_H

#include "rcs_entity.h"
#include <stdio.h>
#include <time.h>
#include <string.h>

/**
 * @interface RCSAPI
 * @brief RCSAPI 接口
 * 该头文件包含了所有的RCS SDK的接口，包括SDK 初始化、RCS能力接口、回调、通知等等,目前SDK已经具备了支持多用户同时使用的能力,
 *
 * SDK的初始化，通过调用init来实现
 * SDK 中的业务，包含两大类:
 * 主动调用 主动调用类型操作，需要注册Callback回调接口,处理主动调用的返回结果,返回数据在Result数据里
 * 事件通知 事件通知类型操作, 需要注册Listener通知接口,处理服务端推送过来的事件,事件数据在Session数据里
 *
 * 使用的一般流程:
 * 1.定义rcs_state* R
 * 2.注册callbacks、listeners到
 * 3.调用init方法初始化R
 * 4.调用start方法开始
 * 5.可以发起主动业务请求,在对应的Callback回调里处理返回结果
 * 6.注册的事件通知里已经能收到事件了
 *
 */

#ifdef __cplusplus
extern "C" {
#endif

#ifdef _WIN32
#define RCSAPI __declspec(dllexport)
#else
#define RCSAPI
#endif

#include <stdlib.h>
#include <string.h>

struct rcs_state;

/**
 * @brief 客户端调用usersetportrait、usergetportrait头像操作应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s UserPortraitResult 头像处理结果 @see {UserPortraitResult}
 * @return void
 *
 */
typedef void (*CBUserPortrait)(struct rcs_state *R,UserPortraitResult* s);

typedef void (*CBUserPortraitJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用默认应答回调,用于未指定回调函数时调用
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ActionResult 操作结果 @see {ActionResult}
 * @return void
 *
 */
typedef void (*CBAction)(struct rcs_state *R,ActionResult* s);

typedef void (*CBActionJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用gpcreate、gpdelete、gpinvitemember、gpremovemember、gpjoin、gpquit、gpsublist、
 *  gpsubinfo、gpmodifynickname、gpchangemanager、gpmodifysubject、gpreject群组操作应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s GroupResult 群组相关操作的结果 @see {GroupResult}
 * @return void
 *
 */
typedef void (*CBGroup)(struct rcs_state *R,GroupResult* s);

typedef void (*CBGroupJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用音视频通话应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s AVResult 音视频操作结果 @see {AVResult}
 * @return void
 *
 */
typedef void (*CBAVCall)(struct rcs_state *R,AVResult* s);

typedef void (*CBAVCallJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用buddyadd、buddydel、buddyhandle、buddymemo好友操作接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s BuddyResult 好友操作的结果 @see {BuddyResult}
 * @return void
 *
 */
typedef void (*CBBuddy)(struct rcs_state *R,BuddyResult* s);

typedef void (*CBBuddyJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用deleteendpoint、bootendpoint应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ActionResult 操作结果 @see {ActionResult}
 * @return void
 *
 */
typedef void (*CBEndpoint)(struct rcs_state *R,ActionResult* s);

typedef void (*CBEndpointJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用login登录接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s LoginResult 登录操作结果 @see {LoginResult}
 * @return void
 *
 */
typedef void (*CBLogin)(struct rcs_state *R,LoginResult* s);

typedef void (*CBLoginJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用getsmscode获取短信回调应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s GetSmsResult 获取短信验证码的结果 @see {GetSmsResult}
 * @return void
 *
 */
typedef void (*CBGetSms)(struct rcs_state *R,GetSmsResult* s);

typedef void (*CBGetSmsJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用msgsetstatus、msgsetconvstatus应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ActionResult 操作结果 @see {ActionResult}
 * @return void
 *
 */
typedef void (*CBMsgSet)(struct rcs_state *R,ActionResult* s);

typedef void (*CBMsgSetJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用provision、provisiondm、provisionotp注册接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ProvisionResult 注册操作结果 @see {ProvisionResult}
 * @return void
 *
 */
typedef void (*CBProvision)(struct rcs_state *R,ProvisionResult* s);

typedef void (*CBProvisionJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用msgsendtext、msggpsendtext、msgsendfile、msggpsendfile、msgfetchfile、
 *  msgpubsendtext、msgsendreport、msggpsendvemoticon、msgsendcloudfile发送消息接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s MessageResult 消息发送结果 @see {MessageResult}
 * @return void
 *
 */
typedef void (*CBMessage)(struct rcs_state *R,MessageResult* s);

typedef void (*CBMessageJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用setpush、disablepush应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ActionResult 操作结果 @see {ActionResult}
 * @return void
 *
 */
typedef void (*CBPush)(struct rcs_state *R,ActionResult* s);

typedef void (*CBPushJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用usergetinfo用户概要信息接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s UserInfoResult 用户信息操作的结果 @see {UserInfoResult}
 * @return void
 *
 */
typedef void (*CBUserInfo)(struct rcs_state *R,UserInfoResult* s);

typedef void (*CBUserInfoJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用get_endpoint_list应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s EndpointResult 操作结果 @see {EndpointResult}
 * @return void
 *
 */
typedef void (*CBEndpointList)(struct rcs_state *R,EndpointResult* s);

typedef void (*CBEndpointListJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用searchgroup搜索群组信息应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s SearchGroupResult 搜索群组的结果 @see {SearchGroupResult}
 * @return void
 *
 */
typedef void (*CBSearchGroup)(struct rcs_state *R,SearchGroupResult* s);

typedef void (*CBSearchGroupJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用token获取Token应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s TokenResult 获取Token的结果 @see {TokenResult}
 * @return void
 *
 */
typedef void (*CBToken)(struct rcs_state *R,TokenResult* s);

typedef void (*CBTokenJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用capsexchange能力查询接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s CapsResult 获取用户能力的结果,1为支持，0为不支持 @see {CapsResult}
 * @return void
 *
 */
typedef void (*CBCaps)(struct rcs_state *R,CapsResult* s);

typedef void (*CBCapsJson)(struct rcs_state *R,const char *json);

/**
 * @brief 客户端调用usersetprofile、usergetprofile用户详细信息应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s UserProfileResult 用户详细信息操作结果 @see {UserProfileResult}
 * @return void
 *
 */
typedef void (*CBUserProfile)(struct rcs_state *R,UserProfileResult* s);

typedef void (*CBUserProfileJson)(struct rcs_state *R,const char *json);


/**
 * @brief 所有的callback必须在调用api之前设置为有效值
 * Callback是主动调用类型操作对应的返回处理结果回调函数
 * 例如:发起一次登录请求,服务端应答在登录回调里回复
 * 客户端编码时在注册的Callback里处理对应应答信息
 * Callback的Result参数通常都携带有如下字段
 *  int sid ///<任务id,用于匹配是哪次api调用
 *  const char* error_extra; ///<错误描述
 *  int error_code; ///<错误码
 */
typedef struct rcs_callbacks{
    CBUserPortrait user_portrait;
    CBUserPortraitJson user_portrait_json;
    CBAction action;
    CBActionJson action_json;
    CBGroup group;
    CBGroupJson group_json;
    CBAVCall avcall;
    CBAVCallJson avcall_json;
    CBBuddy buddy;
    CBBuddyJson buddy_json;
    CBEndpoint endpoint;
    CBEndpointJson endpoint_json;
    CBLogin login;
    CBLoginJson login_json;
    CBGetSms getsms;
    CBGetSmsJson getsms_json;
    CBMsgSet msgset;
    CBMsgSetJson msgset_json;
    CBProvision provision;
    CBProvisionJson provision_json;
    CBMessage message;
    CBMessageJson message_json;
    CBPush push;
    CBPushJson push_json;
    CBUserInfo user_info;
    CBUserInfoJson user_info_json;
    CBEndpointList endpointlist;
    CBEndpointListJson endpointlist_json;
    CBSearchGroup searchgroup;
    CBSearchGroupJson searchgroup_json;
    CBToken token;
    CBTokenJson token_json;
    CBCaps cap;
    CBCapsJson cap_json;
    CBUserProfile user_profile;
    CBUserProfileJson user_profile_json;
}rcs_callbacks;

/**
 * @brief 服务端推送群组详细信息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s GroupSession 群组详细信息 @see {GroupSession}
 * @return void
 *
 */
typedef void (*CBGroupInfo)(struct rcs_state *R,GroupSession* s);

typedef void (*CBGroupInfoJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送富文本消息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageFTSession 文件消息 @see {MessageFTSession}
 * @return void
 *
 */
typedef void (*CBMessageFT)(struct rcs_state *R,MessageFTSession* s);

typedef void (*CBMessageFTJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送音视频通话事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s AvSession 音视频通话的状态 @see {AvSession}
 * @return void
 *
 */
typedef void (*CBAVEvent)(struct rcs_state *R,AvSession* s);

typedef void (*CBAVEventJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送好友操作事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s BuddyEventSession 好友关系操作信息 @see {BuddyEventSession}
 * @return void
 *
 */
typedef void (*CBBuddyEvent)(struct rcs_state *R,BuddyEventSession* s);

typedef void (*CBBuddyEventJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送用户会话状态同步事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MsgConvStatusSession 会话状态同步信息 @see {MsgConvStatusSession}
 * @return void
 *
 */
typedef void (*CBMsgConvStatus)(struct rcs_state *R,MsgConvStatusSession* s);

typedef void (*CBMsgConvStatusJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送群列表变更事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s GroupListSession 群列表的信息 @see {GroupListSession}
 * @return void
 *
 */
typedef void (*CBGroupList)(struct rcs_state *R,GroupListSession* s);

typedef void (*CBGroupListJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送群组通知的信息 这个类型中,描述的是群组其他人发生的和自己无关,不需要额外处理群操作事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s GroupNotificationSession 群组通知的信息 @see {GroupNotificationSession}
 * @return void
 *
 */
typedef void (*CBGroupNotify)(struct rcs_state *R,GroupNotificationSession* s);

typedef void (*CBGroupNotifyJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送商店表情消息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageEmoticonSession 商店表情的消息 @see {MessageEmoticonSession}
 * @return void
 *
 */
typedef void (*CBMessageEmoticon)(struct rcs_state *R,MessageEmoticonSession* s);

typedef void (*CBMessageEmoticonJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送自定义消息,SDK直接透传不处理事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageCustomSession 自定义消息,SDK只作透传,不处理 @see {MessageCustomSession}
 * @return void
 *
 */
typedef void (*CBMessageCustom)(struct rcs_state *R,MessageCustomSession* s);

typedef void (*CBMessageCustomJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送用户强制下线通知事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s LogoutSession 强制下线信息 @see {LogoutSession}
 * @return void
 *
 */
typedef void (*CBLogout)(struct rcs_state *R,LogoutSession* s);

typedef void (*CBLogoutJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送好友列表事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s BuddyListSession 好友列表信息 @see {BuddyListSession}
 * @return void
 *
 */
typedef void (*CBBuddyList)(struct rcs_state *R,BuddyListSession* s);

typedef void (*CBBuddyListJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送SINGLE(一对一聊天)、GROUP(群组聊天)、PUBLIC_ACCOUNT(公众账号消息)、
 *  BROADCAST(广播消息)、DIRECTED(定向消息)文本消息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageTextSession 文本消息 @see {MessageTextSession}
 * @return void
 *
 */
typedef void (*CBMessageText)(struct rcs_state *R,MessageTextSession* s);

typedef void (*CBMessageTextJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送INVITED(被邀请入群)、BOOTED(被踢出群)、
 *  CONFIRMED(群邀请处理结果)、DISMISSED(群被解散)、TRANSFER(被提升为管理员)群操作事件监听器
 *  描述的事件都是与当前用户有关的信息
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s GroupEventSession 群组通知事件的状态 @see {GroupEventSession}
 * @return void
 *
 */
typedef void (*CBGroupEvent)(struct rcs_state *R,GroupEventSession* s);

typedef void (*CBGroupEventJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送消息状态变化事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MsgStatusSession 消息状态变化信息 @see {MsgStatusSession}
 * @return void
 *
 */
typedef void (*CBMsgStatus)(struct rcs_state *R,MsgStatusSession* s);

typedef void (*CBMsgStatusJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送用户在线期间其他端上下线时通知事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s EndpointChangedSession 变化登录点信息 @see {EndpointChangedSession}
 * @return void
 *
 */
typedef void (*CBEpChanged)(struct rcs_state *R,EndpointChangedSession* s);

typedef void (*CBEpChangedJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送彩云文件消息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageCloudFileSession 彩云文件的消息 @see {MessageCloudFileSession}
 * @return void
 *
 */
typedef void (*CBMessageCloudFile)(struct rcs_state *R,MessageCloudFileSession* s);

typedef void (*CBMessageCloudFileJson)(struct rcs_state *R,const char *json);

/**
 * @brief 服务端推送BURN(已焚)、DELIVERED(已送达)、FILE_PROGRESS(文件上传/下载进度)、GROUP_DELIVERED(群组消息已送达)、
 *  GROUP_READ(群组消息已读)、GROUP_WITH_DRAW(群组消息撤销)、READ(已读)、TYPING(正在输入)、UPDATE_MSG_ID(更新消息 ID)、
 *  WITH_DRAW(撤回)、消息报告事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageReportSession 消息报告 @see {MessageReportSession}
 * @return void
 *
 */
typedef void (*CBMessageReport)(struct rcs_state *R,MessageReportSession* s);

typedef void (*CBMessageReportJson)(struct rcs_state *R,const char *json);


/**
 * @brief 所有的listener必须在调用所有api之前设置为有效值
 * listener是服务端推送的事件通知信息监听处理接口
 * 例如:别人发送的消息,群组变化的同步,上传文件进度等
 * 客户端编码时在注册的listener里处理对应的服务端推送事件通知
 */
typedef struct rcs_listeners{
    CBGroupInfo group_info;
    CBGroupInfoJson group_info_json;
    CBMessageFT msg_ft;
    CBMessageFTJson msg_ft_json;
    CBAVEvent av_event;
    CBAVEventJson av_event_json;
    CBBuddyEvent buddy_event;
    CBBuddyEventJson buddy_event_json;
    CBMsgConvStatus msg_conv_status;
    CBMsgConvStatusJson msg_conv_status_json;
    CBGroupList group_list;
    CBGroupListJson group_list_json;
    CBGroupNotify group_notify;
    CBGroupNotifyJson group_notify_json;
    CBMessageEmoticon msg_emoticon;
    CBMessageEmoticonJson msg_emoticon_json;
    CBMessageCustom msg_custom;
    CBMessageCustomJson msg_custom_json;
    CBLogout logout;
    CBLogoutJson logout_json;
    CBBuddyList buddy_list;
    CBBuddyListJson buddy_list_json;
    CBMessageText msg_text;
    CBMessageTextJson msg_text_json;
    CBGroupEvent group_event;
    CBGroupEventJson group_event_json;
    CBMsgStatus msg_status;
    CBMsgStatusJson msg_status_json;
    CBEpChanged ep_changed;
    CBEpChangedJson ep_changed_json;
    CBMessageCloudFile msg_cloudfile;
    CBMessageCloudFileJson msg_cloudfile_json;
    CBMessageReport msg_report;
    CBMessageReportJson msg_report_json;
}rcs_listeners;

typedef struct rcs_parse_buf {
    struct rcs_parse_buf* next;
    void* data;
} rcs_parse_buf;

/**
 * @brief 状态信息数据
 *
 */
typedef struct rcs_state {
    void* L;
    void* task_queue;
    rcs_parse_buf *parse_buf;
    rcs_callbacks *callbacks;
    rcs_listeners *listeners;
    int last_id;
    void* id_mutex;
    int started;
    int irq_cli_fd;
    int irq_srv_fd;
    int irq_port;
    const char* number;
    const char* appid;
} rcs_state;

/**
 * @brief 设置事件通知的监听处理
 * @param rcs_state, RCS 实例
 * @param rcs_listeners 事件回调函数
 * @return void
 *
 */
RCSAPI void rcs_set_listeners(rcs_state*, rcs_listeners *);

/**
 * @brief 设置主动调用操作返回结果处理
 * @param rcs_state, RCS 实例
 * @param rcs_listeners 事件回调函数
 * @return void
 *
 */
RCSAPI void rcs_set_callbacks(rcs_state*, rcs_callbacks *);

/**
 * @brief 获取事件通知处理
 * @param rcs_state, RCS 实例
 * @return rcs_listeners 事件通知的监听处理
 *
 */
RCSAPI rcs_listeners *rcs_get_listeners(rcs_state*);

/**
 * @brief 获取主动调用操作处理
 * @param rcs_state, RCS 实例
 * @return rcs_listeners 事件通知的监听处理
 *
 */
RCSAPI rcs_callbacks *rcs_get_callbacks(rcs_state*);

/**
 * @brief 创建rcs_state实例
 *
 * @return rcs_state, RCS 实例
 *
 */
RCSAPI rcs_state* rcs_state_new();

/**
 * @brief 得到一个新的Cid,每个rcs_state实例保持唯一
 * @param rcs_state, RCS 实例
 * @return int, 新的Cid
 *
 */
RCSAPI int rcs_new_command_id(rcs_state*);

/**
 * @brief 初始化SDK
 *
 * 使用 SDK 第一步是初始化 SDK，通过初始化 SDK，可以得到 rcs 实例(struct rcs_state), 做为后续业务操作的参数。
 *  同时也可以多 SDK 实例同时使用，需要调用方维护好 rcs_state 的关系。
 * @param R rcs_state, RCS 实例，通过 rcs_state_new 方法得到
 * @param number 用户号码
 * @param imei 用户设备标识
 * @param imsi 用户移动身份标识
 * @param devicevendor 设备厂商名称
 * @param devicemodel 设备型号
 * @param deviceos 操作系统名称
 * @param deviceosversion 操作系统版本号
 * @param clientVendor 客户端厂商名称
 * @param clientVersion 客户端版本号
 * @param storage 文件存储路径
 * @param appid 用户所属组织Id
 * @param syspath 配置文件存储路径
 * @param clienttype 客户端类型  @see {ClientType}
 */
RCSAPI int rcs_init(rcs_state* R,const char* number,const char* imei,const char* imsi,const char* devicevendor,
                    const char* devicemodel,const char* deviceos,const char* deviceosversion,const char* clientvendor,
                    const char* clientversion,const char* storage,const char* appid,const char* syspath,int clienttype);
/**
 * @brief 特殊处理，启动engine
 * @param rcs_state, RCS 实例
 * @return int
 *
 */
RCSAPI int rcs_start(rcs_state* R);


/**
 * @brief 邀请人加入群
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param groupUri 群Uri
 * @param target 被邀请用户
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpinvitemember(rcs_state* R,int id,const char* group_uri,const char* target);


/**
 * @brief 按照群名称搜索群组
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param subject 群名称
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpsearch(rcs_state* R,int id,const char* subject);


/**
 * @brief 创建群组
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param resourcelist 群成员列表，用户id/号码以分号间隔
 * @param subject 群名称
 * @param subject 群简介
 * @param subject 群公告
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpcreate(rcs_state* R,int id,const char* resourcelists,const char* subject,const char* introduce,const char* bulletin);


/**
 * @brief 发送消息报告
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param number 消息报告接收者
 * @param message_id 消息Id
 * @param report_type 送达报告类型 @see {ReportType}
 * @param directed_type 定向消息类型 @see {DirectedType}
 * @param target 送达报告类型是群消息已送达、已读时,此字段需要填写群消息发送方的Uid,其它报告类型此字段填NULL
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_msgsendreport(rcs_state* R,int id,const char* number,const char* message_id,int report_type,int directed_type,const char* target);


/**
 * @brief 查询用户在线状态、能力
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param user 被查询用户Id/号码
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_capsexchange(rcs_state* R,int id,const char* user);



RCSAPI int rcs_gpsublist(rcs_state* R,int id,const char* version);


/**
 * @brief 关闭用户Push通知
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_disablepush(rcs_state* R,int id);


/**
 * @brief provision
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param username 用户名
 * @param pwd 密码
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_provision(rcs_state* R,int id,const char* username,const char* pwd);


/**
 * @brief setdmurl
 * @param R rcs_state, RCS 实例
 * @param host
 * @param port
 * @param sslPort
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_setdmurl(rcs_state* R,int id,const char* host,const char* port,const char* sslPort);


/**
 * @brief 退出群
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群Uri
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpquit(rcs_state* R,int id,const char* group_uri);


/**
 * @brief 注销登录
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_logout(rcs_state* R,int id);


/**
 * @brief 添加好友
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param user 用户ID/好友
 * @param reason 请求好友原因/描述
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_buddyadd(rcs_state* R,int id,const char* user,const char* reason);


/**
 * @brief 踢设备下线
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param client_id 客户端ID
 * @param client_type 客户端类型  @see {ClientType}
 * @param client_version 客户端版本
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_bootendpoint(rcs_state* R,int id,const char* client_id,int client_type,const char* client_version);


/**
 * @brief 订阅群信息
 *
 * 通过该方法获取群组详细信息，通过 GroupInfoSession/ Listener 获得群信息 TODO
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群Uri
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpsubinfo(rcs_state* R,int id,const char* group_uri);


/**
 * @brief 删除群成员
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群Uri
 * @param target 被删除用户ID，注意：这里必须是用户ID
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpremovemember(rcs_state* R,int id,const char* group_uri,const char* target);


/**
 * @brief 停止实例
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @return int
 *
 */
RCSAPI int rcs_stop(rcs_state* R,int id);


/**
 * @brief 发送文本信息
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param number 用户Id
 * @param message_id 消息Id，全局唯一；消息送达报告等都通过该ID匹配，建议使用 UUID
 * @param content 消息内容；大小小于 10KB
 * @param need_report 是否需要送达报告
 * @param is_burn 是否阅后即焚
 * @param directed_type 定向消息类型  @see {DirectedType}
 * @param need_read_report 是否需要已读报告
 * @param extension 扩展字段（由客户端自定义,服务端透传）
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_msgsendtext(rcs_state* R,int id,const char* number,const char* message_id,const char* content,int need_report,int is_burn,int directed_type,int need_read_report,const char* extension);


/**
 * @brief 设置PUSH 消息未读条数
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param badge 未读数
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_setpushbadge(rcs_state* R,int id,int badge);


/**
 * @brief 加入群组
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群组Uri
 * @param inviter 原邀请者ID
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpjoin(rcs_state* R,int id,const char* group_uri,const char* inviter);


/**
 * @brief 发送群组文本信息
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群组Uri
 * @param message_id 消息Id，全局唯一；消息送达报告等都通过该ID匹配，建议使用 UUID
 * @param content 消息内容；大小小于 10KB
 * @param need_report 是否需要送达报告
 * @param ccNumber 提醒人ID/号码 暂时无效,填NULL
 * @param need_read_report 是否需要已读报告
 * @param extension 扩展字段（由客户端自定义,服务端透传）
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_msggpsendtext(rcs_state* R,int id,const char* group_uri,const char* message_id,const char* content,int need_report,const char* ccNumber,int need_read_report,const char* extension);


/**
 * @brief 删除好友
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param userId 本删除好友UserId
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_buddydel(rcs_state* R,int id,int userId);


/**
 * @brief provisiondm
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param number
 * @param token
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_provisiondm(rcs_state* R,int id,const char* number,const char* token);


/**
 * @brief 获取用户概要信息，支持批量获取
 *
 * 更多用以得到好友列表之后，批量获取概要信息
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param ids 用户Id，以分号`;` 间隔
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_usergetinfo(rcs_state* R,int id,const char* ids);


/**
 * @brief 获取设备列表
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_getendpointlist(rcs_state* R,int id);


/**
 * @brief 设置用户Push通知
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param token 设备token值
 * @param server_type 推送服务器类型 1: APNS（默认） 2:GCM  3:小米 [可选]
 * @param show_preview 是否显示消息摘要 0: 不显示 1: 显示（默认）[可选]
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_setpush(rcs_state* R,int id,const char* token,int server_type,int show_preview);


/**
 * @brief 发送群组文件类型消息
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群Uri
 * @param message_id 消息Id
 * @param file_path 文件路径
 * @param content_type 文件类型  @see {ContentType}
 * @param file_name 文件名
 * @param need_report 是否需要送达报告
 * @param start 文件内容 offset，0 开始
 * @param thumbnail 缩略图路径，如果发送的是图片/视频，需要发送这个字段，图片最大10KB
 * @param need_read_report 是否需要已读报告
 * @param extension 扩展字段（由客户端自定义,服务端透传）
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_msggpsendfile(rcs_state* R,int id,const char* group_uri,const char* message_id,const char* file_path,int content_type,const char* file_name,int need_report,int start,const char* thumbnail,int need_read_report,const char* extension);


/**
 * @brief 获取用户Token
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_token(rcs_state* R,int id);


/**
 * @brief 处理添加好友请求
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param userId 好友UserId
 * @param accept 是否同意
 * @param reason 原因
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_buddyhandle(rcs_state* R,int id,int userId,int accept,const char* reason);


/**
 * @brief 登录
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param username 用户号码
 * @param password 密码
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_login(rcs_state* R,int id,const char* username,const char* password);


/**
 * @brief doconnect
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @return int
 *
 */
RCSAPI int rcs_doconnect(rcs_state* R,int id);


/**
 * @brief 删除群组
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群Uri
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpdelete(rcs_state* R,int id,const char* group_uri);


/**
 * @brief 备注好友信息
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param userId 用户userId
 * @param memo 备注名
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_buddymemo(rcs_state* R,int id,int userId,const char* memo);


/**
 * @brief 设置头像
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param filePath 头像文件路径
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_usersetportrait(rcs_state* R,int id,const char* file_path);


/**
 * @brief 设置富媒体消息状态,用于同步其他端
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param number 消息发送者
 * @param message_id 消息Id
 * @param msgstate 文件状态  1:已打开 (如媒体文件已经播放) 2:已删除 (如媒体文件已删除)
 * @param chat_type 聊天类型，@see {ChatType}
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_msgsetstatus(rcs_state* R,int id,const char* number,const char* message_id,int msgstate,int chat_type);


/**
 * @brief 设置个人用户信息
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param nickname 用户昵称
 * @param impresa 用户签名
 * @param firstname 名
 * @param lastname 姓
 * @param gender 性别: 1 男，2 女，0未设置
 * @param email 邮箱
 * @param birthday 生日：格式 YYYY-MM-DD，例如： 1986-04-22
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_usersetprofile(rcs_state* R,int id,const char* nickname,const char* impresa,const char* firstname,const char* lastname,int gender,const char* email,const char* birthday);


/**
 * @brief 获取用户详细信息
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param user 用户Id/号码
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_usergetprofile(rcs_state* R,int id,const char* user);


/**
 * @brief 删除设备信息
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param client_id 客户端ID
 * @param client_type 客户端类型  @see {ClientType}
 * @param client_version 客户端版本
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_deleteendpoint(rcs_state* R,int id,const char* client_id,int client_type,const char* client_version);


/**
 * @brief 下载富文本文件
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param number 用户Id
 * @param message_id 消息Id
 * @param chatType 聊天类型，@see {ChatType}
 * @param file_path 文件保存路径
 * @param content_type 文件类型 @see {ContentType}
 * @param file_name 文件名称
 * @param transfer_id 文件传输Id
 * @param start 开始传送位置
 * @param file_size 文件大小
 * @param hash 文件Hash值
 * @param is_burn 是否阅后即焚
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_msgfetchfile(rcs_state* R,int id,const char* number,const char* message_id,int chat_type,const char* file_path,int content_type,const char* file_name,const char* transfer_id,int start,int file_size,const char* hash,int is_burn);


/**
 * @brief 获取短信验证码
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param number 手机号
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_getsmscode(rcs_state* R,int id,const char* number);


/**
 * @brief provisionotp
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param smscode
 * @param username
 * @param otp
 * @param sessid
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_provisionotp(rcs_state* R,int id,const char* smscode,const char* username,const char* otp,const char* sessid);


/**
 * @brief 修改群名
 *
 * @param group_uri 群Uri
 * @param subject 群名
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpmodifysubject(rcs_state* R,int id,const char* group_uri,const char* subject);


/**
 * @brief 转移群管理员
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群Uri
 * @param target 接收者 UserId
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpchangemanager(rcs_state* R,int id,const char* group_uri,const char* target);


/**
 * @brief 设置群内昵称
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群Uri
 * @param nickname 群匿称
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpmodifynickname(rcs_state* R,int id,const char* group_uri,const char* nickName);


/**
 * @brief 获取用户头像
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param userId 用户Id
 * @param isSmall 是否是获取小头像；建议在显示列表的时候获取小头像，速度更快
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_usergetportrait(rcs_state* R,int id,int userId,int isSmall);


/**
 * @brief 修改群名
 *
 * @param group_uri 群Uri
 * @param subject 群公告
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpmodifybulletin(rcs_state* R,int id,const char* group_uri,const char* bulletin);


/**
 * @brief 拒绝加入群组
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param group_uri 群组Uri
 * @param inviter 原邀请者ID
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpreject(rcs_state* R,int id,const char* group_uri,const char* inviter);


/**
 * @brief 设置会话状态,用于同步其他端
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param conv_id 为客户端会话Id，Uid 或 GroupId
 * @param message_id 消息Id
 * @param convstate 会话状态  1:会话已读 2:会话删除
 * @param chat_type 聊天类型，@see {ChatType}
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_msgsetconvstatus(rcs_state* R,int id,const char* conv_id,const char* message_id,int convstate,int chat_type);


/**
 * @brief 修改群名
 *
 * @param group_uri 群Uri
 * @param subject 群简介
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_gpmodifyintroduce(rcs_state* R,int id,const char* group_uri,const char* introduce);


/**
 * @brief 发送文件
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @param id 任务id,调用rcs_new_command_id生成,用于客户端匹配是哪次api调用
 * @param number 接收者号码/UserId
 * @param messageId 消息Id
 * @param filePath 文件路径
 * @param contentType 文件类型 @see {ContentType}
 * @param fileName 文件名
 * @param needReport 是否需要送达报告
 * @param start 文件内容 offset，0 开始
 * @param thumbnail 缩略图路径，如果发送的是图片/视频，需要发送这个字段，图片最大10KB
 * @param isBurn 是否是阅后即焚消息
 * @param directedType 定向消息类型 @see {DirectedType}
 * @param needReadReport 是否需要已读报告
 * @param extension 扩展字段（由客户端自定义,服务端透传）
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
RCSAPI int rcs_msgsendfile(rcs_state* R,int id,const char* number,const char* message_id,const char* file_path,int content_type,const char* file_name,int need_report,int start,const char* thumbnail,int is_burn,int directed_type,int need_read_report,const char* extension);


#ifdef __cplusplus
}

#endif

#endif

