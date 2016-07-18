//
//  FNGroupMsgLogic.m
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/3/24.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "FNGroupMsgLogic.h"
#import "FNFileServiceLogic.h"

#import "FNNotifyArgs.h"
#import "FNNotifyLogic.h"

#import "FNGroupMsgTable.h"
#import "FNRecentConversationTable.h"
#import "FNUserTable.h"

#import "FNUserConfig.h"
#import "FNSystemConfig.h"

#import "CMD.h"
#import "McpRequest.h"

#import "BodyMaker+MessageBodyMaker.h"
#import "DelMsgResult.pb.h"
#import "PullMsgResults.pb.h"
#import "SendMsgResults.pb.h"

#import "NSString+Extension.h"
#import "NSData+DataEncrypt.h"
#import "Utility.h"

@implementation FNGroupMsgLogic

+ (void) getHistory :(FNGetRoamingMsgRequest *)pullMsgReq
            callback:(void (^)(NSArray *msgList))callback
{
    int32_t cmd = CMD_GET_HISTORY_MSG_CONTACT;
    NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeRoamingMsgReqArgs:pullMsgReq.pageSize peerId:[Utility userIdWithoutAppKey:pullMsgReq.peerId] lastRmsId:pullMsgReq.lastRmsId msgType:pullMsgReq.msgType];
    
    
    [[McpRequest sharedInstance] send:cmd userid:sender body:body callback:^(NSData *data) {
        if (data)
        {
            
            PacketObject *packetObject = [McpRequest parseWithData:data
                                                               key:[FNUserConfig getInstance].cStr];
            GetRoamingMsgResults *rspArgs= (GetRoamingMsgResults *)packetObject.args;
            
            FNGetRoamingMsgResponse *rsp = [[FNGetRoamingMsgResponse alloc] initWithPBArgs:rspArgs];
            
            if (200 == rsp.statusCode)
            {
                NSMutableArray *tmpMsgList = [NSMutableArray array];
                //向usertable中写入lastRmsId
                NSString *str = rsp.lastRmsId;
                [FNUserTable setHistoryLastRmsId:str];
                
                for (int i = 0; i < rsp.msgList.count; i++)
                {
                    FNMsgEntity *msgEntity = (FNMsgEntity *)rsp.msgList[i];
                    
                    
                    //[FNUserTable setSyncId:EventTypePrivate syncId:msgEntity.syncID];
                    // 抛弃为空的消息
                    if ([NSString isNullString:msgEntity.msgContent])
                    {
                        continue;
                    }
                    // 插入DB
                    FNGroupMsgTable *message = [[FNGroupMsgTable alloc] init];
                    message.syncId = msgEntity.syncID;
                    message.msgId = msgEntity.msgId;
                    message.tid = [Utility userIdWithoutAppKey:msgEntity.peerID];
                    message.msgType = msgEntity.msgType;
                    message.msgAttribute = msgEntity.msgAttribute;
                    message.senderNickname = msgEntity.senderNickname;
                    message.senderId = [Utility userIdWithoutAppKey:msgEntity.source];  //TODO: 待验证
                    message.readStatus = MsgUnread;
                    message.flag = MsgReceiveFlag;
                    message.createDate = (msgEntity.sendDate ? [FNSystemConfig dateToString:msgEntity.sendDate] : [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]]);
                    
                    FNMsgContent *msgContent = [FNMsgContent toObjectFromStr:msgEntity.msgContent
                                                                 withMsgType:msgEntity.msgType];
                    message.contentType = msgContent.contentType;
                    
                    message.content = msgContent.content; // 一定要放到msgType的赋值之后
                    
                    __block BOOL shouldRecord = YES;
                    // 下载成功才记录
                    if (![msgEntity.msgType isEqualToString:FNMsgTypePlain])
                    {
                        message.fileId = msgContent.fileId;
                        message.fileName = msgContent.fileName;
                        message.URL = msgContent.fileDownloadUrl;
                        message.fileSize = msgContent.fileSize;
                        message.fileWidth = msgContent.fileWidth;
                        message.fileHeight = msgContent.fileHeight;
                        message.bitrate = msgContent.bitrate;
                        message.playTime = msgContent.duration;
                        message.receiveStatus = MsgUnreceive;
                        
                        if ([msgEntity.msgType isEqualToString:FNMsgTypePic] ||
                            [msgEntity.msgType isEqualToString:FNMsgTypeVideo] ||
                            [msgEntity.msgType isEqualToString:FNMsgTypeAudio])
                        {
                            if ([msgEntity.msgType isEqualToString:FNMsgTypeAudio])
                            {
                                if ([NSString isNullString:msgContent.fileName])
                                {
                                    msgContent.fileName = [NSString stringWithFormat:@"%@.amr", [self generateUUID]];
                                }
                                [self downloadSharedFile:msgContent.fileDownloadUrl
                                                fileSize:msgContent.fileSize
                                               fileWidth:msgContent.fileWidth
                                              fileHeight:msgContent.fileHeight
                                                  syncId:msgEntity.syncID
                                                fileType:msgEntity.msgType
                                                fileName:msgContent.fileName
                                                  fileId:msgContent.fileId
                                                callback:^(FNFileDownloadResponse *rspArgs) {
                                                    if (rspArgs.statusCode == 200)
                                                    {
                                                        // 下载成功才记录
                                                        message.receiveStatus = MsgReceiveSuccess;
                                                        message.savePath = rspArgs.fileInfo.filePath;
                                                        
                                                        [FNGroupMsgTable insert:message];
                                                        
                                                        
                                                        [tmpMsgList addObject:message];
                                                        callback([NSArray arrayWithArray:tmpMsgList]);
                                                        [tmpMsgList removeAllObjects];
                                                    }
                                                    else
                                                    {
                                                        shouldRecord = NO;
                                                    }
                                                }];
                            }
                            else
                            {
                                NSString *thumbName = nil;
                                if ([NSString isNullString:msgContent.fileName])
                                {
                                    thumbName = [NSString stringWithFormat:@"%@.JPG", [self generateUUID]];
                                    
                                    if ([msgEntity.msgType isEqualToString:FNMsgTypePic])
                                    {
                                        msgContent.fileName = thumbName;
                                    }
                                    else if ([msgEntity.msgType isEqualToString:FNMsgTypeVideo])
                                    {
                                        msgContent.fileName = [NSString stringWithFormat:@"%@.mp4", [self generateUUID]];
                                    }
                                }
                                [self downloadThumbnail:msgContent.fileDownloadUrl
                                               fileSize:msgContent.fileSize
                                              fileWidth:msgContent.fileWidth
                                             fileHeight:msgContent.fileHeight
                                                 syncId:msgEntity.syncID
                                               fileName:thumbName
                                                 fileId:msgContent.fileId
                                               callback:^(FNFileDownloadResponse *rspArgs) {
                                                   if (rspArgs.statusCode == 200)
                                                   {
                                                       // 下载成功才记录
                                                       message.receiveStatus = MsgReceiveSuccess;
                                                       message.thumbPath = rspArgs.fileInfo.filePath;
                                                       [FNGroupMsgTable insert:message];
                                                       
                                                       FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
                                                       info.eventType = EventTypePrivate; // 注意
                                                       info.msgType = message.msgType;  // 注意
                                                       info.targetId = [Utility userIdWithoutAppKey:msgEntity.peerID];
//                                                       info.targetName = ;
                                                       info.senderNickname = msgEntity.senderNickname;
                                                       info.content = message.content;
                                                       [info setUnreadMsgCount];
                                                       info.syncId = msgEntity.syncID;
                                                       info.lastActiveDate = message.createDate;
                                                       [FNRecentConversationTable insert:info];
                                                       
                                                       [tmpMsgList addObject:message];
                                                       callback([NSArray arrayWithArray:tmpMsgList]);
                                                       [tmpMsgList removeAllObjects];
                                                       
                                                   }
                                                   else
                                                   {
                                                       shouldRecord = NO;
                                                   }
                                               }];
                            }
                        }
                        else
                        {
                            [FNGroupMsgTable insert:message];
                            [tmpMsgList addObject:message];
                        }
                    }
                    else
                    {
                        [FNGroupMsgTable insert:message];
                        [tmpMsgList addObject:message];
                    }
                    
                    
                }
                callback(tmpMsgList);
            }
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)sendTextMsg:(FNSendTextMsgRequest *)textMsgReq
           callback:(void (^)(FNSendMsgResponse *))callback
{
    if ([NSString isNullString:textMsgReq.content])
    {
        NSLog(@"msgcontent is null");
        FNSendMsgResponse *rsp = [[FNSendMsgResponse alloc] initWithStatusCode:400];
        callback(rsp);
        return;
    }
    
    FNGroupMsgTable *message = [[FNGroupMsgTable alloc] init];
    message.syncId = [FNUserTable getSyncId:EventTypePG];
    message.msgId = textMsgReq.msgId;
    message.tid = textMsgReq.peerID;
    message.msgType = FNMsgTypePlain;
    message.msgAttribute = textMsgReq.msgAttribute;
    message.contentType = textMsgReq.contentType;
    message.content = textMsgReq.content;
    message.senderNickname = textMsgReq.senderNickname;
    message.senderId = [Utility userIdWithoutAppKey:textMsgReq.senderId];
    message.senderProtraitUrl = textMsgReq.sendPortraitUrl;
    message.sendStatus = MsgSending;
    message.readStatus = MsgAlreadyRead;
    message.flag = MsgSendFlag;
    message.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
    [FNGroupMsgTable insert:message];
    
    FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
    info.eventType = EventTypePG;
    info.msgType = message.msgType;
    info.targetId = [Utility userIdWithoutAppKey:textMsgReq.peerID];
    info.targetName = textMsgReq.senderNickname;
    info.targetProtraitUrl = textMsgReq.sendPortraitUrl;
    info.senderNickname = textMsgReq.senderNickname;
    info.content = message.content;
    //    [info setUnreadMsgCount];
    info.syncId = [FNUserTable getSyncId:EventTypePG];
    info.lastActiveDate = message.createDate;
    info.msgId = textMsgReq.msgId;
    info.sendStatus = MsgUploading;
    [FNRecentConversationTable insert:info];
    
    FNMsgContent *textContent = [FNMsgContent msgContentWithType:TextMsg];
    [textContent setContent:textMsgReq.content];
    [textContent setContentType:textMsgReq.contentType];
    
    FNMsgEntity *msgEntity = [[FNMsgEntity alloc] init];
    msgEntity.peerID = [Utility userIdWithAppKey:textMsgReq.peerID];
    msgEntity.msgContent = textContent.toJString;
    msgEntity.msgAttribute = textMsgReq.msgAttribute;
    msgEntity.msgType = FNMsgTypePlain;
    msgEntity.msgId = textMsgReq.msgId;
    msgEntity.sendDate = FNSystemConfig.getLocalDate;
    msgEntity.senderNickname = textMsgReq.senderNickname;
    msgEntity.senderId = [Utility userIdWithAppKey:textMsgReq.senderId];
    msgEntity.sendPortraitUrl = textMsgReq.sendPortraitUrl;
    msgEntity.pushDesc = (textMsgReq.pushDesc && [textMsgReq.pushDesc length] > 0) ? textMsgReq.pushDesc : textMsgReq.content;
    
    int32_t cmd = CMD_SEND_MSG_GROUP;
    NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeSendMsgReqArgs:sender
                                       msgEntity:msgEntity];
    BOOL encryption = NO;
    if (encryption)
    {
        NSString *kEncryedPwd = [NSString stringWithFormat:@"kEncryedPwdOf%@", [FNUserConfig getInstance].userIDWithKey];
        body = [self enceyptMsgBody:body key:kEncryedPwd];
    }
    
    [[McpRequest sharedInstance] send:cmd userid:sender body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parseWithData:data
                                                               key:[FNUserConfig getInstance].cStr];
            SendMsgResults *rspArgs = (SendMsgResults *)packetObject.args;
            FNSendMsgResponse *result = [[FNSendMsgResponse alloc] initWithPBArgs:rspArgs];
            
            // msg db
            BOOL success = (result.statusCode == 200 && result.syncID > 0 && (result.reason == nil || [result.reason length] == 0));
            NSLog(@"feinno send groupText message %d",success);
            
            // update message db
            [FNGroupMsgTable updateSendMsgStatus:msgEntity.msgId
                                          syncId:success ? result.syncID : [FNUserTable getSyncId:EventTypePrivate]
                                      sendStatus:success ? MsgSendSuccess : MsgSendFailed
                                        sendTime:(result.sendDate && [result.sendDate length] > 0) ? result.sendDate : [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]]];
            
            if (success)
            {
                [FNUserTable setSyncId:EventTypePG syncId:result.syncID];
            }
            
            [FNRecentConversationTable updateSendStatus:success ? MsgSendSuccess : MsgSendFailed syncId:success ? result.syncID : [FNUserTable getSyncId:EventTypePrivate] msgId:textMsgReq.msgId];
            
            //业务层要求
            message.sendStatus = success ? MsgSendSuccess : MsgSendFailed;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTextMsg" object:message];
            
            callback(result);
        }
        else
        {
            NSLog(@"feinno send groupText message callback nil");
            [FNGroupMsgTable updateSendMsgStatus:msgEntity.msgId
                                          syncId:[FNUserTable getSyncId:EventTypePrivate]
                                      sendStatus:MsgSendFailed
                                        sendTime:[FNSystemConfig dateToString:[FNSystemConfig getLocalDate]]];
            
            //业务层要求
            message.sendStatus =  MsgSendFailed;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTextMsg" object:message];
            
            callback(nil);
        }
    }];
}

