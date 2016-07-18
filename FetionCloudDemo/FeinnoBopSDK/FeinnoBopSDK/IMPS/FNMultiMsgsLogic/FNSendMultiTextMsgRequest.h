//
//  FNSendMultiTextMsgRequest.h
//  FeinnoBopSDK
//
//  Created by yiqingping on 15/11/30.
//  Copyright © 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNMsgArgs.h"
#import "FNMultiMsgEnty.h"

/**
 *  一对多 发送文本消息的请求类
 */
@interface FNSendMultiTextMsgRequest : NSObject

// 发送消息时，消息接收者的ID
@property (nonatomic, strong) NSArray *peerIDs;

// 发送消息的文本内容
@property (nonatomic, copy) NSString *content;

// 可选，消息的内容类型，控制消息的内容的格式，如普通字符串，JSON、XML等消息结构，由具体产品决定，SDK与server透传
@property (nonatomic, copy) NSString *contentType;

// 可选，消息属性，如阅后即焚等。平台透传，多个值用（;）分隔，由UI自定义
@property (nonatomic, copy) NSString *msgAttribute;

// 可选，消息发送者的用户昵称
@property (nonatomic, copy) NSString *senderNickname;

// 可选，消息来源，一般用于群消息中的发送者的ID
@property (nonatomic, copy) NSString *source;

// 消息ID，消息的唯一标示，用于排重，使用generateUUID方法生成
@property (nonatomic, copy) NSString *msgId;

@end

/**
 *  一对多 发送富文本消息的请求类
 */
@interface FNSendMultiRichTextMsgRequest : NSObject

// 发送消息的返回码：200 成功   250 表示富文本文件上传服务器失败   400 请求错误   500 服务器错误
@property (nonatomic, assign) int32_t statusCode;

// 发送消息时对应的消息体
@property (nonatomic, strong) FNMultiMsgEnty *muMsgEntity;

// 发送消息的富文本内容
@property (nonatomic, strong) FNMsgContent *msgContent;

@end



