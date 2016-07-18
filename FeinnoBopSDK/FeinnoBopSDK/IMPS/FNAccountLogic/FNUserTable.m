//
//  FNUserTable.m
//  feinno-sdk-db
//
//  Created by wangshuying on 14-8-22.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNUserTable.h"
#import "FNDBManager.h"
#import "BOPFMDB.h"

@implementation FNUserTable

+ (instancetype)get
{
    __block FNUserTable *user = [[FNUserTable alloc] init];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from User"];
        BOPFMResultSet *rs = [db executeQuery:sql];
        if ([rs next]) {
            user.userId    = [rs stringForColumn:@"userId"];
            user.email     = [rs stringForColumn:@"email"];
            user.mobileNo  = [rs longForColumn:@"mobileNo"];
            user.name      = [rs stringForColumn:@"name"];
            user.groupListVersion = [rs longForColumn:@"groupListVersion"];
            user.privateSyncID = [rs longForColumn:@"privateSyncId"];
            user.pgSyncID = [rs longForColumn:@"pgSyncId"];
            user.ntfSyncID = [rs longForColumn:@"ntfSyncId"];
            user.sysSyncId = [rs longForColumn:@"sysSyncId"];
        }
        [rs close];
    }];
    return user;
}

+ (BOOL)insert:(FNUserTable *)user
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"replace into User(userId, email, mobileNo, name, groupListVersion, privateSyncId, pgSyncId, ntfSyncId, sysSyncId) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        result = [db executeUpdate:sql,
                  user.userId,
                  user.email,
                  [NSNumber numberWithLong:user.mobileNo],
                  user.name,
                  [NSNumber numberWithLong:user.groupListVersion],
                  [NSNumber numberWithLong:user.privateSyncID],
                  [NSNumber numberWithLong:user.pgSyncID],
                  [NSNumber numberWithLong:user.ntfSyncID],
                  [NSNumber numberWithLong:user.sysSyncId]
                  ];
    }];
    return result;
}

+ (BOOL)delete
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from User";
        result = [db executeUpdate:sql];
    }];
    return result;
}

+ (BOOL)clearAll
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from User"];
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        return result;
    }
    
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"alter Table User AUTO_INCREMENT = 1"];
        result = [db executeUpdate:sql];
    }];
    
    return result;
}

+ (BOOL)setSyncId:(EventType)event
           syncId:(int64_t)syncId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql;
        switch (event) {
            case EventTypePrivate:
            {
                sql = @"update User set privateSyncId=?";
                break;
            }
            case EventTypePG:
            {
                sql = @"update User set pgSyncId=?";
                break;
            }
            case EventTypeNtf:
            {
                sql = @"update User set ntfSyncId=?";
                break;
            }
            case EventTypeSysMsg:
            {
                sql = @"update User Set sysSyncId=?";
                break;
            }
            default:
                break;
        }
        result = [db executeUpdate:sql, [NSNumber numberWithLongLong:syncId]];
    }];
    return result;
}

+ (long)getSyncId:(EventType)event
{
    __block long syncId = 0L;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql;
        switch (event) {
            case EventTypePrivate:
            {
                sql = @"select privateSyncId from User";
                break;
            }
            case EventTypePG:
            {
                sql = @"select pgSyncId from User";
                break;
            }
            case EventTypeNtf:
            {
                sql = @"select ntfSyncId from User";
                break;
            }
            case EventTypeSysMsg:
            {
                sql = @"select sysSyncId from User";
                break;
            }
            default:
                break;
        }
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            syncId = [rs longForColumnIndex:0];
        }
    }];
    return syncId;
}

+ (BOOL)setGroupListVersion:(long)groupListVersion
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update User set groupListVersion=?";
        result = [db executeUpdate:sql, [NSNumber numberWithLong:groupListVersion]];
    }];
    return result;
}

+ (long)getGroupListVersion
{
    __block long groupListVersion = 0L;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"select groupListVersion from User";
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            groupListVersion = [rs longForColumnIndex:0];
        }
    }];
    return groupListVersion;
}

// 更新拉取历史消息的lastRmsId
+ (BOOL)setHistoryLastRmsId:(NSString *)lastRmsId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        
        NSString *sql = @"update User set lastRmsId= ?";
        result = [db executeUpdate:sql,lastRmsId];
        
    }];
    return result;
    
}

+ (NSString *)getHistoryLastRmsId
{
    __block NSString *lastRmsId =nil;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"select lastRmsId from User";
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            lastRmsId = [rs  stringForColumnIndex:0];
        }
    }];
    return lastRmsId;
}

@end
