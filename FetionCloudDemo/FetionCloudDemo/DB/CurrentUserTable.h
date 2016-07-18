//
//  CurrentUserTable.h
//  FetionCloudDemo
//
//  Created by Nemo on 16/3/2.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUserTable : NSObject

@property (nonatomic, retain)NSString *userId;

@property (nonatomic, retain)NSString *account;

@property (nonatomic, retain)NSString *password;

@property (nonatomic, retain)NSString *nickName;

@property (nonatomic, retain)NSString *time;

+ (CurrentUserTable *)getLastUser;

+ (CurrentUserTable *)getWithUserId:(NSString *)userId;

+ (BOOL)insert:(CurrentUserTable *)user;

+ (BOOL)update:(CurrentUserTable *)user;

+ (BOOL)del:(CurrentUserTable *)user;

@end

