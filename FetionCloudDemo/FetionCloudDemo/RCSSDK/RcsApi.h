/**
 * @file RcsApi.h
 * @brief RCS API 包含了所有的RCS SDK的接口,包括SDK 初始化、RCS 能力接口、回调、通知等
 *  同时也可以多 SDK 实例同时使用，需要调用方维护好 rcs_state 的关系
 * @author http://www.interrcs.com/
 * @date 2016/04/27
 * @version 1.0.0
 * @copyright interrcs
 */

#import <Foundation/Foundation.h>
#include "rcs_api.h"
#import "rcs_entity.h"
#import "rcs_enum.h"

/**
 * @interface RcsApi
 * @brief RcsApi 接口
 * 该头文件包含了所有的RCS SDK的接口，包括SDK 初始化、RCS能力接口、回调、通知等等,目前SDK已经具备了支持多用户同时使用的能力,
 *
 * SDK的初始化，通过调用init来实现，
 * SDK 中的业务，包含两大类:
 * 主动调用 主动调用类型操作，需要注册Callback回调接口,处理主动调用的返回结果,返回数据在Result数据里
 * 事件通知 事件通知类型操作, 需要注册Listener通知接口,处理服务端推送过来的事件,事件数据在Session数据里
 *
 * 使用的一般流程:
 * 1.调用initSdk方法获取rcs_state对象
 * 2.可以发起主动业务请求,在对应的Callback回调里处理返回结果
 * 3.注册的事件通知里已经能收到事件了
 *
 */
@interface RcsApi : NSObject {}

/**
 * @brief 客户端调用usersetportrait、usergetportrait头像操作应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s UserPortraitResult 头像处理结果 @see {UserPortraitResult}
 * @return void
 *
 */
typedef void (^CUserPortraitResult)(rcs_state* R,UserPortraitResult* s);

/**
 * @brief 客户端调用默认应答回调,用于未指定回调函数时调用
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ActionResult 操作结果 @see {ActionResult}
 * @return void
 *
 */
typedef void (^CActionResult)(rcs_state* R,ActionResult* s);

/**
 * @brief 客户端调用gpcreate、gpdelete、gpinvitemember、gpremovemember、gpjoin、gpquit、gpsublist、
 *  gpsubinfo、gpmodifynickname、gpchangemanager、gpmodifysubject、gpreject群组操作应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s GroupResult 群组相关操作的结果 @see {GroupResult}
 * @return void
 *
 */
typedef void (^CGroupResult)(rcs_state* R,GroupResult* s);

/**
 * @brief 客户端调用音视频通话应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s AVResult 音视频操作结果 @see {AVResult}
 * @return void
 *
 */
typedef void (^CAVResult)(rcs_state* R,AVResult* s);

/**
 * @brief 客户端调用buddyadd、buddydel、buddyhandle、buddymemo好友操作接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s BuddyResult 好友操作的结果 @see {BuddyResult}
 * @return void
 *
 */
typedef void (^CBuddyResult)(rcs_state* R,BuddyResult* s);

/**
 * @brief 客户端调用deleteendpoint、bootendpoint应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ActionResult 操作结果 @see {ActionResult}
 * @return void
 *
 */
typedef void (^CActionResult)(rcs_state* R,ActionResult* s);

/**
 * @brief 客户端调用login登录接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s LoginResult 登录操作结果 @see {LoginResult}
 * @return void
 *
 */
typedef void (^CLoginResult)(rcs_state* R,LoginResult* s);

/**
 * @brief 客户端调用getsmscode获取短信回调应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s GetSmsResult 获取短信验证码的结果 @see {GetSmsResult}
 * @return void
 *
 */
typedef void (^CGetSmsResult)(rcs_state* R,GetSmsResult* s);

/**
 * @brief 客户端调用msgsetstatus、msgsetconvstatus应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ActionResult 操作结果 @see {ActionResult}
 * @return void
 *
 */
typedef void (^CActionResult)(rcs_state* R,ActionResult* s);