+ (void)sendRichTextMsg:(FNSendRichTextMsgRequest *)richTextMsgReq
               callback:(void(^)(FNSendRichTextMsgResponse *))callback
{
    if ([NSString isNullString:richTextMsgReq.msgEntity.msgContent])
    {
        NSLog(@"msgcontent is null");
        FNSendRichTextMsgResponse *rsp = [[FNSendRichTextMsgResponse alloc] init];
        rsp.statusCode = 400;
        callback(rsp);
        return;
    }
    
    richTextMsgReq.msgEntity.msgContent = richTextMsgReq.msgContent.toJString;
    richTextMsgReq.msgEntity.senderId = [FNUserConfig getInstance].userIDWithKey;
    richTextMsgReq.msgEntity.sendDate = FNSystemConfig.getLocalDate;
    richTextMsgReq.msgEntity.peerID = [Utility userIdWithAppKey:richTextMsgReq.msgEntity.peerID];
    
    NSString *userid = [FNUserConfig getInstance].userIDWithKey;
    int32_t cmd = CMD_SEND_MSG_GROUP;
    NSData *body = [BodyMaker makeSendMsgReqArgs:userid
                                       msgEntity:richTextMsgReq.msgEntity];
    
    [[McpRequest sharedInstance] send:cmd userid:userid body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parseWithData:data
                                                               key:[FNUserConfig getInstance].cStr];
            SendMsgResults *rspArgs = (SendMsgResults *)packetObject.args;
            FNSendMsgResponse *result = [[FNSendMsgResponse alloc] initWithPBArgs:rspArgs];
            
            FNSendRichTextMsgResponse *richResult = [[FNSendRichTextMsgResponse alloc] init];
            richResult.msgRsp = result;
            
            // DB
            BOOL success = (result.statusCode == 200 && result.syncID > 0 && (result.reason == nil || [result.reason length] == 0));
            NSLog(@"feinno send groupRichText message %d",success);
            if (success)
            {
                [FNUserTable setSyncId:EventTypePrivate syncId:result.syncID];
            }
            
            [FNGroupMsgTable updateSendMsgStatus:richTextMsgReq.msgEntity.msgId
                                          syncId:success ? result.syncID : [FNUserTable getSyncId:EventTypePG]
                                      sendStatus:success ? MsgSendSuccess : MsgSendFailed
                                        sendTime:(result.sendDate && [result.sendDate length] > 0) ? result.sendDate : [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]]];
            
            
            // recent conversation db,
            [FNRecentConversationTable updateSendStatus:success ? MsgSendSuccess : MsgSendFailed syncId:success ? result.syncID : [FNUserTable getSyncId:EventTypePG] msgId:richTextMsgReq.msgEntity.msgId];
            
            //业务层要求
