/**
 * @file  rcs_entity.h
 * @brief struct definition
 * @author http://www.interrcs.com/
 * @date 2016/04/27
 * @version 1.0.0
 * @copyright interrcs
 */

#ifndef _rcs_entity_h
#define _rcs_entity_h

typedef struct MessageReportSession MessageReportSession;
typedef struct GetSmsResult GetSmsResult;
typedef struct GroupEventSession GroupEventSession;
typedef struct UserInfoResult UserInfoResult;
typedef struct Group Group;
typedef struct UserInfo UserInfo;
typedef struct EndPoint EndPoint;
typedef struct UserProfileResult UserProfileResult;
typedef struct Conversation Conversation;
typedef struct LogoutResult LogoutResult;
typedef struct CapsResult CapsResult;
typedef struct AVResult AVResult;
typedef struct GroupNotificationSession GroupNotificationSession;
typedef struct ProvisionResult ProvisionResult;
typedef struct ActionResult ActionResult;
typedef struct LoginResult LoginResult;
typedef struct BuddyInfo BuddyInfo;
typedef struct MessageTextSession MessageTextSession;
typedef struct UserPortraitResult UserPortraitResult;
typedef struct MessageFTSession MessageFTSession;
typedef struct GroupResult GroupResult;
typedef struct EndpointChangedSession EndpointChangedSession;
typedef struct SearchGroupResult SearchGroupResult;
typedef struct Conference Conference;
typedef struct SearchGroupInfo SearchGroupInfo;
typedef struct AvSession AvSession;
typedef struct TokenResult TokenResult;
typedef struct MessageCustomSession MessageCustomSession;
typedef struct BuddyEventSession BuddyEventSession;
typedef struct EndpointResult EndpointResult;
typedef struct MsgConvStatusSession MsgConvStatusSession;
typedef struct MemberInfo MemberInfo;
typedef struct BuddyResult BuddyResult;
typedef struct MsgStatusSession MsgStatusSession;
typedef struct GroupSession GroupSession;
typedef struct GroupListSession GroupListSession;
typedef struct LogoutSession LogoutSession;
typedef struct MessageEmoticonSession MessageEmoticonSession;
typedef struct MessageCloudFileSession MessageCloudFileSession;
typedef struct AvCrypto AvCrypto;
typedef struct BuddyListSession BuddyListSession;
typedef struct MessageResult MessageResult;

/**
 * @brief 消息报告
 *
 * report_value仅在reportType为 UPDATE_MSG_ID 或者 FILE_PROGRESS 时使用. 分别表示该消息的唯一全局id, 和文件进度.
 *（文件进度格式: progress/total, 例如: 1024/2048）
 * 如果ReportType 是 UPDATE_MSG_ID，需要修改本地存储的消息唯一ID，原值是 imdn_id 修改为 report_value
 *
 */
struct MessageReportSession {
    const char* imdn_id; ///<消息唯一标识id
    const char* from_user; ///<发送用户
    int report_type; ///<消息报告类型，@see {ReportType}
    const char* report_value; ///<消息报告值
};

/**
 * @brief 获取短信验证码的结果
 *
 * error_code 解释：
 * 200: 成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct GetSmsResult {
    const char* session_id; ///<会话id，验证身份时使用，接下来调用provision时需要传入
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};

/**
 * @brief 此类用于记录群组通知事件的状态,这个类型中描述的事件都是与当前用户有关的信息
 *
 */
struct GroupEventSession {
    const char* source_nickname; ///<邀请者昵称
    int handle_result; ///<0: 未同意, 1: 已经同意, 2: 已经拒绝
    const char* group_uri; ///<群组标识
    int time; ///<UTC时间，单位秒
    const char* source; ///<邀请者
    int sid; ///<任务id,用于匹配是哪次api调用
    int event_type; ///<群组事件类型, @see {GroupEventType}
    const char* subject; ///<群名称
};

/**
 * @brief 记录用户信息操作的结果
 *
 * error_code 解释：
 * 200: 操作成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct UserInfoResult {
    UserInfo** user_infos; ///<用户信息结果 @see {UserInfo}
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};

/**
 * @brief 群组概要信息
 *
 */
struct Group {
    const char* uri; ///<群组标识
    int action; ///<数据变化类型，1为添加、2为删除、3为更新
    const char* subject; ///<群名
};

/**
 * @brief 用户概要信息
 *
 */
