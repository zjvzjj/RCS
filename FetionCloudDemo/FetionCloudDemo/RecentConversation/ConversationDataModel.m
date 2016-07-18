#import "ConversationDataModel.h"

#import "FNUserConfig.h"
#import "FNSystemConfig.h"

#import "FNMsgArgs.h"
#import "FNMsgTable.h"
#import "FNMsgLogic.h"
#import "FNRecentConversationTable.h"
#import "FNGroupMsgTable.h"

#import "NSString+Extension.h"
#import "Utility.h"

#import "FNEnum.h"
#import "FNImage.h"
#import "FNGroupMsgLogic.h"

@interface ConversationDataModel ()

@property (strong, nonatomic) NSString *userID;

@end

@implementation ConversationDataModel {
    int32_t src;
}

@synthesize avatars;
@synthesize isFinish;

- (void) dealloc
{
    avatars = nil;
    self.messages = nil;
}

- (instancetype)initWithSourceAndId:(NSString *)source
                           targetId:(NSString *)target
                   historyMsgsCount:(int)count
                          firstLoad:(BOOL)firstLoad
{
    self = [super init];
    if (self)
    { // Todo 数据操作在此完成
        self.userID = [FNUserConfig getInstance].userID;
        self.toUserId = target;
        self.displayName = [FNUserConfig getInstance].nickname;
        if (!self.displayName)
        { // 容错
            self.displayName = self.userID;
        }
        avatars = [[NSMutableDictionary alloc] init];
        
        NSArray *dbMsgs = nil;
        if ([source isEqualToString:@"private"])
        {
            if (firstLoad)
            {   //  从本地数据库获取未读消息
                dbMsgs = [FNMsgTable getUnreadMsgForTid:self.toUserId num:count];
            }
            //  从本地数据库获取历史消息
            dbMsgs = [FNMsgTable getHistoryMsgForTid:self.toUserId num:count];
            
            src = EventTypePrivate;
        }
        else if ([source isEqualToString:@"group"])
        {
            if (firstLoad)
            {
                dbMsgs = [FNGroupMsgTable getUnreadMsgForGroupId:self.toUserId num:count];
            }
            dbMsgs = [FNGroupMsgTable getHistoryMsgForGroupId:self.toUserId num:count];
            src = EventTypePG;
        }
        
        if (!dbMsgs) {
            NSLog(@"self.dbMsgs init failed!");
            return nil;
        }
        
        self.messages = [self makeTargetFNMsg:dbMsgs mediaData:nil];
        if (!self.messages) {
            NSLog(@"self.messages init failed!");
            return nil;
        }
        // 泡泡
        FNMessagesBubbleImageFactory *bubbleFactory = [[FNMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImage];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImage];
        
    }
    
    return self;
}

