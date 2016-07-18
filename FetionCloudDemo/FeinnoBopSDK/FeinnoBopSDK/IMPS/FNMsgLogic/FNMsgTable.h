//
//  FNMsgTable.h
//  feinno-sdk-db
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNEnum.h"

/**
 *  消息表的模型
 */
@interface FNMsgTable : NSObject

/**
 *  消息排序ID
 */
@property (nonatomic) int64_t syncId;

/**
 *  消息的ID
 */
@property (nonatomic) NSString *msgId;

/**
 *  会话对方的ID，可以是个人用户的ID也可以使群组ID
 */
@property (nonatomic) NSString *tid;

/**
 *  UI定义的消息内容的类型
 */
@property (nonatomic) NSString *msgType;

/**
 *  消息特性
 */
@property (nonatomic) NSString *msgAttribute;

/**
 *  消息内容的类型
 */
@property (nonatomic) NSString *contentType;

/**
 *  消息的内容
 */
@property (nonatomic) NSString *content;

/**
 *  消息的内容的翻译
 */
@property (nonatomic) NSString *translation;

/**
 *  消息的发送者的昵称
 */
@property (nonatomic) NSString *senderNickname;

/**
 *  消息源，用于标识消息的发送者ID，一般用在群消息中
 */
@property (nonatomic) NSString *senderId;

/**
 *  消息的发送者的头像
 */
@property (nonatomic) NSString *senderProtraitUrl;

/**
 *  消息的发送状态，取值为MsgSendStatus类型的枚举变量 MsgSendSuccess   MsgSending  MsgSendFailed
 */
@property (nonatomic) int32_t sendStatus;

/**
 *  消息的读状态，取值为MsgReadStatus类型的枚举变量 MsgAlreadyRead  MsgUnread
 */
@property (nonatomic) int32_t readStatus;

/**
 *  消息的发送或者接收标识,取值为MsgSendOrReceiveFlag类型的枚举变量 MsgSendFlag MsgReceiveFlag
 */
@property (nonatomic) MsgSendOrReceiveFlag flag;

/**
 *  消息的发送日期
 */
@property (nonatomic) NSString *createDate;

/** 富文本表部分 **/

/**
 *  富文本消息的文件ID
 */
@property (nonatomic) NSString *fileId;

/**
 *  富文本消息的文件名
 */
@property (nonatomic) NSString *fileName;

/**
 *  富文本消息的文件的大小
 */
@property (nonatomic) long fileSize;

/**
 *  富文本消息的文件的宽度
 */
@property (nonatomic) long fileWidth;

/**
 *  富文本消息的文件的高度
 */
@property (nonatomic) long fileHeight;

/**
 *  富文本消息的文件在server的下载地址
 */
@property (nonatomic) NSString *URL;

/**
 *  富文本消息的接收状态，取值为MsgReceiveStatus的枚举类型 MsgReceiveSuccess Msgreceiving  MsgReceiveFailed
 */
@property (nonatomic) int32_t receiveStatus;

/**
 *  富文本消息的文件在本地沙盒的保存路径
 */
@property (nonatomic, getter = getSavePath) NSString *savePath;

/**
 *  富文本消息的文件缩略图在本地沙盒的保存路径
 */
@property (nonatomic, getter = getThumbPath) NSString *thumbPath;

/**
 *  音视频文件的播放时间
 */
@property (nonatomic) long playTime;

/**
 *  音视频的比特率
 */
@property (nonatomic) long bitrate;

/**
 *  文件上传下载处理时已处理文件的大小，可用于断点续传
 */
@property (nonatomic) long processedSize;

/**
 *  查询一定数量的历史已读消息
 *
 *  @param tid 消息的接收者ID
 *  @param num 查询的消息数量,当num大于历史消息总数时返回全部历史消息，反之，返回num条历史消息消息，当num=-1时获取全部消息
 *
 *  @return 返回的消息信息数组，数组内存储的是FNMsgTable类型的变量
 */
