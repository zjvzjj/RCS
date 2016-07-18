#import "ConversationModelData.h"

#import "FNUserConfig.h"
#import "FNSystemConfig.h"
#import "FNServerConfig.h"

#import "FNMsgArgs.h"
#import "FNMsgTable.h"
#import "FNGroupMsgTable.h"
#import "FNMsgLogic.h"

#import "NSString+Extension.h"

#import "FNEnum.h"
#import "FNImage.h"

@interface ConversationModelData ()

@property (strong, nonatomic) NSString *userID;

@end

@implementation ConversationModelData {
    int32_t src;
}

- (instancetype)initWithSourceAndId:(NSString *)source targetId:(NSString *)target historyMsgsCount:(int)count firstLoad:(BOOL)firstLoad {
    self = [super init];
    if (self) { // Todo 数据操作在此完成
        self.userID = [FNUserConfig getInstance].userID;
        self.toUserId = target;
        self.displayName = [FNUserConfig getInstance].nickname;
        
        _avatars = [[NSMutableDictionary alloc] init];

        if (!self.displayName) { // 容错
            self.displayName = self.userID;
        }
        
        NSArray *dbMsgs = nil;
        if ([source isEqualToString:@"private"]) {
            if (firstLoad)
            {   //  从本地数据库获取未读消息
                dbMsgs = [FNMsgTable getUnreadMsgForTid:self.toUserId num:count];
            }
            //  从本地数据库获取历史消息
            dbMsgs = [FNMsgTable getHistoryMsgForTid:self.toUserId num:count];
            
            src = EventTypePrivate;
        } else if ([source isEqualToString:@"group"]) {
            if (firstLoad)
            {
                dbMsgs = [FNGroupMsgTable getUnreadMsgForGroupId:self.toUserId num:count];
            }
            dbMsgs = [FNGroupMsgTable getHistoryMsgForGroupId:self.toUserId num:count];
            
            src = EventTypePG;
        }
        
        if (count>[dbMsgs count] || ![dbMsgs count])
        {
            [self getHistoryWithSource:src lastRmsID: [(FNMsgTable *)[dbMsgs lastObject] msgId] count:count];
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
        FNMessagesBubbleImageFactory *bubbleFactory = [[FNMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImage];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImage];
        
    }
    
    return self;
}


// 获取对应类型的FNMessage消息
- (NSMutableArray *)makeTargetFNMsg:(NSArray *)messageData mediaData:(NSData *)mediaData {
    
    NSMutableArray *fnMsgs = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < messageData.count; i++) {
        // 抽出生成FNMessage的代码
        FNMessage *msg = nil;
        NSString *senderId = nil;
        NSString *senderNickname = nil;
        NSString *content = nil;
        NSString *type = nil;
        // 强制转换，统一处理
        if (src == EventTypePrivate)
        {
            FNMsgTable *data = (FNMsgTable *)[messageData objectAtIndex:i];
            if (MsgSendFlag == data.flag)
            {
                // 发送的消息标志
                senderId = self.userID;
            }
            else if (MsgReceiveFlag == data.flag)
            {// 接受消息
                if (src == EventTypePrivate) { //两人消息时
                    senderId = data.tid;
                }
//else if (src == EventTypePG) { //群消息或者讨论组消息
                //                    senderId = data.senderId;
//                    if (!senderId) {  // 当为群组消息时，source为发送者，但是安卓端source为null，为什么？
//                        senderId = data.tid;
//                    }
//                }
                
            }
            senderNickname = (data.senderNickname.length ? data.senderNickname : senderId);
            if (0 == senderNickname.length) {
                senderNickname = senderId;
            }
            content = data.content;
            type = data.msgType;
            
            if ([type isEqualToString:FNMsgTypePlain])
            {  // text
                msg = [[FNMessage alloc] initWithSenderId:senderId
                                         senderDisplayName:senderNickname
                                                      date:(data.createDate.length ? [FNSystemConfig stringToDate:data.createDate] : [FNSystemConfig getLocalDate])
                                                      text:content];
                
                
                
            }
            else
            {
                if (mediaData.length == 0) { // media
                    NSError *error;
                    if (data.thumbPath && [data.thumbPath length] > 0)
                    {
                        mediaData = [NSData dataWithContentsOfFile:data.thumbPath
                                                           options:NSDataReadingUncached
                                                             error:&error];
                        if (error)
                        {
                            NSLog(@"get thumbdata error: %@", error);
                        }
                    }
                    if (0 == mediaData.length) {
                        mediaData = [FNImage dataWithName:@"failure3"];
                    }
//                    if (data.savePath && [data.savePath length] > 0)
//                    {
//                        NSData *fileData = [NSData dataWithContentsOfFile:data.savePath
//                                                                  options:NSDataReadingUncached
//                                                                    error:&error];
//                        if (error)
//                        {
//                            NSLog(@"get fileData error: %@", error);
//                        }
//                    }
                }
                //
                if (mediaData.length) {
                    id<FNMessageMediaData> newMediaData = nil;
                    BOOL isOutgoing = NO;
                    if (1 == data.flag) {
                        isOutgoing = YES;
                    }
                    // 媒体文件分类
                    //                    if ([type isEqualToString:FNMsgTypePic] ||
                    //                        [type isEqualToString:FNMsgTypeAudio] ||
                    //                        [type isEqualToString:FNMsgTypeVedio]) {
                    if ([type isEqualToString:FNMsgTypePic])
                    {
                        
                        FNPhotoMediaItem *photoItemCopy = [[FNPhotoMediaItem alloc] initWithImage:[UIImage imageWithData:mediaData]];
                        photoItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = photoItemCopy;
                    }
                    else if ([type isEqualToString:FNMsgTypeFile])
                    {
                        FNLocationMediaItem *locationItemCopy = (FNLocationMediaItem *)mediaData;
                        locationItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = locationItemCopy;
                    }
                    else if ( [type isEqualToString:FNMsgTypeVedio]) {
                        mediaData = [NSData dataWithContentsOfFile:data.savePath
                                                           options:NSDataReadingUncached
                                                             error:nil];
                        FNVideoMediaItem *videoItemCopy = [[FNVideoMediaItem  alloc]initWithFileURL:[NSURL fileURLWithPath:data.savePath

                                                                                                     ] isReadyToPlay:isOutgoing];
                        videoItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = videoItemCopy;
                      
                    }
                    else if ([type isEqualToString:FNMsgTypeAudio]) {
                        mediaData = [NSData dataWithContentsOfFile:data.savePath
                                                           options:NSDataReadingUncached
                                                             error:nil];
                        FNAudioMediaItem *audioItemCopy = [[FNAudioMediaItem  alloc]initWithFileURL:[NSURL fileURLWithPath:data.savePath
                                                            ] isReadyToPlay:YES];
                        audioItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = audioItemCopy;

                    }
                    else if ([type isEqualToString:FNMsgTypeLocation]) {
                        FNLocationMediaItem *locationItemCopy = (FNLocationMediaItem *)mediaData;
                        locationItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = locationItemCopy;
                    } else {
                        NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
                    }
                    
                    msg = [[FNMessage alloc] initWithSenderId:senderId
                                            senderDisplayName:senderNickname
                                                         date:[FNSystemConfig stringToDate:data.createDate]
                                                        media:newMediaData];
                    
                    msg.text = [content removeHtml];
                } else { //容错
                    msg = [[FNMessage alloc] initWithSenderId:senderId
                                            senderDisplayName:senderNickname
                                                         date:[FNSystemConfig stringToDate:data.createDate]
                                                         text:[content removeHtml]];
                }
                mediaData = nil;
            }
            
            [self setAvatarWithDefaultSenderID:senderId];

            
            [fnMsgs addObject:msg];
        }
        else if (src == EventTypePG)
        {
            FNGroupMsgTable *data = (FNGroupMsgTable *)[messageData objectAtIndex:i];
            if (MsgSendFlag == data.flag) {
                senderId = self.userID;
            } else if (MsgReceiveFlag == data.flag) {
                if (src == EventTypePrivate) { //两人消息时
                    senderId = data.tid;
                } else if (src == EventTypePG) { //群消息或者讨论组消息
                    senderId = data.senderId;
                    if (!senderId) {  // 当为群组消息时，source为发送者，但是安卓端source为null，为什么？
                        senderId = data.tid;
                    }
                }
                
            }
            senderNickname = (data.senderNickname.length ? data.senderNickname : senderId);
            if (0 == senderNickname.length) {
                senderNickname = senderId;
            }
            content = data.content;
            type = data.msgType;
            
            if ([type isEqualToString:FNMsgTypePlain]) {  // text
                msg = [[FNMessage alloc] initWithSenderId:senderId
                                        senderDisplayName:senderNickname
                                                     date:(data.createDate.length ? [FNSystemConfig stringToDate:data.createDate] : [FNSystemConfig getLocalDate])
                                                     text:content];
            } else {
                if (mediaData.length == 0) { // media
                    NSError *error;
                    if (data.thumbPath && [data.thumbPath length] > 0)
                    {
                        mediaData = [NSData dataWithContentsOfFile:data.thumbPath
                                                           options:NSDataReadingUncached
                                                             error:&error];
                        if (error)
                        {
                            NSLog(@"get thumbdata error: %@", error);
                        }
                    }
                    if (0 == mediaData.length) {
                        mediaData = [FNImage dataWithName:@"failure3"];
                    }
                    //                    if (data.savePath && [data.savePath length] > 0)
                    //                    {
                    //                        NSData *fileData = [NSData dataWithContentsOfFile:data.savePath
                    //                                                                  options:NSDataReadingUncached
                    //                                                                    error:&error];
                    //                        if (error)
                    //                        {
                    //                            NSLog(@"get fileData error: %@", error);
                    //                        }
                    //                    }
                }
                
                if (mediaData.length) {
                    id<FNMessageMediaData> newMediaData = nil;
                    BOOL isOutgoing = NO;
                    if (1 == data.flag) {
                        isOutgoing = YES;
                    }
                    // 媒体文件分类
                    if ([type isEqualToString:FNMsgTypePic])
                        //                    if ([type isEqualToString:FNMsgTypePic] ||
                        //                        [type isEqualToString:FNMsgTypeAudio] ||
                        //                        [type isEqualToString:FNMsgTypeVedio])
                    {
                        FNPhotoMediaItem *photoItemCopy = [[FNPhotoMediaItem alloc] initWithImage:[UIImage imageWithData:mediaData]];
                        photoItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = photoItemCopy;
                    } else if ([type isEqualToString:FNMsgTypeFile]) {
                        FNLocationMediaItem *locationItemCopy = (FNLocationMediaItem *)mediaData;
                        locationItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = locationItemCopy;
                    }  // 音视频合并
                    else if ([type isEqualToString:FNMsgTypeVedio]) {
                        FNVideoMediaItem *videoItemCopy = [[FNVideoMediaItem  alloc]initWithFileURL:[NSURL fileURLWithPath:data.savePath
                                                                                                     ] isReadyToPlay:YES];
                        videoItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = videoItemCopy;
                        
                    }
                    else if ([type isEqualToString:FNMsgTypeAudio]) {
                        mediaData = [NSData dataWithContentsOfFile:data.savePath
                                                           options:NSDataReadingUncached
                                                             error:nil];
                        FNAudioMediaItem *audioItemCopy = [[FNAudioMediaItem  alloc]initWithFileURL:[NSURL fileURLWithPath:data.savePath
                                                                                                     ] isReadyToPlay:isOutgoing];
                        audioItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = audioItemCopy;

                    }
                    else if ([type isEqualToString:FNMsgTypeLocation]) {
                        FNLocationMediaItem *locationItemCopy = (FNLocationMediaItem *)mediaData;
                        locationItemCopy.appliesMediaViewMaskAsOutgoing = isOutgoing;
                        newMediaData = locationItemCopy;
                    } else {
                        NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
                    }
                    
                    msg = [[FNMessage alloc] initWithSenderId:senderId
                                            senderDisplayName:senderNickname
                                                         date:[FNSystemConfig stringToDate:data.createDate]
                                                        media:newMediaData];
                    
                    msg.text = [content removeHtml];
                } else { //容错
                    msg = [[FNMessage alloc] initWithSenderId:senderId
                                            senderDisplayName:senderNickname
                                                         date:[FNSystemConfig stringToDate:data.createDate]
                                                         text:[content removeHtml]];
                }
                mediaData = nil;
            }
            [self setAvatarWithDefaultSenderID:senderId];
            
            [fnMsgs addObject:msg];
        }
    }
    
    return fnMsgs;
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
    
    UIImage *result = [UIImage roundWithImage:image diameter:10];
    
    FNMessagesAvatarImage *ava = [[FNMessagesAvatarImage alloc] initWithAvatarImage:result highlightedImage:result placeholderImage:result];
    
    [self.avatars setObject:ava forKey:senderID];
}