// 获取对应类型的FNMessage消息
// 将消息表中的数据转成FNMessage模型
- (NSMutableArray *)makeTargetFNMsg:(NSArray *)messageData
                          mediaData:(NSData *)mediaData
{
    NSMutableArray *fnMsgs = [[NSMutableArray alloc] init];
    for (int i = 0; i < messageData.count; i++)
    {
        BOOL isOutgoing = NO;
        // 抽出生成FNMessage的代码
        FNMessage *msg = nil;
        NSString *senderId = nil;
        NSString *senderNickname = nil;
        NSString *content = nil;
        NSString *type = nil;
        NSString *msgId = nil;
        
        if (src == EventTypePrivate)
        {
            FNMsgTable *data = (FNMsgTable *)[messageData objectAtIndex:i];
            if (MsgSendFlag == data.flag)
            {
                isOutgoing = YES;
                senderId = self.userID;
            }
            else if (MsgReceiveFlag == data.flag)
            {
                senderId = data.senderId;
            }
            senderNickname = (data.senderNickname.length ? data.senderNickname : senderId);
            if (0 == senderNickname.length)
            {
                senderNickname = senderId;
            }
            content = data.content;
            type = data.msgType;
            msgId = data.msgId;
            
            if ([type isEqualToString:FNMsgTypePlain])
            {
                msg = [[FNMessage alloc] initWithSenderId:senderId
                                        senderDisplayName:senderNickname
                                                     date:(data.createDate.length ? [FNSystemConfig stringToDate:data.createDate] : [FNSystemConfig getLocalDate])
                                                     text:content
                                                    msgId:msgId];
                
                if(data.sendStatus == 1)
                {
                    msg.sendingFlag = NO;
                    msg.sendFailureFlag = NO;
                }else if (data.sendStatus ==2 ||data.sendStatus ==5)
                {
                    msg.sendingFlag = NO;
                    msg.sendFailureFlag = YES;
                }else
                {
                    msg.sendingFlag = YES;
                }
                
            }
            else
            {
                id<FNMessageMediaData> newMediaData = nil;
                /* 图片 */
                if ([type isEqualToString:FNMsgTypePic])
                {
                    NSData *picData = nil;
                    if (data.savePath && [data.savePath length] > 0)
                    {
                        
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *rootCachePath = [paths firstObject];
                        NSString *imagePath = [NSString  stringWithFormat:@"%@/%@.jpg",rootCachePath,data.fileName];
                        
                        NSFileHandle *hanlde = [NSFileHandle fileHandleForReadingAtPath:imagePath];
                        picData = [hanlde readDataToEndOfFile];
                    }
                    else if ( data.thumbPath && [data.thumbPath length] > 0)
                    {
                        NSFileHandle *hanlde = [NSFileHandle fileHandleForReadingAtPath:data.thumbPath];
                        picData = [hanlde readDataToEndOfFile];
                    }
                    
                    FNPhotoMediaItem *photoItemCopy = [[FNPhotoMediaItem alloc] initWithImage:[UIImage imageWithData:picData]];
                   
                    photoItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                    newMediaData = photoItemCopy;
                    
                }
                /* 语音 */
                else if ([type isEqualToString:FNMsgTypeAudio])
                {
                    BOOL isFileExist = NO;
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *rootCachePath = [paths firstObject];
                    NSString *audioPath = [NSString  stringWithFormat:@"%@/%@.amr",rootCachePath,data.fileName];
                    
                    if (data.savePath && [data.savePath length] > 0)
                    {
                        isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:audioPath];
                    }
                    
                    FNAudioMediaItem *audioItem = [[FNAudioMediaItem alloc] initWithMaskAsOutgoing:isOutgoing];
                    if(data.savePath != nil)
                    {
                    audioItem.fileURL = [NSURL fileURLWithPath:audioPath];
                    }
                    audioItem.duration = (double)data.playTime;
                    
                    audioItem.status = isFileExist ? kAudioStatusReadyForPL : kAudioStatusReadyForDL;
                    audioItem.appliesMediaViewMaskAsOutgoing = isOutgoing;
                    
                    if (data.bitrate > 0)
                    {
                        audioItem.bitrate = [NSString stringWithFormat:@"%ld", data.bitrate];
                    }
                    newMediaData = audioItem;
                }
                //视频
                else if ([type isEqualToString:FNMsgTypeVideo])
                {
                    FNVideoMediaItem *videoItemCopy = nil;
                    
                    //                    if (data.savePath && [data.savePath length] > 0)
                    //                    {
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *rootCachePath = [paths firstObject];
                    NSString *videoPath = [NSString  stringWithFormat:@"%@/%@.mp4",rootCachePath,data.fileName];
                    
                
                    if(data.savePath != nil)
                    {
                        //videoItemCopy = [[FNVideoMediaItem alloc] initWithFileURL:[NSURL fileURLWithPath:data.savePath] isReadyToPlay:isOutgoing || data.savePath];
                        videoItemCopy = [[FNVideoMediaItem alloc] initWithFileURL:[NSURL fileURLWithPath:videoPath] isReadyToPlay:isOutgoing || videoPath];
                        
                        
                    }else
                    {
                       // videoItemCopy = [[FNVideoMediaItem alloc] initWithFileURL:[NSURL fileURLWithPath:@""] isReadyToPlay:isOutgoing || data.savePath];
                        videoItemCopy = [[FNVideoMediaItem alloc] initWithFileURL:[NSURL fileURLWithPath:@""] isReadyToPlay:isOutgoing || videoPath];
                        
                        
                    }
                    //                    }
                    //                    else
                    //                    {
                    //                        videoItemCopy = [[FNVideoMediaItem alloc] initWithFileURL:[NSURL fileURLWithPath:@""] isReadyToPlay:isOutgoing || data.savePath];
                    //                    }
                    
                    //                    FNVideoMediaItem *videoItemCopy = [[FNVideoMediaItem alloc] initWithFileURL:[NSURL fileURLWithPath:data.savePath] isReadyToPlay:isOutgoing || data.savePath];
                    //                    FNVideoMediaItem *videoItemCopy = [[FNVideoMediaItem alloc] initWithFileURL:[NSURL fileURLWithPath:data.savePath] isReadyToPlay:isOutgoing || data.savePath];
                    
                    videoItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                    newMediaData = videoItemCopy;
                    
                }
                else if ([type isEqualToString:FNMsgTypeLocation]) {
                    FNLocationMediaItem *locationItemCopy = (FNLocationMediaItem *)mediaData;
                    locationItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                    newMediaData = locationItemCopy;
                } else {
                    NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
                }
                
                //                [self downloadWithMessage:data callback:^(FNMsgTable *table) {
                //
                //                    if ([self.dataSource respondsToSelector:@selector(conversationDataModel:message:)])
                //                    {
                //                        [self.dataSource conversationDataModel:self message:table];
                //                    }
                //                }];
                //
                if (newMediaData)
                {
                    msg = [[FNMessage alloc] initWithSenderId:senderId
                                            senderDisplayName:senderNickname
                                                         date:[FNSystemConfig stringToDate:data.createDate]
                                                        media:newMediaData
                                                        msgId:msgId];
                    if ([type isEqualToString:FNMsgTypeVideo])
                    {
                        msg.messageType = FNMessageTypeVideo;
                        msg.timeLong = data.playTime;
                        msg.fileSize =[self getBytesFromDataLength:data.fileSize];
                    }
                    if([type isEqualToString:FNMsgTypePic])
                    {
                        msg.messageType = FNMessageTypePicture;
                    }
                    if(data.sendStatus == 1)
                    {
                        msg.sendingFlag = NO;
                        msg.sendFailureFlag = NO;
                    }else if (data.sendStatus ==2 ||data.sendStatus ==5)
                    {
                        msg.sendingFlag = NO;
                        msg.sendFailureFlag = YES;
                    }else
                    {
                        msg.sendingFlag = YES;
                    }
                }
                
                msg.text = [content removeHtml];
            }
            
            [self setAvatarWithDefaultSenderID:senderId];
            
            if (msg)
            {
                [fnMsgs addObject:msg];
            }
        }
        else if (src == EventTypePG)
        {
            FNGroupMsgTable *data = (FNGroupMsgTable *)[messageData objectAtIndex:i];
            if (MsgSendFlag == data.flag)
            {
                isOutgoing = YES;
                
                senderId = self.userID;
            }
            else if (MsgReceiveFlag == data.flag)
            {
                senderId = [Utility userIdWithoutAppKey:data.senderId];
            }
            senderNickname = (data.senderNickname.length ? data.senderNickname : senderId);
            if (0 == senderNickname.length)
            {
                senderNickname = senderId;
            }
            content = data.content;
            type = data.msgType;
            msgId = data.msgId;
            
            if ([type isEqualToString:FNMsgTypePlain])
            {
                msg = [[FNMessage alloc] initWithSenderId:senderId
                                        senderDisplayName:senderNickname
                                                     date:(data.createDate.length ? [FNSystemConfig stringToDate:data.createDate] : [FNSystemConfig getLocalDate])
                                                     text:content
                                                    msgId:msgId];
                
                if(data.sendStatus == 1)
                {
                    msg.sendingFlag = NO;
                    msg.sendFailureFlag = NO;
                }else if (data.sendStatus ==2 ||data.sendStatus ==5)
                {
                    msg.sendingFlag = NO;
                    msg.sendFailureFlag = YES;
                }else
                {
                    msg.sendingFlag = YES;
                }
            }
            else
            {
                id<FNMessageMediaData> newMediaData = nil;
                /* 图片 */
                if ([type isEqualToString:FNMsgTypePic])
                {
                    NSData *picData = nil;
                    if (data.savePath && [data.savePath length] > 0)
                    {
                        NSFileHandle *hanlde = [NSFileHandle fileHandleForReadingAtPath:data.savePath];
                        picData = [hanlde readDataToEndOfFile];
                    }
                    else if ( data.thumbPath && [data.thumbPath length] > 0)
                    {
                        NSFileHandle *hanlde = [NSFileHandle fileHandleForReadingAtPath:data.thumbPath];
                        picData = [hanlde readDataToEndOfFile];
                    }
                    
                    FNPhotoMediaItem *photoItemCopy = [[FNPhotoMediaItem alloc] initWithImage:[UIImage imageWithData:picData]];
                    photoItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                    newMediaData = photoItemCopy;
                }
                /* 语音 */
                else if ([type isEqualToString:FNMsgTypeAudio])
                {
                    BOOL isFileExist = NO;
                    if (data.savePath && [data.savePath length] > 0)
                    {
                        isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:data.savePath];
                    }
                    
                    FNAudioMediaItem *audioItem = [[FNAudioMediaItem alloc] initWithMaskAsOutgoing:isOutgoing];
                    audioItem.fileURL = [NSURL fileURLWithPath:data.savePath];
                    audioItem.duration = (double)data.playTime;
                    audioItem.status = isFileExist ? kAudioStatusReadyForPL : kAudioStatusReadyForDL;
                    audioItem.appliesMediaViewMaskAsOutgoing = isOutgoing;
                    
                    if (data.bitrate > 0)
                    {
                        audioItem.bitrate = [NSString stringWithFormat:@"%ld", data.bitrate];
                    }
                    newMediaData = audioItem;
                    
                }
                else if ([type isEqualToString:FNMsgTypeVideo])
                {
                    //                    mediaData = [NSData dataWithContentsOfFile:data.savePath
                    //                                                       options:NSDataReadingUncached
                    //                                                         error:nil];
                    FNVideoMediaItem *videoItemCopy = nil;
                    if(data.savePath != nil)
                    {
                        videoItemCopy = [[FNVideoMediaItem alloc] initWithFileURL:[NSURL fileURLWithPath:data.savePath] isReadyToPlay:isOutgoing || data.savePath];
                        videoItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = videoItemCopy;
                    }else
                    {
                        videoItemCopy = [[FNVideoMediaItem alloc] initWithFileURL:[NSURL fileURLWithPath:@""] isReadyToPlay:isOutgoing || data.savePath];
                    }
                    //                    FNVideoMediaItem *videoItemCopy = [[FNVideoMediaItem  alloc]initWithFileURL:[NSURL fileURLWithPath:data.savePath
                    //
                    //                                                                                                 ] isReadyToPlay:isOutgoing || data.savePath];
                    //                    //videoItemCopy.thumbPath = data.thumbPath;
                    //                    videoItemCopy.fileURL = [NSURL URLWithString:data.savePath];
                    //
                    //                    videoItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                    //                    newMediaData = videoItemCopy;
                }
                else if ([type isEqualToString:FNMsgTypeLocation]) {
                    FNLocationMediaItem *locationItemCopy = (FNLocationMediaItem *)mediaData;
                    locationItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                    newMediaData = locationItemCopy;
                } else {
                    NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
                }
                
                //                [self downloadGroupWithMessage:data callback:^(FNGroupMsgTable *table) {
                //
                //                    if ([self.dataSource respondsToSelector:@selector(conversationDataModel:groupMessage:)])
                //                    {
                //                        [self.dataSource conversationDataModel:self groupMessage:table];
                //                    }
                //                }];
                
                if (newMediaData)
                {
                    msg = [[FNMessage alloc] initWithSenderId:senderId
                                            senderDisplayName:senderNickname
                                                         date:[FNSystemConfig stringToDate:data.createDate]
                                                        media:newMediaData
                                                        msgId:msgId];
                    if ([type isEqualToString:FNMsgTypeVideo])
                    {
                        msg.messageType = FNMessageTypeVideo;
                        msg.timeLong = data.playTime;
                        msg.fileSize =[self getBytesFromDataLength:data.fileSize];
                    }
                    if([type isEqualToString:FNMsgTypePic])
                    {
                        msg.messageType = FNMessageTypePicture;
                    }
                    if(data.sendStatus == 1)
                    {
                        msg.sendingFlag = NO;
                        msg.sendFailureFlag = NO;
                    }else if (data.sendStatus ==2 ||data.sendStatus ==5)
                    {
                        msg.sendingFlag = NO;
                        msg.sendFailureFlag = YES;
                    }else
                    {
                        msg.sendingFlag = YES;
                    }
            }
                
                msg.text = [content removeHtml];
            }
            
            [self setAvatarWithDefaultSenderID:senderId];
            
            if (msg)
            {
                [fnMsgs addObject:msg];
            }
        }
    }
    
    return fnMsgs;
}
- (NSString *)getBytesFromDataLength:(NSInteger)dataLength {
    NSString *bytes;
    if (dataLength >= 0.1 * (1024 * 1024)) {
        bytes = [NSString stringWithFormat:@"%0.1fM",dataLength/1024/1024.0];
    } else if (dataLength >= 1024) {
        bytes = [NSString stringWithFormat:@"%0.0fK",dataLength/1024.0];
    } else {
        bytes = [NSString stringWithFormat:@"%zdB",dataLength];
    }
    return bytes;
}

