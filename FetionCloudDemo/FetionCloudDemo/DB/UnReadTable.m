//
//  UnReadTable.m
//  FetionCloudDemo
//
//  Created by Nemo on 16/3/2.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "UnReadTable.h"
#import "DBManager.h"
#import "BOPFMDB.h"

@implementation UnReadTable

//- (UnReadTable *)get
//{
//    __block UnReadTable *user = [[UnReadTable alloc] init];
//    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
//    [queue inDatabase:^(BOPFMDatabase *db) {
//        NSString *sql = [NSString stringWithFormat:@"select * from UnReadTable"];
//        BOPFMResultSet *rs = [db executeQuery:sql];
//        if ([rs next]) {
//            user.userId = [rs stringForColumn:@"userId"];
//            user.account = [rs stringForColumn:@"account"];
//            user.nickName = [rs stringForColumn:@"nickName"];
//        }
//        [rs close];
//    }];
//    return user;
//}
//
//- (BOOL)insert:(UnReadTable *)user
//{
//    __block BOOL result = NO;
//    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
//    [queue inDatabase:^(BOPFMDatabase *db) {
//        NSString *sql = @"insert into UnReadTable(userId, account, nickName) values(?, ?, ?)";
//        result = [db executeUpdate:sql,
//                  user.userId,
//                  user.account,
//                  user.nickName
//                  ];
//    }];
//    return result;
//}
//
//- (BOOL)update:(UnReadTable *)user
//{
//    __block BOOL result = NO;
//    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
//    [queue inDatabase:^(BOPFMDatabase *db) {
//        NSString *sql = @"update UnReadTable set userId=?, account=?, nickName=?";
//        result = [db executeUpdate:sql,
//                  user.userId,
//                  user.account,
//                  user.nickName];
//    }];
//    return result;
//}
//
//- (BOOL)del:(UnReadTable *)user
//{
//    __block BOOL result = NO;
//    BOPFMDatabaseQueue *queue = [DBManager sharedDatabaseQueue];
//    [queue inDatabase:^(BOPFMDatabase *db) {
//        NSString *sql = @"delete from UnReadTable where userId=?";
//        result = [db executeUpdate:sql,
//                  user.userId];
//    }];
//    return result;
//}

@end