- (void)addPhotoMediaMessage:(UIImage *)image
{
    FNPhotoMediaItem *photoItem = [[FNPhotoMediaItem alloc] initWithImage:image];
    FNMessage *photoMessage = [FNMessage messageWithSenderId:self.userID
                                                 displayName:self.displayName
                                                       media:photoItem];
    [self.messages addObject:photoMessage];
}



- (void)addFileMediaMessage
{
    
}
- (void)addAudioMediaMessage:(NSString  *)audio
{
    NSString *urlStr = [[NSString stringWithFormat: @"file://%@",audio] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *audioURL = [NSURL URLWithString:urlStr];
   
    FNAudioMediaItem *audioItem =[[FNAudioMediaItem alloc]initWithFileURL:audioURL isReadyToPlay:YES];
    
    FNMessage *audioMessage = [FNMessage messageWithSenderId:self.userID
                                                 displayName:self.displayName
                                                       media:audioItem];
    [self.messages addObject:audioMessage];
}

- (void)addVideoMediaMessage:(NSString *)stringURL
{
    NSString *urlStr = [[NSString stringWithFormat: @"file://%@",stringURL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *videoURL = [NSURL URLWithString:urlStr];
    // don't have a real video, just pretending
    // NSURL *videoURL = [NSURL URLWithString:[NSString stringWithFormat: @"file://%@",stringURL]];
    
    
    FNVideoMediaItem *videoItem = [[FNVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    FNMessage *videoMessage = [FNMessage messageWithSenderId:self.userID
                                                 displayName:self.displayName
                                                       media:videoItem];
    [self.messages addObject:videoMessage];
}

- (NSString *)createRandom32
{
    int32_t n1=arc4random();
    int32_t n2=arc4random();
    int32_t n3=arc4random();
    int32_t n4=arc4random();
    
    if (n1>>24<16) {
        n1+=0x10000000;
    }
    
    if (n2>>24<16) {
        n2+=0x10000000;
    }
    
    if (n3>>24<16) {
        n3+=0x10000000;
    }
    
    if (n4>>24<16) {
        n4+=0x10000000;
    }
    NSString *str = [NSString stringWithFormat:@"%8X%8X%8X%8X",n1,n2,n3,n4];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str;
}

#pragma mark - Get History

- (void)getHistoryWithSource:(EventType)source lastRmsID:(NSString *)lastRmsId count:(int)count;
{
    FNGetRoamingMsgRequest *req = [[FNGetRoamingMsgRequest alloc] init];
    
    req.pageSize = 10;
    
    req.peerId = [NSString stringWithFormat:@"%@@%@",self.toUserId,[FNServerConfig getInstance].appKey];
    
    req.lastRmsId = lastRmsId;
    
    req.msgType = (source == EventTypePrivate) ? 1 : 2;
    
    __weak __typeof(self) weakSelf = self;
    
    void (^getHistoryCallback)(NSArray *msgList) = ^(NSArray *msgList){
        
        __strong __typeof(weakSelf) strong = weakSelf;
        
        strong.messages = [strong makeTargetFNMsg:msgList mediaData:nil];
    };

    [FNMsgLogic getHistory:req callback:getHistoryCallback];
}


@end
