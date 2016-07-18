//
//  FNGroupMsgTable.m
//  feinno-sdk-db
//
//  Created by doujinkun on 14/11/19.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNGroupMsgTable.h"
#import "BOPFMDB.h"
#import "FNDBManager.h"
#import "BOPFMDatabaseAdditions.h"
#import "Utility.h"
#import "NSString+Extension.h"
#import "FNUserConfig.h"

@implementation FNGroupMsgTable

+ (NSMutableArray *)getHistoryMsgForGroupId:(NSString *)groupId
                                        num:(int32_t)num
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    __block int32_t number = num;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = nil;
        BOPFMResultSet *rs = nil;
        if (num > -1)
        {
            sql = @"select count(*) from GroupMsg where tid=?";
            int msgsSum = [db intForQuery:sql, groupId];
            number = MIN(num, msgsSum);
            int off = msgsSum > number ? (int)msgsSum - number : 0;
            sql = [NSString stringWithFormat:@"select * from GroupMsg where tid=? and readStatus=%d order by syncId asc, createDate asc limit %d offset %d", (int32_t)MsgAlreadyRead, number, off];
        }
        else
        {
            sql = [NSString stringWithFormat:@"select * from GroupMsg where tid=? order by syncId asc, createDate asc"];
        }
        rs = [db executeQuery:sql, groupId];
        while ([rs next])
        {
            FNGroupMsgTable *mt = [[FNGroupMsgTable alloc] init];
            
            // 第一列为ID
            mt.syncId = [rs longForColumnIndex:0];
            mt.msgId = [rs stringForColumnIndex:1];
            mt.tid = [rs stringForColumnIndex:2];
            mt.msgType = [rs stringForColumnIndex:3];
            mt.msgAttribute = [rs stringForColumnIndex:4];
            mt.contentType = [rs stringForColumnIndex:5];
            mt.content = [rs stringForColumnIndex:6];
            mt.senderNickname = [rs stringForColumnIndex:7];
            mt.senderId = [Utility userIdWithoutAppKey:[rs stringForColumnIndex:8]];
            mt.senderProtraitUrl = [rs stringForColumnIndex:9];
            mt.sendStatus = [rs intForColumnIndex:10];
            mt.readStatus = [rs intForColumnIndex:11];
            mt.flag = [rs intForColumnIndex:12];
            mt.createDate = [rs stringForColumnIndex:13];
            
            if (![mt.msgType isEqualToString:FNMsgTypePlain])
            {
                if (mt.flag == MsgSendFlag)
                {
                    sql = [NSString stringWithFormat:@"select * from RichTextMsg where msgId = ?"];
                }
                else
                {
                    sql = [NSString stringWithFormat:@"select * from RichTextMsg where syncId = ?"];
                }
                
                BOPFMResultSet *sRs = [db executeQuery:sql, (mt.flag == MsgSendFlag ? mt.msgId : [NSNumber numberWithLongLong:(int64_t)mt.syncId])];
                while ([sRs next])
                {
                    mt.fileId = [sRs stringForColumn:@"fileId"];
                    mt.fileName = [sRs stringForColumn:@"fileName"];
                    mt.fileSize = [sRs longForColumn:@"fileSize"];
                    mt.fileWidth = [sRs longForColumn:@"fileWidth"];
                    mt.fileHeight = [sRs longForColumn:@"fileHeight"];
                    mt.URL = [sRs stringForColumn:@"URL"];
                    mt.savePath = [sRs stringForColumn:@"savePath"];
                    mt.thumbPath = [sRs stringForColumn:@"thumbPath"];
                    mt.playTime = [sRs longForColumn:@"playTime"];
                    mt.bitrate = [sRs longForColumn:@"bitrate"];
                    mt.receiveStatus = [sRs intForColumn:@"receiveStatus"];
                    //                mt.processSize = [sRs longForColumn:@""];
                }
            }
            
            [array addObject:mt];
        }
    }];
    
    return array;
}