/**
 * @brief 客户端调用provision、provisiondm、provisionotp注册接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ProvisionResult 注册操作结果 @see {ProvisionResult}
 * @return void
 *
 */
typedef void (^CProvisionResult)(rcs_state* R,ProvisionResult* s);

/**
 * @brief 客户端调用msgsendtext、msggpsendtext、msgsendfile、msggpsendfile、msgfetchfile、
 *  msgpubsendtext、msgsendreport、msggpsendvemoticon、msgsendcloudfile发送消息接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s MessageResult 消息发送结果 @see {MessageResult}
 * @return void
 *
 */
typedef void (^CMessageResult)(rcs_state* R,MessageResult* s);

/**
 * @brief 客户端调用setpush、disablepush应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s ActionResult 操作结果 @see {ActionResult}
 * @return void
 *
 */
typedef void (^CActionResult)(rcs_state* R,ActionResult* s);

/**
 * @brief 客户端调用usergetinfo用户概要信息接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s UserInfoResult 用户信息操作的结果 @see {UserInfoResult}
 * @return void
 *
 */
typedef void (^CUserInfoResult)(rcs_state* R,UserInfoResult* s);

/**
 * @brief 客户端调用get_endpoint_list应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s EndpointResult 操作结果 @see {EndpointResult}
 * @return void
 *
 */
typedef void (^CEndpointResult)(rcs_state* R,EndpointResult* s);

/**
 * @brief 客户端调用searchgroup搜索群组信息应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s SearchGroupResult 搜索群组的结果 @see {SearchGroupResult}
 * @return void
 *
 */
typedef void (^CSearchGroupResult)(rcs_state* R,SearchGroupResult* s);

/**
 * @brief 客户端调用token获取Token应答回调
 *  客户端调用上述接口后,需要在此注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s TokenResult 获取Token的结果 @see {TokenResult}
 * @return void
 *
 */
typedef void (^CTokenResult)(rcs_state* R,TokenResult* s);

/**
 * @brief 客户端调用capsexchange能力查询接口应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s CapsResult 获取用户能力的结果,1为支持，0为不支持 @see {CapsResult}
 * @return void
 *
 */
typedef void (^CCapsResult)(rcs_state* R,CapsResult* s);

/**
 * @brief 客户端调用usersetprofile、usergetprofile用户详细信息应答回调
 *  客户端调用上述接口后,需要在注册的回调函数里处理上述业务应答
 * @param R rcs_state, RCS 实例
 * @param s UserProfileResult 用户详细信息操作结果 @see {UserProfileResult}
 * @return void
 *
 */
typedef void (^CUserProfileResult)(rcs_state* R,UserProfileResult* s);

/**
 * @brief 服务端推送群组详细信息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s GroupSession 群组详细信息 @see {GroupSession}
 * @return void
 *
 */
typedef void (^CGroupInfo)(rcs_state* R,GroupSession* s);

/**
 * @brief 服务端推送富文本消息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageFTSession 文件消息 @see {MessageFTSession}
 * @return void
 *
 */
typedef void (^CMessageFT)(rcs_state* R,MessageFTSession* s);

/**
 * @brief 服务端推送音视频通话事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s AvSession 音视频通话的状态 @see {AvSession}
 * @return void
 *
 */
typedef void (^CAVEvent)(rcs_state* R,AvSession* s);

/**
 * @brief 服务端推送好友操作事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s BuddyEventSession 好友关系操作信息 @see {BuddyEventSession}
 * @return void
 *
 */
typedef void (^CBuddyEvent)(rcs_state* R,BuddyEventSession* s);

/**
 * @brief 服务端推送用户会话状态同步事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MsgConvStatusSession 会话状态同步信息 @see {MsgConvStatusSession}
 * @return void
 *
 */
typedef void (^CMsgConvStatus)(rcs_state* R,MsgConvStatusSession* s);

/**
 * @brief 服务端推送群列表变更事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s GroupListSession 群列表的信息 @see {GroupListSession}
 * @return void
 *
 */
typedef void (^CGroupList)(rcs_state* R,GroupListSession* s);

