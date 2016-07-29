//
//  CurrentUserTable.m
//  FetionCloudDemo
//
//  Created by Nemo on 16/3/2.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "CurrentUserTable.h"
#import "DBManager.h"
#import "BOPFMDB.h"

@implementation CurrentUserTable

+ (CurrentUserTable *)getLastUser
{
    __block CurrentUserTable *user = [[CurrentUserTable alloc] init];
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from CurrentUserTable order by time desc limit 0,1"];
        BOPFMResultSet *rs = [db executeQuery:sql];
        if ([rs next]) {
            user.userId = [rs stringForColumn:@"userId"];
            user.account = [rs stringForColumn:@"account"];
            user.password = [rs stringForColumn:@"password"];
            user.nickName = [rs stringForColumn:@"nickName"];
            user.time = [rs stringForColumn:@"time"];
        }
        [rs close];
    }];
    return user;
}

+ (CurrentUserTable *)getWithUserId:(NSString *)userId
{
    __block CurrentUserTable *user = [[CurrentUserTable alloc] init];
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from CurrentUserTable where userId=?"];
        BOPFMResultSet *rs = [db executeQuery:sql,
                              userId];
        if ([rs next]) {
            user.userId = [rs stringForColumn:@"userId"];
            user.account = [rs stringForColumn:@"account"];
            user.password = [rs stringForColumn:@"password"];
            user.nickName = [rs stringForColumn:@"nickName"];
            user.time = [rs stringForColumn:@"time"];
        }
        [rs close];
    }];
    return user;
}

+ (BOOL)insert:(CurrentUserTable *)user
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"insert into CurrentUserTable(userId, account, password, nickName, time) values(?, ?, ?, ?, ?)";
        result = [db executeUpdate:sql,
                  user.userId,
                  user.account,
                  user.password,
                  user.nickName,
                  [NSDate date]
                  ];
    }];
    return result;
}

+ (BOOL)update:(CurrentUserTable *)user
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update CurrentUserTable set userId=?, account=?, password=?, nickName=?, time=?";
        result = [db executeUpdate:sql,
                  user.userId,
                  user.account,
                  user.password,
                  user.nickName,
                  [NSDate date]];
    }];
    return result;
}

+ (BOOL)del:(CurrentUserTable *)user
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from CurrentUserTable where userId=?";
        result = [db executeUpdate:sql,
                  user.userId];
    }];
    return result;
}

@end
