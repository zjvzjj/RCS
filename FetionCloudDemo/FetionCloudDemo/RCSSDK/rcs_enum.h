/**
 * @file  rcs_enum.h
 * @brief enum definition
 * @author http://www.interrcs.com/
 * @date 2016/04/27
 * @version 1.0.0
 * @copyright interrcs
 */

#ifndef _rcs_enum_h
#define _rcs_enum_h

/**
 * @brief 定向消息类型
 */
typedef enum {
    DirectedTypeNONE = 0, ///<非定向
    DirectedTypeOTHER = 1, ///<其他终端
    DirectedTypePC = 2, ///<PC终端
    DirectedTypeUnknown = -255,
}DirectedType;

DirectedType DirectedTypeFromInt(int v);
const char* DirectedTypeToString(DirectedType v);

/**
 * @brief 当前终端的在线状态表示
 *
 */
typedef enum {
    EndpointStatesCONNECTED = 2, ///<已重新连接服务器
    EndpointStatesBOOTED = 3, ///<被其他终端踢下线
    EndpointStatesCONNECT_FAILED = 1, ///<与服务器连接失败
    EndpointStatesUnknown = -255,
}EndpointStates;

EndpointStates EndpointStatesFromInt(int v);
const char* EndpointStatesToString(EndpointStates v);

/**
 * @brief 好友关系操作类型
 */
typedef enum {
    BuddyOpsADD_BUDDY = 1, ///<添加好友
    BuddyOpsADDED_BUDDY = 6, ///<被添加为好友
    BuddyOpsMEMO_BUDDY = 3, ///<修改好友备注名
    BuddyOpsREQ_HANDLED = 7, ///<添加好友处理结果通知
    BuddyOpsSYNC_BUDDY_LIST = 5, ///<同步好友列表
    BuddyOpsHANDLE_BUDDY_REQ = 4, ///<处理好友添加请求
    BuddyOpsDELETE_BUDDY = 2, ///<删除好友
    BuddyOpsUnknown = -255,
}BuddyOps;

BuddyOps BuddyOpsFromInt(int v);
const char* BuddyOpsToString(BuddyOps v);

/**
 * @brief 群操作的枚举值
 */
typedef enum {
    GroupOpEnumJOIN_GROUP = 3, ///<加入群
    GroupOpEnumINVITE_MEMBER = 1, ///<邀请群成员
    GroupOpEnumMODIFY_SUBJECT = 7, ///<修改群名称
    GroupOpEnumREMOVE_USER = 5, ///<移除群成员
    GroupOpEnumSUB_GROUPLIST = 9, ///<订阅群列表
    GroupOpEnumDELETE_GROUP = 11, ///<删除群组
    GroupOpEnumSUB_GROUPINFO = 10, ///<订阅群信息
    GroupOpEnumMODIFY_NICKNAME = 8, ///<修改群昵称
    GroupOpEnumCHANGE_MANAGER = 6, ///<转让群管理员
    GroupOpEnumEXIT_GROUP = 4, ///<退出群组
    GroupOpEnumCREATE_GROUP = 2, ///<创建群
    GroupOpEnumUnknown = -255,
}GroupOpEnum;

GroupOpEnum GroupOpEnumFromInt(int v);
const char* GroupOpEnumToString(GroupOpEnum v);

/**
 * @brief 好友同步动作类型
 */
typedef enum {
    BuddySyncActionUPDATE = 3, ///<更新
    BuddySyncActionADD = 1, ///<添加
    BuddySyncActionDELETE = 2, ///<删除
    BuddySyncActionUnknown = -255,
}BuddySyncAction;

BuddySyncAction BuddySyncActionFromInt(int v);
const char* BuddySyncActionToString(BuddySyncAction v);

/**
 * @brief 用户开通的状态
 *
 */
typedef enum {
    ProvisionStatesGetSMSCode = 1, ///<获取验证码
    ProvisionStatesProvision = 2, ///<注册
    ProvisionStatesUnknown = -255,
}ProvisionStates;

ProvisionStates ProvisionStatesFromInt(int v);
const char* ProvisionStatesToString(ProvisionStates v);

