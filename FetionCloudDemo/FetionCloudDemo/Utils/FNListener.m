//
//  FNListener.m
//  FetionCloudDemo
//
//  Created by feinno on 16/7/28.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNListener.h"
#import "RcsApi.h"
#import "AppDelegate.h"

#import "FNUserInfo.h"
#import "MessageEntity.h"
#import "FNmsgTable.h"
#import "DBManager.h"

#import "FNDBManager.h"
#import "FNUserConfig.h"
#import "FNUserTable.h"
#import "FNSystemConfig.h"
#import "ContactDataTable.h"
#import "ContactRequestTable.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>


@implementation FNListener



+(instancetype)ShareStaticConst{
    
    static FNListener * _static = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (_static == nil)
        {
            _static = [[FNListener alloc]init];
        }
    });
    return _static;
    
}






- (void)registerAvListener
{
}

- (void)registerGroupListener
{
}

//服务端推送好友操作事件监听器
- (void)registerBuddyEventListener
{
    //__weak typeof(self) weakSelf = self;
    [globalRcsApi setBuddyEventListener:^(rcs_state*R, BuddyEventSession* s){
        
        //_buddyInviterId = [NSString stringWithUTF8String:s->from_user];
        NSLog(@"_buddyInbiterId================%s",s->from_user);
        
        [DBManager initDBWithUserId:[FNUserInfo ShareStaticConst].localNum];
        
        
        //收到被添加请求，发送通知
        if (s->op == 6) {
            
            
            //_addBuddyArray = [[NSMutableArray alloc]init];
            
            UserInfo * u = s->user_info;
            
            NSString *str1 = [NSString  stringWithFormat:@"%d",u->user_id];
            ContactRequestTable *table = [ContactRequestTable getWithUserId:str1];
            table.userId = [NSString stringWithFormat:@"%d",u->user_id];
            table.nickName = [NSString stringWithUTF8String:u->nickname];
            table.username = [NSString stringWithUTF8String:u->username];
            
            //            NSLog(@"请求的好友数量%d----%d",_addBuddyArray.count,s->op);
            //                  NSLog(@"请求的好友名字----%@----%@",table.nickName,table.username);
            //            [_addBuddyArray addObject:table];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addbuddy" object:table];
            
        }
        
    }];
    
}


//服务端推送好友列表事件监听器
- (void)registerBuddyListListener
{
    // __weak typeof(self) weakSelf = self;
    
    if (!_buddyIDArray) {
        
        _buddyIDArray = [[NSMutableArray alloc]init];
        
    }
    
    [globalRcsApi setBuddyListListener:^(rcs_state*R, BuddyListSession* s)
     {
         int i = 0;
         while (1 && s->full)
         {
             BuddyInfo* p = s->full[i++];
             if (p == NULL) {
                 break;
             }
             //[weakSelf AddLogNs:[NSString stringWithFormat:@"buddy %d:%d", i, p->user_id]];
             //_buddyRemoteId = p->user_id;
             
             //NSNumber *number = [[NSNumber alloc]initWithInt:_buddyRemoteId];
             
             NSString *buddyRemoteId = [NSString stringWithFormat:@"%d",p->user_id];
             
             [_buddyIDArray addObject:buddyRemoteId];
             
             [FNUserInfo ShareStaticConst].buddyIDArray = _buddyIDArray;
             
             [DBManager initDBWithUserId:[FNUserInfo ShareStaticConst].localNum];
             
             ContactDataTable *table = [ContactDataTable getWithUserId:buddyRemoteId];
             
             if (p->action == 1) {
                 NSLog(@"add");
             }else if (p->action == 2){
                 NSLog(@"dele");
             }else if (p->action == 3){
                 NSLog(@"update'");
             }
             
             if (!table.userId)
             {
                 ContactDataTable *table = [[ContactDataTable alloc] init];
                 table.userId = buddyRemoteId;
                 [ContactDataTable insert:table];
             }
         }
         
         i = 0;
         while (1 && s->partial)
         {
             BuddyInfo* p = s->partial[i++];
             if (p == NULL) {
                 break;
             }
             
             NSString *buddyRemoteId = [NSString stringWithFormat:@"%d",p->user_id];
             
             if (p->action == 2) {
                 
                 NSLog(@"hah");
                 
                 [_buddyIDArray removeObject:buddyRemoteId];
                 
                 
                 [ContactDataTable del:buddyRemoteId];
             }else if (p->action == 1){
                 
                 [_buddyIDArray addObject:buddyRemoteId];
                 
                 ContactDataTable *table = [ContactDataTable getWithUserId:buddyRemoteId];
                 
                 if (!table.userId)
                 {
                     ContactDataTable *table = [[ContactDataTable alloc] init];
                     table.userId = buddyRemoteId;
                     [ContactDataTable insert:table];
                 }
                 
                 
             }else if (p->action == 3){
                 
                 NSLog(@"do what");
                 
             }
             
             [FNUserInfo ShareStaticConst].buddyIDArray = _buddyIDArray;
             
             //ContactDataTable *table = [ContactDataTable getWithUserId:[NSString stringWithFormat:@"%@",number]];
             
             //             if (!table.userId)
             //             {
             //                 ContactDataTable *table = [[ContactDataTable alloc] init];
             //                 table.userId = [NSString stringWithFormat:@"%@",number];
             //                 [ContactDataTable insert:table];
             //             }
             
             NSLog(@"do what....");
             
         }
     }];
    
}


