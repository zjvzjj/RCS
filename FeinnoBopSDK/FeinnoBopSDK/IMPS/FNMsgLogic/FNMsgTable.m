//
//  ChatMessage.m
//  feinno-sdk-db
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNMsgTable.h"
#import "FNDBManager.h"
#import "BOPFMDB.h"
#import "BOPFMDatabaseAdditions.h"
#import "Utility.h"
#import "NSString+Extension.h"
#import "FNUserConfig.h"

@implementation FNMsgTable

+ (NSMutableArray *)getHistoryMsgForTid:(NSString *)tid
                                    num:(int32_t)num
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    __block int32_t number = num;
    __block NSString *targetId = [Utility userIdWithoutAppKey:tid];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = nil;
        BOPFMResultSet *rs = nil;
        if (num > -1)
        {
            sql = @"select count(*) from Message where tid=?";
            int msgsSum = [db intForQuery:sql, targetId];
            number = MIN(num, msgsSum);
            int off = msgsSum > number ? (int)msgsSum - number : 0;
      //    sql = [NSString stringWithFormat:@"select * from Message where tid=? and readStatus=%d order by syncId asc, createDate asc limit %d offset %d", (int32_t)MsgAlreadyRead, number, off];
            sql = [NSString stringWithFormat:@"select * from Message where tid=? and readStatus=%d order by createDate asc, syncId asc limit %d offset %d", (int32_t)MsgAlreadyRead, number, off];

        }
        else
        {
            sql = [NSString stringWithFormat:@"select * from Message where tid=? order by createDate asc, syncId asc"];
        }
        rs = [db executeQuery:sql, targetId];
        while ([rs next])
        {
            FNMsgTable *mt = [[FNMsgTable alloc] init];
            
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
            
            if (![mt.msgType isEqualToString:FNMsgTypePlain])
            {
                if (mt.flag == MsgSendFlag)
                {
                    sql = [NSString stringWithFormat:@"select * from RichTextMsg where msgId = ?"];
                }
                else
                {
                    sql = [NSString stringWithFormat:@"select * from RichTextMsg where msgId = ?"];
                }
                
              
                
                BOPFMResultSet *sRs = [db executeQuery:sql,mt.msgId];
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


+ (NSMutableArray *)getUnreadMsgForTid:(NSString *)tid
                                   num:(int32_t)num
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    __block int32_t number = num;
    __block NSString *targetId = [Utility userIdWithoutAppKey:tid];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = nil;
        BOPFMResultSet *rs = nil;
        if (num > -1)
        {
            sql = @"select count(*) from Message where tid=?";
            int msgsSum = [db intForQuery:sql, targetId];
            sql = [NSString stringWithFormat:@"select count(*) from Message where tid=? and readStatus=%d", (int32_t)MsgUnread];
            int unreadMsgsCount = [db intForQuery:sql, targetId];
            
            int off = 0;
            number = unreadMsgsCount; // 未读消息全部取出
            off = msgsSum > number ? msgsSum - number : 0;
            sql = [NSString stringWithFormat:@"select * from Message where tid=? order by syncId asc, createDate asc limit %d offset %d", number, off];
        }
        else if (-1 == num)
        {
            sql = [NSString stringWithFormat:@"select * from Message where tid=? order by syncId asc, createDate asc"];
        }
        rs = [db executeQuery:sql, targetId];
        while ([rs next])
        {
            FNMsgTable *mt = [[FNMsgTable alloc] init];
            
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
        sql = [NSString stringWithFormat:@"update Message set readStatus=? where readStatus=?"];
        [db executeUpdate:sql, [NSNumber numberWithInt:MsgAlreadyRead], [NSNumber numberWithInt:MsgUnread]];
    }];
    return array;
}

+ (NSMutableArray *)getUnreadMsgForTid:(NSString *)tid
                                   num:(int32_t)num
                             andSyncId:(NSInteger)syncId
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
//    __block int32_t number = num;
    __block NSString *targetId = [Utility userIdWithoutAppKey:tid];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = nil;
        BOPFMResultSet *rs = nil;
        sql = [NSString stringWithFormat:@"select * from Message where tid=?  and syncId=?"];
        NSString *delSql = [NSString stringWithFormat:@"update Message set readStatus=? where syncId=?"];
        [db executeUpdate:delSql, [NSNumber numberWithInt:MsgAlreadyRead],@(syncId)];
        rs = [db executeQuery:sql, targetId,@(syncId)];
        while ([rs next])
        {
            FNMsgTable *mt = [[FNMsgTable alloc] init];
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

+ (NSArray *)getMsgBySyncId:(int64_t)syncId
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"select * from Message where syncId=%lld", syncId];
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            FNMsgTable *mt = [[FNMsgTable alloc] init];
            
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
        NSString *sql = [NSString stringWithFormat:@"select * from Message where msgId=?"];
        BOPFMResultSet *rs = [db executeQuery:sql, msgId];
        while ([rs next])
        {
            FNMsgTable *mt = [[FNMsgTable alloc] init];
            
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

+ (NSArray *)getMsgByContent:(NSString *)msgContent number:(int32_t)number page:(int32_t)page tid:(NSString *)tid
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = nil;
        if (tid)
        {
            sql = [NSString stringWithFormat:@"select * from Message where tid = '%@' and content like '%%%@%%' limit %d offset %d", [Utility userIdWithoutAppKey:tid], msgContent, number, (page - 1) * number];
        }
        else
        {
            sql = [NSString stringWithFormat:@"select * from Message where content like '%%%@%%' limit %d offset %d", msgContent, number, (page - 1) * number];
        }
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            FNMsgTable *mt = [[FNMsgTable alloc] init];
            
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
            
            [array addObject:mt];
        }
    }];
    
    return array;
}