/**
 * @brief 消息类型
 */
typedef enum {
    ContentTypeVIDEO = 8, ///<视频
    ContentTypeLOCATION = 4, ///<位置
    ContentTypeCLOUDFILE = 10, ///<云文件
    ContentTypePICTURE = 2, ///<图片
    ContentTypeNOTIFICATION = 5, ///<通知
    ContentTypeAUDIO = 3, ///<音频
    ContentTypeOTHER = 6, ///<其他
    ContentTypeTEXT = 1, ///<文本
    ContentTypePUBLIC_MSG = 11, ///<公众号消息
    ContentTypeVEMOTICON = 9, ///<表情商店表情
    ContentTypeVCARD = 7, ///<电子名片
    ContentTypeUnknown = -255,
}ContentType;

ContentType ContentTypeFromInt(int v);
const char* ContentTypeToString(ContentType v);

/**
 * @brief 好友列表同步类型
 */
typedef enum {
    BuddySyncModeFULL = 2, ///<全量同步
    BuddySyncModePARTIAL = 1, ///<差量同步
    BuddySyncModeUnknown = -255,
}BuddySyncMode;

BuddySyncMode BuddySyncModeFromInt(int v);
const char* BuddySyncModeToString(BuddySyncMode v);

/**
 * @brief 推送服务器类型
 */
typedef enum {
    ServerTypeNONE = 1, ///<APNS
    ServerTypeOTHER = 2, ///<GCM
    ServerTypePC = 3, ///<小米
    ServerTypeUnknown = -255,
}ServerType;

ServerType ServerTypeFromInt(int v);
const char* ServerTypeToString(ServerType v);

/**
 * @brief 终端管理接口调用的结果枚举
 */
typedef enum {
    EPManagerStatesOK = 200, ///<成功
    EPManagerStatesSERVER_ERROR = 500, ///<服务端错误
    EPManagerStatesINVALID_TOKEN = 410, ///<不合法Token
    EPManagerStatesREQUEST_ERROR = 400, ///<错误请求
    EPManagerStatesINVALID_IDENTITY = 401, ///<不合法验证
    EPManagerStatesINVALID_SESSIONID = 420, ///<不合法SessionID
    EPManagerStatesUSER_OFFLINE = 406, ///<用户离线
    EPManagerStatesUnknown = -255,
}EPManagerStates;

EPManagerStates EPManagerStatesFromInt(int v);
const char* EPManagerStatesToString(EPManagerStates v);

/**
 * @brief 终端管理操作类型的枚举
 */
typedef enum {
    EndpointOPEnumKICK_ENDPOINT = 2, ///<踢其他终端下线
    EndpointOPEnumGEN_PC_TOKEN = 3, ///<扫描二维码登录PC终端
    EndpointOPEnumGET_EP_STATUS = 1, ///<获取其他终端在线状态
    EndpointOPEnumUnknown = -255,
}EndpointOPEnum;

EndpointOPEnum EndpointOPEnumFromInt(int v);
const char* EndpointOPEnumToString(EndpointOPEnum v);

/**
 * @brief 聊天类型
 */
typedef enum {
    ChatTypePUBLIC_ACCOUNT = 4, ///<公众账号消息
    ChatTypeBROADCAST = 3, ///<广播消息
    ChatTypeGROUP = 2, ///<群组聊天
    ChatTypeDIRECTED = 5, ///<定向消息
    ChatTypeSINGLE = 1, ///<一对一聊天
    ChatTypeUnknown = -255,
}ChatType;

ChatType ChatTypeFromInt(int v);
const char* ChatTypeToString(ChatType v);

/**
 * @brief 消息报告类型
 */
