//
//  FZChatsViewModel.h
//  FANSZ
//
//  Created by yiqingping on 16/1/21.
//  Copyright © 2016年 FANSZ. All rights reserved.
//



#import <Foundation/Foundation.h>

#import "FNRecentConversationTable.h"
#import "FNGroupTable.h"
@interface MessageTableModel : NSObject

@property (nonatomic,copy)NSString *tid;

@property (nonatomic,assign)EventType eventType;

@property (nonatomic,copy) NSString *sendNickName;

// 群组消息的最后一条的发送者的昵称
@property (nonatomic,copy) NSString *lastNickName;

//最后一条消息的内容
@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *lastActiveDate;

// 头像url
@property (nonatomic,copy) NSString *protraitUrl;

@property(nonatomic,assign)NSInteger unreadCount;

@end