+ (NSMutableArray *)getUnreadMsgForGroupId:(NSString *)groupId
                                       num:(int32_t)num
                                 andSyncId:(NSInteger)syncId
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
//    __block int32_t number = num;
    __block NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = nil;
        BOPFMResultSet *rs = nil;
        sql = [NSString stringWithFormat:@"select *from GroupMsg where tid=? and syncId=? and senderId<>?"];
        NSString *delSql = [NSString stringWithFormat:@"update GroupMsg set readStatus=? where syncId=?"];
        
        [db executeUpdate:delSql,[NSNumber numberWithInt:MsgAlreadyRead],@(syncId)];
        rs = [db executeQuery:sql, groupId,@(syncId),sender];
        while ([rs next])
        {
            FNGroupMsgTable *mt = [[FNGroupMsgTable alloc] init];
            
            // 第一列为ID
            mt.syncId = [rs longForColumnIndex:0];
            mt.msgId = [rs stringForColumnIndex:1];
            mt.tid = [rs stringForColumnIndex:2];
            mt.msgType = [rs stringForColumnIndex:3];
            mt.msgAttribute = [rs stringForColumnIndex:4];
            mt.contentType = [rs stringForColumnIndex:5];
            mt.content = [rs stringForColumnIndex:6];
            mt.senderNickname = [rs stringForColumnIndex:7];
            mt.senderId = [Utility userIdWithoutAppKey:[rs stringForColumnIndex:8]];
            mt.senderProtraitUrl = [rs stringForColumnIndex:9];
            mt.sendStatus = [rs intForColumnIndex:10];
            mt.readStatus = [rs intForColumnIndex:11];
            mt.flag = [rs intForColumnIndex:12];
            mt.createDate = [rs stringForColumnIndex:13];
            
            if (![mt.msgType isEqualToString:FNMsgTypePlain])
            {
                if (mt.flag == MsgSendFlag)
                {
                    sql = [NSString stringWithFormat:@"select * from RichTextMsg where msgId = ?"];
                }
                else
                {
                    sql = [NSString stringWithFormat:@"select * from RichTextMsg where syncId = ?"];
                }
                
                BOPFMResultSet *sRs = [db executeQuery:sql, (mt.flag == MsgSendFlag ? mt.msgId : [NSNumber numberWithLongLong:mt.syncId])];
                while ([sRs next])
                {
                    mt.fileId = [sRs stringForColumn:@"fileId"];
                    mt.fileName = [sRs stringForColumn:@"fileName"];
                    mt.fileSize = [sRs longForColumn:@"fileSize"];
                    mt.fileWidth = [sRs longForColumn:@"fileWidth"];
                    mt.fileHeight = [sRs longForColumn:@"fileHeight"];
                    mt.URL = [sRs stringForColumn:@"URL"];
                    mt.savePath = [sRs stringForColumn:@"savePath"];
                    mt.thumbPath = [sRs stringForColumn:@"thumbPath"];
                    mt.playTime = [sRs longForColumn:@"playTime"];
                    mt.bitrate = [sRs longForColumn:@"bitrate"];
                    mt.receiveStatus = [sRs intForColumn:@"receiveStatus"];
                    // mt.processSize = [sRs longForColumn:@""];
                }
            }
            
            [array addObject:mt];
        }
        
    }];
    
    return array;
    
}
+ (NSMutableArray *)getUnreadMsgForGroupId:(NSString *)groupId
                                       num:(int32_t)num
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    __block int32_t number = num;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = nil;
        BOPFMResultSet *rs = nil;
        if (num > -1)
        {
            sql = [NSString stringWithFormat:@"select count(*) from GroupMsg where tid=?"];
            int msgsSum = [db intForQuery:sql, groupId];
            sql = [NSString stringWithFormat:@"select count(*) from GroupMsg where tid=? and readStatus=%d", (int32_t)MsgUnread];
            int unreadMsgsCount = [db intForQuery:sql, groupId];
            
            int off = 0;
            number = unreadMsgsCount; // 未读消息全部取出
            off = msgsSum > number ? msgsSum - number : 0;
            sql = [NSString stringWithFormat:@"select * from GroupMsg where tid=? order by syncId asc, createDate asc limit %d offset %d", number, off];
        }
        else
        {
            sql = [NSString stringWithFormat:@"select * from GroupMsg where tid=? order by syncId asc, createDate asc"];
        }
        rs = [db executeQuery:sql, groupId];
        while ([rs next])
        {
            FNGroupMsgTable *mt = [[FNGroupMsgTable alloc] init];
            
            // 第一列为ID
            mt.syncId = [rs longForColumnIndex:0];
            mt.msgId = [rs stringForColumnIndex:1];
            mt.tid = [rs stringForColumnIndex:2];
            mt.msgType = [rs stringForColumnIndex:3];
            mt.msgAttribute = [rs stringForColumnIndex:4];
            mt.contentType = [rs stringForColumnIndex:5];
            mt.content = [rs stringForColumnIndex:6];
            mt.senderNickname = [rs stringForColumnIndex:7];
            mt.senderId = [Utility userIdWithoutAppKey:[rs stringForColumnIndex:8]];
            mt.senderProtraitUrl = [rs stringForColumnIndex:9];
            mt.sendStatus = [rs intForColumnIndex:10];
            mt.readStatus = [rs intForColumnIndex:11];
            mt.flag = [rs intForColumnIndex:12];
            mt.createDate = [rs stringForColumnIndex:13];
            
            if (![mt.msgType isEqualToString:FNMsgTypePlain])
            {
                if (mt.flag == MsgSendFlag)
                {
                    sql = [NSString stringWithFormat:@"select * from RichTextMsg where msgId = ?"];
                }
                else
                {
                    sql = [NSString stringWithFormat:@"select * from RichTextMsg where syncId = ?"];
                }
                
                BOPFMResultSet *sRs = [db executeQuery:sql, (mt.flag == MsgSendFlag ? mt.msgId : [NSNumber numberWithLongLong:mt.syncId])];
                while ([sRs next])
                {
                    mt.fileId = [sRs stringForColumn:@"fileId"];
                    mt.fileName = [sRs stringForColumn:@"fileName"];
                    mt.fileSize = [sRs longForColumn:@"fileSize"];
                    mt.fileWidth = [sRs longForColumn:@"fileWidth"];
                    mt.fileHeight = [sRs longForColumn:@"fileHeight"];
                    mt.URL = [sRs stringForColumn:@"URL"];
                    mt.savePath = [sRs stringForColumn:@"savePath"];
                    mt.thumbPath = [sRs stringForColumn:@"thumbPath"];
                    mt.playTime = [sRs longForColumn:@"playTime"];
                    mt.bitrate = [sRs longForColumn:@"bitrate"];
                    mt.receiveStatus = [sRs intForColumn:@"receiveStatus"];
                    //                mt.processSize = [sRs longForColumn:@""];
                }
            }
            
            [array addObject:mt];
        }
        
        // 设置全部未读消息的读装填字段
        sql = [NSString stringWithFormat:@"update GroupMsg set readStatus=? where readStatus=?"];
        [db executeUpdate:sql, [NSNumber numberWithInt:MsgAlreadyRead], [NSNumber numberWithInt:MsgUnread]];
    }];
    
    return array;
}