+ (NSMutableArray *)getHistoryMsgForTid:(NSString *)tid
                                    num:(int32_t)num;

/**
 *  查询一定数量的未读消息
 *
 *  @param tid 消息的接收者ID
 *  @param num 查询的消息数量,当num大于实际未读消息数时返回实际的未读消息，反之，返回num条未读消息，当num=-1时获取全部消息
 *
 *  @return 返回的消息信息数组，数组内存储的是FNMsgTable类型的变量
 */
+ (NSMutableArray *)getUnreadMsgForTid:(NSString *)tid
                                   num:(int32_t)num;



+ (NSMutableArray *)getUnreadMsgForTid:(NSString *)tid
                                   num:(int32_t)num
                             andSyncId:(NSInteger)syncId;
/**
 *  获取某一条消息记录
 *
 *  @param syncId 该条消息的ID，成功的消息才有
 *
 *  @return 返回的消息信息数组，数组内存储的是FNMsgTable类型的变量
 */
+ (NSArray *)getMsgBySyncId:(int64_t)syncId;

/**
 *  获取某一条消息记录
 *
 *  @param msgId 该条消息的ID
 *
 *  @return 返回的消息信息数组，数组内存储的是FNMsgTable类型的变量
 */
+ (NSArray *)getMsgByMsgId:(NSString *)msgId;

/**
 *  根据内容获取消息
 *
 *  @param msgContent 消息内容
 *  @param number     数量
 *  @param page       页数（从1开始）
 *  @param tid        目标id（置nil为所有联系人）
 *
 *  @return 返回的消息信息数组，数组内存储的是FNMsgTable类型的变量
 */
+ (NSArray *)getMsgByContent:(NSString *)msgContent number:(int32_t)number page:(int32_t)page tid:(NSString *)tid;

/**
 *  插入一条消息的记录
 *
 *  @param message 消息的模型参数
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)insert:(FNMsgTable *)message;

/**
 *  更新发送消息的状态信息
 *
 *  @param msgId      发送消息的ID
 *  @param sendStatus 想要更新的消息的状态
 *  @param sendTime   想要更新的消息的时间
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)updateSendMsgStatus:(NSString *)msgId
                     syncId:(int64_t)syncId
                 sendStatus:(MsgSendStatus)sendStatus
                   sendTime:(NSString *)sendTime;

/**
 *  更新富文本表的某一条富文本文件信息记录
 *
 *  @param richInfo 文件信息
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)updateReceiveRichMsgInfo:(FNMsgTable *)richInfo;

/**
 *  删除某一条消息记录
 *
 *  @param syncId 该条消息的ID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)deleteBySyncId:(long)syncId;

/**
 *  删除发送的消息中的一条记录
 *
 *  @param msgId 发送消息的ID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)deleteByMsgId:(NSString *)msgId;

/**
 *  删除与某人的聊天记录
 *
 *  @param userId 要删除聊天记录的用户ID
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)deleteByUserId:(NSString *)userId;

/**
 *  清空消息表
 *
 *  @return 返回参数，标志表的操作成功与否
 */
+ (BOOL)clearAll;

/**
 *  获取富文本文件存储路径
 *
 *  @return 富文本文件存储路径
 */
- (NSString *)getSavePath;

/**
 *  获取富文本文件缩略图存储路径
 *
 *  @return 富文本文件缩略图存储路径
 */
- (NSString *)getThumbPath;

/**
 *  获取聊天对象富文本路径
 *
 *  @param tid     目标id
 *  @param msgType 富文本类型
 *
 *  @return 存储路径地址
 */
+ (NSMutableArray *)getRichMessageByUserId:(NSString *)tid messageType:(NSString *)msgType;

/**
 *  获取聊天对象图片和视频文件
 *
 *  @param tid 目标id
 *
 *  @return 聊天文件
 */
+ (NSMutableArray *)getPicAndVideoByUserId:(NSString *)tid;

@end