struct UserInfo {
    const char* impresa; ///<个性签名(心情短语)
    int user_id; ///<用户id
    const char* username; ///<用户名
    int portrait_version; ///<头像version，当前上传或者下载头像的 version
    const char* nickname; ///<昵称
};

/**
 * @brief 终端对象
 *
 */
struct EndPoint {
    int create_time; ///<设备激活时间
    const char* client_id; ///<客户端标识
    int client_type; ///<客户端类型
    const char* client_name; ///<客户端名称、服务器根据client_type配置，用于UI显示
    const char* client_version; ///<客户端版本
    int is_self; ///<是否自己设备 0: 否, 1 是
    const char* device_model; ///<设备Model
    int presence; ///<在线状态 -1 不在线 0	隐身或不在线 1	在线
    int client_caps; ///<客户端能力
    int last_active_time; ///<最后活跃时间
};

/**
 * @brief 用户详细信息操作结果
 *
 * error_code 解释：
 * 200: 操作成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct UserProfileResult {
    int gender; ///<性别，1：男，2：女，0：未知
    const char* nickname; ///<昵称
    const char* work_email; ///<邮箱
    const char* error_extra; ///<错误描述
    const char* lastname; ///<姓氏
    const char* impresa; ///<个性签名(心情短语)
    const char* birthday; ///<生日，1900-10-10
    const char* firstname; ///<名字
    int user_id; ///<用户id
    int portrait_version; ///<头像version，当前上传或者下载头像的 version
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* username; ///<用户名
    int error_code; ///<错误码
};

/**
 * @brief 此类描述会话状态信息
 *
 */
struct Conversation {
    const char* conv_id; ///<为客户端会话Id，为: Uid / GroupId
    const char* max_sole_id; ///<会话最大消息id
};

/**
 * @brief 登出操作结果
 *
 * error_code 解释：
 * 200: 操作成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct LogoutResult {
    const char* error_extra; ///<错误描述
    int sid; ///<任务id,用于匹配是哪次api调用
    int error_code; ///<错误码
};

/**
 * @brief 获取用户能力的结果,1为支持，0为不支持
 * 200: 成功
 * 404: 对方无能力
 * 408: 请求超时
 * 480: 对方离线
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct CapsResult {
    int video_call; ///<视频通话能力
    int voice_call; ///<语音通话能力
    const char* error_extra; ///<错误描述
    int ft; ///<文件传输能力
    int transient_msg; ///<阅后即焚能力
    int user_id; ///<用户id
    int group_chat; ///<群聊能力
    int sid; ///<任务id,用于匹配是哪次api调用
    int msg; ///<文本消息能力
    int error_code; ///<错误码
};

/**
 * @brief 音视频操作结果
 *
 * error_code 解释：
 * 200: 操作成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct AVResult {
    const char* session_id; ///<音视频会话Id
    int op; ///<音视频操作, @see {AvOpEnum}
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};

/**
 * @brief 此类保存了一个群组通知的信息.这个类型中,描述的是群组其他人发生的和自己无关,不需要额外处理
 *
 */
struct GroupNotificationSession {
    const char* source_nickname; ///<发起人名称
    const char* target; ///<目标用户
    int time; ///<UTC时间，单位秒
    const char* group_uri; ///<群组 URI
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* source; ///<通知发起用户
    int event_type; ///<事件类型, @see {GroupEventType}
    const char* target_nickname; ///<目标用户昵称
};

/**
 * @brief 使用短信验证码注册结果
 * 200: 成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct ProvisionResult {
    int user_id; ///<用户id
    const char* error_extra; ///<错误描述
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* client_id; ///<客户端ID
    int error_code; ///<错误码
};

/**
 * @brief 操作结果
 *
 * 200: 操作成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct ActionResult {
    const char* error_extra; ///<错误描述
    int sid; ///<任务id,用于匹配是哪次api调用
    int error_code; ///<错误码
};

/**
 * @brief 此类用于记录登录的结果
 *
 * error_code 解释：
 * 200: 登录成功
 * 403: 密码错误
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct LoginResult {
    const char* error_extra; ///<错误描述
    int sid; ///<任务id,用于匹配是哪次api调用
    int error_code; ///<错误码
};

/**
 * @brief 好友概要信息
 *
 */
struct BuddyInfo {
    UserInfo* user_info; ///<当action为ADD或者UPDATE的时候，该字段可用，@see {UserInfo}
    int user_id; ///<用户id
    int action; ///<好友信息变化动作
    const char* local_name; ///<备注名
};