+ (NSArray *)getMsgBySyncId:(int64_t)syncId
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from GroupMsg where syncId=%lld", syncId];
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            FNGroupMsgTable *mt = [[FNGroupMsgTable alloc] init];
            
            // 第一列为ID
            mt.syncId = [rs longForColumnIndex:0];
            mt.msgId = [rs stringForColumnIndex:1];
            mt.tid = [rs stringForColumnIndex:2];
            mt.msgType = [rs stringForColumnIndex:3];
            mt.msgAttribute = [rs stringForColumnIndex:4];
            mt.contentType = [rs stringForColumnIndex:5];
            mt.content = [rs stringForColumnIndex:6];
            mt.senderNickname = [rs stringForColumnIndex:7];
            mt.senderId = [Utility userIdWithoutAppKey:[rs stringForColumnIndex:8]];
            mt.senderProtraitUrl = [rs stringForColumnIndex:9];
            mt.sendStatus = [rs intForColumnIndex:10];
            mt.readStatus = [rs intForColumnIndex:11];
            mt.flag = [rs intForColumnIndex:12];
            mt.createDate = [rs stringForColumnIndex:13];
            
            if (![mt.msgType isEqualToString:FNMsgTypePlain])
            {
                sql = [NSString stringWithFormat:@"select * from RichTextMsg where syncId=?"];
                BOPFMResultSet *sRs = [db executeQuery:sql, mt.syncId];
                while ([sRs next])
                {
                    mt.fileId = [sRs stringForColumn:@"fileId"];
                    mt.fileName = [sRs stringForColumn:@"fileName"];
                    mt.fileSize = [sRs longForColumn:@"fileSize"];
                    mt.fileWidth = [sRs longForColumn:@"fileWidth"];
                    mt.fileHeight = [sRs longForColumn:@"fileHeight"];
                    mt.URL = [sRs stringForColumn:@"URL"];
                    mt.savePath = [sRs stringForColumn:@"savePath"];
                    mt.thumbPath = [sRs stringForColumn:@"thumbPath"];
                    mt.playTime = [sRs longForColumn:@"playTime"];
                    mt.bitrate = [sRs longForColumn:@"bitrate"];
                    mt.receiveStatus = [sRs intForColumn:@"receiveStatus"];
//                mt.processSize = [sRs longForColumn:@""];
                }
            }
            
            [array addObject:mt];
        }
    }];
    
    return array;
}

