//
//  FNMultiMsgsLogic.m
//  FeinnoBopSDK
//
//  Created by yiqingping on 15/11/30.
//  Copyright © 2015年 Feinno. All rights reserved.
//

#import "FNMultiMsgsLogic.h"
#import "FNFileServiceLogic.h"
#import "FNMultiMsgEnty.h"

#import "FNUserConfig.h"
#import "FNSystemConfig.h"

#import "CMD.h"
#import "McpRequest.h"

#import "BodyMaker+MessageBodyMaker.h"
#import "SendMultiMsgResults.pb.h"

#import "FNMsgTable.h"
#import "FNUserTable.h"
#import "FNRecentConversationTable.h"

#import "Utility.h"
#import "NSString+Extension.h"
#import "NSData+DataEncrypt.h"

@implementation FNMultiMsgsLogic

+ (void)sendMultiTextMsg:(FNSendMultiTextMsgRequest *)textMsgReq
                callback:(void (^)(FNSendMsgResponse *))callback

{
    if ([NSString isNullString:textMsgReq.content])
    {
        NSLog(@"msgcontent is null");
        FNSendMsgResponse *rsp = [[FNSendMsgResponse alloc] initWithStatusCode:400];
        callback(rsp);
        return;
    }
    
    FNMsgContent *textContent = [FNMsgContent msgContentWithType:TextMsg];
    [textContent setContent:textMsgReq.content];
    [textContent setContentType:textMsgReq.contentType];
    
    FNMultiMsgEnty *msgEntity = [[FNMultiMsgEnty alloc] init];
    msgEntity.peerIDs = [Utility userIdListWithAppkeys:textMsgReq.peerIDs];
    msgEntity.msgContent = textContent.toJString;//这里为什么是个nill 是不是回调时候赋值的
    msgEntity.msgAttribute = textMsgReq.msgAttribute;
    msgEntity.msgType = FNMsgTypePlain;
    if([NSString isNullString:textMsgReq.msgId])
    {
       msgEntity.msgId = [FNMsgBasicLogic generateUUID];
    }else{
       msgEntity.msgId = textMsgReq.msgId; 
    }
    msgEntity.sendDate = [FNSystemConfig getLocalDate];
    msgEntity.senderNickname = [FNUserConfig getInstance].nickname;
    msgEntity.source = textMsgReq.source;
    
    [self sendTextMsg:msgEntity
           msgContent:textMsgReq.content
          contentType:textMsgReq.contentType
          isEncrypted:NO
             callback:callback];
}
+ (void)sendTextMsg:(FNMultiMsgEnty *)msgEntity
         msgContent:(NSString *)content
        contentType:(NSString *)contentType
        isEncrypted:(BOOL)encryption
           callback:(void(^)(FNSendMsgResponse *))callback
{
    int32_t cmd = CMD_SEND_MULTI_MSG_CONTACT;
    NSString *sender = [FNUserConfig getInstance].userIDWithKey;
    NSData *body = [BodyMaker makeSendMultiMsgReqArgs:sender
                                            msgEntity:msgEntity];
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
            
            BOOL success = (result.statusCode == 200 && result.syncID > 0 && (result.reason == nil || [result.reason length] == 0));
            FNMsgTable *message = [[FNMsgTable alloc] init];
            message.syncId = result.syncID;
            message.msgId = msgEntity.msgId;
            
            NSMutableString* str=[[NSMutableString alloc]init];
            for (NSString *need in msgEntity.peerIDs) {
                [str appendString:[NSString stringWithFormat:@",%@",need]];
            }
            message.tid = str;
            
            message.msgType = msgEntity.msgType;
            message.msgAttribute = msgEntity.msgAttribute;
            message.contentType = contentType;
            message.content = content;
            message.senderNickname = msgEntity.senderNickname;
            message.senderId = [FNUserConfig getInstance].userIDWithKey;
            message.sendStatus = success ? MsgSendSuccess : MsgSendFailed;
            message.readStatus = MsgAlreadyRead;
            message.flag = MsgSendFlag;
            message.createDate = (result.sendDate && [result.sendDate length] > 0) ? result.sendDate : [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
            
            [FNMsgTable insert:message];
            
            // recent conversation db, 只写入发送成功的消息
            if (success)
            {
               [FNUserTable setSyncId:EventTypePrivate syncId:result.syncID];
            
                FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
                info.eventType = EventTypePrivate; // 必须放在setUnreadMsgCount前面
                info.msgType = message.msgType;
                NSMutableString *str = [[NSMutableString alloc]init];
                for (NSString *need in msgEntity.peerIDs)
                {
                    [str appendString:[NSString stringWithFormat:@",%@",need]];
                }
                info.targetId = str;
                info.senderNickname = msgEntity.senderNickname;
                info.content = content;
                [info setUnreadMsgCount];
                info.syncId = result.syncID;
                info.lastActiveDate = (result.sendDate && [result.sendDate length] > 0) ? result.sendDate : [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
                
                [FNRecentConversationTable insert:info];
            }
            
            callback(result);
        }
        else
        {
            FNMsgTable *message = [[FNMsgTable alloc] init];
            message.syncId = [FNUserTable getSyncId:EventTypePrivate];
            message.msgId = msgEntity.msgId;
            
            NSMutableString *str=[[NSMutableString alloc]init];
            for (NSString *need in msgEntity.peerIDs) {
                [str appendString:[NSString stringWithFormat:@",%@",need]];
            }
            message.tid = str;
            
            message.msgType = msgEntity.msgType;
            message.msgAttribute = msgEntity.msgAttribute;
            message.contentType = contentType;
            message.content = content;
            message.senderNickname = msgEntity.senderNickname;
            message.senderId = [FNUserConfig getInstance].userIDWithKey;
            message.sendStatus = MsgSendFailed;
            message.readStatus = MsgAlreadyRead;
            message.flag = MsgSendFlag;
            message.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
            
            [FNMsgTable insert:message];
            
            callback(nil);
        }
    }];
}