/**
 * @brief 文本消息
 *
 */
struct MessageTextSession {
    const char* imdn_id; ///<消息id
    int is_silence; ///<是否需要静默
    int is_burn_report; ///<是否已发送已焚报告
    int is_delivered; ///<是否已投递
    int is_report; ///<是否已发送送达报告
    const char* extension; ///<扩展字段(由客户端自定义,服务端透传)
    const char* content; ///<文本内容
    int need_read_report; ///<是否需要已读报告
    int is_read; ///<是否已读
    int is_open; ///<是否已打开
    const char* to; ///<收信人id
    int is_read_report; ///<是否已发送已读报告
    int send_time; ///<发送时间
    int is_burn; ///<是否是阅后即焚
    const char* cc_number; ///<需要@的群成员号码，只在群消息中使用，分号分割
    int need_report; ///<是否需要送达报告
    int chat_type; ///<聊天类型，@see {ChatType}
    const char* contribution_id; ///<暂时没用
    int directed_type; ///<定向消息类型，@see {DirectedType}
    const char* from; ///<发信人id
    int need_burn_report; ///<是否需要已焚报告
};

/**
 * @brief 头像处理结果
 *
 * error_code 解释：
 * 200: 操作成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct UserPortraitResult {
    const char* file_path; ///<下载的头像保存路径
    int version; ///<头像版本
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};

/**
 * @brief 文件消息
 *
 */
struct MessageFTSession {
    const char* imdn_id; ///<消息id
    int is_silence; ///<是否需要静默
    int is_burn_report; ///<是否已发送已焚报告
    const char* file_path; ///<文件保存路径
    int is_delivered; ///<是否已投递
    int is_report; ///<是否已发送送达报告
    const char* file_name; ///<文件名
    const char* extension; ///<扩展字段(由客户端自定义,服务端透传)
    const char* cc_number; ///<需要@的群成员号码，只在群消息中使用，分号分割
    const char* file_hash; ///<文件hash值
    const char* transfer_id; ///<传输id，下载该文件时使用
    int file_size; ///<文件大小
    int need_read_report; ///<是否需要已读报告
    int is_read; ///<是否已读
    int is_open; ///<是否已打开
    const char* to; ///<收信人id
    int is_read_report; ///<是否已发送已读报告
    int send_time; ///<发送时间
    int is_burn; ///<是否是阅后即焚
    const char* thumbnail_path; ///<缩略图保存路径，只有图片和视频有效
    int need_report; ///<是否需要报告
    int chat_type; ///<聊天类型，@see {ChatType}
    const char* contribution_id; ///<暂时没用
    int directed_type; ///<定向消息类型，@see {DirectedType}
    const char* from; ///<发信人id
    int content_type; ///<内容类型，@see {ContentType}
};

/**
 * @brief 描述群组相关操作的结果
 *
 * error_code 解释：
 * 200: 操作成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct GroupResult {
    const char* group_uri; ///<群组Uri
    int op; ///<群组操作, @see {GroupOpEnum}
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};

/**
 * @brief 此类描述变化设备节点信息
 *
 */
struct EndpointChangedSession {
    int action; ///1. login 2. logout
    EndPoint* endpoint; ///<变化的登陆点
};

/**
 * @brief 群组搜索结果
 *
 * error_code 解释：
 * 200: 操作成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct SearchGroupResult {
    SearchGroupInfo** infos; ///<搜索的群组数据
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};

/**
 * @brief 会议对象描述
 *
 */
struct Conference {
    int is_locked; ///<是否锁定
    int duration; ///<持续时间
    int state; ///<状态
    const char* group_uri; ///<群Id
    int is_active; ///<是否活跃
    int max_user_count; ///<最大人数
    const char* version; ///<版本
    MemberInfo** members; ///<成员列表, @see {MemberInfo}
    int user_count; ///<人数
    const char* subject; ///<名称
};

/**
 * @brief 群组搜索信息
 *
 */
struct SearchGroupInfo {
    int portrait_version; ///<群头像
    int member_count; ///<群成员数量
    const char* introduce; ///<群简介
    int group_id; ///<群id
    const char* group_name; ///<群名称
};

/**
 * @brief 此类用于记录音视频通话的状态
 *
 */