/**
 * @brief 服务端推送群组通知的信息 这个类型中,描述的是群组其他人发生的和自己无关,不需要额外处理群操作事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s GroupNotificationSession 群组通知的信息 @see {GroupNotificationSession}
 * @return void
 *
 */
typedef void (^CGroupNotify)(rcs_state* R,GroupNotificationSession* s);

/**
 * @brief 服务端推送商店表情消息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageEmoticonSession 商店表情的消息 @see {MessageEmoticonSession}
 * @return void
 *
 */
typedef void (^CMessageEmoticon)(rcs_state* R,MessageEmoticonSession* s);

/**
 * @brief 服务端推送自定义消息,SDK直接透传不处理事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageCustomSession 自定义消息,SDK只作透传,不处理 @see {MessageCustomSession}
 * @return void
 *
 */
typedef void (^CMessageCustom)(rcs_state* R,MessageCustomSession* s);

/**
 * @brief 服务端推送用户强制下线通知事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s LogoutSession 强制下线信息 @see {LogoutSession}
 * @return void
 *
 */
typedef void (^CLogout)(rcs_state* R,LogoutSession* s);

/**
 * @brief 服务端推送好友列表事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s BuddyListSession 好友列表信息 @see {BuddyListSession}
 * @return void
 *
 */
typedef void (^CBuddyList)(rcs_state* R,BuddyListSession* s);

/**
 * @brief 服务端推送SINGLE(一对一聊天)、GROUP(群组聊天)、PUBLIC_ACCOUNT(公众账号消息)、
 *  BROADCAST(广播消息)、DIRECTED(定向消息)文本消息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageTextSession 文本消息 @see {MessageTextSession}
 * @return void
 *
 */
typedef void (^CMessageText)(rcs_state* R,MessageTextSession* s);

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
typedef void (^CGroupEvent)(rcs_state* R,GroupEventSession* s);

/**
 * @brief 服务端推送消息状态变化事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MsgStatusSession 消息状态变化信息 @see {MsgStatusSession}
 * @return void
 *
 */
typedef void (^CMsgStatus)(rcs_state* R,MsgStatusSession* s);

/**
 * @brief 服务端推送用户在线期间其他端上下线时通知事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s EndpointChangedSession 变化登录点信息 @see {EndpointChangedSession}
 * @return void
 *
 */
typedef void (^CEpChanged)(rcs_state* R,EndpointChangedSession* s);

/**
 * @brief 服务端推送彩云文件消息事件监听器
 *  客户端接收到上述事件后,需要在注册的监听函数里处理上述事件
 * @param R rcs_state, RCS 实例
 * @param s MessageCloudFileSession 彩云文件的消息 @see {MessageCloudFileSession}
 * @return void
 *
 */
typedef void (^CMessageCloudFile)(rcs_state* R,MessageCloudFileSession* s);

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
typedef void (^CMessageReport)(rcs_state* R,MessageReportSession* s);


//所有的listener必须在调用所有api之前设置为有效值

@property (nonatomic,copy) CGroupInfo groupInfoListener;
@property (nonatomic,copy) CMessageFT msgFtListener;
@property (nonatomic,copy) CAVEvent avEventListener;
@property (nonatomic,copy) CBuddyEvent buddyEventListener;
@property (nonatomic,copy) CMsgConvStatus msgConvStatusListener;
@property (nonatomic,copy) CGroupList groupListListener;
@property (nonatomic,copy) CGroupNotify groupNotifyListener;
@property (nonatomic,copy) CMessageEmoticon msgEmoticonListener;
@property (nonatomic,copy) CMessageCustom msgCustomListener;
@property (nonatomic,copy) CLogout logoutListener;
@property (nonatomic,copy) CBuddyList buddyListListener;
@property (nonatomic,copy) CMessageText msgTextListener;
@property (nonatomic,copy) CGroupEvent groupEventListener;
@property (nonatomic,copy) CMsgStatus msgStatusListener;
@property (nonatomic,copy) CEpChanged epChangedListener;
@property (nonatomic,copy) CMessageCloudFile msgCloudfileListener;
@property (nonatomic,copy) CMessageReport msgReportListener;

