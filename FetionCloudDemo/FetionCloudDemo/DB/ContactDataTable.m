//
//  ContactDataTable.m
//  FetionCloudDemo
//
//  Created by Nemo on 16/3/2.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "ContactDataTable.h"
#import "DBManager.h"
#import "BOPFMDB.h"
#import "ContactDataTable+Extension.h"

@implementation ContactDataTable

+ (ContactDataTable *)getWithUserId:(NSString *)userId
{
    userId = [self formatWithUserId:userId];
    __block ContactDataTable *user = [[ContactDataTable alloc] init];
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from ContactDataTable where userId=?"];
        BOPFMResultSet *rs = [db executeQuery:sql,
                              userId];
        if ([rs next]) {
            user.userId = [rs stringForColumn:@"userId"];
            user.account = [rs stringForColumn:@"account"];
            user.nickName = [rs stringForColumn:@"nickName"];
            user.portrait = [rs stringForColumn:@"portrait"];
        }
        [rs close];
    }];
    return user;
}

+ (NSArray *)getAll
{
    __block NSMutableArray *array = [NSMutableArray array];
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from ContactDataTable"];
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ContactDataTable *user = [[ContactDataTable alloc] init];
            user.userId = [rs stringForColumn:@"userId"];
            user.account = [rs stringForColumn:@"account"];
            user.nickName = [rs stringForColumn:@"nickName"];
            user.portrait = [rs stringForColumn:@"portrait"];
            [array addObject:user];
        }
        [rs close];
    }];
    return array;
}

+ (BOOL)insert:(ContactDataTable *)user
{   
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"insert into ContactDataTable(userId, account, nickName, portrait) values(?, ?, ?, ?)";
        result = [db executeUpdate:sql,
                  user.userId,
                  user.account,
                  user.nickName,
                  user.portrait
                  ];
    }];
    return result;
}

+ (BOOL)update:(ContactDataTable *)user
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update ContactDataTable set userId=?, account=?, nickName=?, portrait=?";
        result = [db executeUpdate:sql,
                  user.userId,
                  user.account,
                  user.nickName,
                  user.portrait
                  ];
    }];
    return result;
}

+ (BOOL)del:(NSString *)userId
{
    userId = [self formatWithUserId:userId];
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from ContactDataTable where userId=?";
        result = [db executeUpdate:sql,
                  userId];
    }];
    return result;
}

@end