+ (BOOL)insert:(FNMsgTable *)message
{
    if (nil == message)
    {
        NSLog(@"invalid parameter");
        return NO;
    }
    
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"replace into Message values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
        result = [db executeUpdate:sql,
                  [NSNumber numberWithLongLong:message.syncId],
                  message.msgId,
                  [Utility userIdWithoutAppKey:message.tid],
                  message.msgType,
                  message.msgAttribute,
                  message.contentType,
                  message.content,
                  message.senderNickname,
                  [Utility userIdWithoutAppKey:message.senderId],
                  message.senderProtraitUrl,
                  [NSNumber numberWithInt:message.sendStatus],
                  [NSNumber numberWithInt:message.readStatus],
                  [NSNumber numberWithInt:message.flag],
                  message.createDate,
                  [NSNumber numberWithInt:message.sendtime]];
    }];
    if (!result)
    {
        return NO;
    }
    
    [queue inDatabase:^(BOPFMDatabase *db) {
        if (![message.msgType isEqualToString:FNMsgTypePlain])
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
                      [Utility userIdWithoutAppKey:message.tid]];
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
        NSString *sql = [NSString stringWithFormat:@"update Message set syncId = ? , sendStatus = ? , createDate = ? where msgId = ?"];
        result = [db executeUpdate:sql,
                  [NSNumber numberWithLong:syncId],
                  [NSNumber numberWithInt:sendStatus],
                  sendTime,
                  msgId];
    }];
    return result;
}

+ (BOOL)updateReceiveRichMsgInfo:(FNMsgTable *)richInfo
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

+ (BOOL)deleteBySyncId:(long)syncId
{
    if (0 == syncId)
    {
        NSLog(@"invalid parameter");
        return NO;
    }
    
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from Message where syncId=?"];
        result = [db executeUpdate:sql, [NSNumber numberWithLong:syncId]];
        if (result)
        {
            sql = [NSString stringWithFormat:@"delete from RichTextMsg where syncId=?"];
            result = [db executeUpdate:sql, [NSNumber numberWithLong:syncId]];
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
        NSString *sql = [NSString stringWithFormat:@"delete from Message where msgId=?"];
        result = [db executeUpdate:sql, msgId];
        if (result) {
            sql = [NSString stringWithFormat:@"delete from RichTextMsg where msgId=?"];
            result = [db executeUpdate:sql, msgId];
        }
    }];
    
    return result;
}

+ (BOOL)deleteByUserId:(NSString *)userId
{
    if (nil == userId)
    {
        NSLog(@"invalid parameter");
        return NO;
    }
    
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from Message where tid=?"];
        result = [db executeUpdate:sql, [Utility userIdWithoutAppKey:userId]];
        if (result) {
            sql = [NSString stringWithFormat:@"delete from RichTextMsg where tid=?"];
            result = [db executeUpdate:sql, [Utility userIdWithoutAppKey:userId]];
        }
    }];
    
    return result;
}

+ (BOOL)clearAll
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from Message"];
        result = [db executeUpdate:sql];
        if (result)
        {
            sql = [NSString stringWithFormat:@"delete from RichTextMsg"];
            result = [db executeUpdate:sql];
            
            sql = [NSString stringWithFormat:@"alter Table Message AUTOINCREMENT = 1"];
            result = [db executeUpdate:sql];
            
            sql = [NSString stringWithFormat:@"alter Table RichTextMsg AUTOINCREMENT = 1"];
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
    tid = [Utility userIdWithoutAppKey:tid];
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
        BOPFMResultSet *sRs = [db executeQuery:sql, [Utility userIdWithoutAppKey:tid], @"text/pic", @"text/video"];
        while ([sRs next])
        {
            FNMsgTable *msg = [[FNMsgTable alloc] init];
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
