//
//  FNMultiMsgEnty.h
//  FeinnoBopSDK
//
//  Created by yiqingping on 15/11/30.
//  Copyright © 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  一对多消息的实体类
 */
@interface FNMultiMsgEnty : NSObject

// 会话对象的ID
@property (nonatomic, strong) NSArray *peerIDs;

// 消息ID，消息的唯一标示，用于排重，使用generateUUID方法生成
@property (nonatomic, copy) NSString *msgId;

// msgType的取值依次为：FNMsgTypePlain 文本消息  FNMsgTypePic 富文本图片消息  FNMsgTypeAudio 富文本音频消息  FNMsgTypeFile 富文本文件消息 FNMsgTypeVideo 富文本视频消息
@property (nonatomic, retain) NSString *msgType;

// 可选，消息属性，如阅后即焚等。平台透传，多个值用（;）分隔，由UI自定义
@property (nonatomic, copy) NSString *msgAttribute;

// 必选，消息内容，msgContetn只能是FNMsgContent类族中的某一个子类调用toJString方法得到的字符串，由SDK调用
@property (nonatomic, copy) NSString *msgContent;

// 可选，消息发送者的用户昵称
@property (nonatomic, copy) NSString *senderNickname;

// 可选，消息来源，一般用于群消息中的发送者的ID
@property (nonatomic, copy) NSString *source;

// 可选，产品的私人定制
@property (nonatomic, copy) NSData *extend;

// 消息的顺序ID，由server赋值，用于消息排序
@property (nonatomic) int64_t syncID;

// 消息事件类型 两人消息 EventTypePrivate   群组消息 EventTypePG
@property (nonatomic, assign) int32_t event;

// 可选，消息发送时间
@property (nonatomic, copy) NSDate *sendDate;



@end