struct AvSession {
    const char* video_codec; ///<使用的视频编解码
    const char* audio_codec; ///<使用的音频编解码
    int start_time; ///<音视频通话接通时间
    const char* video_ip; ///<视频通话ip，由server提供
    const char* audio_ip; ///<音频通话ip，由server提供
    const char* self_number; ///<自己手机号
    int sid; ///<session id，用于唯一标识一个session
    int is_audio; ///<是否为音频通话，用于区分音频或视频通话
    int create_time; ///<session的创建时间
    int is_multi; ///<是否为多人模式
    int state; ///<状态码，取值参照枚举 @see {AvSessionStates}
    const char* audio_port; ///<音频通话port，由server提供
    AvCrypto* crypto_info; ///<srtp的加密信息, @see {AvCrypto}
    Conference* conference; ///<多人模式下的通知信息, @see {Conference}
    int is_call_in; ///<是否为呼入请求，用于区分呼入或呼出
    const char* video_port; ///<视频通话port，由server提供
    const char* number; ///<通话对方手机号
};

/**
 * @brief 此类用于记录获取Token的结果
 *
 * error_code 解释：
 * 200:
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct TokenResult {
    const char* token; ///<SDK生成的Token验证串，10分钟有效
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};

/**
 * @brief 自定义消息,SDK只作透传,不处理
 *
 */
struct MessageCustomSession {
    int data_type; ///<自定义数据类型，SDK不做处理，透传
    const char* imdn_id; ///<消息id
    const char* from; ///<发信人id
    const char* data; ///<自定义消息数据， SDK不做处理，透传
    const char* to; ///<收信人id
    const char* data_id; ///<自定义数据ID，SDK不做处理，透传
    int send_time; ///<发送时间
};

/**
 * @brief 好友关系操作信息
 *
 */
struct BuddyEventSession {
    UserInfo* user_info; ///<操作涉及到的用户信息, @see {UserInfo}
    int time; ///<操作时间
    const char* reason; ///<操作时的备注信息，如加好友时的请求内容
    const char* from_user; ///<操作发起人
    int accepted; ///<是否已同意添加好友请求
    int op; ///<操作类型，@see {BuddyOps}
    const char* to_user; ///<被操作用户
};

/**
 * @brief 此类用于记录获取设备节点的结果
 *
 * error_code 解释：
 * 200:
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct EndpointResult {
    EndPoint** endpoints; ///<所有激活的登录设备
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};

/**
 * @brief 此类描述同步会话状态信息
 *
 */
struct MsgConvStatusSession {
    Conversation** conversations; ///<会话状态
    int convstate; ///<会话状态操作类型, 1:已读 2:删除
    int chat_type; ///<聊天类型，@see {ChatType}
};

/**
 *@brief 描述群组成员的信息
 *
 */
struct MemberInfo {
    const char* user; ///<群组成员
    int join_time; ///<加入群组的时间 UTC 时间，秒
    const char* display_name; ///<群内昵称
    int role; ///<角色, 1为普通成员 2为管理员
};

/**
 * @brief 记录好友操作的结果
 *
 * error_code 解释：
 * 200: 操作成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct BuddyResult {
    int op; ///<操作类型，@see {BuddyOps}
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};

/**
 * @brief 此类描述同步消息状态信息
 *
 */
struct MsgStatusSession {
    const char* imdn_id; ///<消息id
    int burn_sent; ///<已发送已焚报告 0: 未焚(默认) 1: 已焚
    int read; ///<已读状态 0: 未读(默认) 1: 已读
    int deleted; ///<已删除状态  0:未删除(默认) 1:已删除 
    int time; ///<操作时间
    int read_sent; ///<已发送已读报告 0: 未读(默认) 1: 已读
    int opened; ///<打开状态  0:未打开(默认) 1:已打开 (如媒体已经播放)
    int delivery_sent; ///<已发送送达报告 0: 未送达(默认) 1: 已经送达
};

/**
 * @brief 群组详细信息
 *
 */
struct GroupSession {
    int create_time; ///<群创建时间，UTC时间，秒
    int flag; ///<群状态 0:活动的,1:已删除
    const char* bulletin; ///<群公告
    const char* group_uri; ///<群组标识
    MemberInfo** members; ///<群成员列表, @see {MemberInfo}
    const char* version; ///<版本号
    const char* introduce; ///<群简介
    int sid; ///<任务id,用于匹配是哪次api调用
    int user_count; ///<当前群成员数量
    const char* subject; ///<群名称
};