@property NSMutableDictionary* cbDict;
@property NSLock* lock;
@property NSMutableSet* stateSet;

/**
 * @brief RcsApi初始化 此处采用单例模式,防止使用时重复创建
 *
 * 使用 SDK 第一步是初始化RcsApi初始化，然后调用newState，可以得到rcs实例(struct rcs_state), 做为后续业务操作的参数。同时也可以多rcs实例同时使用，需要调用方维护好 rcs_state 的关系
 * @return RcsApi, RcsApi单例对象
 *
 */
+ (RcsApi*)shareInstance;

/**
 * @brief 创建rcs_state对象
 *
 * @param number 用户号码
 * @param appid 用户所属组织Id
 * @param clientVendor 客户端厂商名称
 * @param clientVersion 客户端版本号
 * @param storagePath 文件存储路径
 * @param sysPath 配置文件存储路径
 * @return rcs_state, rcs 实例
 */
- (rcs_state*) newState:(NSString*)number appId:(NSString *)appId clientVendor:(NSString*)clientVendor clientVersion:(NSString*)clientVersion storagePath:(NSString *)storagePath sysPath:(NSString *)sysPath;

/**
 * @brief 停止实例
 *
 * @param R rcs_state, RCS 实例
 * @return int
 *
 */
-(int) stop:(rcs_state*)R;

/**
 * @brief 注销登录
 *
 * @param R rcs_state, RCS 实例，通过 rcs_init 方法初始化
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) logout:(rcs_state*)R;

/**
 * @brief sdk网络重连
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @return int
 *
 */
-(int) doconnect:(rcs_state*)R;

