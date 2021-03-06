//
//  FNDBManager.h
//  feinno-sdk-db
//
//  Created by wangshuying on 14-8-22.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOPFMDatabaseQueue.h"

/**
 *  DB的管理模型
 */
@interface DBManager : NSObject

/**
 *  获取BOPFMDatabaseQueue，用于防止数据库死锁
 *
 *  @return BOPFMDatabaseQueue单例
 */
+ (BOPFMDatabaseQueue *)sharedDatabaseQueue;

/**
 *  初始化DB
 */
+ (void)initDBWithUserId:(NSString *)userId;

@end