//            message.sendStatus = success ? MsgSendSuccess : MsgSendFailed;
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendRichTextMsg" object:message];
            
            callback(richResult);
        }
        else
        {
            // DB
            NSLog(@"feinno sendGroupRichMsg callBack nil");
            [FNGroupMsgTable updateSendMsgStatus:richTextMsgReq.msgEntity.msgId syncId:[FNUserTable getSyncId:EventTypePrivate]  sendStatus:MsgSendFailed sendTime:[FNSystemConfig dateToString:[FNSystemConfig getLocalDate]]];
            
            [FNRecentConversationTable updateSendStatus:MsgSendFailed syncId:[FNUserTable getSyncId:EventTypePrivate] msgId:richTextMsgReq.msgEntity.msgId];
            //业务层要求
//            message.sendStatus = MsgSendFailed;
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendRichTextMsg" object:message];
            
            callback(nil);
        }
    }];
}

+ (void)getMsg:(FNPullMsgRequest *)pullMsgReq
      callback:(void(^)(NSArray *msgList))callback
{
    int64_t syncId = [FNUserTable getSyncId:EventTypePG];
    if (pullMsgReq.deleteHistoryMsg)
    {
        syncId = 9223372036854775807;
        FNPullNotifyRequest *req = [[FNPullNotifyRequest alloc] init];
        req.deleteHistoryMsg = YES;
        [FNNotifyLogic getNotify:req callback:^(FNPullNotifyResponse *rsp) {
        }];
    }
    NSData *body = [BodyMaker makePullMsgReqArgs:(pullMsgReq.count == 0 ? FN_PULL_MSG_COUNT_DEFAULT : pullMsgReq.count)
                                          syncId:syncId];
    int32_t cmd = CMD_GET_MSG_GROUP;
    NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    
    [[McpRequest sharedInstance] send:cmd userid:sender body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parseWithData:data
                                                               key:[FNUserConfig getInstance].cStr];
            PullMsgResults *rspArgs = (PullMsgResults *)packetObject.args;
            FNPullMsgResponse *rsp = [[FNPullMsgResponse alloc] initWithPBArgs:rspArgs];
            
            // DB
            if (200 == rsp.statusCode)
            {
                NSMutableArray *tmpMsgList = [NSMutableArray array];
                for (int i = 0; i < rsp.msgList.count; i++)
                {
                    FNMsgEntity *msgEntity = (FNMsgEntity *)rsp.msgList[i];
                    NSLog(@"msgcontent : %@", msgEntity.msgContent);
                    NSLog(@"message syncId: %lld and isCompleted: %d", msgEntity.syncID, (rsp.isCompleted ? 1 : 0));
                    // 写入syncId
                    int64_t oldSyncId = [FNUserTable getSyncId:EventTypePG];
                    if (oldSyncId >= msgEntity.syncID)
                    {
                        // 重复消息，抛弃
                        continue;
                    }
                    [FNUserTable setSyncId:EventTypePG syncId:msgEntity.syncID];
                    
                    if ([NSString isNullString:msgEntity.msgContent])
                    {
                        continue;
                    }
                    
                    // 插入DB
                    FNGroupMsgTable *message = [[FNGroupMsgTable alloc] init];
                    message.syncId = msgEntity.syncID;
                    message.msgId = msgEntity.msgId;
                    message.tid = [Utility userIdWithoutAppKey:msgEntity.peerID];
                    message.msgType = msgEntity.msgType;
                    message.msgAttribute = msgEntity.msgAttribute;
                    message.senderNickname = msgEntity.senderNickname;
                    message.senderId = [Utility userIdWithoutAppKey:msgEntity.senderId];
                    message.senderProtraitUrl = msgEntity.sendPortraitUrl;
                    message.readStatus = MsgUnread;
                    message.flag = MsgReceiveFlag;
                    message.createDate = (msgEntity.sendDate ? [FNSystemConfig dateToString:msgEntity.sendDate] : [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]]);
                    
                    FNMsgContent *msgContent = [FNMsgContent toObjectFromStr:msgEntity.msgContent
                                                                 withMsgType:msgEntity.msgType];
                    message.contentType = msgContent.contentType;
                    message.content = msgContent.content; // 一定要放到msgType的赋值之后
                    
                    message.fileId = msgContent.fileId;
                    message.fileName = msgContent.fileName;
                    message.URL = msgContent.fileDownloadUrl;
                    message.fileSize = msgContent.fileSize;
                    message.fileWidth = msgContent.fileWidth;
                    message.fileHeight = msgContent.fileHeight;
                    message.bitrate = msgContent.bitrate;
                    message.playTime = msgContent.duration;
                    message.receiveStatus = MsgUnreceive;
                    
                    [FNGroupMsgTable insert:message];
                    [tmpMsgList addObject:message];
                    
                    //whether recent conversation db
                    FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
                    info.eventType = EventTypePG; // 注意
                    info.msgType = message.msgType;  // 注意
                    info.targetId = [Utility userIdWithoutAppKey:msgEntity.peerID];
                    info.targetName = msgEntity.senderNickname;
                    info.targetProtraitUrl = msgEntity.sendPortraitUrl;
                    info.senderNickname = msgEntity.senderNickname;
                    info.content = message.content;
                    [info setUnreadMsgCount];
                    info.syncId = msgEntity.syncID;
                    info.lastActiveDate = message.createDate;
                    
                    [FNRecentConversationTable insert:info];
                }
                // 循环完毕，通知一次
                if ([tmpMsgList count] > 0)
                {
                    //业务层要求
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"getMsg" object:tmpMsgList];
                    
                    callback([NSArray arrayWithArray:tmpMsgList]);
                    [tmpMsgList removeAllObjects];
                }
                
                // 删除服务端消息
                FNDelMsgRequest *delMsgReq = [[FNDelMsgRequest alloc] init];
                delMsgReq.syncID = [FNUserTable getSyncId:EventTypePG];
                [self delMsg:delMsgReq callback:^(FNDelMsgResponse *rspArgs) {
                    if (200 == rspArgs.statusCode)
                    {
                        NSLog(@"del server msg success");
                        if (!rsp.isCompleted)
                        {
                            if ([rsp.msgList count] == 0)
                            {
                                [FNUserTable setSyncId:EventTypePG syncId:rsp.syncID];
                            }
                            [self getMsg:pullMsgReq callback:callback];
                        }
                        else if (pullMsgReq.deleteHistoryMsg)
                        {
                            [FNUserTable setSyncId:EventTypePG syncId:0];
                        }
                    }
                    else
                    {
                        NSLog(@"del server msg failed");
                    }
                }];
            }
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)delMsg:(FNDelMsgRequest *)delMsgReq
      callback:(void(^)(FNDelMsgResponse *rspArgs))callback;
{
    NSData *body = [BodyMaker makeDelMsgReqArgs:delMsgReq.syncID];
    int32_t cmd = CMD_DEL_MSG_GROUP;
    NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    
    [[McpRequest sharedInstance] send:cmd userid:sender body:body callback:^(NSData *data) {
        if (data)
        {
            PacketObject *packetObject = [McpRequest parse:data];
            DelMsgResult *rspArgs = (DelMsgResult *)packetObject.args;
            FNDelMsgResponse *rsp = [[FNDelMsgResponse alloc] initWithPBArgs:rspArgs];
            
            callback(rsp);
        }
        else
        {
            callback(nil);
        }
    }];
}