/**
 * @brief 邀请人加入群
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param groupUri 群Uri
 * @param target 被邀请用户
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpinvitemember:(rcs_state*)R groupUri:(NSString*)groupUri target:(NSString*)target callback:(CGroupResult)cb;

/**
 * @brief 按照群名称搜索群组
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param subject 群名称
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpsearch:(rcs_state*)R subject:(NSString*)subject callback:(CGroupResult)cb;

/**
 * @brief 创建群组
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param resourcelist 群成员列表，用户id/号码以分号间隔
 * @param subject 群名称
 * @param subject 群简介
 * @param subject 群公告
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpcreate:(rcs_state*)R resourcelists:(NSString*)resourcelists subject:(NSString*)subject introduce:(NSString*)introduce bulletin:(NSString*)bulletin callback:(CGroupResult)cb;

/**
 * @brief 发送消息报告
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param number 消息报告接收者
 * @param message_id 消息Id
 * @param report_type 送达报告类型 @see {ReportType}
 * @param directed_type 定向消息类型 @see {DirectedType}
 * @param target 送达报告类型是群消息已送达、已读时,此字段需要填写群消息发送方的Uid,其它报告类型此字段填NULL
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) msgsendreport:(rcs_state*)R number:(NSString*)number messageId:(NSString*)messageId reportType:(ReportType)reportType directedType:(DirectedType)directedType target:(NSString*)target callback:(CMessageResult)cb;

/**
 * @brief 查询用户在线状态、能力
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param user 被查询用户Id/号码
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) capsexchange:(rcs_state*)R user:(NSString*)user callback:(CCapsResult)cb;


-(int) gpsublist:(rcs_state*)R version:(NSString*)version callback:(CGroupResult)cb;

/**
 * @brief 关闭用户Push通知
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) disablepush:(rcs_state*)R callback:(CActionResult)cb;

/**
 * @brief provision
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param username 用户名
 * @param pwd 密码
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) provision:(rcs_state*)R username:(NSString*)username pwd:(NSString*)pwd callback:(CProvisionResult)cb;

/**
 * @brief setdmurl
 * @param R rcs_state, RCS 实例
 * @param host
 * @param port
 * @param sslPort
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) setdmurl:(rcs_state*)R host:(NSString*)host port:(NSString*)port sslPort:(NSString*)sslPort callback:(CActionResult)cb;

/**
 * @brief 退出群
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param group_uri 群Uri
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpquit:(rcs_state*)R groupUri:(NSString*)groupUri callback:(CGroupResult)cb;

/**
 * @brief 添加好友
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param user 用户ID/好友
 * @param reason 请求好友原因/描述
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) buddyadd:(rcs_state*)R user:(NSString*)user reason:(NSString*)reason callback:(CBuddyResult)cb;

/**
 * @brief 踢设备下线
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param client_id 客户端ID
 * @param client_type 客户端类型  @see {ClientType}
 * @param client_version 客户端版本
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) bootendpoint:(rcs_state*)R clientId:(NSString*)clientId clientType:(ClientType)clientType clientVersion:(NSString*)clientVersion callback:(CActionResult)cb;

/**
 * @brief 订阅群信息
 *
 * 通过该方法获取群组详细信息，通过 GroupInfoSession/ Listener 获得群信息 TODO
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param group_uri 群Uri
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpsubinfo:(rcs_state*)R groupUri:(NSString*)groupUri callback:(CGroupResult)cb;

/**
 * @brief 删除群成员
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param group_uri 群Uri
 * @param target 被删除用户ID，注意：这里必须是用户ID
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpremovemember:(rcs_state*)R groupUri:(NSString*)groupUri target:(NSString*)target callback:(CGroupResult)cb;

/**
 * @brief 发送文本信息
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param number 用户Id
 * @param message_id 消息Id，全局唯一；消息送达报告等都通过该ID匹配，建议使用 UUID
 * @param content 消息内容；大小小于 10KB
 * @param need_report 是否需要送达报告
 * @param is_burn 是否阅后即焚
 * @param directed_type 定向消息类型  @see {DirectedType}
 * @param need_read_report 是否需要已读报告
 * @param extension 扩展字段（由客户端自定义,服务端透传）
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) msgsendtext:(rcs_state*)R number:(NSString*)number messageId:(NSString*)messageId content:(NSString*)content needReport:(BOOL)needReport isBurn:(BOOL)isBurn directedType:(DirectedType)directedType needReadReport:(BOOL)needReadReport extension:(NSString*)extension callback:(CMessageResult)cb;

/**
 * @brief 设置PUSH 消息未读条数
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param badge 未读数
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) setpushbadge:(rcs_state*)R badge:(int)badge callback:(CActionResult)cb;

/**
 * @brief 加入群组
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param group_uri 群组Uri
 * @param inviter 原邀请者ID
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpjoin:(rcs_state*)R groupUri:(NSString*)groupUri inviter:(NSString*)inviter callback:(CGroupResult)cb;

/**
 * @brief 发送群组文本信息
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param group_uri 群组Uri
 * @param message_id 消息Id，全局唯一；消息送达报告等都通过该ID匹配，建议使用 UUID
 * @param content 消息内容；大小小于 10KB
 * @param need_report 是否需要送达报告
 * @param ccNumber 提醒人ID/号码 暂时无效,填NULL
 * @param need_read_report 是否需要已读报告
 * @param extension 扩展字段（由客户端自定义,服务端透传）
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) msggpsendtext:(rcs_state*)R groupUri:(NSString*)groupUri messageId:(NSString*)messageId content:(NSString*)content needReport:(BOOL)needReport ccNumber:(NSString*)ccNumber needReadReport:(BOOL)needReadReport extension:(NSString*)extension callback:(CMessageResult)cb;

/**
 * @brief 删除好友
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param userId 本删除好友UserId
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) buddydel:(rcs_state*)R userId:(int)userId callback:(CBuddyResult)cb;

/**
 * @brief provisiondm
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param number
 * @param token
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) provisiondm:(rcs_state*)R number:(NSString*)number token:(NSString*)token callback:(CProvisionResult)cb;

/**
 * @brief 获取用户概要信息，支持批量获取
 *
 * 更多用以得到好友列表之后，批量获取概要信息
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param ids 用户Id，以分号`;` 间隔
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) usergetinfo:(rcs_state*)R ids:(NSString*)ids callback:(CUserInfoResult)cb;

/**
 * @brief 获取设备列表
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) getendpointlist:(rcs_state*)R callback:(CActionResult)cb;

/**
 * @brief 设置用户Push通知
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param token 设备token值
 * @param server_type 推送服务器类型 1: APNS（默认） 2:GCM  3:小米 [可选]
 * @param show_preview 是否显示消息摘要 0: 不显示 1: 显示（默认）[可选]
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) setpush:(rcs_state*)R token:(NSString*)token serverType:(ServerType)serverType showPreview:(int)showPreview callback:(CActionResult)cb;

/**
 * @brief 发送群组文件类型消息
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
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
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) msggpsendfile:(rcs_state*)R groupUri:(NSString*)groupUri messageId:(NSString*)messageId filePath:(NSString*)filePath contentType:(ContentType)contentType fileName:(NSString*)fileName needReport:(BOOL)needReport start:(int)start thumbnail:(NSString*)thumbnail needReadReport:(BOOL)needReadReport extension:(NSString*)extension callback:(CMessageResult)cb;

/**
 * @brief 获取用户Token
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) token:(rcs_state*)R callback:(CTokenResult)cb;

/**
 * @brief 处理添加好友请求
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param userId 好友UserId
 * @param accept 是否同意
 * @param reason 原因
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) buddyhandle:(rcs_state*)R userId:(int)userId accept:(BOOL)accept reason:(NSString*)reason callback:(CBuddyResult)cb;

/**
 * @brief 登录
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param username 用户号码
 * @param password 密码
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) login:(rcs_state*)R username:(NSString*)username password:(NSString*)password callback:(CLoginResult)cb;

/**
 * @brief 删除群组
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param group_uri 群Uri
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpdelete:(rcs_state*)R groupUri:(NSString*)groupUri callback:(CGroupResult)cb;

/**
 * @brief 备注好友信息
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param userId 用户userId
 * @param memo 备注名
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) buddymemo:(rcs_state*)R userId:(int)userId memo:(NSString*)memo callback:(CBuddyResult)cb;

/**
 * @brief 设置头像
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param filePath 头像文件路径
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) usersetportrait:(rcs_state*)R filePath:(NSString*)filePath callback:(CUserPortraitResult)cb;

/**
 * @brief 设置富媒体消息状态,用于同步其他端
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param number 消息发送者
 * @param message_id 消息Id
 * @param msgstate 文件状态  1:已打开 (如媒体文件已经播放) 2:已删除 (如媒体文件已删除)
 * @param chat_type 聊天类型，@see {ChatType}
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) msgsetstatus:(rcs_state*)R number:(NSString*)number messageId:(NSString*)messageId msgstate:(int)msgstate chatType:(ChatType)chatType callback:(CMessageResult)cb;

/**
 * @brief 设置个人用户信息
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param nickname 用户昵称
 * @param impresa 用户签名
 * @param firstname 名
 * @param lastname 姓
 * @param gender 性别: 1 男，2 女，0未设置
 * @param email 邮箱
 * @param birthday 生日：格式 YYYY-MM-DD，例如： 1986-04-22
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) usersetprofile:(rcs_state*)R nickname:(NSString*)nickname impresa:(NSString*)impresa firstname:(NSString*)firstname lastname:(NSString*)lastname gender:(int)gender email:(NSString*)email birthday:(NSString*)birthday callback:(CUserProfileResult)cb;

/**
 * @brief 获取用户详细信息
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param user 用户Id/号码
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) usergetprofile:(rcs_state*)R user:(NSString*)user callback:(CUserProfileResult)cb;

/**
 * @brief 删除设备信息
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param client_id 客户端ID
 * @param client_type 客户端类型  @see {ClientType}
 * @param client_version 客户端版本
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) deleteendpoint:(rcs_state*)R clientId:(NSString*)clientId clientType:(ClientType)clientType clientVersion:(NSString*)clientVersion callback:(CActionResult)cb;

/**
 * @brief 下载富文本文件
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
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
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) msgfetchfile:(rcs_state*)R number:(NSString*)number messageId:(NSString*)messageId chatType:(ChatType)chatType filePath:(NSString*)filePath contentType:(ContentType)contentType fileName:(NSString*)fileName transferId:(NSString*)transferId start:(int)start fileSize:(int)fileSize hash:(NSString*)hash isBurn:(BOOL)isBurn callback:(CMessageResult)cb;

/**
 * @brief 获取短信验证码
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param number 手机号
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) getsmscode:(rcs_state*)R number:(NSString*)number callback:(CGetSmsResult)cb;

/**
 * @brief provisionotp
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param smscode
 * @param username
 * @param otp
 * @param sessid
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) provisionotp:(rcs_state*)R smscode:(NSString*)smscode username:(NSString*)username otp:(NSString*)otp sessid:(NSString*)sessid callback:(CProvisionResult)cb;

/**
 * @brief 修改群名
 *
 * @param group_uri 群Uri
 * @param subject 群名
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpmodifysubject:(rcs_state*)R groupUri:(NSString*)groupUri subject:(NSString*)subject callback:(CGroupResult)cb;

/**
 * @brief 转移群管理员
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param group_uri 群Uri
 * @param target 接收者 UserId
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpchangemanager:(rcs_state*)R groupUri:(NSString*)groupUri target:(NSString*)target callback:(CGroupResult)cb;

/**
 * @brief 设置群内昵称
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param group_uri 群Uri
 * @param nickname 群匿称
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpmodifynickname:(rcs_state*)R groupUri:(NSString*)groupUri nickName:(NSString*)nickName callback:(CGroupResult)cb;

/**
 * @brief 获取用户头像
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param userId 用户Id
 * @param isSmall 是否是获取小头像；建议在显示列表的时候获取小头像，速度更快
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) usergetportrait:(rcs_state*)R userId:(int)userId isSmall:(BOOL)isSmall callback:(CUserPortraitResult)cb;

/**
 * @brief 修改群名
 *
 * @param group_uri 群Uri
 * @param subject 群公告
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpmodifybulletin:(rcs_state*)R groupUri:(NSString*)groupUri bulletin:(NSString*)bulletin callback:(CGroupResult)cb;

/**
 * @brief 拒绝加入群组
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param group_uri 群组Uri
 * @param inviter 原邀请者ID
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpreject:(rcs_state*)R groupUri:(NSString*)groupUri inviter:(NSString*)inviter callback:(CGroupResult)cb;

/**
 * @brief 设置会话状态,用于同步其他端
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
 * @param conv_id 为客户端会话Id，Uid 或 GroupId
 * @param message_id 消息Id
 * @param convstate 会话状态  1:会话已读 2:会话删除
 * @param chat_type 聊天类型，@see {ChatType}
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) msgsetconvstatus:(rcs_state*)R convId:(NSString*)convId messageId:(NSString*)messageId convstate:(int)convstate chatType:(ChatType)chatType callback:(CMessageResult)cb;

/**
 * @brief 修改群名
 *
 * @param group_uri 群Uri
 * @param subject 群简介
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) gpmodifyintroduce:(rcs_state*)R groupUri:(NSString*)groupUri introduce:(NSString*)introduce callback:(CGroupResult)cb;

/**
 * @brief 发送文件
 *
 * @param R rcs_state, RCS 实例，通过 newState 生成
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
 * @param callback 操作结果回调
 * @return int 任务id,用于客户端匹配是哪次api调用,-1表示调用失败
 *
 */
-(int) msgsendfile:(rcs_state*)R number:(NSString*)number messageId:(NSString*)messageId filePath:(NSString*)filePath contentType:(ContentType)contentType fileName:(NSString*)fileName needReport:(BOOL)needReport start:(int)start thumbnail:(NSString*)thumbnail isBurn:(BOOL)isBurn directedType:(DirectedType)directedType needReadReport:(BOOL)needReadReport extension:(NSString*)extension callback:(CMessageResult)cb;


@end
