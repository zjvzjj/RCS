//
//  NSUserDefaults+MessageSetting.h
//  feinno-sdk-demo
//
//  Created by doujinkun on 14/11/25.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (MessageSetting)

+ (void)saveExtraMessagesSetting:(BOOL)value;
+ (BOOL)extraMessagesSetting;

+ (void)saveLongMessageSetting:(BOOL)value;
+ (BOOL)longMessageSetting;

+ (void)saveEmptyMessagesSetting:(BOOL)value;
+ (BOOL)emptyMessagesSetting;

+ (void)saveSpringinessSetting:(BOOL)value;
+ (BOOL)springinessSetting;

+ (void)saveOutgoingAvatarSetting:(BOOL)value;
+ (BOOL)outgoingAvatarSetting;

+ (void)saveIncomingAvatarSetting:(BOOL)value;
+ (BOOL)incomingAvatarSetting;

@end
