//
//  ContactRequestTable.m
//  FetionCloudDemo
//
//  Created by 张静杰 on 16/7/25.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "ContactRequestTable.h"

@implementation ContactRequestTable

+ (ContactRequestTable *)getWithUserId:(NSString *)userId
{
    //    userId = [self formatWithUserId:userId];
    __block ContactRequestTable *user = [[ContactRequestTable alloc] init];
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from ContactRequestTable where userId=?"];
        BOPFMResultSet *rs = [db executeQuery:sql,
                              userId];
        if ([rs next]) {
            user.userId = [rs stringForColumn:@"userId"];
            user.username = [rs stringForColumn:@"username"];
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
        NSString *sql = [NSString stringWithFormat:@"select * from ContactRequestTable"];
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ContactRequestTable *user = [[ContactRequestTable alloc] init];
            user.userId = [rs stringForColumn:@"userId"];
            user.username = [rs stringForColumn:@"username"];
            user.nickName = [rs stringForColumn:@"nickName"];
            user.portrait = [rs stringForColumn:@"portrait"];
            [array addObject:user];
        }
        [rs close];
    }];
    return array;
}

+ (BOOL)insert:(ContactRequestTable *)user
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"insert into ContactRequestTable(userId, username, nickName, portrait) values(?, ?, ?, ?)";
        result = [db executeUpdate:sql,
                  user.userId,
                  user.username,
                  user.nickName,
                  user.portrait
                  ];
    }];
    return result;
}

+ (BOOL)del:(NSString *)userId
{
    //    userId = [self formatWithUserId:userId];
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from ContactRequestTable where userId=?";
        result = [db executeUpdate:sql,
                  userId];
    }];
    return result;
}
@end