/**
 * @brief 此类用于记录群列表的信息
 *
 */
struct GroupListSession {
    const char* user; ///<用户
    int sync_mode; ///<更新模式: 1增量，2全量
    int sid; ///<任务id,用于匹配是哪次api调用
    Group** groups; ///<群组列表信息，@see {Group}
};

/**
 * @brief 此类描述强制下线通知(服务器在下发完通知后会立即关闭连接，客户端收到通知后不应该再自动重连)
 *
 */
struct LogoutSession {
    const char* reason; ///<原因描述
    int type; ///类型，@see {LogoutType}
};

/**
 * @brief 商店表情的消息
 *
 */
struct MessageEmoticonSession {
    const char* vemoticon_name; ///
    const char* imdn_id; ///<消息id
    int is_silence; ///<是否需要静默
    int is_burn; ///<是否是阅后即焚
    const char* to; ///<收信人id
    int is_open; ///<是否已打开
    int send_time; ///<发送时间
    int is_read; ///<是否已读
    int is_delivered; ///<是否已投递
    int need_report; ///<是否需要报告
    int chat_type; ///<聊天类型，@see {ChatType}
    const char* contribution_id; ///<暂时没用
    int directed_type; ///<定向消息类型，@see {DirectedType}
    const char* vemoticon_id; ///
    const char* from; ///<发信人id
};

/**
 * @brief 彩云文件的消息
 *
 */
struct MessageCloudFileSession {
    const char* imdn_id; ///<消息id
    int is_silence; ///<是否需要静默
    const char* fiel_url; ///<文件url地址
    int is_delivered; ///<是否已投递
    const char* file_name; ///<文件名
    int is_read; ///<是否已读
    const char* to; ///<收信人id
    int send_time; ///<发送时间
    const char* file_size; ///<文件大小
    int is_open; ///<是否已打开
    int need_report; ///<是否需要报告
    int chat_type; ///<聊天类型，@see {ChatType}
    const char* contribution_id; ///<暂时没用
    int directed_type; ///<定向消息类型，@see {DirectedType}
    int is_burn; ///<是否是阅后即焚
    const char* from; ///<发信人id
};

/**
 * @brief 音视频加密描述
 *
 */
struct AvCrypto {
    const char* local_video_crypto_key; ///<本地视频srtp加密使用的key
    const char* remote_video_crypto_param; ///<远端视频srtp加密使用的参数。多个参数的情况下使用空格分隔。KDR UNENCRYPTED_SRTP UNENCRYPTED_SRTCP UNAUTHENTICATED_SRTP FEC_ORDER FEC_KEY WSH
    const char* local_video_crypto_suite; ///<本地视频srtp加密算法描述
    const char* remote_audio_crypto_suite; ///<远端音频srtp加密算法描述
    const char* remote_video_crypto_key; ///<远端视频srtp加密使用的key
    const char* remote_audio_crypto_param; ///<远端音频加密参数。多个参数的情况下使用空格分隔。KDR UNENCRYPTED_SRTP UNENCRYPTED_SRTCP UNAUTHENTICATED_SRTP FEC_ORDER FEC_KEY WSH
    const char* remote_audio_crypto_key; ///<远端音频加密使用的key
    const char* local_audio_crypto_suite; ///<本地音频srtp加密算法描述
    const char* remote_video_crypto_suite; ///<远端视频srtp加密算法描述
    const char* local_audio_crypto_key; ///<本地音频srtp加密使用的key
};

/**
 * @brief 好友列表信息
 *
 */
struct BuddyListSession {
    BuddyInfo** full; ///<全量同步时的好友列表
    BuddyInfo** partial; ///<差量同步时的好友变更列表 @see {BuddyInfo}
    int sync_mode; ///<同步类型，1, partial 2, full @see {BuddySyncMode}
};

/**
 * @brief 消息发送结果
 *
 * error_code 解释：
 * 200: 消息发送成功
 * 408: 请求超时
 * 500: 服务器错误
 * -2: 网络错误
 * -1: 未知错误
 *
 */
struct MessageResult {
    const char* imdn_id; ///<消息唯一标识id
    const char* file_hash; ///<文件hash值
    const char* file_path; ///<文件保存路径
    int sid; ///<任务id,用于匹配是哪次api调用
    const char* error_extra; ///<错误描述
    int error_code; ///<错误码
};


#endif

