//
//  FNGroupTable.m
//  feinno-sdk-db
//
//  Created by doujinkun on 14/11/13.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNGroupTable.h"
#import "FNDBManager.h"
#import "BOPFMDB.h"

@implementation FNGroupTable

@synthesize groupId;
@synthesize groupName;
@synthesize groupType;

+ (NSMutableArray *)get:(NSString *)groupId
              groupType:(int32_t)groupType
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        BOPFMResultSet *rs;
        NSString *sql;
        if (nil == groupId)
        {
            sql = [NSString stringWithFormat:@"select * from Groups where groupType=%d", groupType];
        }
        else
        {
            sql = [NSString stringWithFormat:@"select * from Groups where groupId=? and groupType=%d", groupType];
        }
        rs = [db executeQuery:sql, groupId];
        while ([rs next])
        {
            FNGroupTable *cli= [[FNGroupTable alloc] init];
            cli.groupId = [rs stringForColumnIndex:0];
            cli.groupType = [rs intForColumnIndex:1];
            cli.groupName = [rs stringForColumnIndex:2];
            cli.groupProtaitUrl = [rs stringForColumnIndex:3];
            cli.userNickname = [rs stringForColumnIndex:4];
            cli.identity = [rs intForColumnIndex:5];
            cli.config = [rs intForColumnIndex:6];
            [array addObject:cli];
        }
    }];
    return array;
}

+ (NSMutableArray *)get:(NSString *)groupId{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        BOPFMResultSet *rs;
        NSString *sql;
        sql = [NSString stringWithFormat:@"select * from Groups where groupId=?"];
        
        rs = [db executeQuery:sql,groupId];
        while ([rs next])
        {
            FNGroupTable *cli= [[FNGroupTable alloc] init];
            cli.groupId = [rs stringForColumnIndex:0];
            cli.groupType = [rs intForColumnIndex:1];
            cli.groupName = [rs stringForColumnIndex:2];
            cli.groupProtaitUrl = [rs stringForColumnIndex:3];
            cli.userNickname = [rs stringForColumnIndex:4];
            cli.identity = [rs intForColumnIndex:5];
            cli.config = [rs intForColumnIndex:6];
            [array addObject:cli];
        }
    }];
    return array;
}

+ (BOOL)insert:(FNGroupTable *)groupInfo
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"replace into Groups values(?,?,?,?,?,?,?)";
        result = [db executeUpdate:sql, groupInfo.groupId,
                  [NSNumber numberWithInt:groupInfo.groupType],
                  groupInfo.groupName,
                  groupInfo.groupProtaitUrl,
                  groupInfo.userNickname,
                  [NSNumber numberWithInt:groupInfo.identity],
                  [NSNumber numberWithInt:groupInfo.config]];
    }];
    return result;
}

+ (BOOL)update:(NSString *)groupId
     groupName:(NSString *)groupName
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update Groups set groupName=? where groupId=?";
        result = [db executeUpdate:sql, groupName, groupId];
    }];
    return result;
}

+ (BOOL)update:(NSString *)groupId groupProtaitUrl:(NSString *)groupProtaitUrl
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update Groups set groupProtraitUrl=? where groupId=?";
        result = [db executeUpdate:sql, groupProtaitUrl, groupId];
    }];
    return result;
}

+ (BOOL)update:(NSString *)groupId groupConfig:(int32_t)groupConfig
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update Groups set config=? where groupId=?";
        result = [db executeUpdate:sql, groupConfig, groupId];
    }];
    return result;
}

+ (BOOL)delete:(NSString *)groupId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from Groups where groupId=?";
        result = [db executeUpdate:sql, groupId];
    }];
    return result;
}

+ (BOOL)clearAll
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from Groups";
        result = [db executeUpdate:sql];
    }];
    return result;
}

+ (BOOL)clear:(int32_t)groupType
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from Groups where groupType=%d", groupType];
        result = [db executeUpdate:sql];
    }];
    return result;
}

@end
