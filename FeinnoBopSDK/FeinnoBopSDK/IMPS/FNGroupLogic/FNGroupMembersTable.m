//
//  FNGroupMembersTable.m
//  feinno-sdk-db
//
//  Created by doujinkun on 14/11/21.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNGroupMembersTable.h"
#import "FNDBManager.h"
#import "BOPFMDB.h"

@implementation FNGroupMembersTable

+ (NSMutableArray *)get:(NSString *)groupId {
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"select * from GroupMembers where groupId=?";
        BOPFMResultSet *rs = [db executeQuery:sql, groupId];
        while ([rs next])
        {
            FNGroupMembersTable *cli   = [[FNGroupMembersTable alloc] init];
            cli.groupId       = [rs stringForColumnIndex:0];
            cli.memberID      = [rs stringForColumnIndex:1];
            cli.memberNickName = [rs stringForColumnIndex:2];
            cli.memberProtaitUrl = [rs stringForColumnIndex:3];
            cli.identity      = [rs intForColumnIndex:4];
            
            [array addObject:cli];
        }
    }];
    return array;
}

+ (NSMutableArray *)getGroupMemberByNickName:(NSString *)memberNickName number:(int32_t)number page:(int32_t)page groupId:(NSString *)groupId
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = nil;
        if (groupId)
        {
            sql = [NSString stringWithFormat:@"select * from GroupMembers where groupId='%@' and memberNickName like '%%%@%%' limit %d offset %d", groupId, memberNickName, number, (page - 1) * number];
        }
        else
        {
            sql = [NSString stringWithFormat:@"select * from GroupMembers where memberNickName like '%%%@%%' limit %d offset %d",memberNickName, number, (page - 1) * number];
        }
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            FNGroupMembersTable *cli   = [[FNGroupMembersTable alloc] init];
            cli.groupId       = [rs stringForColumnIndex:0];
            cli.memberID      = [rs stringForColumnIndex:1];
            cli.memberNickName = [rs stringForColumnIndex:2];
            cli.memberProtaitUrl = [rs stringForColumnIndex:3];
            cli.identity      = [rs intForColumnIndex:4];
            
            [array addObject:cli];
        }
    }];
    return array;
}

+ (BOOL)insert:(FNGroupMembersTable *)groupInfo
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"replace into GroupMembers values(?, ?, ?, ?, ?)";
        result = [db executeUpdate:sql,
                  groupInfo.groupId,
                  groupInfo.memberID,
                  groupInfo.memberNickName,
                  groupInfo.memberProtaitUrl,
                  [NSNumber numberWithInt:groupInfo.identity]];
    }];
    return result;
}

+ (BOOL)delete:(NSString *)memberID
       groupId:(NSString *)groupId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from GroupMembers where memberID=? and groupId=?";
        if (nil == memberID)
        {
            sql = @"delete from GroupMembers where groupId=?";
        }
        result = [db executeUpdate:sql, memberID, groupId];
    }];
    return result;
}

+ (BOOL)update:(NSString *)groupId
        memberId:(NSString *)memberId
      groupOwnerId:(NSString *)groupOwnerId;
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *old = @"update GroupMembers set identity=? where memberID=? and groupId=?";
        [db executeUpdate:old, [NSNumber numberWithInt:1], groupId, memberId];
        
        NSString *sql = @"update GroupMembers set identity=? where memberID=? and groupId=?";
        result = [db executeUpdate:sql,
                  [NSNumber numberWithInt:0],
                  groupId,
                  groupOwnerId];
    }];
    return result;
}

+ (BOOL)updateGroupMemberNickName:(NSString *)groupMemberNickName
                         memberId:(NSString *)memberId
                          groupId:(NSString *)groupId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update GroupMembers set memberNickName=? where memberID=? and groupId=?";
        result = [db executeUpdate:sql,
                  groupMemberNickName,
                  memberId,
                  groupId];
    }];
    return result;
}

+ (BOOL)updateGroupMemberProtaitUrl:(NSString *)memberGroupProtaitUrl
                           memberId:(NSString *)memberId
                            groupId:(NSString *)groupId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update GroupMembers set memberProtraitUrl=? where memberID=? and groupId=?";
        result = [db executeUpdate:sql,
                  memberGroupProtaitUrl,
                  memberId,
                  groupId];
    }];
    return result;
}

+ (BOOL)clearAll
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from GroupMembers";
        result = [db executeUpdate:sql];
    }];
    return result;
}

@end