+ (void)uploadRichTextFilePath:(NSString *)filePath
                         msgId:(NSString *)msgId
                      fileType:(NSString *)fileType
                           tid:(NSString *)tid
                      callBack:(void (^)(FNFileUploadResponse *serviceRsp))callBack
{
    FNFileUploadRequest *fileReq = [[FNFileUploadRequest alloc] init];
    fileReq.filePath = filePath;
    fileReq.fileType = [self getFileTypeByMIMEType:filePath];
    fileReq.ssic = [NSString urlEncode:[FNUserConfig getInstance].cStr];
    fileReq.msgId = msgId;
    fileReq.tid = [Utility userIdWithAppKey:tid];
    fileReq.sp = @"2";
    
    FNFileServiceLogic *fileService = [[FNFileServiceLogic alloc] init];
    
    [fileService uploadFile:fileReq callback:^(FNFileUploadResponse *serviceRsp) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack(serviceRsp);
        });
    }];
}

+ (void)saveRichTextMessage:(FNSendRichTextMsgRequest *)richTextMsgReq
{
    //消息
    FNGroupMsgTable *message = [[FNGroupMsgTable alloc] init];
    message.syncId = [FNUserTable getSyncId:EventTypePG];
    message.msgId = richTextMsgReq.msgEntity.msgId;
    message.tid = [Utility userIdWithoutAppKey:richTextMsgReq.msgEntity.peerID];
    message.msgType = richTextMsgReq.msgEntity.msgType;
    message.msgAttribute = richTextMsgReq.msgEntity.msgAttribute;
    message.senderNickname = richTextMsgReq.msgEntity.senderNickname;
    message.senderId = richTextMsgReq.msgEntity.senderId;
    message.senderProtraitUrl = richTextMsgReq.msgEntity.sendPortraitUrl;
    message.sendStatus = MsgUploading;
    message.readStatus = MsgAlreadyRead;
    message.flag = MsgSendFlag;
    message.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
    message.contentType = richTextMsgReq.msgContent.contentType;
    message.content = richTextMsgReq.msgContent.content;
    message.savePath = richTextMsgReq.msgContent.filePath;
    message.thumbPath = richTextMsgReq.msgContent.fileThumbPath;
    //    message.fileId = richTextMsgReq.msgContent.fileId;
    //    message.fileName = richTextMsgReq.msgContent.fileName;
    //    message.fileSize = richTextMsgReq.msgContent.fileSize;
    //    message.fileWidth = richTextMsgReq.msgContent.fileWidth;
    //    message.fileHeight = richTextMsgReq.msgContent.fileHeight;
    //    message.URL = richTextMsgReq.msgContent.fileDownloadUrl;
    
    //    message.playTime = richTextMsgReq.msgContent.duration;
    //    message.bitrate = richTextMsgReq.msgContent.bitrate;
    //    message.processedSize = 0L;
    [FNGroupMsgTable insert:message];
    
    //最近会话
    FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
    info.eventType = EventTypePG;
    info.msgType = message.msgType;
    info.targetId = [Utility userIdWithoutAppKey:richTextMsgReq.msgEntity.peerID];
    info.targetName = richTextMsgReq.msgEntity.senderNickname;
    info.targetProtraitUrl = richTextMsgReq.msgEntity.sendPortraitUrl;
    info.senderNickname = richTextMsgReq.msgEntity.senderNickname;
    info.content = message.content;
    //    [info setUnreadMsgCount];
    info.syncId = [FNUserTable getSyncId:EventTypePG];
    info.lastActiveDate = message.createDate;
    info.msgId = richTextMsgReq.msgEntity.msgId;
    info.sendStatus = MsgUploading;
    [FNRecentConversationTable insert:info];
}

