//
//  FNContactArgs.h
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/2/2.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNEnum.h"

@class GetAddressListRspArgs;
@class GetRelationShipRspArgs;
@class GetPresenceResult;
@class IsRegisterRspArgs;
@class UploadBuddyListResult;
@class SimpleRspArgs;


#pragma mark -
#pragma mark 联系人列表上传、获取、删除

/**
 *  获取联系人列表请求类
 */
@interface FNGetAddressListRequest : NSObject

// 是否拉取联系人的详细信息
@property (nonatomic) BOOL isDetail;

// 要获取的通讯录ID，只有在需要明细，即 isDetail 为真时有效，如果赋值为nil，则表示获取全量
@property (nonatomic, copy) NSArray *addressListIDs;

// 起始ID，在获取明细，即 isDetail 为真时有意义，用于分批，该字段来自上次应答结果中的 nextAddressListID
@property (nonatomic, copy) NSString *startAddressListID;

// 获取联系人的数量，分批使用，该字段为客户端传递，但是server也有配置，取二者中的小者
@property (nonatomic) int32_t count;

@end

/**
 *  获取联系人列表的应答类
 */
@interface FNGetAddressListResponse : NSObject

// 获取联系人列表的应答码
@property (nonatomic, readonly) int32_t statusCode;

// 返回的描述信息
@property (nonatomic, readonly) NSString *retDescription;

// 是否结束拉取，如果需要分批继续拉取则为NO
@property (nonatomic, readonly) BOOL isEnd;

// 在需要下次获取时提供的 startAddressListId，本次结果不包含 nextAddressListID
@property (nonatomic, readonly) NSString *nextAddressListID;

// 数组内存储要联系人的详细信息集合类 FNAddressListDetailCombo
@property (nonatomic, readonly) NSArray *addressListCombo;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GetAddressListRspArgs *)rspArgs;

@end

/**
 *  上传联系人的详细信息集合类
 */
@interface FNAddressListDetailCombo : NSObject

// 用户通讯录中的ID
@property (nonatomic, copy) NSString *addressListID;

// 通讯录明细，二进制格式
@property (nonatomic, strong) NSData *addressListDetail;

// 通讯录明细的数据协议的原类型, 如PB Json XML等
@property (nonatomic, copy) NSString *type;

@end

/**
 *  上传 或者 更新 通讯录联系人的请求类，通讯录数据格式由SDK确定
 */
@interface FNUpAddressListRequest : NSObject

// 上传数据的二进制原类型
@property (nonatomic, copy) NSString *dataType;

// 数组内存储要上传联系人的详细信息
@property (nonatomic, strong) NSMutableArray *addressList;

@end

/**
 *  上传 或者 更新 通讯录联系人的应答类
 */
@interface FNUpAddressListResponse : NSObject

// 返回的应答状态码：200 成功
@property (nonatomic, readonly) int32_t statusCode;

// 返回的状态描述
@property (nonatomic, readonly) NSString *retDescription;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(SimpleRspArgs *)rspArgs;

@end

/**
 *  删除联系人请求类
 */
@interface FNDelAddressListRequest : NSObject

// 要删除的联系人的ID数组
@property (nonatomic, strong) NSArray *tids;

@end

/**
 *  删除联系人的应答类
 */
@interface FNDelAddressListResponse : NSObject

// 返回的应答状态码：200 成功
@property (nonatomic, readonly) int32_t statusCode;

// 返回的状态描述
@property (nonatomic, readonly) NSString *retDescription;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(SimpleRspArgs *)rspArgs;

@end


#pragma mark -
#pragma mark 联系人列表查询

/**
 *  查询联系人关系链的请求类
 */
@interface FNGetRelationshipRequest : NSObject

// 管理链的范围： 1 直接关系  2 朋友的朋友 如此类推
@property (nonatomic) int32_t extentNo;

// 查询的目标用户ID，如果不为nil，则获取用户朋友中tid的朋友
@property (nonatomic, copy) NSString *tid;

// 起始ID，此参数用于在获取的ID太多时的拆包,首次使用时置为nil
@property (nonatomic, copy) NSString *startID;

@end

/**
 *  查询联系人关系链的应答类,支持分批操作
 */
@interface FNGetRelationshipResponse : NSObject