- (void)registerMsgListener
{
    __weak typeof(self) weakSelf = self;
    
    //服务端推送SINGLE(一对一聊天)、GROUP(群组聊天)、PUBLIC_ACCOUNT(公众账号消息)、BROADCAST(广播消息)、DIRECTED(定向消息)文本消息事件监听器
    
    [globalRcsApi setMsgTextListener:^(rcs_state*R, MessageTextSession* s)
     {
         //[weakSelf AddLogC:s->content];
         NSLog(@"content=======%s",s->content);
         
         
         // MessageEntity * m = [MessageEntity new];
         // m.imdn_id = [NSString stringWithFormat:@"%@",s->imdn_id];
         //----------------------------------------------------------------------------------
         
         FNMsgTable *message = [[FNMsgTable alloc] init];
         message.syncId = [FNUserTable getSyncId:EventTypePrivate];
         message.msgId = [NSString stringWithFormat:@"%s",s->imdn_id];
         message.tid = [NSString stringWithFormat:@"%s",s->to];
         message.msgType = FNMsgTypePlain;
         message.msgAttribute = [NSString stringWithFormat:@"%d",s->is_burn];
         message.contentType = FNMsgTypePlain;
         message.content = [NSString stringWithUTF8String:s->content];
         message.senderNickname = @"JACK";
         message.senderId = [NSString stringWithFormat:@"%s",s->from];
         
         message.senderProtraitUrl =@"path";
         message.sendStatus = MsgSendSuccess;
         message.readStatus = MsgAlreadyRead;
         message.flag = MsgReceiveFlag;
         message.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
         [FNMsgTable insert:message];
         
         //------------------------------------------------------------------------------
         
         // [[FNUserInfo ShareStaticConst].messageArray addObject:m];
         
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:message];
         
         // [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_HAS_NEW_MSG object:message];
         
         if(s->need_report)
         {
             NSString* from = [NSString stringWithUTF8String:s->from];
             NSString* messageId = [NSString stringWithUTF8String:s->imdn_id];
             [globalRcsApi msgsendreport:R number:from messageId:messageId reportType:ReportTypeDELIVERED directedType:DirectedTypeNONE callback:^(rcs_state* R, MessageResult *s) {
                 if (s->error_code == 200) {
                     //[weakSelf AddLogC:"send report ok"];
                     NSLog(@"send report ok");
                 }
                 else
                 {
                     //[weakSelf AddLogC:"send report failed"];
                     NSLog(@"send report failed");
                 }
             }];
         }
     }];
    
    /*    服务端推送BURN(已焚)、DELIVERED(已送达)、FILE_PROGRESS(文件上传/下载进度)、GROUP_DELIVERED(群组消息已送达)、
     *   GROUP_READ(群组消息已读)、GROUP_WITH_DRAW(群组消息撤销)、READ(已读)、TYPING(正在输入)、UPDATE_MSG_ID(更新消息 ID)、
     *    WITH_DRAW(撤回)、消息报告事件监听器
     */
    [globalRcsApi setMsgReportListener:^(rcs_state*R, MessageReportSession* s)
     {
         //[weakSelf AddLogC:"receive MessageReportSession"];
         NSLog(@"receice MessageReportSession");
         
     }];
    
    // 服务端推送彩云文件消息事件监听器
    [globalRcsApi setMsgCloudfileListener:^(rcs_state*R, MessageCloudFileSession* s)
     {
         //[weakSelf AddLogC:"receive MessageCloudFileSession"];
         NSLog(@"receive MessageCloudFileSession");
     }];
    
    // 服务端推送商店表情消息事件监听器
    [globalRcsApi setMsgEmoticonListener:^(rcs_state*R, MessageEmoticonSession* s)
     {
         //[weakSelf AddLogC:"receive MessageEmoticonSession"];
         NSLog(@"receice MessageEmoticonSession ");
     }];
    
    // 服务端推送自定义消息,SDK直接透传不处理事件监听器
    [globalRcsApi setMsgCustomListener:^(rcs_state*R, MessageCustomSession* s)
     {
         // [weakSelf AddLogNs:[NSString stringWithFormat:@"receive custom msg, data:%s, data_id:%s, data_type:%d", s->data, s->data_id, s->data_type]];
         NSLog(@"receive custom msg, data:%s, data_id:%s, data_type:%d", s->data, s->data_id, s->data_type);
     }];
    
    // 服务端推送富文本消息事件监听器
    [globalRcsApi setMsgFtListener:^(rcs_state*R, MessageFTSession* s)
     {
         
         NSLog(@"receive MessageFtSession");
         
         if(!s->is_report && s->file_size > 0)
         {
             NSString* messageId = [NSString stringWithUTF8String:s->imdn_id];
             NSString* transferId = [NSString stringWithUTF8String:s->transfer_id];
             
             NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             
             NSString *filePath = [docPaths objectAtIndex:0];
             
             UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
             
             NSString * filename = [NSString stringWithFormat:@"%lld", recordTime];
             
             NSString* newfilePath = [NSString stringWithFormat:@"%@/%@", filePath,filename];
             
             FNMsgTable *message = [[FNMsgTable alloc] init];
             message.syncId = [FNUserTable getSyncId:EventTypePrivate];
             message.msgId = [NSString stringWithFormat:@"%s",s->imdn_id];
             message.tid = [NSString stringWithFormat:@"%s",s->to];
             message.msgAttribute = [NSString stringWithFormat:@"%d",s->is_burn];
             //message.content = [NSString stringWithUTF8String:s->content];
             message.senderNickname = @"嘿";
             message.senderId = [NSString stringWithFormat:@"%s",s->from];
             message.senderProtraitUrl =@"path";
             
             
             if (s->content_type == 2) {
                 
                 message.msgType = FNMsgTypePic;
                 message.contentType = FNMsgTypePic;
                 newfilePath = [newfilePath stringByAppendingString:@".jpg"];
                 NSData *data = [NSData dataWithContentsOfFile:newfilePath];
                 message.fileWidth =[UIImage imageWithData:data].size.width;
                 message.fileHeight = [UIImage imageWithData:data].size.height;
                 
                 
             }else if (s->content_type == 3){
                 
                 message.msgType = FNMsgTypeAudio;
                 message.contentType = FNMsgTypeAudio;
                 newfilePath = [newfilePath stringByAppendingString:@".amr"];
                 
                 
             }else if (s->content_type == 8){
                 
                 message.msgType = FNMsgTypeVideo;
                 message.contentType = FNMsgTypeVideo;
                 newfilePath = [newfilePath stringByAppendingString:@".mp4"];
                 
                 
             }else{
                 
                 NSLog(@"other");
                 
             }
             
             NSString *fullPath = [[[FNUserConfig getInstance].filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%s",s->file_name]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
             
             message.fileId =@"";
             message.fileName = filename;
             message.fileSize = s->file_size;
             message.savePath = fullPath;
             message.thumbPath = fullPath;
             
             message.sendStatus = MsgSendSuccess;
             message.readStatus = MsgAlreadyRead;
             
             
             NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
             
             if ([userId isEqualToString:message.senderId]) {
                 
                 message.flag = MsgSendFlag;
                 
             }else{
                 
                 message.flag = MsgReceiveFlag;
             }
             
             message.receiveStatus = MsgReceiveSuccess;
             message.createDate = [FNSystemConfig dateToString:[FNSystemConfig getLocalDate]];
             
             //下载富文本文件
             [globalRcsApi msgfetchfile:R number:weakSelf.localNum
                              messageId:messageId
                               chatType:s->chat_type
                               filePath:fullPath
                            contentType:s->content_type
                               fileName:@""
                             transferId:transferId
                                  start:0
                               fileSize:s->file_size
                                   hash:@""
                                 isBurn:s->is_burn
                               callback:^(rcs_state* R, MessageResult *s) {
                                   
                                   if (s->error_code == 200) {
                                       NSURL *url = [NSURL fileURLWithPath:fullPath];
                                       AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:url options:nil];
                                       CMTime time = audioAsset.duration;
                                       NSTimeInterval seconds = CMTimeGetSeconds(time);
                                       NSLog(@"fetch file ok");
                                       message.playTime = seconds;
                                       [FNMsgTable insert:message];
                                       
                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:message];
                                       
                                   }
                                   else
                                   {
                                       NSLog(@"fetch file failed");
                                   }
                               }];
         }
         
     }];
    
}