- (FNMessage *)makePhotoMediaMessage:(UIImage *)image
                              sender:(NSString *)userid
                                name:(NSString *)username
                               msgId:(NSString *)msgId
                           imagePath:(NSString *)imgPath
{
    FNPhotoMediaItem *item = [[FNPhotoMediaItem alloc] initWithImage:image];
    item.imagePath = imgPath;
    
    FNMessage *message = [FNMessage messageWithSenderId:userid
                                            displayName:username
                                                  media:item
                                                  msgId:msgId];
    
    message.messageType = FNMessageTypePicture;
    
    return message;
}

- (FNMessage *)makeAudioMediaMessage:(NSURL *)fileURL
                            duration:(NSInteger)duration
                             bitrate:(NSString *)bitrate
                              sender:(NSString *)userid
                                name:(NSString *)username
                               msgID:(NSString *)msgId
{
    FNAudioMediaItem *item = [[FNAudioMediaItem alloc] initWithMaskAsOutgoing:YES];
    item.status = kAudioStatusReadyForPL;
    item.duration = duration;
    item.fileURL = fileURL;
    item.bitrate = bitrate;
    
    FNMessage *message = [FNMessage messageWithSenderId:userid
                                            displayName:username
                                                  media:item
                                                  msgId:msgId];
    
    message.messageType = FNMessageTypeAudio;
    
    return message;
}

