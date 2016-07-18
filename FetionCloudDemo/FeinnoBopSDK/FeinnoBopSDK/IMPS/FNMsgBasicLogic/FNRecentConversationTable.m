//
//  FNRecentConversationTable.m
//  FeinnoBopSDK-db
//
//  Created by zym on 15/2/3.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNRecentConversationTable.h"
#import "FNDBManager.h"
#import "BOPFMDB.h"
#import "BOPFMDatabaseAdditions.h"
#import "Utility.h"
#import "NSString+Extension.h"

@implementation FNRecentConversationTable

+ (NSMutableArray *)get
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from RecentConversation order by syncId desc,lastActiveDate desc"];
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            FNRecentConversationTable *recentConversation = [[FNRecentConversationTable alloc] init];
            recentConversation.targetId = [Utility userIdWithoutAppKey:[rs stringForColumnIndex:0]];
            recentConversation.targetName = [rs stringForColumnIndex:1];
            recentConversation.senderNickname = [rs stringForColumnIndex:2];
            recentConversation.targetProtraitUrl = [rs stringForColumnIndex:3];
            recentConversation.msgType = [rs stringForColumnIndex:8];
            recentConversation.content = [rs stringForColumnIndex:4];
            recentConversation.unreadMsgCount = [rs intForColumnIndex:5];
            recentConversation.syncId = [rs longForColumnIndex:6];
            recentConversation.lastActiveDate = [rs stringForColumnIndex:7];
            recentConversation.eventType = [rs intForColumnIndex:9];
            recentConversation.msgId = [rs stringForColumnIndex:10];
            recentConversation.sendStatus = [rs intForColumnIndex:11];
            
            [array addObject:recentConversation];
        }
    }];
    return array;
}

+ (NSMutableArray *)getByTid:(NSString *)tid
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from RecentConversation where tid = ?"];
        BOPFMResultSet *rs = [db executeQuery:sql, tid];
        while ([rs next])
        {
            FNRecentConversationTable *recentConversation = [[FNRecentConversationTable alloc] init];
            recentConversation.targetId = [Utility userIdWithoutAppKey:[rs stringForColumnIndex:0]];
            recentConversation.targetName = [rs stringForColumnIndex:1];
            recentConversation.senderNickname = [rs stringForColumnIndex:2];
            recentConversation.targetProtraitUrl = [rs stringForColumnIndex:3];
            recentConversation.content = [rs stringForColumnIndex:4];
            recentConversation.unreadMsgCount = [rs intForColumnIndex:5];
            recentConversation.syncId = [rs longForColumnIndex:6];
            recentConversation.lastActiveDate = [rs stringForColumnIndex:7];
            recentConversation.msgType = [rs stringForColumnIndex:8];
            recentConversation.eventType = [rs intForColumnIndex:9];
            recentConversation.msgId = [rs stringForColumnIndex:10];
            recentConversation.sendStatus = [rs intForColumnIndex:11];
            
            [array addObject:recentConversation];
        }
    }];
    return array;
}

+ (BOOL)updateContent:(NSString *)msgContent tid:(NSString *)tid
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update RecentConversation set content=? where tid=?";
        result = [db executeUpdate:sql, msgContent, tid];
    }];
    return result;
}

+ (BOOL)updateSendStatus:(int32_t)sendStatus syncId:(int64_t)syncId msgId:(NSString *)msgId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update RecentConversation set sendStatus=?, syncId = ? where msgId=?";
        result = [db executeUpdate:sql, [NSNumber numberWithInt:sendStatus], [NSNumber numberWithLong:syncId],msgId];
    }];
    return result;
}

+ (BOOL)insert:(FNRecentConversationTable *)info
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"replace into RecentConversation values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        result = [db executeUpdate:sql,
                  info.targetId,
                  info.targetName,
                  info.senderNickname,
                  info.targetProtraitUrl,
                  info.content,
                  [NSNumber numberWithLongLong:info.unreadMsgCount],
                  [NSNumber numberWithLongLong:info.syncId],
                  info.lastActiveDate,
                  info.msgType,
                  [NSNumber numberWithInt:info.eventType],
                  info.msgId,
                  [NSNumber numberWithInt:info.sendStatus]];
    }];
    return result;
}

+ (BOOL)delete:(NSString *)targetId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from RecentConversation where tid=?";
        result = [db executeUpdate:sql, targetId];
    }];
    return result;
}


+ (BOOL)clearAll
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from RecentConversation";
        result = [db executeUpdate:sql];
    }];
    return result;
}

+ (BOOL)updateUnReadCount:(NSString *)targetId
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"update RecentConversation set unreadMsgCount=? where tid=?";
        result = [db executeUpdate:sql, @0L, targetId];
    }];
    return result;
}

- (int64_t)setUnreadMsgCount
{
    if (nil == self || nil == _targetId)
    {
        [NSException raise:@"invalid call" format:@"object uninitialized!"];
    }
    
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql;
        if (_eventType == EventTypePrivate)
        {
            sql = [NSString stringWithFormat:@"select count(readStatus) from Message where tid=? and readStatus=?"];
        }
        else if (_eventType == EventTypePG)
        {
            sql = [NSString stringWithFormat:@"select count(readStatus) from GroupMsg where tid=? and readStatus=?"];
        }
        
        _unreadMsgCount = [db intForQuery:sql, _targetId, [NSNumber numberWithInt:MsgUnread]];
    }];
    return _unreadMsgCount;
}

- (void)setContent:(NSString *)content
{
    if ([_msgType isEqualToString:FNMsgTypePlain])
    {
        _content = content;
    }
    else if ([_msgType isEqualToString:FNMsgTypePic] && [NSString isNullString:_content])
    {
        _content = [NSString stringWithFormat:@"%@", ([NSString isNullString:content] ? @"[图片]" : content)];
    }
    else if ([_msgType isEqualToString:FNMsgTypeAudio] && [NSString isNullString:_content])
    {
        _content = [NSString stringWithFormat:@"%@", ([NSString isNullString:content] ? @"[语音]" : content)];
    }
    else if ([_msgType isEqualToString:FNMsgTypeVideo] && [NSString isNullString:_content])
    {
        _content = [NSString stringWithFormat:@"%@", ([NSString isNullString:content] ? @"[视频]" : content)];
    }
    else if ([_msgType isEqualToString:FNMsgTypeFile] && [NSString isNullString:_content])
    {
        _content = [NSString stringWithFormat:@"%@", ([NSString isNullString:content] ? @"[文件]" : content)];
    }
}

@end
