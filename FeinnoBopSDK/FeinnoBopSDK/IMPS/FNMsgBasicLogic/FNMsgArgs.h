//
//  FNMsgArgs.h
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/2/2.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNMsgContent.h"
#import "FNFileServiceArgs.h"

@class SendMsgResults;
@class PullMsgResults;
@class DelMsgResult;
@class GetRoamingMsgResults;
@class SendSimpleMsgNotify;

/**
 *  获取历史消息的请求类
 */
@interface FNGetRoamingMsgRequest : NSObject

// 本次获取历史消息的数量, 当count = 0时缺省设置为10条
@property (nonatomic) int32_t pageSize;

// 下次写把这个改为发送者的Id
@property(nonatomic,copy) NSString *peerId;

@property(nonatomic,copy) NSString *lastRmsId;

//消息的类型，1：二人消息；2：群组消息
@property(nonatomic) int32_t msgType;

@end

/**
 *  拉取历史消息的应答类
 */
@interface FNGetRoamingMsgResponse : NSObject

// 拉取消息的应答状态码： 200 成功   201 无未读消息   500 服务器错误
@property (nonatomic, readonly) int32_t statusCode;

// 拉取到的历史消息，该数组内存储的是 FNMsgEntity 类
@property (nonatomic, readonly) NSArray *msgList;

// 拉取历史消息 最后一条的id
@property (nonatomic, readonly) NSString *lastRmsId;
// 消息类型 1 普通消息    2短信消息
@property (nonatomic, readonly) int32_t msgType;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(GetRoamingMsgResults *)pbArgs;

@end

/**
 *  消息实体类
 */
@interface FNMsgEntity : NSObject

// 会话对象的ID
@property (nonatomic, copy) NSString *peerID;

// 消息ID，消息的唯一标示，用于排重，使用generateUUID方法生成
@property (nonatomic, copy) NSString *msgId;

// msgType的取值依次为：FNMsgTypePlain 文本消息  FNMsgTypePic 富文本图片消息  FNMsgTypeAudio 富文本音频消息  FNMsgTypeFile 富文本文件消息 FNMsgTypeVideo 富文本视频消息
@property (nonatomic, retain) NSString *msgType;

// 可选，消息属性，如阅后即焚等。平台透传，多个值用（;）分隔，由UI自定义
@property (nonatomic, copy) NSString *msgAttribute;

// 必选，消息内容，msgContetn只能是FNMsgContent类族中的某一个子类调用toJString方法得到的字符串，由SDK调用
@property (nonatomic, copy) NSString *msgContent;

// 必选，消息内容，msgTranslation是msgContent的译文
@property (nonatomic, copy) NSString *msgTranslation;

// 可选，消息发送者的用户昵称
@property (nonatomic, copy) NSString *senderNickname;

//可选，消息发送者的用户昵称
@property (nonatomic, copy) NSString *sendPortraitUrl;

// 可选，消息来源，一般用于群消息中的发送者的ID
@property (nonatomic, copy) NSString *source;

// 可选，消息来源，一般用于群消息中的发送者的ID
@property (nonatomic, copy) NSString *senderId;

// 可选，产品的私人定制
@property (nonatomic, copy) NSData *extend;

// 消息的顺序ID，由server赋值，用于消息排序
@property (nonatomic) int64_t syncID;

// 消息事件类型 两人消息 EventTypePrivate   群组消息 EventTypePG 
@property (nonatomic, assign) int32_t event;

// 可选，消息发送时间
@property (nonatomic, copy) NSDate *sendDate;

// 发送PUSH时用于显示PUSH的内容
@property (nonatomic, copy) NSString *pushDesc;

@end

/**
 *  发送普通文本消息的请求类
 */
@interface FNSendTextMsgRequest : NSObject

// 发送消息时，消息接收者的ID
@property (nonatomic, copy) NSString *peerID;

// 发送消息时，消息接收者的Name
@property (nonatomic, copy) NSString *name;

// 发送消息的文本内容
@property (nonatomic, copy) NSString *content;

// 可选，消息的内容类型，控制消息的内容的格式，如普通字符串，JSON、XML等消息结构，由具体产品决定，SDK与server透传
@property (nonatomic, copy) NSString *contentType;

// 可选，消息属性，如阅后即焚等。平台透传，多个值用（;）分隔，由UI自定义
@property (nonatomic, copy) NSString *msgAttribute;

// 可选，消息发送者的用户昵称
@property (nonatomic, copy) NSString *senderNickname;

// 可选，消息来源，一般用于群消息中的发送者的ID
@property (nonatomic, copy) NSString *senderId;

