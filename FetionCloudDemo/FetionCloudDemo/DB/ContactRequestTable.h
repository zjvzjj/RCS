//
//  ContactRequestTable.h
//  FetionCloudDemo
//
//  Created by 张静杰 on 16/7/25.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactDataTable.h"

@interface ContactRequestTable : ContactDataTable
+ (ContactRequestTable *)getWithUserId:(NSString *)userId;
+ (BOOL)insert:(ContactDataTable *)user;
@end