+ (void)sendMultiRichTextMsg:(FNSendMultiRichTextMsgRequest *)richTextMsgReq
                    callback:(void(^)(FNSendRichTextMsgResponse *))callback
{
    FNMultiFileUploadRequest *fileReq =[[FNMultiFileUploadRequest alloc]init];
    
    // 拼接路径
    if ([NSString isNullString:richTextMsgReq.msgContent.fileName])
    {
        richTextMsgReq.msgContent.fileName = [NSString stringWithFormat:@"%@.jpg", [FNMsgBasicLogic generateUUID]];
    }
    
    fileReq.fileName = richTextMsgReq.msgContent.fileName;
    NSString *filePath = [[FNUserConfig getInstance].filePath stringByAppendingPathComponent:richTextMsgReq.msgContent.fileName];
    
    if ([NSString isNullString:richTextMsgReq.msgContent.filePath])
    {
        fileReq.fileData = richTextMsgReq.msgContent.fileData;
    }
    else
    {
        fileReq.fileData = [NSData dataWithContentsOfFile:richTextMsgReq.msgContent.filePath];
    }
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileReq.fileData attributes:nil];
    fileReq.filePath = filePath;
    fileReq.fileType = [self getFileTypeByMIMEType:fileReq.filePath];
    fileReq.ssic = [NSString urlEncode:[FNUserConfig getInstance].cStr];
    fileReq.tids = [Utility userIdListWithAppkeys:richTextMsgReq.muMsgEntity.peerIDs];
    fileReq.sp = @"1";
    
    FNFileServiceLogic *fileService = [[FNFileServiceLogic alloc] init];
    
    [fileService uploadMultiFiles:fileReq callback:^(FNFileUploadResponse *serviceRsp) {
        dispatch_async(dispatch_get_main_queue(), ^{  // 这里是否需要返回主线程处理？
            NSLog(@"upload rich text msg file statusCode:%d", serviceRsp.statusCode);
            
            richTextMsgReq.muMsgEntity.msgType = [self getMsgTypeByMIMEType:fileReq.filePath];
            richTextMsgReq.msgContent.filePath = serviceRsp.fileInfo.filePath;
            [richTextMsgReq.msgContent setFileDownloadUrl:serviceRsp.fileInfo.downloadURL];
            [richTextMsgReq.msgContent setFileId:serviceRsp.fileInfo.fileId];
            [richTextMsgReq.msgContent setFileSize:serviceRsp.fileInfo.fileSize];
            
            richTextMsgReq.muMsgEntity.msgContent = richTextMsgReq.msgContent.toJString;
          
            richTextMsgReq.muMsgEntity.msgId = richTextMsgReq.muMsgEntity.msgId;
            richTextMsgReq.muMsgEntity.sendDate = FNSystemConfig.getLocalDate;
            richTextMsgReq.muMsgEntity.senderNickname = (richTextMsgReq.muMsgEntity.senderNickname ? richTextMsgReq.muMsgEntity.senderNickname : [FNUserConfig getInstance].nickname);
            richTextMsgReq.muMsgEntity.peerIDs =[Utility userIdListWithAppkeys:richTextMsgReq.muMsgEntity.peerIDs];
            
            if (200 == serviceRsp.statusCode)
            {
                if ([NSString isNullString:richTextMsgReq.muMsgEntity.msgContent])
                {
                    NSLog(@"msgcontent is null");
                    FNSendRichTextMsgResponse *rsp = [[FNSendRichTextMsgResponse alloc]init];
                    rsp.statusCode = 400;
                    callback(rsp);
                    return;
                }
                
                NSString *userid = [FNUserConfig getInstance].userIDWithKey;
                int32_t cmd = CMD_SEND_MULTI_MSG_CONTACT;
                NSData *body = [BodyMaker makeSendMultiMsgReqArgs:userid
                                                        msgEntity:richTextMsgReq.muMsgEntity];
                
                [[McpRequest sharedInstance] send:cmd userid:userid body:body callback:^(NSData *data) {
                    FNMsgContent *msgContent = [FNMsgContent toObjectFromStr:richTextMsgReq.muMsgEntity.msgContent withMsgType:richTextMsgReq.muMsgEntity.msgType];
                    if (data)
                    {
                        PacketObject *packetObject = [McpRequest parseWithData:data
                                                                           key:[FNUserConfig getInstance].cStr];
                        SendMsgResults *rspArgs = (SendMsgResults *)packetObject.args;
                        
                        FNSendMsgResponse *result = [[FNSendMsgResponse alloc] initWithPBArgs:rspArgs];
                        FNSendRichTextMsgResponse *richResult = [[FNSendRichTextMsgResponse alloc]init];
                        richResult.msgRsp = result;
                        richResult.fileInfo = serviceRsp.fileInfo;
                        
                        // DB
                        BOOL success = (result.statusCode == 200 && result.syncID > 0 && (result.reason == nil || [result.reason length] == 0));
                        
                        FNMsgTable *message = [[FNMsgTable alloc] init];
                        message.syncId = result.syncID;
                        message.msgId = richTextMsgReq.muMsgEntity.msgId;
                        
                        NSMutableString * str = [[NSMutableString alloc]init];
                        for (NSString *needStr in fileReq.tids) {
                            [str appendString:[NSString stringWithFormat:@",%@",needStr]];
                        }
                        message.tid = str;
                        
                        message.msgType = richTextMsgReq.muMsgEntity.msgType;
                        message.msgAttribute = richTextMsgReq.muMsgEntity.msgAttribute;
                        message.senderNickname = richTextMsgReq.muMsgEntity.senderNickname;
                        message.senderId = [FNUserConfig getInstance].userIDWithKey;
                        message.sendStatus = success ? MsgSendSuccess : MsgSendFailed;
                        message.readStatus = MsgAlreadyRead;
                        message.flag = MsgSendFlag;
                        message.createDate = (result.sendDate && [result.sendDate length] > 0) ? result.sendDate : [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
                        
                        // 写消息内容和属性
                        message.contentType = msgContent.contentType;
                        message.content = msgContent.content;
                        
                        message.fileId = richResult.fileInfo.fileId;
                        message.fileName = richResult.fileInfo.fileName;
                        message.fileSize = richResult.fileInfo.fileSize;
                        message.fileWidth = richTextMsgReq.msgContent.fileWidth;
                        message.fileHeight = richTextMsgReq.msgContent.fileHeight;
                        message.URL = richResult.fileInfo.downloadURL;
                        message.savePath = fileReq.filePath;
                        message.thumbPath = fileReq.filePath;
                        
                        message.playTime = msgContent.duration;
                        message.bitrate = msgContent.bitrate;
                        
                        [FNMsgTable insert:message];
                        
                        // recent conversation db, 只写入发送成功的消息
                        if (success)
                        {
                            [FNUserTable setSyncId:EventTypePrivate syncId:result.syncID];
                            
                            FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
                            info.eventType = EventTypePrivate; // 必须放在setUnreadMsgCount前面
                            info.msgType = message.msgType;  // 必须放在getRichMsgContentInRichMsgTable:前面
                            
                            NSMutableString * str = [[NSMutableString alloc]init];
                            for (NSString *needStr in fileReq.tids) {
                                [str appendString:[NSString stringWithFormat:@",%@",needStr]];
                            }
                            info.targetId = str;
                            
                            info.senderNickname = richTextMsgReq.muMsgEntity.senderNickname;
                            info.content = message.content;
                            [info setUnreadMsgCount];
                            info.syncId = result.syncID;
                            info.lastActiveDate = message.createDate;
                            
                            [FNRecentConversationTable insert:info];
                        }
                        
                        callback(richResult);
                    }
                    else
                    {
                        // DB
                        FNMsgTable *message = [[FNMsgTable alloc] init];
                        message.syncId = [FNUserTable getSyncId:EventTypePrivate];
                        message.msgId = richTextMsgReq.muMsgEntity.msgId;
                        
                        NSMutableString * str = [[NSMutableString alloc]init];
                        for (NSString *need in fileReq.tids) {
                            [str appendString:[NSString stringWithFormat:@",%@",need]];
                        }
                        message.tid = str;
                        
                        message.msgType = richTextMsgReq.muMsgEntity.msgType;
                        message.msgAttribute = richTextMsgReq.muMsgEntity.msgAttribute;
                        message.contentType = msgContent.contentType;
                        message.content = msgContent.content;
                        message.senderNickname = richTextMsgReq.muMsgEntity.senderNickname;
                        message.senderId = [FNUserConfig getInstance].userIDWithKey;
                        message.sendStatus = MsgSendFailed;
                        message.readStatus = MsgAlreadyRead;
                        message.flag = MsgSendFlag;
                        message.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
                        
                        message.fileName = fileReq.fileName;
                        message.savePath = fileReq.filePath;
                        message.thumbPath = fileReq.filePath;
                        
                        [FNMsgTable insert:message];
                        
                        callback(nil);
                    }
                }];
            }
            else
            {
                FNSendMsgResponse *sendMsgRsp = [[FNSendMsgResponse alloc] initWithStatusCode:250]; // 250 表示HTTP上传文件失败的状态码
                FNSendRichTextMsgResponse *rResult = [[FNSendRichTextMsgResponse alloc] init];
                rResult.msgRsp = sendMsgRsp;
                FNMsgTable *message = [[FNMsgTable alloc] init];
                message.syncId =  [FNUserTable getSyncId:EventTypePrivate];
                message.msgId = richTextMsgReq.muMsgEntity.msgId;
                NSMutableString * str = [[NSMutableString alloc]init];
                for (NSString *need in fileReq.tids) {
                    [str appendString:[NSString stringWithFormat:@",%@",need]];
                }
                //数据库字段长度有显示会崩溃
                message.tid = str;
                
                message.msgType = richTextMsgReq.muMsgEntity.msgType;
                message.msgAttribute = richTextMsgReq.muMsgEntity.msgAttribute;
                message.content = richTextMsgReq.muMsgEntity.msgContent;
                message.senderNickname = richTextMsgReq.muMsgEntity.senderNickname;
                message.senderId = [FNUserConfig getInstance].userIDWithKey;
                message.sendStatus = MsgSendFailed;
                message.readStatus = MsgAlreadyRead;
                message.flag = MsgSendFlag;
                message.createDate = (sendMsgRsp.sendDate && [sendMsgRsp.sendDate length] > 0) ? sendMsgRsp.sendDate : [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
                
                message.fileName = fileReq.fileName;
                message.savePath = fileReq.filePath;
                message.thumbPath = fileReq.filePath;
                
                [FNMsgTable insert:message];
                
                callback(rResult);
            }
        });
    }];
}



@end
