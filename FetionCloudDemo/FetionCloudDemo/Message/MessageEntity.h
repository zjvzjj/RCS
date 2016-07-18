//
//  MessageEntity.h
//  FetionCloudDemo
//
//  Created by feinno on 16/7/5.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageEntity : NSObject

@property (nonatomic,copy)NSString *imdn_id;//消息ID

@property (nonatomic,assign)int is_silence;//是否需要静默

@property (nonatomic,assign)int is_delicered;//是否已投递

@property (nonatomic,assign)int need_read_report;//是否需要已读报告

@property (nonatomic,assign)int is_read;//是否已读

@property (nonatomic,copy)NSString *toUserid;//收信人id

@property (nonatomic,copy)NSString *content;//文本内容

@property (nonatomic,assign)int seng_time;//发送时间

@property (nonatomic,assign)int is_open;//是否已打开

@property (nonatomic,assign)int need_report;//是否需要报告

@property (nonatomic,assign)int chatType;//聊天类型

@property (nonatomic,assign)int directed_type;//定向消息类型

@property (nonatomic,assign)int is_burn;//是否是阅后即焚

@property (nonatomic,copy)NSString *fromUserId;//发信人ID











@end