- (FNMessage *)makeVideoMediaMessage:(NSURL *)fileURL
                            duration:(NSInteger)duration
                              sender:(NSString *)userid
                                name:(NSString *)username
                               msgID:(NSString *)msgId
{
    FNVideoMediaItem *item = [[FNVideoMediaItem alloc] initWithFileURL:fileURL isReadyToPlay:YES];
    
    FNMessage *message = [FNMessage messageWithSenderId:userid
                                            displayName:username
                                                  media:item
                                                  msgId:msgId];
    
    message.messageType = FNMessageTypeVideo;
    
    return message;
}

- (void)setAvatarWithDefaultSenderID:(NSString *)senderID
{
    NSString *avatar = @"avatar_in";
    
    if ([senderID isEqualToString:self.userID])
    {
        avatar = @"avatar_out";
    }
    
    [self setAvatar:avatar senderID:senderID];
}

- (void)setAvatar:(NSString *)avatar senderID:(NSString *)senderID
{
    UIImage *image = [FNImage imageWithName:avatar];
    FNMessagesAvatarImage *ava = [[FNMessagesAvatarImage alloc] initWithAvatarImage:image highlightedImage:image placeholderImage:image];
    
    [self.avatars setObject:ava forKey:senderID];
}

- (void)downloadWithMessage:(FNMsgTable *)message callback:(void (^) (FNMsgTable *table))callback
{
    
    FNMsgContent *msgContent = [FNMsgContent toObjectFromStr:message.content
                                                 withMsgType:message.msgType];
    if(message.flag == MsgReceiveFlag)
    {
        if ([message.msgType isEqualToString:FNMsgTypeAudio] )
        {
            [FNMsgLogic downloadSharedFile:msgContent.fileDownloadUrl
                                  fileSize:msgContent.fileSize
                                 fileWidth:msgContent.fileWidth
                                fileHeight:msgContent.fileHeight
                                    syncId:message.syncId
                                  fileType:message.msgType
                                  fileName:msgContent.fileName
                                    fileId:msgContent.fileId
                                  callback:^(FNFileDownloadResponse *rspArgs) {
                                      if (rspArgs.statusCode == 200)
                                      {
                                          // 下载成功才记录
                                          message.receiveStatus = MsgReceiveSuccess;
                                          message.savePath = rspArgs.fileInfo.filePath;
                                          message.thumbPath = rspArgs.fileInfo.filePath;
                                          
                                          [FNMsgTable updateReceiveRichMsgInfo:message];
                                          
                                          FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
                                          info.eventType = EventTypePrivate; // 注意
                                          info.msgType = message.msgType;  // 注意
                                          info.targetId = message.tid;
                                          info.senderNickname = message.senderNickname;
                                          info.content = message.content;
                                          [info setUnreadMsgCount];
                                          info.syncId = message.syncId;
                                          info.lastActiveDate = message.createDate;
                                          
                                          [FNRecentConversationTable insert:info];
                                          callback(message);
                                      }
                                  }];
        }
        
        else if ([message.msgType isEqualToString:FNMsgTypePic]|| [message.msgType isEqualToString:FNMsgTypeVideo])
        {
            NSString *thumbName = [NSString stringWithFormat:@"%@.JPG", [FNMsgBasicLogic generateUUID]];
            
            [FNMsgLogic downloadThumbnail:msgContent.fileDownloadUrl
                                 fileSize:msgContent.fileSize
                                fileWidth:msgContent.fileWidth
                               fileHeight:msgContent.fileHeight
                                   syncId:message.syncId
                                 fileName:thumbName
                                   fileId:msgContent.fileId
                                 callback:^(FNFileDownloadResponse *rspArgs) {
                                     if (rspArgs.statusCode == 200)
                                     {
                                         // 下载成功才记录
                                         message.receiveStatus = MsgReceiveSuccess;
                                         message.thumbPath = rspArgs.fileInfo.filePath;
                                         [FNMsgTable updateReceiveRichMsgInfo:message];
                                         
                                         FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
                                         info.eventType = EventTypePrivate; // 注意
                                         info.msgType = message.msgType;  // 注意
                                         info.targetId = message.tid;
                                         info.senderNickname = message.senderNickname;
                                         info.content = message.content;
                                         [info setUnreadMsgCount];
                                         info.syncId = message.syncId;
                                         info.lastActiveDate = message.createDate;
                                         [FNRecentConversationTable insert:info];
                                         
                                         callback(message);
                                     }
                                 }];
        }
    }
    
}

