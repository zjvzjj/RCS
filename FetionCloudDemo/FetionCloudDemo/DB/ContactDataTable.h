//
//  ContactDataTable.h
//  FetionCloudDemo
//
//  Created by Nemo on 16/3/2.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactDataTable : NSObject

@property (nonatomic, retain)NSString *userId;  //xx@key=bopid

@property (nonatomic, retain)NSString *account;//~mobile

@property (nonatomic, retain)NSString *nickName;//back

@property (nonatomic, retain)NSString *username;//back

@property (nonatomic, retain)NSString *portrait;//

@property (nonatomic,copy) NSString *portraitPath;

+ (ContactDataTable *)getWithUserId:(NSString *)userId;

+ (NSArray *)getAll;

+ (BOOL)insert:(ContactDataTable *)user;

+ (BOOL)update:(ContactDataTable *)user;

+ (BOOL)del:(NSString *)userId;

@end
