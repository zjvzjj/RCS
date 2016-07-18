//
//  FNGroupNotifyTable.m
//  FeinnoBopSDK-db
//
//  Created by doujinkun on 15/3/18.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNGroupNotifyTable.h"
#import "FNDBManager.h"
#import "BOPFMDB.h"

@implementation FNGroupNotifyTable

+ (NSArray *)get:(int32_t)msgType
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"select * from GroupNotify where msgType = ?";
        BOPFMResultSet *rs = [db executeQuery:sql, msgType];
        while ([rs next])
        {
            FNGroupNotifyTable *cli  = [[FNGroupNotifyTable alloc] init];
            cli.msgType = [rs stringForColumnIndex:0];
            cli.groupId = [rs stringForColumnIndex:1];
            cli.groupName = [rs stringForColumnIndex:2];
            cli.memberProtraitUrl = [rs stringForColumnIndex:3];
            cli.sourceUserId = [rs stringForColumnIndex:4];
            cli.sourceUserNickname = [rs stringForColumnIndex:5];
            cli.targetUserId = [rs stringForColumnIndex:6];
            cli.targetUserNickname = [rs stringForColumnIndex:7];
            cli.msgId = [rs stringForColumnIndex:8];
            cli.handleFlag = [rs intForColumnIndex:9];
            cli.handleResult = [rs intForColumnIndex:10];
            cli.createDate = [rs stringForColumnIndex:11];
            cli.sortKey = [rs intForColumnIndex:12];
            
            [array addObject:cli];
        }
    }];
    return array;
}

+ (BOOL)insert:(FNGroupNotifyTable *)notify
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"replace into GroupNotify values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        result = [db executeUpdate:sql,
                  notify.msgType,
                  notify.groupId,
                  notify.groupName,
                  notify.memberProtraitUrl,
                  notify.sourceUserId,
                  notify.sourceUserNickname,
                  notify.targetUserId,
                  notify.targetUserNickname,
                  notify.msgId,
                  [NSNumber numberWithInt:notify.handleFlag],
                  [NSNumber numberWithInt:notify.handleResult],
                  notify.createDate,
                  [NSNumber numberWithLongLong:notify.sortKey]];
    }];
    return result;
}

+ (BOOL)delete:(NSString *)messageId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from GroupNotify where msgId=?";
        result = [db executeUpdate:sql, messageId];
    }];
    return result;
}

+ (BOOL)clearAll
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from Notify";
        result = [db executeUpdate:sql];
    }];
    return result;
}

@end