- (void)downloadGroupWithMessage:(FNGroupMsgTable *)message callback:(void (^) (FNGroupMsgTable *table))callback
{
    FNMsgContent *msgContent = [FNMsgContent toObjectFromStr:message.content
                                                 withMsgType:message.msgType];
    if(message.flag ==MsgReceiveFlag)
    {
        if ([message.msgType isEqualToString:FNMsgTypeAudio] || [message.msgType isEqualToString:FNMsgTypeVideo])
        {
            [FNGroupMsgLogic downloadSharedFile:msgContent.fileDownloadUrl
                                       fileSize:msgContent.fileSize
                                      fileWidth:msgContent.fileWidth
                                     fileHeight:msgContent.fileHeight
                                         syncId:message.syncId
                                       fileType:message.msgType
                                       fileName:msgContent.fileName
                                         fileId:msgContent.fileId
                                       callback:^(FNFileDownloadResponse *rspArgs) {
                                           if (rspArgs.statusCode == 200)
                                           {
                                               // 下载成功才记录
                                               message.receiveStatus = MsgReceiveSuccess;
                                               message.savePath = rspArgs.fileInfo.filePath;
                                               message.thumbPath = rspArgs.fileInfo.filePath;
                                               
                                               [FNGroupMsgTable updateReceiveRichMsgInfo:message];
                                               
                                               FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
                                               info.eventType = EventTypePrivate; // 注意
                                               info.msgType = message.msgType;  // 注意
                                               info.targetId = message.tid;
                                               info.senderNickname = message.senderNickname;
                                               info.content = message.content;
                                               [info setUnreadMsgCount];
                                               info.syncId = message.syncId;
                                               info.lastActiveDate = message.createDate;
                                               
                                               [FNRecentConversationTable insert:info];
                                               callback(message);
                                           }
                                       }];
        }
        else if ([message.msgType isEqualToString:FNMsgTypePic])
        {
            NSString *thumbName = [NSString stringWithFormat:@"%@.JPG", [FNMsgBasicLogic generateUUID]];
            
            [FNGroupMsgLogic downloadThumbnail:msgContent.fileDownloadUrl
                                      fileSize:msgContent.fileSize
                                     fileWidth:msgContent.fileWidth
                                    fileHeight:msgContent.fileHeight
                                        syncId:message.syncId
                                      fileName:thumbName
                                        fileId:msgContent.fileId
                                      callback:^(FNFileDownloadResponse *rspArgs) {
                                          if (rspArgs.statusCode == 200)
                                          {
                                              // 下载成功才记录
                                              message.receiveStatus = MsgReceiveSuccess;
                                              message.thumbPath = rspArgs.fileInfo.filePath;
                                              
                                              [FNGroupMsgTable updateReceiveRichMsgInfo:message];
                                              FNRecentConversationTable *info = [[FNRecentConversationTable alloc] init];
                                              info.eventType = EventTypePrivate; // 注意
                                              info.msgType = message.msgType;  // 注意
                                              info.targetId = message.tid;
                                              info.senderNickname = message.senderNickname;
                                              info.content = message.content;
                                              [info setUnreadMsgCount];
                                              info.syncId = message.syncId;
                                              info.lastActiveDate = message.createDate;
                                              [FNRecentConversationTable insert:info];
                                              
                                              callback(message);
                                          }
                                      }];
        }
    }
}

@end