+ (void)updateLocalData:(NSString *)downloadUrl msgId:(NSString *)msgId fileId:(NSString *)fileId fileName:(NSString *)fileName fileSize:(long)fileSize fileWidth:(long)fileWidth fileHeight:(long)fileHeight sendStatus:(int)sendStatus
{
    FNGroupMsgTable *message = [[FNGroupMsgTable alloc] init];
    message.fileId = fileId;
    message.fileName = fileName;
    message.fileSize = fileSize;
    message.fileWidth = fileWidth;
    message.fileHeight = fileHeight;
    message.URL = downloadUrl;
    message.thumbPath = @"";
    message.processedSize = 0L;
    message.syncId = [FNUserTable getSyncId:EventTypePG];
    message.msgId = msgId;
    
    [FNGroupMsgTable updateReceiveRichMsgInfo:message];
    [FNGroupMsgTable updateSendMsgStatus:msgId syncId:message.syncId sendStatus:MsgUploadSuccess sendTime:[FNSystemConfig dateToString:[FNSystemConfig getLocalDate]]];
    
    int status = sendStatus==200?MsgUploadSuccess:MsgUploadFailed;
    [FNRecentConversationTable updateSendStatus:status syncId:message.syncId msgId:msgId];
}

+ (void)downloadThumbnail:(NSString *)url
                 fileSize:(long)fileSize
                fileWidth:(long)fileWidth
               fileHeight:(long)fileHeight
                   syncId:(int64_t)syncId
                 fileName:(NSString *)fileName
                   fileId:(NSString *)fileId
                 callback:(void(^)(FNFileDownloadResponse *rspArgs))callback
{
    if ([NSString isNullString:url] ||
        [NSString isNullString:fileId] ||
        fileSize <= 0 ||
        syncId <= 0)
    {
        FNFileDownloadResponse *rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:400 fileInfo:nil errorInfo:@"invalid parameters!"];
        callback(rsp);
        return;
    }
    
    FNFileDownloadRequest *fileReq = [[FNFileDownloadRequest alloc] init];
    fileReq.credential = [NSString urlEncode:[FNUserConfig getInstance].cStr];
    fileReq.fileInfo = [[FNSharedFileInfo alloc] init];
    fileReq.fileInfo.downloadURL = url;
    fileReq.fileInfo.fileSize = fileSize;
    fileReq.fileInfo.fileWidth = fileWidth;
    fileReq.fileInfo.fileHeight = fileHeight;
    fileReq.fileInfo.fileName = nil;//fileName;//适配安卓传入的参数
    fileReq.fileInfo.fileId = fileId;
    
    FNFileServiceLogic *fileService = [[FNFileServiceLogic alloc] init];
    [fileService downloadFileThumb:fileReq callback:^(FNFileDownloadResponse *rspArgs) {
        dispatch_async(dispatch_get_main_queue(), ^{  //callback 处理
            FNGroupMsgTable *richInfo = [[FNGroupMsgTable alloc] init];
            if (200 == rspArgs.statusCode)
            {
                richInfo.syncId = syncId;
                richInfo.fileId = rspArgs.fileInfo.fileId;
                richInfo.fileName = rspArgs.fileInfo.fileName;
                richInfo.fileSize = rspArgs.fileInfo.fileSize;
                richInfo.fileWidth = fileWidth;
                richInfo.fileHeight = fileHeight;
                richInfo.thumbPath = rspArgs.fileInfo.filePath;
                richInfo.receiveStatus = MsgReceiveSuccess;
            }
            else
            {
                richInfo.receiveStatus = MsgReceiveFailed;
            }
            
            [FNGroupMsgTable updateReceiveRichMsgInfo:richInfo];
            
            callback(rspArgs);
        });
    }];
}

