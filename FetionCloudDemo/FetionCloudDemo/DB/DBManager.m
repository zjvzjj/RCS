//
//  FNDBManager.m
//  feinno-sdk-db
//
//  Created by wangshuying on 14-8-22.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "DBManager.h"
#import "BOPFMDB.h"
#import "BOPFMDatabaseAdditions.h"
#import "FNUserConfig.h"

@implementation DBManager

static NSString *dbPath;
static BOPFMDatabaseQueue *queue;

+ (BOPFMDatabaseQueue *)sharedDatabaseQueue
{
    if (!queue)
    {
        queue = [BOPFMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return queue;
}

+ (void)initDBWithUserId:(NSString *)userId
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 历史记录 (获得DB的大小)
    NSString *userPath = [[cachePath stringByAppendingPathComponent:@"BOPDB"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", userId]];
    
    BOOL isDir = NO;
    // 表文件路径
    if (![[NSFileManager defaultManager] fileExistsAtPath:userPath isDirectory:&isDir])
    {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:userPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
        {
            NSLog(@"create dbpath error : %@", error);
        }
    }
    dbPath = [userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"demo.db"]];
    NSLog(@"db path: %@", dbPath);
    
    // 如果DB已存在直接return
    if ([[NSFileManager defaultManager] fileExistsAtPath:dbPath])
    {
        queue = [BOPFMDatabaseQueue databaseQueueWithPath:dbPath];
        return;
    }

    // 创建DB
    queue = [BOPFMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(BOPFMDatabase *db) {
        
        //  联系人表
        [db executeUpdate:@"create table ContactDataTable (userId text primary key, account text,username test, nickName text, portrait text)"];
        
        //  当前用户表
        [db executeUpdate:@"create table CurrentUserTable (userId text primary key, account text, password text, nickName text, time text)"];
        
        //  未读消息表
//        [db executeUpdate:@"create table UnReadTable ()"];
        
    }];
}

@end