+ (NSArray *)getMsgByMsgId:(NSString *)msgId
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from GroupMsg where msgId=?"];
        BOPFMResultSet *rs = [db executeQuery:sql, msgId];
        while ([rs next])
        {
            FNGroupMsgTable *mt = [[FNGroupMsgTable alloc] init];
            
            // 第一列为ID
            mt.syncId = [rs longForColumnIndex:0];
            mt.msgId = [rs stringForColumnIndex:1];
            mt.tid = [rs stringForColumnIndex:2];
            mt.msgType = [rs stringForColumnIndex:3];
            mt.msgAttribute = [rs stringForColumnIndex:4];
            mt.contentType = [rs stringForColumnIndex:5];
            mt.content = [rs stringForColumnIndex:6];
            mt.senderNickname = [rs stringForColumnIndex:7];
            mt.senderId = [Utility userIdWithoutAppKey:[rs stringForColumnIndex:8]];
            mt.senderProtraitUrl = [rs stringForColumnIndex:9];
            mt.sendStatus = [rs intForColumnIndex:10];
            mt.readStatus = [rs intForColumnIndex:11];
            mt.flag = [rs intForColumnIndex:12];
            mt.createDate = [rs stringForColumnIndex:13];
            
            if (![mt.msgType isEqualToString:FNMsgTypePlain])
            {
                sql = [NSString stringWithFormat:@"select * from RichTextMsg where msgId=?"];
                BOPFMResultSet *sRs = [db executeQuery:sql, mt.msgId];
                while ([sRs next])
                {
                    mt.fileId = [sRs stringForColumn:@"fileId"];
                    mt.fileName = [sRs stringForColumn:@"fileName"];
                    mt.fileSize = [sRs longForColumn:@"fileSize"];
                    mt.fileWidth = [sRs longForColumn:@"fileWidth"];
                    mt.fileHeight = [sRs longForColumn:@"fileHeight"];
                    mt.URL = [sRs stringForColumn:@"URL"];
                    mt.savePath = [sRs stringForColumn:@"savePath"];
                    mt.thumbPath = [sRs stringForColumn:@"thumbPath"];
                    mt.playTime = [sRs longForColumn:@"playTime"];
                    mt.bitrate = [sRs longForColumn:@"bitrate"];
                    mt.receiveStatus = [sRs intForColumn:@"receiveStatus"];
//                mt.processSize = [sRs longForColumn:@""];
                }
            }
            
            [array addObject:mt];
        }
    }];
    
    return array;
}