+ (void)downloadSharedFile:(NSString *)url
                  fileSize:(long)fileSize
                 fileWidth:(long)fileWidth
                fileHeight:(long)fileHeight
                    syncId:(int64_t)syncId
                  fileType:(NSString *)fileType
                  fileName:(NSString *)fileName
                    fileId:(NSString *)fileId
                  callback:(void(^)(FNFileDownloadResponse *rspArgs))callback
{
    if ([NSString isNullString:url] ||
        [NSString isNullString:fileId] ||
        fileSize <= 0 ||
        syncId <= 0)
    {
        FNFileDownloadResponse *rsp = [[FNFileDownloadResponse alloc] initWithRspArgs:400 fileInfo:nil errorInfo:@"invalid parameters!"];
        callback(rsp);
        return;
    }
    if ([NSString isNullString:fileName])
    {
        if ([fileType isEqualToString:FNMsgTypePic])
        {
            fileName = [NSString stringWithFormat:@"%@.JPG", [self generateUUID]];
        }else if ([fileType isEqualToString:FNMsgTypeAudio])
        {
            fileName = [NSString stringWithFormat:@"%@.amr", [self generateUUID]];
        }else if ([fileType isEqualToString:FNMsgTypeVideo])
        {
            fileName = [NSString stringWithFormat:@"%@.mp4", [self generateUUID]];
        }else if ([fileType isEqualToString:FNMsgTypeFile])
        {
            fileName = fileId;
        }
    }
    FNFileDownloadRequest *fileReq = [[FNFileDownloadRequest alloc] init];
    fileReq.credential = [NSString urlEncode:[FNUserConfig getInstance].cStr];
    fileReq.fileInfo = [[FNSharedFileInfo alloc] init];
    fileReq.fileInfo.downloadURL = url;
    fileReq.fileInfo.fileSize = fileSize;
    fileReq.fileInfo.fileWidth = fileWidth;
    fileReq.fileInfo.fileHeight = fileHeight;
    fileReq.fileInfo.fileName = fileName;
    fileReq.fileInfo.fileId = fileId;
    
    FNFileServiceLogic *fileService = [[FNFileServiceLogic alloc] init];
    [fileService downloadFile:fileReq callback:^(FNFileDownloadResponse *rspArgs) {
        dispatch_async(dispatch_get_main_queue(), ^{  //callback 处理
            FNGroupMsgTable *richInfo = [[FNGroupMsgTable alloc] init];
            if (200 == rspArgs.statusCode)
            {
                richInfo.syncId = syncId;
                richInfo.fileId = rspArgs.fileInfo.fileId;
                richInfo.fileName = rspArgs.fileInfo.fileName;
                richInfo.fileSize = rspArgs.fileInfo.fileSize;
                richInfo.fileWidth = fileWidth;
                richInfo.fileHeight = fileHeight;
                richInfo.savePath = rspArgs.fileInfo.filePath;
                richInfo.receiveStatus = MsgReceiveSuccess;
            }
            else
            {
                richInfo.receiveStatus = MsgReceiveFailed;
            }
            
            [FNGroupMsgTable updateReceiveRichMsgInfo:richInfo];
            
            callback(rspArgs);
        });
    }];
}

@end