typedef enum {
    ReportTypeWITH_DRAW = 64, ///<撤回消息
    ReportTypeDELIVERED = 1, ///<已送达
    ReportTypeGROUP_WITH_DRAW = 512, ///<群消息撤回
    ReportTypeREAD = 16, ///<已读
    ReportTypeTYPING = 2, ///<正在输入
    ReportTypeGROUP_READ = 256, ///<群消息已读
    ReportTypeBURN = 32, ///<已焚
    ReportTypeUPDATE_MSG_ID = 4, ///<更新消息 ID
    ReportTypeGROUP_DELIVERED = 128, ///<群消息已送达
    ReportTypeFILE_PROGRESS = 8, ///<文件进度
    ReportTypeUnknown = -255,
}ReportType;

ReportType ReportTypeFromInt(int v);
const char* ReportTypeToString(ReportType v);

/**
 * @brief 音视频操作类型
 *
 */
typedef enum {
    AvOpEnumINVITE_USER = 7, ///<邀请用户
    AvOpEnumRESUME = 6, ///<恢复
    AvOpEnumANSWER = 3, ///<应答
    AvOpEnumHUNG_UP = 2, ///<挂起
    AvOpEnumHOLD = 5, ///<主动保持
    AvOpEnumCALL = 1, ///<呼叫
    AvOpEnumRING = 4, ///<振铃
    AvOpEnumUnknown = -255,
}AvOpEnum;

AvOpEnum AvOpEnumFromInt(int v);
const char* AvOpEnumToString(AvOpEnum v);

/**
 * @brief 登录操作结果类型
 *
 */
typedef enum {
    LoginStatesTimeout = 408, ///<超时
    LoginStatesLoginSuccess = 200, ///<成功
    LoginStatesLoginFailed = 404, ///<失败
    LoginStatesTxError = 505, ///<传输错误
    LoginStatesOtherError = -1, ///<其他错误
    LoginStatesPasswordError = 403, ///<密码错误
    LoginStatesUnknown = -255,
}LoginStates;

LoginStates LoginStatesFromInt(int v);
const char* LoginStatesToString(LoginStates v);

/**
 * @brief 群组的事件类型
 *
 */
typedef enum {
    GroupEventTypeTRANSFER = 1, ///<被提升为管理员
    GroupEventTypeDISMISSED = 3, ///<群被解散
    GroupEventTypeINVITED = 4, ///<被邀请入群
    GroupEventTypeCONFIRMED = 5, ///<群邀请处理结果
    GroupEventTypeQUIT = 6, ///<退出群
    GroupEventTypeBOOTED = 2, ///<被踢出群
    GroupEventTypeUnknown = -255,
}GroupEventType;

GroupEventType GroupEventTypeFromInt(int v);
const char* GroupEventTypeToString(GroupEventType v);

/**
 * @brief 音视频通话的状态码
 *
 */
typedef enum {
    AvSessionStatesHELD = 15, ///<被对方保持通话(来电和去电)
    AvSessionStatesCONNECTING = 1, ///<去电时尝试连接，对方响铃之前
    AvSessionStatesFAILED = 4, ///<连接失败
    AvSessionStatesCONNECTED = 3, ///<连接成功，正在通话，不包含响铃时间(来电和去电)
    AvSessionStatesACCEPTED = 13, ///<被邀请（来电）响铃后用户同意邀请（接听），此时连接尚未建立
    AvSessionStatesHOLD = 14, ///<主动保持通话(来电和去电)
    AvSessionStatesINVITED = 12, ///<被邀请（来电），正在响铃
    AvSessionStatesNOT_REACHABLE = 11, ///<去电对方不可达
    AvSessionStatesERROR = 10, ///<连接出现错误
    AvSessionStatesEND = 9, ///<主动挂断(来电和去电)
    AvSessionStatesHUNGUP = 8, ///<被对方挂断(来电和去电)（去电对方响铃挂断为Rejected）
    AvSessionStatesREJECTED = 7, ///<去电对方响铃，被对方挂断
    AvSessionStatesTIMEOUT = 6, ///<连接超时
    AvSessionStatesBUSY = 5, ///<去电时对方忙
    AvSessionStatesRINGING = 2, ///<去电时对方正在响铃
    AvSessionStatesUnknown = -255,
}AvSessionStates;

AvSessionStates AvSessionStatesFromInt(int v);
const char* AvSessionStatesToString(AvSessionStates v);


#endif