+ (NSArray *)getMsgByContent:(NSString *)msgContent number:(int32_t)number page:(int32_t)page groupId:(NSString *)groupId
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = nil;
        if (groupId)
        {
            sql = [NSString stringWithFormat:@"select * from GroupMsg where tid = '%@' and (content like '%%%@%%' or senderNickName like '%%%@%%') limit %d offset %d", groupId, msgContent, msgContent, number, (page - 1) * number];
        }
        else
        {
            sql = [NSString stringWithFormat:@"select * from GroupMsg where (content like '%%%@%%' or senderNickName like '%%%@%%') limit %d offset %d",msgContent, msgContent, number, (page - 1) * number];
        }
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            FNGroupMsgTable *mt = [[FNGroupMsgTable alloc] init];
            
            // 第一列为ID
            mt.syncId = [rs longForColumnIndex:0];
            mt.msgId = [rs stringForColumnIndex:1];
            mt.tid = [rs stringForColumnIndex:2];
            mt.msgType = [rs stringForColumnIndex:3];
            mt.msgAttribute = [rs stringForColumnIndex:4];
            mt.contentType = [rs stringForColumnIndex:5];
            mt.content = [rs stringForColumnIndex:6];
            mt.senderNickname = [rs stringForColumnIndex:7];
            mt.senderId = [rs stringForColumnIndex:8];
            mt.senderProtraitUrl = [rs stringForColumnIndex:9];
            mt.sendStatus = [rs intForColumnIndex:10];
            mt.readStatus = [rs intForColumnIndex:11];
            mt.flag = [rs intForColumnIndex:12];
            mt.createDate = [rs stringForColumnIndex:13];
//            NSLog(@"%@-%@",mt.senderNickname,mt.content);
            [array addObject:mt];
        }
    }];
    
    return array;
}

+ (NSUInteger)getMsgCountByGroupId:(NSString *)groupId
                            userId:(NSString *)userId
{
    __block NSUInteger msgCount = 0;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"select count(*) from GroupMsg where tid=? and senderId=?";
        msgCount = [db intForQuery:sql, groupId, userId];
    }];
    return msgCount;
}

+ (BOOL)insert:(FNGroupMsgTable *)message
{
    if (nil == message)
    {
        NSLog(@"invalid parameter");
        return NO;
    }

    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"replace into GroupMsg values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
        result = [db executeUpdate:sql,
                  [NSNumber numberWithLongLong:message.syncId],
                  message.msgId,
                  message.tid,
                  message.msgType,
                  message.msgAttribute,
                  message.contentType,
                  message.content,
                  message.senderNickname,
                  message.senderId,
                  message.senderProtraitUrl,
                  [NSNumber numberWithInt:message.sendStatus],
                  [NSNumber numberWithInt:message.readStatus],
                  [NSNumber numberWithInt:message.flag],
                  message.createDate];
    }];
    if (!result)
    {
        return NO;
    }
    
    [queue inDatabase:^(BOPFMDatabase *db) {
        if (![message.msgType isEqualToString:@"text/plain"])
        {
            NSString *sql = [NSString stringWithFormat:@"replace into RichTextMsg values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
            result = [db executeUpdate:sql,
                      message.msgId,
                      message.msgType,
                      [NSNumber numberWithLongLong:message.syncId],
                      [NSNumber numberWithInt:message.receiveStatus],
                      message.fileId,
                      message.fileName,
                      [NSNumber numberWithLong:message.fileSize],
                      [NSNumber numberWithLong:message.fileWidth],
                      [NSNumber numberWithLong:message.fileHeight],
                      message.URL,
                      message.savePath,
                      message.thumbPath,
                      [NSNumber numberWithLong:message.playTime],
                      [NSNumber numberWithLong:message.bitrate],
                      [NSNumber numberWithLong:message.processedSize],
                      message.tid];
        }
    }];
    return result;
}