- (void)registerGroupListListener
{
    //__weak typeof(self) weakSelf = self;
    [globalRcsApi setGroupListListener:^(rcs_state*R, GroupListSession* s)
     {
         //[weakSelf AddLogC:"call GroupListListener"];
         
         NSLog(@"%d,%s,%d",s->sid,s->user,s->sync_mode);
         
     }];
}

//服务端推送群组详细信息事件监听器
- (void)registerGroupInfoListener
{
    //__weak typeof(self) weakSelf = self;
    [globalRcsApi setGroupInfoListener:^(rcs_state*R, GroupSession* s)
     {
         //[weakSelf AddLogC:"call GroupInfoListener"];
         
     }];
}

//服务端推送INVITED(被邀请入群)、QUIT(退出群)、BOOTED(被踢出群)、
// CONFIRMED(群邀请处理结果)、DISMISSED(群被解散)、TRANSFER(被提升为管理员)群操作事件监听器
//描述的事件都是与当前用户有关的信息
- (void)registerGroupEventListener
{
    // __weak typeof(self) weakSelf = self;
    [globalRcsApi setGroupEventListener:^(rcs_state*R, GroupEventSession* s)
     {
         //[weakSelf AddLogC:"call GroupEventListener"];
     }];
}

//服务端推送群组通知的信息 这个类型中,描述的是群组其他人发生的和自己无关,不需要额外处理群操作事件监听器
- (void)registerGroupNotifyListener
{
    //__weak typeof(self) weakSelf = self;
    [globalRcsApi setGroupNotifyListener:^(rcs_state*R,  GroupNotificationSession* s)
     {
         //[weakSelf AddLogC:"call GroupNotifyListener"];
     }];
}


@end