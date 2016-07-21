//
//  FNUserInfo.h
//  FetionCloudDemo
//
//  Created by feinno on 16/6/30.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BuddyInfoEntity;


@interface FNUserInfo : NSObject

@property (strong ,nonatomic) NSMutableArray *buddyIDArray;

@property (strong,nonatomic) NSMutableArray *addBuddyArray;

@property (copy ,nonatomic) NSString *localNum;

//@property (strong,nonatomic) NSMutableArray *BuddyInfoArray;

//@property (strong,nonatomic) BuddyInfoEntity *buddyInfo;

@property (nonatomic,copy)NSString *imgpath;

@property (nonatomic,strong)NSMutableArray *messageArray;



//用户信息单例

+ (instancetype)ShareStaticConst;

@end


@interface BuddyInfoEntity : NSObject

@property (assign,nonatomic) int buddyID;

@property (copy,nonatomic) NSString *buddy_nickName;

@property (copy,nonatomic) NSString *buddyPotraitPath;


@end