+ (BOOL)updateSendMsgStatus:(NSString *)msgId
                     syncId:(int64_t)syncId
                 sendStatus:(MsgSendStatus)sendStatus
                   sendTime:(NSString *)sendTime
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"update GroupMsg set sendStatus = ?, sendStatus = ? , createDate = ? where msgId = ?"];
        result = [db executeUpdate:sql,
                  [NSNumber numberWithLong:syncId],
                  [NSNumber numberWithInt:sendStatus],
                  sendTime,
                  msgId];
    }];
    return result;
}

+ (BOOL)updateReceiveRichMsgInfo:(FNGroupMsgTable *)richInfo
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        if (![NSString isNullString:richInfo.thumbPath])
        {
            NSString *sql = [NSString stringWithFormat:@"update RichTextMsg set receiveStatus = ?,  fileId = ?, fileName = ?, fileSize = ?, fileWidth = ?, fileHeight = ?, thumbPath = ? where syncId = ?"];
            result = [db executeUpdate:sql,
                      [NSNumber numberWithInt:richInfo.receiveStatus],
                      richInfo.fileId,
                      richInfo.fileName,
                      [NSNumber numberWithLong:richInfo.fileSize],
                      [NSNumber numberWithLong:richInfo.fileWidth],
                      [NSNumber numberWithLong:richInfo.fileHeight],
                      richInfo.thumbPath,
                      [NSNumber numberWithLongLong:richInfo.syncId]];
        }
        else if (![NSString isNullString:richInfo.savePath])
        {
            NSString *sql = [NSString stringWithFormat:@"update RichTextMsg set receiveStatus = ?,  fileId = ?, fileName = ?, fileSize = ?, fileWidth = ?, fileHeight = ?, savePath = ? where syncId = ?"];
            result = [db executeUpdate:sql,
                      [NSNumber numberWithInt:richInfo.receiveStatus],
                      richInfo.fileId,
                      richInfo.fileName,
                      [NSNumber numberWithLong:richInfo.fileSize],
                      [NSNumber numberWithLong:richInfo.fileWidth],
                      [NSNumber numberWithLong:richInfo.fileHeight],
                      richInfo.savePath,
                      [NSNumber numberWithLongLong:richInfo.syncId]];
        }
        else
        {
            NSString *sql = [NSString stringWithFormat:@"update RichTextMsg set receiveStatus = ?,  fileId = ?, fileName = ?, fileSize = ?, fileWidth = ?, fileHeight = ? , URL = ? where msgId = ?"];
            result = [db executeUpdate:sql,
                      [NSNumber numberWithInt:richInfo.receiveStatus],
                      richInfo.fileId,
                      richInfo.fileName,
                      [NSNumber numberWithLong:richInfo.fileSize],
                      [NSNumber numberWithLong:richInfo.fileWidth],
                      [NSNumber numberWithLong:richInfo.fileHeight],
                      richInfo.URL,
                      richInfo.msgId];
        }
    }];
    return result;
}

+ (BOOL)deleteBySyncId:(int64_t)syncId
{
    if (0 == syncId)
    {
        NSLog(@"invalid parameter");
        return NO;
    }
    
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from GroupMsg where syncId=?"];
        result = [db executeUpdate:sql, [NSNumber numberWithLongLong:syncId]];
        if (result)
        {
            sql = [NSString stringWithFormat:@"delete from RichTextMsg where syncId=?"];
            result = [db executeUpdate:sql, [NSNumber numberWithLongLong:syncId]];
        }
    }];
    
    return result;
}