// 应答返回的状态码 200 成功
@property (nonatomic, readonly) int32_t statusCode;

// 应答返回的描述信息
@property (nonatomic, readonly) NSString *retDescription;

// 管理链的范围： 1 直接关系  2 朋友的朋友 如此类推
@property (nonatomic, readonly) int32_t extentNo;

// 目标用户的ID，如果不为nil，则获取二者关系链的交集
@property (nonatomic, readonly) NSString *tid;

// 是否完成，如果需要分批的话，其值为NO
@property (nonatomic, readonly) BOOL isEnd;

// 下次起始的ID，用于太多人时的拆包，尤其是2度或者3度关系时
@property (nonatomic, readonly) NSString *nextUID;

// 该属性 数组内 存储的是 联系人的关系信息类 FNAddressListRelationsEntity
@property (nonatomic, readonly) NSArray *relations;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GetRelationShipRspArgs *)rspArgs;

@end

/**
 *  查询关系消息实体类
 */
@interface FNAddressListRelationsEntity : NSObject

// 用户ID
@property (nonatomic, copy) NSString *userID;

// 用户通讯录的ID，一般为手机号或者邮箱
@property (nonatomic, copy) NSString *addressListID;

// 更新时间作为版本号version的值
@property (nonatomic) int64_t version;

@end

/**
 *  在线状态的描述类
 */
@interface FNOnlineItem : NSObject

// 在线转态对应的用户ID
@property (nonatomic, readonly) NSString *userId;

// 该用户ID对应的在线状态值，OnlineStatusOff 不在线    OnlineStatusOn 在线
@property (nonatomic, readonly) OnlineStatus presenceValue;

// 该类的初始化方法，由SDK调用
- (instancetype)initWithUserId:(NSString *)userId onlineStatus:(OnlineStatus)presenceValue;

@end

/**
 *  查询好友在线状态的请求类
 */
@interface FNGetPresenceRequest : NSObject

// 要查询的好友列表
@property (nonatomic) NSArray *tidList;

@end

/**
 *  查询好友在线状态的应答类
 */
@interface FNGetPresenceResponse : NSObject

// 返回的应答状态码，200 成功
@property (nonatomic, readonly) int32_t statusCode;

// 所查询的好友的在线状态描述列表，数组内存储的是FNOnlineItem类型的变量
@property (nonatomic, readonly) NSArray *onlineStatusList;

// 该类的初始化方法，由SDK调用
- (instancetype)initWithPBArgs:(GetPresenceResult *)pbArgs;

@end

/**
 *  查询一个或者多个用户注册状态的请求类
 */
@interface FNIsRegisterRequest : NSObject

// 该数组用于存储要查询的用户的ID（NSString 类型），查询他们的注册状态
@property (nonatomic, strong) NSArray *tids;

@end

/**
 *  查询 注册 状态的应答类
 */
@interface FNIsRegisterResponse : NSObject

// 返回的状态码：200 成功
@property (nonatomic, readonly) int32_t statusCode;

// 返回的状态描述
@property (nonatomic, readonly) NSString *retDescription;

// 该数组存储的是 查询状态的结果类 FNRegisterStatusCombo
@property (nonatomic, readonly) NSArray *registerStatus;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(IsRegisterRspArgs *)rspArgs;

@end

/**
 *  查询某些用户注册状态的结果类
 */
@interface FNRegisterStatusCombo : NSObject

// 用户的ID
@property (nonatomic, copy) NSString *userID;

// 注册状态信息：
@property (nonatomic) int32_t registerStatus;

@end


#pragma mark -
#pragma mark 好友列表上传

/**
 *  上传好友列表的请求类
 */
@interface FNUploadBuddyListRequest : NSObject

// 上传好友列表的版本号
@property (nonatomic) NSString *buddyListVersion;

// 好友列表数组，数组内存储好友的ID
@property (nonatomic) NSArray *buddyList;

@end

/**
 *  上传好友列表的应答类
 */
@interface FNUploadBuddyListResponse : NSObject

// 返回的应答状态码
@property (nonatomic, readonly) int32_t statusCode;

// 该类的初始化方法，由SDK调用
- (instancetype)initWithPBArgs:(UploadBuddyListResult *)pbArgs;

@end
