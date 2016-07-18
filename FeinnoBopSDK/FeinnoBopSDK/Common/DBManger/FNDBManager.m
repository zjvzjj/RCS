//
//  FNDBManager.m
//  feinno-sdk-db
//
//  Created by wangshuying on 14-8-22.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNDBManager.h"
#import "BOPFMDB.h"
#import "BOPFMDatabaseAdditions.h"
#import "FNUserConfig.h"

@implementation FNDBManager

static NSString *dbPath;
static BOPFMDatabaseQueue *queue;

+ (BOPFMDatabaseQueue *)sharedDatabaseQueue
{
    if (!queue)
    {
        queue = [BOPFMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return queue;
}

+ (void)initDB:(NSString *)userid
{
    NSString *userPath = [FNUserConfig getInstance].dbPath;
    dbPath = [userPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", userid]];
    NSLog(@"db path: %@", dbPath);
    
    // 如果DB已存在直接return
    if ([[NSFileManager defaultManager] fileExistsAtPath:dbPath])
    {
        queue = [BOPFMDatabaseQueue databaseQueueWithPath:dbPath];
        return;
    }

    // 创建DB
    queue = [BOPFMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(BOPFMDatabase *db) {
        // 当前用户表
        [db executeUpdate:@"create table User (userId text primary key, email text, mobileNo ingteger, name text, groupListVersion integer, privateSyncId integer, pgSyncId integer, ntfSyncId integer, sysSyncId integer)"];
        
        // 联系人表
        [db executeUpdate:@"create table Contact (name text, mobileNo text primary key, email text, userId text, registerStatus integer, relationship integer, relationshipUserId text, extension text, version text)"];
        
        // 消息表
        [db executeUpdate:@"create table Message (syncId integer, msgId text, tid text, msgType text, msgAttribute text, contentType text, content text, senderNickname text, senderId text, senderPortraitUrl text, sendStatus integer, readStatus integer, srFlag integer, createDate datetime, primary key(syncId, msgId))"];
        // 对消息表 msgId列 加索引
//        [db executeUpdate:@"create index idx_message on Message(msgId)"];
        
        // 富文本消息表
        [db executeUpdate:@"create table RichTextMsg (msgId text, msgType text, syncId integer, receiveStatus integer, fileId text, fileName text, fileSize integer, fileWidth integer, fileHeight integer, URL text, savePath text, thumbPath text, playTime integer, bitrate integer, processSize integer, tid text, primary key(syncId, msgId))"];
        // 对富文本消息表的 msgId列 加索引
//        [db executeUpdate:@"create index idx_rich_text_msg on RichTextMsg(msgId)"];
        
        // 群组表
        [db executeUpdate:@"create table Groups (groupId text primary key, groupType integer, groupName text, groupProtraitUrl text, userNickname text, identity integer, config integer)"];
        // 对群租表 groupType列 加索引
        [db executeUpdate:@"create index idx_groups on Groups(groupType)"];
        
        // 群成员表
        // userConfig 用户对群的功能配置
        [db executeUpdate:@"create table GroupMembers (groupId text, memberID text, memberNickName text, memberProtraitUrl text, identity integer, primary key(groupId, memberID))"];
        //对群成员列表 groupId列 加索引
        [db executeUpdate:@"create index idx_group_members on GroupMembers(groupId)"];
        
        // 群组消息表
        [db executeUpdate:@"create table GroupMsg (syncId integer, msgId text, tid text, msgType text, msgAttribute text, contentType text, content text, senderNickname text, senderId text, groupPortraitUrl text, sendStatus integer, readStatus integer, srFlag integer, createDate datetime, primary key(syncId, msgId))"];
        // 对群组消息表 msgID列 加索引
//        [db executeUpdate:@"create index idx_group_msg on GroupMsg(msgId)"];
        
        // 最近会话列表
        [db executeUpdate:@"create table RecentConversation (tid text primary key, tname text , senderNickname text, tPortraitUrl text, content text, unreadMsgCount integer, syncId integer, lastActiveDate text, msgType text, eventType integer, msgId text, sendStatus integer)"];
        
        // 群组通知表
        [db executeUpdate:@"create table GroupNotify (msgType text, groupId text, groupName text, groupPortraitUrl text, sourceUserId text, sourceUserNickname text, targetUserId text, targetUserNickname text, msgId text, handleFlag integer, handleResult integer, createDate datetime, syncId integer)"];
        
        // 系统通知表
        [db executeUpdate:@"create table SystemNotify (fromUserId text, msgId text primary key, title text, msgType integer, sendDate text, readStatus integer, msgBody text)"];
        // 对系统通知表 msgId列 加索引
        [db executeUpdate:@"create index idx_system_notify on SystemNotify(msgId)"];
    }];
}

@end
