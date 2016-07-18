//
//  FNSystemNotifyTable.m
//  FeinnoBopSDK
//
//  Created by zym on 15/4/3.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNSystemNotifyTable.h"
#import "FNDBManager.h"
#import "BOPFMDB.h"

@implementation FNSystemNotifyTable

+ (FNSystemNotifyTable *)get:(int64_t)msgId
{
    __block FNSystemNotifyTable *data = [[FNSystemNotifyTable alloc] init];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"select * from SystemNotify where msgId = ?";
        BOPFMResultSet *rs = [db executeQuery:sql, msgId];
        if ([rs next])
        {
            data.fromUserId = [rs stringForColumnIndex:0];
            data.msgId = [rs longForColumnIndex:1];
            data.title = [rs stringForColumnIndex:2];
            data.msgType = [rs intForColumnIndex:3];
            data.sendDate = [rs stringForColumnIndex:4];
            data.readStatus = [rs intForColumnIndex:5];
            data.msgBody = [rs stringForColumnIndex:6];
        }
    }];
    return data;
}

+ (NSMutableArray *)getList
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"select * from SystemNotify";
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            FNSystemNotifyTable *data = [[FNSystemNotifyTable alloc] init];
            data.fromUserId = [rs stringForColumnIndex:0];
            data.msgId = [rs longForColumnIndex:1];
            data.title = [rs stringForColumnIndex:2];
            data.msgType = [rs intForColumnIndex:3];
            data.sendDate = [rs stringForColumnIndex:4];
            data.readStatus = [rs intForColumnIndex:5];
            data.msgBody = [rs stringForColumnIndex:6];
            
            [array addObject:data];
        }
    }];
    return array;
}

+ (BOOL)insert:(FNSystemNotifyTable *)systemNotify
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"replace into SystemNotify values(?, ?, ?, ?, ?, ?, ?)";
        result = [db executeUpdate:sql,
                  systemNotify.fromUserId,
                  [NSNumber numberWithLongLong:systemNotify.msgId],
                  systemNotify.title,
                  [NSNumber numberWithInt:systemNotify.msgType],
                  systemNotify.sendDate,
                  [NSNumber numberWithLongLong:systemNotify.readStatus],
                  systemNotify.msgBody];
    }];
    return result;
}

+ (BOOL)delete:(int64_t)msgId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from SystemNotify where msgId=?";
        result = [db executeUpdate:sql, [NSNumber numberWithLongLong:msgId]];
    }];
    return result;
}

+ (BOOL)clearAll
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from SystemNotify";
        result = [db executeUpdate:sql];
    }];
    return result;
}

@end