+ (BOOL)deleteByMsgId:(NSString *)msgId
{
    if (nil == msgId)
    {
        NSLog(@"invalid parameter");
        return NO;
    }
    
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from GroupMsg where msgId=?"];
        result = [db executeUpdate:sql, msgId];
        if (result)
        {
            sql = [NSString stringWithFormat:@"delete from RichTextMsg where msgId=?"];
            result = [db executeUpdate:sql, msgId];
        }
    }];
    return result;
}

+ (BOOL)deleteByGroupId:(NSString *)groupId
{
    if (nil == groupId)
    {
        NSLog(@"invalid parameter");
        return NO;
    }
    
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from GroupMsg where tid=?"];
        result = [db executeUpdate:sql, groupId];
        if (result) {
            sql = [NSString stringWithFormat:@"delete from RichTextMsg where tid=?"];
            result = [db executeUpdate:sql, groupId];
        }
    }];
    
    return result;
}

+ (BOOL)clearAll
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from GroupMsg";
        result = [db executeUpdate:sql];
        if (result)
        {
            sql = @"delete from RichTextMsg";
            result = [db executeUpdate:sql];
            
            sql = @"alter Table GroupMsg AUTO_INCREMENT = 1";
            result = [db executeUpdate:sql];
            
            sql = @"alter Table RichTextMsg AUTO_INCREMENT = 1";
            result = [db executeUpdate:sql];
        }
    }];
    
    return result;
}

- (NSString *)getSavePath
{
    if ([NSString isNullString:_savePath])
    {
        return nil;
    }
    return [[FNUserConfig getInstance].filePath stringByAppendingPathComponent:[_savePath lastPathComponent]];
}

- (NSString *)getThumbPath
{
    if (self.flag == MsgSendFlag)
    {
        return [self getSavePath];
    }
    if ([NSString isNullString:_thumbPath])
    {
        return nil;
    }
    return [[FNUserConfig getInstance].thumbPath stringByAppendingPathComponent:[_thumbPath lastPathComponent]];
}

+ (NSMutableArray *)getRichMessageByUserId:(NSString *)tid messageType:(NSString *)msgType
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from RichTextMsg where tid=? and msgType=?"];
        BOPFMResultSet *sRs = [db executeQuery:sql, tid, msgType];
        while ([sRs next])
        {
            NSString *thumbPath = [sRs stringForColumn:@"thumbPath"];
            [array addObject:thumbPath];
        }
    }];
    
    return array;
}

+ (NSMutableArray *)getPicAndVideoByUserId:(NSString *)tid
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from RichTextMsg where tid=? and (msgType=? or msgType=?)"];
        BOPFMResultSet *sRs = [db executeQuery:sql, tid,@"text/pic",@"text/video"];
        while ([sRs next])
        {
            FNGroupMsgTable *msg = [[FNGroupMsgTable alloc] init];
            msg.msgId = [sRs stringForColumnIndex:0];
            msg.msgType = [sRs stringForColumnIndex:1];
            msg.syncId = [sRs longLongIntForColumnIndex:2];
            msg.receiveStatus = [sRs intForColumnIndex:3];
            msg.fileId = [sRs stringForColumnIndex:4];
            msg.fileName = [sRs stringForColumnIndex:5];
            msg.fileSize = [sRs longForColumnIndex:6];
            msg.fileWidth = [sRs longForColumnIndex:7];
            msg.fileHeight = [sRs longForColumnIndex:8];
            msg.URL = [sRs stringForColumnIndex:9];
            msg.savePath = [sRs stringForColumnIndex:10];
            msg.thumbPath = [sRs stringForColumnIndex:11];
            msg.playTime = [sRs longForColumnIndex:12];
            msg.bitrate = [sRs longForColumnIndex:13];
            msg.processedSize = [sRs longForColumnIndex:14];
            msg.tid = [sRs stringForColumnIndex:15];
            [array addObject:msg];
        }
    }];
    
    return array;
}
@end
