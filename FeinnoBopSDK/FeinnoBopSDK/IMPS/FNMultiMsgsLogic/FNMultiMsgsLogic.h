//
//  FNMultiMsgsLogic.h
//  FeinnoBopSDK
//
//  Created by yiqingping on 15/11/30.
//  Copyright © 2015年 Feinno. All rights reserved.
//

#import "FNMsgBasicLogic.h"
#import "FNSendMultiTextMsgRequest.h"
#import "FNMsgArgs.h"

/**
 *  一对多发送消息的逻辑操作方法
 */
@interface FNMultiMsgsLogic : FNMsgBasicLogic

/**
 *  一对多 发送文本消息
 *
 *  @param textMsgReq  一对多发送文本的消息类参数
 *  @param callback   发送文本消息的回调
 */
+ (void)sendMultiTextMsg:(FNSendMultiTextMsgRequest *)textMsgReq
                callback:(void (^)(FNSendMsgResponse *))callback;

/**
 *  一对多 发送富文本消息
 *
 *  @param richTextMsgReq 一对多发送富文本消息的参数
 *  @param callback       发送富文本消息的回调
 */

+ (void)sendMultiRichTextMsg:(FNSendMultiRichTextMsgRequest *)richTextMsgReq
                    callback:(void (^)(FNSendRichTextMsgResponse *))callback;

@end