//可选，消息发送者的用户昵称
@property (nonatomic, copy) NSString *sendPortraitUrl;

// 消息ID，消息的唯一标示，用于排重，使用generateUUID方法生成
@property (nonatomic, copy) NSString *msgId;

// 发送PUSH时用于显示PUSH的内容
@property (nonatomic, copy) NSString *pushDesc;

@end

/**
 *  发送消息的应答类
 */
@interface FNSendMsgResponse : NSObject

// 发送消息的返回码：200 成功   250 表示富文本文件上传服务器失败   400 请求错误   500 服务器错误
@property (nonatomic, readonly) int32_t statusCode;

// 发送消息的错误原因，是对应答码的相应解释
@property (nonatomic, readonly) NSString *reason;

// 消息ID，是那条消息的应答，是发送消息对象对应的msgID
@property (nonatomic, readonly) NSString *msgID;

// 消息发送时间
@property (nonatomic, readonly) NSString* sendDate;

// 消息顺序ID，用于消息排序
@property (nonatomic, readonly) int64_t syncID;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(SendMsgResults *)pbArgs;

// 初始化该类，由SDK调用
- (instancetype)initWithStatusCode:(int32_t)statusCode;

@end

/**
 *  发送富文本消息的请求类
 */
@interface FNSendRichTextMsgRequest : NSObject

// 发送消息的返回码：200 成功   250 表示富文本文件上传服务器失败   400 请求错误   500 服务器错误
@property (nonatomic, assign) int32_t statusCode;

// 发送消息时对应的消息体
@property (nonatomic, strong) FNMsgEntity *msgEntity;

// 发送消息的富文本内容
@property (nonatomic, strong) FNMsgContent *msgContent;

@end

/**
 *  发送富文本消息的应答类
 */
@interface FNSendRichTextMsgResponse : NSObject

// 发送消息的返回码：200 成功   250 表示富文本文件上传服务器失败   400 请求错误   500 服务器错误
@property (nonatomic, assign) int32_t statusCode;

// 发送富文本消息时，还需要填写的参数
@property (nonatomic, strong) FNSendMsgResponse *msgRsp;

// 富文本消息的文件路径
@property (nonatomic, strong) FNSharedFileInfo *fileInfo;

@end

/**
 *  拉取消息的请求类
 */
@interface FNPullMsgRequest : NSObject

// 本次拉取消息的数量, 当count = 0时缺省设置为10条
@property (nonatomic) int32_t count;

// 是否删除服务器端所有历史消息，YES 是，NO 否
@property (nonatomic, assign) BOOL deleteHistoryMsg;

@end

/**
 *  拉取消息的应答类
 */
@interface FNPullMsgResponse : NSObject

// 拉取消息的应答状态码： 200 成功   201 无未读消息   500 服务器错误
@property (nonatomic, readonly) int32_t statusCode;

// 拉取到的消息，该数组内存储的是 FNMsgEntity 类
@property (nonatomic, readonly) NSArray *msgList;

// 是否拉取完成
@property (nonatomic, readonly) BOOL isCompleted;

// 消息的syncID
@property (nonatomic, readonly) int64_t syncID;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(PullMsgResults *)pbArgs;

@end

/**
 *  设置消息已送达并删除服务端消息的请求类,由SDK调用
 */
@interface FNDelMsgRequest : NSObject

// 消息类型的标记
@property (nonatomic) long syncID;

@end

/**
 *  设置消息已送达并删除服务端消息的应答类
 */
@interface FNDelMsgResponse : NSObject

// 标记消息已送达的状态码
@property (nonatomic, readonly) int32_t statusCode;

// 初始化该类，由SDK调用
- (instancetype)initWithPBArgs:(DelMsgResult *)pbArgs;

@end

/**
 *  发送透传消息的请求类
 */
@interface FNSendSimpleMsgRequest : NSObject

// 目标的bopId
@property (nonatomic) NSString *toBopId;

// 发送的状态信息
@property (nonatomic) NSString *msg;

@end

/**
 *  发送透传消息的应答类
 */
@interface FNSendSimpleMsgResponse : NSObject

// 应答状态码
@property (nonatomic, readonly) int32_t statusCode;

- (instancetype)initWithStatusCode:(int32_t)statusCode;

@end

/**
 *  发送透传消息的通知
 */
@interface FNSendSimpleMsgNtfItem : NSObject

// 发送者的用户ID
@property (nonatomic) NSString *sourceUserId;

// 发送的内容
@property (nonatomic) NSString *message;

- (instancetype)initWithPBArgs:(SendSimpleMsgNotify *)pbArgs;

@end
