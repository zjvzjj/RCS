//
//  ConversationController.m
//  FetionCloudDemo
//
//  Created by Nemo on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "ConversationController.h"
#import "ContactDataTable.h"
#import "ContactDetailController.h"
#import "ConversationDataModel.h"

#import "FNMessageMediaData.h"
#import "FNMessagesViewController.h"

#import "NSUserDefaults+MessageSetting.h"
#import "NSDate+Extension.h"
#import "NSString+Extension.h"
#import "UIView+Toast.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

#import "FNMsgLogic.h"
#import "FNMsgTable.h"

#import "FNGroupMsgLogic.h"
#import "FNGroupMsgTable.h"

#import "FNGroupMsgNotify.h"
#import "FNMsgNotify.h"
#import "FNGroupLogic.h"

#import "FNUserTable.h"
#import "FNGroupTable.h"
#import "FNUserConfig.h"
#import "FNSystemConfig.h"
#import "GroupDetailController.h"
#import "AddContactController.h"

#import "FNMultiMsgsLogic.h"

#import "UIView+Toast.h"
#import "NSDate+Extension.h"
#import "NSString+Extension.h"
#import "FNSendMultiTextMsgRequest.h"
#import "FNMessagesViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "FNImage.h"
#import "BOPReachability+Extension.h"
#import "FNServerConfig.h"
#import "FNTranslation.h"
#import "CurrentUserTable.h"

#import "SNSVideoPlayer.h"
#import "VoiceConverter.h"
#import "Utility.h"
#import "ContactDataTable.h"
#import "FNNetworkHandle.h"
#import "ABViewController.h"
#import "GroupMemberController.h"
#import "FNGroupNotify.h"
#import "DeleteGroupMemController.h"
#import "FNRecentConversationTable.h"

#import "AppDelegate.h"
#import "MessageEntity.h"
#import "FNUserInfo.h"
#import "DBManager.h"


NSString *_groupID;

@interface ConversationController ()
<UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
AVAudioPlayerDelegate,
ConversationDataModelSource
>
{
    NSIndexPath *_menuIndexPath;
}

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) MPMoviePlayerController *movieControll;

@property (nonatomic, weak) UIView *movieShowView;

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) UIActivityIndicatorView *activity;

@property (nonatomic, strong) FNAudioMediaItem  *currentAudioItem;

@end

@implementation ConversationController {
    id sync;
    int32_t eventType;
}
@synthesize toDisplayName;
@synthesize toUserid;
@synthesize source;
@synthesize msgDataModel;

- (void)detailAction
{
    if ([self.source isEqualToString:@"private"])
    {
        if (![[ContactDataTable getWithUserId:toUserid] nickName])
        {
            AddContactController *destVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddContactController"];
            destVC.contactName = toDisplayName;
            destVC.contactId = toUserid;
            [self.navigationController pushViewController:destVC animated:YES];
        }
        else
        {
            [self performSegueWithIdentifier:@"contactDetail" sender:nil];
        }
    }
    else if ([self.source isEqualToString:@"group"])
    {
        [self performSegueWithIdentifier:@"groupDetail" sender:nil];
    }
}

- (void)goBack
{
    if (self.isCreated)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"contactDetail"])
    {
        ContactDetailController *contactDetailVC = segue.destinationViewController;
        contactDetailVC.userId = self.toUserid;
    }
    else if ([segue.identifier isEqualToString:@"groupDetail"])
    {
        GroupDetailController *groupDetailVC = segue.destinationViewController;
        groupDetailVC.groupId = self.toUserid;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _localNum = @"+8615901435217";
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUploadNotification:) name:@"uploadResult" object:nil];
    
    [self performSelector:@selector(scrollToBottomAnimated:) withObject:@(NO) afterDelay:0.0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notifyGroupListChanged:)
                                                 name:@"groupListChange"
                                               object:nil];
    
    // 初始化消息通知
//    SEL handler = @selector(recvMsgNTF:);
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    [nc addObserver:self selector:handler name:NOTIFY_HAS_NEW_MSG object:nil];
//    [nc addObserver:self selector:handler name:NOTIFY_HAS_NEW_GROUP_MSG object:nil];
    
    SEL handler = @selector(recemessage:);
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
   [nc addObserver:self selector:handler name:@"test" object:nil];
    [nc addObserver:self selector:handler name:NOTIFY_HAS_NEW_MSG object:nil];
    [nc addObserver:self selector:handler name:NOTIFY_HAS_NEW_GROUP_MSG object:nil];
    
    self.title = toDisplayName;
    //self.senderId = [FNUserConfig getInstance].userID;
    //self.senderDisplayName = [CurrentUserTable getWithUserId:self.senderId].nickName;
    //CurrentUserTable *cut = [CurrentUserTable getWithUserId:self.senderId];
    // NSLog(@"%@",[CurrentUserTable getWithUserId:self.senderId]);
    //NSLog(@"id======%@ name========%@",self.senderId,self.senderDisplayName);
    
    self.senderId = @"500015";
    self.senderDisplayName = @"Jack";
    
    UIImage *detaiItemImage = nil;
    if (!self.senderDisplayName)
    {
        self.senderDisplayName = [CurrentUserTable getWithUserId:self.senderId].account;
    }
    
    [FNNetworkHandle handelNetwork];
    self.showLoadEarlierMessagesHeader = YES;
    
    // 分类处理
    if ([source isEqualToString:@"private"]) {
        
        eventType = EventTypePrivate;
        detaiItemImage = [FNImage imageWithName:@"chat_detail_private_n"];
        
        
    } else if ([source isEqualToString:@"group"]) {
        eventType = EventTypePG;
        detaiItemImage = [FNImage imageWithName:@"chat_detail_group_n"];
        
        NSArray *array = [FNGroupTable get:self.toUserid];
        if (array.count == 0)
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithImage:detaiItemImage style:UIBarButtonItemStyleBordered target:self action:@selector(detailAction)];
    
    [self.navigationItem setRightBarButtonItem:detailItem];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(hideKeyboard)];
    
    tap.cancelsTouchesInView = NO;
    [self.collectionView addGestureRecognizer:tap];
    
    // 初始化若干历史消息
//    self.msgDataModel = [[ConversationDataModel alloc] initWithSourceAndId:source
//                                                                  targetId:[Utility userIdWithoutAppKey:toUserid]
//                                                          historyMsgsCount:10
//                                                                 firstLoad:YES];
    
  
    self.msgDataModel = [[ConversationDataModel alloc] initWithSourceAndId:source
                                                                  targetId:toUserid
                                                          historyMsgsCount:10
                                                                 firstLoad:YES];
    
    self.msgDataModel.dataSource = self;
    
    self.collectionView.delegate = self;
    
    FNPullMsgRequest *request = [[FNPullMsgRequest alloc] init];
    if (eventType == EventTypePrivate)
    {
        [FNMsgLogic getMsg:request callback:^(NSArray *msgList) {
            [self recvMsgNTF:nil];
        }];
    }else{
        [FNGroupMsgLogic getMsg:request callback:^(NSArray *msgList) {
            [self recvMsgNTF:nil];
        }];
    }
    
    _facilitiesView = [[ConversationFacilitiesView alloc] initWithFrame:CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height - 88.0f, [UIScreen mainScreen].bounds.size.width, 216.0f + 44.0f)];
    _facilitiesView.observer = self;
    [self.view addSubview:_facilitiesView];
    __weak __typeof(self) weakSelf = self;
    
    [_facilitiesView setText:^(NSString *text) {
        
        __strong __typeof(weakSelf) strong = weakSelf;
        
        if (![[text stringByReplacingOccurrencesOfString:@" " withString:@""] length])
        {
            [strong.view makeToast:@"请输入内容"];
            
            return ;
        }
        
        NSDate *date = [NSDate distantPast];
        [strong sendTextMessage:text withDate:date];
    }];
    
    [_facilitiesView setImage:^(UIImage *image) {
        
        __strong __typeof(weakSelf) strong = weakSelf;
        [strong sendImageWithImage:image];
    }];
    
    [_facilitiesView setLocation:^(CLLocation *location) {
        
        __strong __typeof(weakSelf) strong = weakSelf;
        
        //        [strong changeGroupOwner];
        
        //        [strong sendSimpleMsg:@"hello"];
        
        return ;
        
        FNLocationMediaItem *locationItem = [[FNLocationMediaItem alloc] init];
        
        [locationItem setLocation:location withCompletionHandler:^{
            
            
            
        }];
        
        FNMessage *locationMessage = [FNMessage messageWithSenderId:strong.senderId
                                                        displayName:strong.toDisplayName
                                                              media:locationItem
                                                              msgId:[FNMsgBasicLogic generateUUID]];
        
        [strong.msgDataModel setAvatarWithDefaultSenderID:locationMessage.senderId];
        
        [strong.msgDataModel.messages addObject:locationMessage];
        
        [strong.collectionView reloadData];
        
        [strong scrollToBottomAnimated:YES];
        
        [strong.collectionView reloadData];
    }];
    
    [_facilitiesView setVideo:^(NSURL *url,ALAsset *asset) {
        
        __strong __typeof(weakSelf) strong = weakSelf;
        [strong sendVideoWithURL:url andAsset:asset];
        
    }];
    
    [_facilitiesView setAudio:^(NSString *url) {
        
        __strong __typeof(weakSelf) strong = weakSelf;
        [strong sendAudioWithNSString:url];
    }];
    
    // Reframe collectionView to fit screen.
    UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 0.0f, 88.0f , 0.0f);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
    
    
}


- (void)recemessage:(NSNotification *)notify{
    
    
    FNMsgTable *messageData = notify.object;
    [self scrollToBottomAnimated:YES];

    if ([messageData.msgType isEqualToString:FNMsgTypePlain])
    {
        // 文本消息直接刷新UI
        FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject:messageData]mediaData:nil].lastObject;
        
        [FNSystemSoundPlayer fn_playMessageReceivedSound];
        [self.msgDataModel.messages addObject:fnMsg];
        [self finishReceivingMessage];
        
    }else{
    
        // 富文本信息 先下载 接收消息时，发送完图片之后接着发文字，文本先到，要排序
        NSData *data;
        if (messageData.receiveStatus != MsgReceiveSuccess) {
            data = [FNImage dataWithName:@"failure3"];
        }
        
        FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject: messageData]mediaData:data].lastObject;
        
        if (fnMsg != nil)
        {
            [self.msgDataModel.messages addObject:fnMsg];
            
            if (fnMsg.isMediaMessage) {
                id<FNMessageMediaData> mediaData = fnMsg.media;
                // 媒体文件分类
                if ([mediaData isKindOfClass:[FNPhotoMediaItem class]]) {
                    
                    FNPhotoMediaItem *photoItemCopy = (FNPhotoMediaItem *)mediaData;
                    photoItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                    
                    dispatch_async(dispatch_get_main_queue(),^{
                        
                        [self.collectionView reloadData];
                        
                    });
                    
                }else if ([mediaData isKindOfClass:[FNVideoMediaItem class]]) {
                    
                    FNVideoMediaItem *avItemCopy = (FNVideoMediaItem *)mediaData;
                    avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                    avItemCopy.isReadyToPlay = YES;
                    dispatch_async(dispatch_get_main_queue(),^{
                        
                        [self.collectionView reloadData];
                        
                    });
                    
                }else if ([mediaData isKindOfClass:[FNAudioMediaItem class]]) {
                    
                    FNAudioMediaItem *avItemCopy = (FNAudioMediaItem *)mediaData;
                    avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                    
                    dispatch_async(dispatch_get_main_queue(),^{
                        
                        [self.collectionView reloadData];
                        
                    });
                }
                else {
                    NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
                }
                
                // self.showTypingIndicator = !self.showTypingIndicator;
                [FNSystemSoundPlayer fn_playMessageReceivedSound];
                [self finishReceivingMessage];
            }
        }
    
    }

}


/*
 // 处理收听到的广播
 - (void)recvMsgNTF:(NSNotification *)notify
 {
 int32_t msgNum = (int32_t)((NSArray *)notify.object).count;
 NSArray *recvMsgs;
 NSArray *fnTables = notify.object;
 
 if ([source isEqualToString:@"private"])
 {
 NSInteger syncId = [[fnTables lastObject] syncId];
 recvMsgs = [FNMsgTable getUnreadMsgForTid:self.toUserid num:msgNum andSyncId:syncId];
 for (int i = 0; i < recvMsgs.count; i++)
 {
 FNMsgTable *messageData = (FNMsgTable *)recvMsgs[i];
 self.showTypingIndicator = !self.showTypingIndicator;
 [self scrollToBottomAnimated:YES];
 
 if ([messageData.msgType isEqualToString:FNMsgTypePlain])
 {
 // 文本消息直接刷新UI
 FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject:messageData] mediaData:nil].lastObject;
 
 [FNSystemSoundPlayer fn_playMessageReceivedSound];
 [self.msgDataModel.messages addObject:fnMsg];
 [self finishReceivingMessage];
 
 }
 else
 {
 // 富文本信息 先下载 接收消息时，发送完图片之后接着发文字，文本先到，要排序
 if ([messageData.contentType isEqualToString:FNMsgTypePic])
 {
 NSData *data;
 if (messageData.receiveStatus != MsgReceiveSuccess) {
 data = [FNImage dataWithName:@"failure3"];
 }
 
 FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject:messageData]
 mediaData:data].lastObject;
 if (fnMsg != nil)
 {
 [self.msgDataModel.messages addObject:fnMsg];
 
 if (fnMsg.isMediaMessage) {
 id<FNMessageMediaData> mediaData = fnMsg.media;
 // 媒体文件分类
 if ([mediaData isKindOfClass:[FNPhotoMediaItem class]]) {
 FNPhotoMediaItem *photoItemCopy = (FNPhotoMediaItem *)mediaData;
 photoItemCopy.appliesMediaViewMaskAsOutgoing = NO;
 [self.collectionView reloadData];
 
 }
 else
 {
 NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
 }
 
 self.showTypingIndicator = !self.showTypingIndicator;
 [FNSystemSoundPlayer fn_playMessageReceivedSound];
 [self finishReceivingMessage];
 }
 }
 }
 else
 {
 NSData *data;
 if (messageData.receiveStatus != MsgReceiveSuccess) {
 data = [FNImage dataWithName:@"failure3"];
 }
 
 FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject:messageData]
 mediaData:data].lastObject;
 if (fnMsg != nil)
 {
 [self.msgDataModel.messages addObject:fnMsg];
 
 if (fnMsg.isMediaMessage) {
 id<FNMessageMediaData> mediaData = fnMsg.media;
 if ([mediaData isKindOfClass:[FNVideoMediaItem class]]) {
 FNVideoMediaItem *avItemCopy = (FNVideoMediaItem *)mediaData;
 avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
 avItemCopy.isReadyToPlay = YES;
 [self.collectionView reloadData];
 }
 else if ([mediaData isKindOfClass:[FNAudioMediaItem class]]) {
 FNAudioMediaItem *avItemCopy = (FNAudioMediaItem *)mediaData;
 avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
 [self.collectionView reloadData];
 }
 else {
 NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
 }
 
 self.showTypingIndicator = !self.showTypingIndicator;
 [FNSystemSoundPlayer fn_playMessageReceivedSound];
 [self finishReceivingMessage];
 }
 }
 }
 }
 }
 } else if ([source isEqualToString:@"group"]) {
 
 NSInteger syncId=[[fnTables lastObject] syncId];
 recvMsgs=[FNGroupMsgTable getUnreadMsgForGroupId:toUserid num:msgNum andSyncId:syncId];
 for (int i = 0; i < recvMsgs.count; i++)
 {
 FNMsgTable *messageData = (FNMsgTable *)recvMsgs[i];
 self.showTypingIndicator = !self.showTypingIndicator;
 [self scrollToBottomAnimated:YES];
 
 if ([messageData.msgType isEqualToString:FNMsgTypePlain])
 {
 // 文本消息直接刷新UI
 FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject:messageData] mediaData:nil].lastObject;
 
 [FNSystemSoundPlayer fn_playMessageReceivedSound];
 [self.msgDataModel.messages addObject:fnMsg];
 [self finishReceivingMessage];
 }
 else
 {
 // 富文本信息 先下载 接收消息时，发送完图片之后接着发文字，文本先到，要排序
 if ([messageData.contentType isEqualToString:FNMsgTypePic])
 {
 NSData *data;
 if (messageData.receiveStatus != MsgReceiveSuccess) {
 data = [FNImage dataWithName:@"failure3"];
 }
 
 FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject:messageData]
 mediaData:data].lastObject;
 if (fnMsg != nil)
 {
 [self.msgDataModel.messages addObject:fnMsg];
 
 if (fnMsg.isMediaMessage) {
 id<FNMessageMediaData> mediaData = fnMsg.media;
 // 媒体文件分类
 if ([mediaData isKindOfClass:[FNPhotoMediaItem class]]) {
 FNPhotoMediaItem *photoItemCopy = (FNPhotoMediaItem *)mediaData;
 photoItemCopy.appliesMediaViewMaskAsOutgoing = NO;
 [self.collectionView reloadData];
 
 }
 else {
 NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
 }
 
 self.showTypingIndicator = !self.showTypingIndicator;
 [FNSystemSoundPlayer fn_playMessageReceivedSound];
 [self finishReceivingMessage];
 }
 }
 }
 else
 {
 NSData *data;
 if (messageData.receiveStatus != MsgReceiveSuccess) {
 data = [FNImage dataWithName:@"failure3"];
 }
 
 FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject:messageData]
 mediaData:data].lastObject;
 if (fnMsg != nil)
 {
 [self.msgDataModel.messages addObject:fnMsg];
 
 if (fnMsg.isMediaMessage) {
 id<FNMessageMediaData> mediaData = fnMsg.media;
 // 媒体文件分类
 if ([mediaData isKindOfClass:[FNVideoMediaItem class]]) {
 FNVideoMediaItem *avItemCopy = (FNVideoMediaItem *)mediaData;
 avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
 avItemCopy.isReadyToPlay = YES;
 [self.collectionView reloadData];
 }
 else if ([mediaData isKindOfClass:[FNAudioMediaItem class]]) {
 FNAudioMediaItem *avItemCopy = (FNAudioMediaItem *)mediaData;
 avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
 [self.collectionView reloadData];
 }
 else {
 NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
 }
 
 self.showTypingIndicator = !self.showTypingIndicator;
 [FNSystemSoundPlayer fn_playMessageReceivedSound];
 [self finishReceivingMessage];
 }
 }
 }
 }
 }
 }
 }
 */





// 处理收听到的广播
- (void)recvMsgNTF:(NSNotification *)notify
{
   int32_t msgNum = (int32_t)((NSArray *)notify.object).count;
    NSArray *recvMsgs;
    NSArray *fnTables = notify.object;
   
//    NSMutableArray *msgarray = [FNUserInfo ShareStaticConst].messageArray;
//    int32_t msgNum =(int32_t) msgarray.count;
    
    //NSArray *fnTables = [FNUserInfo ShareStaticConst].messageArray;
    
    if ([source isEqualToString:@"private"])
    {
        NSInteger syncId = [[fnTables lastObject] syncId];
        recvMsgs = [FNMsgTable getUnreadMsgForTid:toUserid num:msgNum andSyncId:syncId];
        
        
    } else if ([source isEqualToString:@"group"]) {
        
        NSInteger syncId=[[fnTables lastObject] syncId];
        recvMsgs=[FNGroupMsgTable getUnreadMsgForGroupId:toUserid num:msgNum andSyncId:syncId];
    }
    
    for (int i = 0; i < recvMsgs.count; i++)
    {
        FNMsgTable *messageData = (FNMsgTable *)recvMsgs[i];
        [self scrollToBottomAnimated:YES];
        
        if ([messageData.msgType isEqualToString:FNMsgTypePlain])
        {
            // 文本消息直接刷新UI
            FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject:messageData]
                                                        mediaData:nil].lastObject;
            
            [FNSystemSoundPlayer fn_playMessageReceivedSound];
            [self.msgDataModel.messages addObject:fnMsg];
            [self finishReceivingMessage];
            
        } else {
            // 富文本信息 先下载 接收消息时，发送完图片之后接着发文字，文本先到，要排序
            NSData *data;
            if (messageData.receiveStatus != MsgReceiveSuccess) {
                data = [FNImage dataWithName:@"failure3"];
            }
            
            FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject: messageData]
                                                        mediaData:data].lastObject;
            if (fnMsg != nil)
            {
                [self.msgDataModel.messages addObject:fnMsg];
                
                if (fnMsg.isMediaMessage) {
                    id<FNMessageMediaData> mediaData = fnMsg.media;
                    // 媒体文件分类
                    if ([mediaData isKindOfClass:[FNPhotoMediaItem class]]) {
                        FNPhotoMediaItem *photoItemCopy = (FNPhotoMediaItem *)mediaData;
                        photoItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                        
                        dispatch_async(dispatch_get_main_queue(),^{
                            
                           [self.collectionView reloadData];
                            
                        });
                        
                    }
                    else if ([mediaData isKindOfClass:[FNVideoMediaItem class]]) {
                        FNVideoMediaItem *avItemCopy = (FNVideoMediaItem *)mediaData;
                        avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                        avItemCopy.isReadyToPlay = YES;
                        [self.collectionView reloadData];
                    }
                    else if ([mediaData isKindOfClass:[FNAudioMediaItem class]]) {
                        FNAudioMediaItem *avItemCopy = (FNAudioMediaItem *)mediaData;
                        avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                        [self.collectionView reloadData];
                    }
                    else {
                        NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
                    }
                    
                    // self.showTypingIndicator = !self.showTypingIndicator;
                    [FNSystemSoundPlayer fn_playMessageReceivedSound];
                    [self finishReceivingMessage];
                }
            }
        }
    }
    [FNRecentConversationTable updateUnReadCount:self.toUserid];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_facilitiesView addObserverForKeyBoard];
    
    if (ABGroupAddMsg)
    {
        [self sendTextMessage:ABGroupAddMsg withDate:[NSDate date]];
        
        ABGroupAddMsg = nil;
    }
    else if (ContactAddGroupMsg)
    {
        [self sendTextMessage:ContactAddGroupMsg withDate:[NSDate date]];
        
        ContactAddGroupMsg = nil;
    }
    else if (DeleteGroupMsg)
    {
        [self sendTextMessage:DeleteGroupMsg withDate:[NSDate date]];
        
        DeleteGroupMsg = nil;
    }
    else if (DisGroupAddMsg)
    {
        [self sendTextMessage:DisGroupAddMsg withDate:[NSDate date]];
        
        DisGroupAddMsg = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.collectionView.collectionViewLayout.springinessEnabled = [NSUserDefaults springinessSetting];
}



- (void)notifyGroupListChanged:(NSNotification *)notify
{
    NSDictionary *dic = notify.object;
    if ([dic[@"type"] isEqualToString:@"kick"])
    {
        NSString *kick = [NSString stringWithFormat:@"您已被移出%@",dic[@"groupName"]];
        UIAlertView *isDelete = [[UIAlertView alloc] initWithTitle:@"信息提示" message:kick delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [isDelete show];
        
        if ([dic[@"groupId"] isEqualToString:[Utility userIdWithAppKey:toUserid]])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    else if ([dic[@"type"] isEqualToString:@"delete"])
    {
        NSString *delete = [NSString stringWithFormat:@"%@已解散",dic[@"groupName"]];
        UIAlertView *isDelete = [[UIAlertView alloc] initWithTitle:@"信息提示" message:delete delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [isDelete show];
        
        if ([dic[@"groupId"] isEqualToString:[Utility userIdWithAppKey:toUserid]])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#pragma mark - Testing

- (void)pushMainViewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:nc.topViewController animated:YES];
}

#pragma mark - conversationDataModelSource

- (void)conversationDataModel:(ConversationDataModel *)model groupMessage:(FNGroupMsgTable *)message
{
    [self.msgDataModel.messages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FNMsgTable *table = (FNMsgTable *)obj;
        
        if ([table.msgId isEqualToString:message.msgId])
        {
            [self.collectionView reloadData];
        }
    }];
}

- (void)conversationDataModel:(ConversationDataModel *)model message:(FNMsgTable *)message
{
    [self.msgDataModel.messages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FNMsgTable *table = (FNMsgTable *)obj;
        
        if ([table.msgId isEqualToString:message.msgId])
        {
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - FNMessages CollectionView DataSource

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_facilitiesView resign];
}

- (id<FNMessageData>)collectionView:(FNMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.msgDataModel.messages objectAtIndex:indexPath.item];
}

- (void)collectionView:(FNMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    [self.msgDataModel.messages removeObjectAtIndex:indexPath.item];
}

- (id<FNMessageBubbleImageDataSource>)collectionView:(FNMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FNMessage *message = [self.msgDataModel.messages objectAtIndex:indexPath.item];
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.msgDataModel.outgoingBubbleImageData;
    }
    return self.msgDataModel.incomingBubbleImageData;
}

- (id<FNMessageCancleImageDataSource>)collectionView:(FNMessagesCollectionView *)collectionView cancleImageForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (id<FNMessageAvatarImageDataSource>)collectionView:(FNMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FNMessage *message = [self.msgDataModel.messages objectAtIndex:indexPath.item];
    return [self.msgDataModel.avatars objectForKey:message.senderId];
}

- (NSAttributedString *)collectionView:(FNMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    FNMessage *preMessage = nil;
    NSString *preNeedDateString = nil;
    NSMutableAttributedString *strM = nil;
    if (indexPath.item != 0)
    {
        preMessage = [self.msgDataModel.messages objectAtIndex:indexPath.item -1];
        preNeedDateString = [self changeTimeFormat:preMessage.date];
    }
    FNMessage *message = [self.msgDataModel.messages objectAtIndex:indexPath.item];
    NSString *needDateString = [self changeTimeFormat:message.date];
    if([needDateString isEqualToString:preNeedDateString])
    {
        strM = [[NSMutableAttributedString alloc]initWithString:@""];
    }else{
        
        strM = [[NSMutableAttributedString alloc]initWithString:needDateString];
    }
    return strM;
}

// 时间格式的转换
- (NSString *)changeTimeFormat:(NSDate *)createDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    if ([NSDate isThisYearWithDate:createDate])
    {
        if ([NSDate isTodayWithDate:createDate]) {
            
            formatter.dateFormat = @"今天 HH:mm";
            return [formatter stringFromDate:createDate];
        }else{
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:createDate];
        }
    }else{
        
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [formatter stringFromDate:createDate];
    }
}


- (NSAttributedString *)collectionView:(FNMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    FNMessage *message = [self.msgDataModel.messages objectAtIndex:indexPath.item];
    
    if (eventType == EventTypePrivate || (eventType == EventTypePG && [message.senderId isEqualToString:self.senderId]))
    {
        return nil;
    }
    NSString *name = nil;
    
    NSString *sendId = message.senderId;
    ContactDataTable *contact = [ContactDataTable getWithUserId:[Utility userIdWithAppKey:sendId]];
    if (contact.nickName)
    {
        name = contact.nickName;
    }else
    {
        name = message.senderDisplayName;
    }
    
    
    return [[NSAttributedString alloc] initWithString:name];
}




#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.msgDataModel.messages count];
}

- (UICollectionViewCell *)collectionView:(FNMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FNMessagesCollectionViewCell *cell = (FNMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    for (UIView *subview in cell.messageBubbleContainerView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]] && subview.tag == 1807)
        {
            [subview removeFromSuperview];
        }
    }
    
    FNMessage *msg = [self.msgDataModel.messages objectAtIndex:indexPath.item];
    if ([msg.senderId isEqualToString:self.senderId])
    {
    
        if (![cell viewWithTag:444]) {
            UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            activity.tag = 444;
            activity.color = [UIColor blackColor];
            
            [cell.cancleImageView addSubview:activity];
        }
        UIActivityIndicatorView *activityView = [cell viewWithTag:444];
        if(msg.sendingFlag)
        {
            [activityView startAnimating];
            
        }else{
            [activityView stopAnimating];
            [activityView removeFromSuperview];
            if(msg.sendFailureFlag ==YES)
            {
                cell.cancleImageView.image = [UIImage imageNamed:@"send_failed"];
            }else
            {
                cell.cancleImageView.image = nil;
            }
        }
    }
//
//        if([msg.senderId isEqualToString:self.senderId]&& msg.messageType == FNMessageTypePicture)
//        {
//            UILabel *progressView = [cell viewWithTag:2999];
//            progressView.hidden = NO;
//            progressView.text = [NSString stringWithFormat:@"%.2f",msg.progress];
//            if([progressView.text isEqual:@"1.00"])
//            {
//                progressView.hidden = YES;
//                [progressView removeFromSuperview];
//            }
//    
//        }
    if( msg.messageType == FNMessageTypeVideo)
    {
        UILabel *fileSizeLabel = [cell viewWithTag:2000];
        fileSizeLabel.text = msg.fileSize;
        UILabel *timeLabel = [cell viewWithTag:2001];
        timeLabel.text = [NSString stringWithFormat:@"%zds",msg.timeLong];
        
    }
    
    return cell;
}
- (NSAttributedString *)collectionView:(FNMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

- (CGFloat)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0;
}

#pragma mark - FNMessages collection view flow layout delegate
#pragma mark - Adjusting cell label heights
- (CGFloat)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return kFNMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    FNMessage *message = [self.msgDataModel.messages objectAtIndex:indexPath.item];
    
    if (eventType == EventTypePrivate || (eventType == EventTypePG && [message.senderId isEqualToString:self.senderId]))
    {
        return 0;
    }
    
    return kFNMessagesCollectionViewCellLabelHeightDefault;
}


#pragma mark - UICollectionView Delegate
#pragma mark - Adjusting cell label heights

#pragma mark - Responding to collection view tap events

- (void)collectionView:(FNMessagesCollectionView *)collectionView
                header:(FNMessagesLoadEarlierHeaderView *)headerView
didTapLoadEarlierMessagesButton:(UIButton *)sender
{
    NSLog(@"Load earlier messages!");
    unsigned int historyMsgsCount = (unsigned int)self.msgDataModel.messages.count + 10; // 每次多拉取10条信息
    unsigned int recorder = (unsigned int)self.msgDataModel.messages.count;
    
    self.msgDataModel = [[ConversationDataModel alloc] initWithSourceAndId:source
                                                                  targetId:toUserid
                                                          historyMsgsCount:historyMsgsCount
                                                                 firstLoad:NO];
    if (self.msgDataModel.messages.count > recorder)
    {
        [self.collectionView reloadData];
    }
}


//点击聊天头像
- (void)collectionView:(FNMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped avatar!");
}


//点击聊天信息
- (void)collectionView:(FNMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    NSLog(@"Tapped message bubble!");
    FNMessage *msg = self.msgDataModel.messages[indexPath.item];
    
    if (msg.isMediaMessage)
    {
        if ([msg.media isMemberOfClass:[FNPhotoMediaItem class]])
        {
            FNPhotoMediaItem *item = (FNPhotoMediaItem *)(msg.media);
            if (item.image == nil)
            {
                return ;
            }
            [self showImgInBubble:((FNPhotoMediaItem *)(msg.media)).image];
        }
        else if([msg.media isMemberOfClass:[FNVideoMediaItem class]])
        {
            FNVideoMediaItem *item = (FNVideoMediaItem *)(msg.media);
            if (item.fileURL)
            {
                NSString *urlstring = item.fileURL.absoluteString;
                if (![urlstring hasPrefix:@"file:"]) {
                    urlstring=[NSString stringWithFormat:@"file://%@",urlstring];
                }
                
                NSURL *url = [NSURL URLWithString:urlstring];
                [self showVideoInBubble:url];
            }
            else
            {
                if ([source isEqualToString:@"private"])
                {
                    FNMsgTable *table = [[FNMsgTable getMsgByMsgId:msg.msgId] firstObject];
                    [FNMsgLogic downloadSharedFile:table.URL fileSize:table.fileSize fileWidth:table.fileWidth fileHeight:table.fileHeight syncId:table.syncId fileType:@"" fileName:table.fileName fileId:table.fileId callback:^(FNFileDownloadResponse *rspArgs) {
                        
                        item.fileURL = [NSURL fileURLWithPath:rspArgs.fileInfo.filePath];
                        if(item.fileURL )
                        {
                            [self showVideoInBubble:item.fileURL];
                        }
                    }];
                }
                else
                {
                    FNGroupMsgTable *table = [[FNGroupMsgTable getMsgByMsgId:msg.msgId] firstObject];
                    [FNGroupMsgLogic downloadSharedFile:table.URL fileSize:table.fileSize fileWidth:table.fileWidth fileHeight:table.fileHeight syncId:table.syncId fileType:@"" fileName:table.fileName fileId:table.fileId callback:^(FNFileDownloadResponse *rspArgs) {
                        
                        item.fileURL = [NSURL fileURLWithPath:rspArgs.fileInfo.filePath];
                        if(item.fileURL)
                        {
                            [self showVideoInBubble:item.fileURL];
                        }
                    }];
                }
            }
        }
        else if ([msg.media isMemberOfClass:[FNAudioMediaItem class]])
        {
            [self.currentAudioItem stopAnimation];
            self.currentAudioItem = nil;
            FNAudioMediaItem *item = (FNAudioMediaItem *)(msg.media);
            self.currentAudioItem = item;
            if (item.fileURL)
            {
                NSString *urlstring = ((FNAudioMediaItem *)(msg.media)).fileURL.absoluteString;
                
                if (![urlstring hasPrefix:@"file:"]) {
                    urlstring=[NSString stringWithFormat:@"file://%@",urlstring];
                }
                NSString *converString = urlstring;
                converString =[converString substringFromIndex:7];
                
                NSString *playPath=[[FNUserConfig getInstance].filePath stringByAppendingPathComponent:@"/playVoiceThumb.wav"];
                
                NSFileManager *manager=[NSFileManager defaultManager];
                [manager createFileAtPath:playPath contents:nil attributes:nil];
                
                [VoiceConverter ConvertAmrToWav:converString wavSavePath:playPath];
                NSString *playCurrent=[NSString stringWithFormat:@"file://%@",playPath];
                
                NSURL  *url=[NSURL URLWithString:playCurrent];
                [self.currentAudioItem startAnimation];
                [self playAudioInBuddle:url];
                
            }
            else
            {
                if ([source isEqualToString:@"private"])
                {
                    FNMsgTable *table = [[FNMsgTable getMsgByMsgId:msg.msgId] firstObject];
                    [FNMsgLogic downloadSharedFile:table.URL fileSize:table.fileSize fileWidth:table.fileWidth fileHeight:table.fileHeight syncId:table.syncId fileType:@"" fileName:table.fileName fileId:table.fileId callback:^(FNFileDownloadResponse *rspArgs) {
                        
                        item.fileURL = [NSURL fileURLWithPath:rspArgs.fileInfo.filePath];
                        [self playAudioInBuddle:item.fileURL];
                    }];
                }
                else
                {
                    FNGroupMsgTable *table = [[FNGroupMsgTable getMsgByMsgId:msg.msgId] firstObject];
                    [FNGroupMsgLogic downloadSharedFile:table.URL fileSize:table.fileSize fileWidth:table.fileWidth fileHeight:table.fileHeight syncId:table.syncId fileType:@"" fileName:table.fileName fileId:table.fileId callback:^(FNFileDownloadResponse *rspArgs) {
                        
                        item.fileURL = [NSURL fileURLWithPath:rspArgs.fileInfo.filePath];
                        [self playAudioInBuddle:item.fileURL];
                    }];
                }
            }
        }
    }
}

- (void)collectionView:(FNMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    NSLog(@"Tapped cell at %@!", NSStringFromCGPoint(touchLocation));
    [_facilitiesView resign];
}

- (void)hideKeyboard
{
    [_facilitiesView resign];
    // 语音播放的时候,点击屏幕停止播放
  //  [item stopAnimation];
    [self.currentAudioItem stopAnimation];
    self.currentAudioItem = nil;
    [self.player pause];
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}
// 播放音频
- (void)playAudioInBuddle:(NSURL *)url
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.player.delegate = self;
    [self.player prepareToPlay];
    [self.player play];
}
// 播放完毕
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.currentAudioItem stopAnimation];
    self.currentAudioItem = nil;
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}

// 退出当前页面
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideKeyboard];
    [_facilitiesView removeObserverForkeyBorad];
    [self.player pause];
    
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}
// 播放视频
- (void)showVideoInBubble:(NSURL *)url
{
    UIViewController *viewController = [[UIViewController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:viewController];
    MPMoviePlayerController *playViewController = [[MPMoviePlayerController alloc]initWithContentURL:url];
    self.movieControll = playViewController;
    UIView *playView = playViewController.view;
    playView.frame = [UIScreen mainScreen].bounds;
    playViewController.controlStyle = MPMovieControlStyleFullscreen;
    [viewController.view addSubview:playView];
    [self.movieControll play];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeBtn setFrame:CGRectMake(0, 0, 44, 44)];
    [viewController.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:closeBtn]];
    [closeBtn addTarget:self action:@selector(closeCurrentCon) forControlEvents:UIControlEventTouchUpInside];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)closeCurrentCon
{
    [self.movieControll stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)movieViewRemoveFromSuper:(UIGestureRecognizer*)recognizer
{
    [UIView animateWithDuration:1 animations:^{
        self.movieShowView.alpha=0.1;
    } completion:^(BOOL finished) {
        
        self.movieControll=nil;
        [self.movieShowView removeFromSuperview];
    }];
}

- (void)showImgInBubble:(UIImage *)img
{
    [self.view endEditing:YES];
    UIView *blackView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    blackView.backgroundColor=[UIColor blackColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = self.collectionView.frame;
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    imgView.userInteractionEnabled = YES;
    [blackView addSubview:imgView];
    [[UIApplication sharedApplication].keyWindow addSubview:blackView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgInBubble:)];
    singleTap.cancelsTouchesInView = NO;
    [blackView addGestureRecognizer:singleTap];
}

- (void)tapImgInBubble:(UITapGestureRecognizer *)tap
{
    [tap.view removeFromSuperview];
}

- (void) KeyboardFacilityChange:(CGFloat)yorigin curve:(UIViewAnimationOptions)ops duration:(double)duration
{
    float yOffset = self.view.bounds.size.height - yorigin;
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0.0f, yOffset , 0.0f);
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:ops
                     animations:^ {
                         
                         self.collectionView.contentInset = insets;
                         self.collectionView.scrollIndicatorInsets = insets;
                         [self.collectionView scrollRectToVisible:CGRectMake(0.0f, self.collectionView.contentSize.height - 1.0f, self.collectionView.contentSize.width, 1.0f) animated:NO];
                         
                     }
                     completion:nil];
}

// 发送文本消息
- (void)sendTextMessage:(NSString *)textString withDate:(NSDate *)date
{
    NSString *messageid = [FNMsgBasicLogic generateUUID];
    FNMessage *message = [FNMessage messageWithSenderId:self.senderId
                                            displayName:self.senderDisplayName
                                                   text:textString
                                                  msgId:messageid];
    
    message.sendingFlag = YES;
    [self.msgDataModel.messages addObject:message];
    [self sendMessage:message];
}

//压缩图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


// 接收到通知的类
-(void)getUploadNotification:(NSNotification *)noti
{
    NSDictionary *dict =noti.object;
    NSString *msgId = dict[@"msgId"];
    NSInteger finishiedBlock = [dict[@"finishedBlockCount"] integerValue];
    NSInteger totalBlockCount = [dict[@"totalBlockCount"] integerValue];
    CGFloat progress = finishiedBlock *1.00/totalBlockCount *1.00;
    NSLog(@"=========---%lf, %zd,%zd",progress,finishiedBlock,totalBlockCount);
    FNMessage *message = nil;
    for(FNMessage *mess in self.msgDataModel.messages)
    {
        if([mess.msgId isEqualToString:msgId])
        {
            message = mess;
        }
    }
    message.progress = progress;
    [self.collectionView reloadData];
    
}


// 发送图片
- (void)sendImageWithImage:(UIImage *)image
{
    //大小图路径未处理
    UIImage * image2 = [self scaleImage:image toScale:0.6];
    image = [self scaleImage:image toScale:0.05];
    NSString *msgId = [FNMsgBasicLogic generateUUID];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", msgId];
   // NSString *fileName2 = [NSString stringWithFormat:@"thumb-%@.jpg",msgId];
    
    NSLog(@"filepath=========%@",[FNUserConfig getInstance].filePath);
    NSLog(@"userID============%@",[FNUserConfig getInstance].userID);
    
    NSString *fullPath = [[[FNUserConfig getInstance].filePath stringByAppendingPathComponent:fileName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSString *thumbPath = [[[FNUserConfig getInstance].filePath stringByAppendingPathComponent:fileName2] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSData *imageData = UIImageJPEGRepresentation(image,1);
   // NSData *imageData2 = UIImageJPEGRepresentation(image2,1);
    [[NSFileManager defaultManager] createFileAtPath:fullPath contents:imageData attributes:nil];
    //[[NSFileManager defaultManager] createFileAtPath:thumbPath contents:imageData2 attributes:nil];
    
    
    
    FNMessage *message = [self.msgDataModel makePhotoMediaMessage:image2 sender:self.senderId name:self.senderDisplayName msgId:msgId imagePath:fullPath];
    message.messageType = FNMessageTypePicture;
    message.progress = 0 ;
    message.sendingFlag = YES;
    message.isOutgoing = YES;
    // 先展示
    [self.msgDataModel.messages addObject:message];
    
    if (!message.isReSent)
    {
        [self finishSendingMessage];
    }
    [self.msgDataModel setAvatarWithDefaultSenderID:self.senderId];
    
    if ([source isEqualToString:@"private"])
    {
        FNMsgContent *msgContent = [FNMsgContent msgContentWithType:ImageMsg];
        [msgContent setFilePath:fullPath];
        [msgContent setContent:@"[图片]"];
        [msgContent setContentType:FNMsgTypePic];
        [msgContent setFileName:fileName];
        [msgContent setFileThumbPath:fullPath];
        // [msgContent setFileDownloadUrl:serviceRsp.fileInfo.downloadURL];
        // [msgContent setFileSize:serviceRsp.fileInfo.fileSize];
        // [msgContent setFileId:serviceRsp.fileInfo.fileId];
        [msgContent setFileWidth:image.size.width];
        [msgContent setFileHeight:image.size.height];
        
        FNMsgEntity *msgEntity = [[FNMsgEntity alloc] init];
        msgEntity.event = eventType;
        msgEntity.msgAttribute = nil;
        msgEntity.senderId = self.senderId;
        msgEntity.senderNickname = self.senderDisplayName;
        msgEntity.sendPortraitUrl = @"lllllllllllllllllttt";
        msgEntity.peerID = toUserid;
        msgEntity.msgType = FNMsgTypePic;
        msgEntity.msgContent = [msgContent toJString];
        msgEntity.msgId = msgId;
        msgEntity.pushDesc = @"给你发了一张图片";
        
        
        __block FNSendRichTextMsgRequest *imageReq = [[FNSendRichTextMsgRequest alloc] init];
        imageReq.msgEntity = msgEntity;
        imageReq.msgContent = msgContent;
        
        [FNMsgLogic saveRichTextMessage:imageReq];
        
        
//        [FNMsgLogic uploadRichTextFilePath:fullPath msgId:msgEntity.msgId fileType:FNMsgTypePic tid:self.toUserid callBack:^(FNFileUploadResponse *serviceRsp){
//            
//            int32_t statusCode = serviceRsp.statusCode;
//            imageReq.msgContent.fileDownloadUrl = serviceRsp.fileInfo.downloadURL ;
//            imageReq.msgContent.fileId = serviceRsp.fileInfo.fileId;
//            imageReq.msgContent.fileSize = serviceRsp.fileInfo.fileSize;
//            
//            [FNMsgLogic updateLocalData:serviceRsp.fileInfo.downloadURL msgId:msgEntity.msgId fileId:serviceRsp.fileInfo.fileId fileName:serviceRsp.fileInfo.fileName fileSize:serviceRsp.fileInfo.fileSize fileWidth:serviceRsp.fileInfo.fileWidth fileHeight:serviceRsp.fileInfo.fileHeight sendStatus:statusCode] ;
//            
//            if(statusCode == 200)
//            {
//                void(^sendRichMsgCallback)(FNSendRichTextMsgResponse *rspArgs) = ^(FNSendRichTextMsgResponse *rspArgs) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (200 == rspArgs.msgRsp.statusCode) {
//                            NSLog(@"send rich msg success!");
//                             message.sendingFlag = NO;
//                            message.sendFailureFlag =  NO;
//                            [self.collectionView reloadData];
//
//                        } else {
//                            NSLog(@"发送失败");
//                             message.sendingFlag = NO;
//                            message.sendFailureFlag = YES;
//                            [self.collectionView reloadData];
//
//                        }
//                        [FNSystemSoundPlayer fn_playMessageSentSound];
//                        [self finishSendingMessage];
//                        
//                    });
//                };
//                [FNMsgLogic bopSendRichTextMsg:imageReq callback:sendRichMsgCallback];
//                
//            }
//            else
//            {
//                 message.sendingFlag = NO;
//                message.sendFailureFlag = YES;
//                NSLog(@"上传失败");
//                [self finishSendingMessage];
//                [self.collectionView reloadData];
//            }
//        }];
        
        
//----------------------------RCSSDK--------------------------------------------------
        
        
        [globalRcsApi msgsendfile:R number:toUserid messageId:msgEntity.msgId filePath:fullPath contentType:ContentTypePICTURE fileName:fileName needReport:YES start:0 thumbnail:fullPath isBurn:NO directedType:DirectedTypeNONE needReadReport:NO callback:^(rcs_state* R, MessageResult *s) {
            if (s) {
                if (s->error_code == 200) {
                    
                    NSLog(@"seng picture ok");
                    message.sendingFlag = NO;
                    message.sendFailureFlag =  NO;
                    
                    dispatch_async(dispatch_get_main_queue(),^{
                        
                        [self.collectionView reloadData];
                        
                    });
                }
                else
                {
                    NSLog(@"send picture failed");
                    
                }
            }
        }];
 

        
//------------------------------------end---------------------------------------------------
        
        
    }else if ([source isEqualToString:@"group"])
    {
        FNMsgContent *msgContent = [FNMsgContent msgContentWithType:ImageMsg];
        [msgContent setFilePath:fullPath];
        [msgContent setContent:@"[图片]"];
        [msgContent setContentType:FNMsgTypePic];
        [msgContent setFileName:fileName];
        [msgContent setFileThumbPath:fullPath];
        // [msgContent setFileDownloadUrl:serviceRsp.fileInfo.downloadURL];
        // [msgContent setFileSize:serviceRsp.fileInfo.fileSize];
        // [msgContent setFileId:serviceRsp.fileInfo.fileId];
        [msgContent setFileWidth:image.size.width];
        [msgContent setFileHeight:image.size.height];
        
        FNMsgEntity *msgEntity = [[FNMsgEntity alloc] init];
        msgEntity.event = eventType;
        msgEntity.msgAttribute = nil;
        msgEntity.senderId = self.senderId;
        msgEntity.senderNickname = self.senderDisplayName;
        msgEntity.sendPortraitUrl = @"lllllllllllllllllttt";
        msgEntity.peerID = toUserid;
        msgEntity.msgType = FNMsgTypePic;
        msgEntity.msgContent = [msgContent toJString];
        msgEntity.msgId = [FNMsgBasicLogic generateUUID];
        msgEntity.pushDesc = @"给你发了一张图片";
        
        __block FNSendRichTextMsgRequest *imageReq = [[FNSendRichTextMsgRequest alloc] init];
        imageReq.msgEntity = msgEntity;
        imageReq.msgContent = msgContent;
        
        
        [FNGroupMsgLogic saveRichTextMessage:imageReq];
        
        [FNGroupMsgLogic uploadRichTextFilePath:fullPath msgId:msgEntity.msgId fileType:FNMsgTypePic tid:self.toUserid callBack:^(FNFileUploadResponse *serviceRsp){
            
            int32_t statusCode = serviceRsp.statusCode;
            imageReq.msgContent.fileDownloadUrl = serviceRsp.fileInfo.downloadURL ;
            imageReq.msgContent.fileId = serviceRsp.fileInfo.fileId;
            imageReq.msgContent.fileSize = serviceRsp.fileInfo.fileSize;
            [FNGroupMsgLogic updateLocalData:serviceRsp.fileInfo.downloadURL msgId:msgEntity.msgId fileId:serviceRsp.fileInfo.fileId fileName:serviceRsp.fileInfo.fileName fileSize:serviceRsp.fileInfo.fileSize fileWidth:serviceRsp.fileInfo.fileWidth fileHeight:serviceRsp.fileInfo.fileHeight sendStatus:statusCode];
            
            if(statusCode == 200)
            {
                void(^sendRichMsgCallback)(FNSendRichTextMsgResponse *rspArgs) = ^(FNSendRichTextMsgResponse *rspArgs) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (200 == rspArgs.msgRsp.statusCode) {
                            NSLog(@"send rich msg success!");
                            message.sendingFlag = NO;
                            message.sendFailureFlag =  NO;
                            [self.collectionView reloadData];
                            
                        } else {
                            NSLog(@"发送失败");
                             message.sendingFlag = NO;
                            message.sendFailureFlag = YES;
                            [self.collectionView reloadData];
                        }
                       
                        [FNSystemSoundPlayer fn_playMessageSentSound];
                        [self finishSendingMessage];
                        
                    });
                };
                
                [FNGroupMsgLogic bopSendRichTextMsg:imageReq callback:sendRichMsgCallback];
            }else{
                NSLog(@"上传图片失败");
               message.sendingFlag = NO;
                message.sendFailureFlag = YES;
                
                [self finishSendingMessage];
                [self.collectionView reloadData];
            }
            
        }];
    }
}


// 发送视频
- (void)sendVideoWithURL:(NSURL *)url andAsset:(ALAsset *)asset
{
    NSString *msgId = [FNMsgBasicLogic generateUUID];
    NSString *fileName = [NSString stringWithFormat:@"%@.mp4", msgId];
    NSString *fullPath = [[[FNUserConfig getInstance].filePath stringByAppendingPathComponent:fileName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data =nil;
    
    if(url!=nil)
    {
        data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:fullPath atomically:YES];
    }
    
    if(asset !=nil)
    {
        
        NSURL *mediaURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        if (mediaURL)
        {
            //从路径中最后一个组成部分中提取扩展名
            NSString *extension = [mediaURL pathExtension];
            
            fileName = [NSString stringWithFormat:@"%@.%@", [[[[[mediaURL query] componentsSeparatedByString:@"&"] firstObject] componentsSeparatedByString:@"="] lastObject], extension];
        }
        
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        Byte *buffer = (Byte*)malloc(rep.size);
        
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
        
        //这个方法生成的data中保存的是指向数据的指针，并没有对数据进行复制操作。当flag为yes的时候，生成的data对象是bytes的所有者，当data对象被释放的时候也会同时释放bytes，所以bytes必须是通过malloc在堆上分配的内存。当flag为no的时候，bytes不会被自动释放，释放bytes时要注意时机，不要再data对象还被使用的时候释放bytes。
        data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
        
        [data writeToFile:fullPath atomically:YES];
    }

    
    //获取视频文件大小
    NSString *size = [self getBytesFromDataLength:data.length];
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:url];
    CMTime time = [avUrl duration];
    int seconds = ceil(time.value/time.timescale);//视频文件时长
    
    FNMessage *message = [self.msgDataModel makeVideoMediaMessage:[NSURL fileURLWithPath:fullPath] duration:seconds sender:self.senderId name:self.senderDisplayName msgID:msgId];
    message.sendingFlag = YES;
    message.timeLong = seconds;
    message.fileSize = size;
    [self.msgDataModel.messages addObject:message];
    message.isOutgoing = YES;
    
    if (!message.isReSent)
    {
        [self finishSendingMessage];
    }
    [self.msgDataModel setAvatarWithDefaultSenderID:self.senderId];
    
    if ([source isEqualToString:@"private"])
    {
        FNMsgContent *msgContent = [FNMsgContent msgContentWithType:VideoMsg];
        
        [msgContent setFilePath:fullPath];
        [msgContent setContent:@"[视频]"];
        [msgContent setContentType:FNMsgTypeVideo];
        [msgContent setFileName:fileName];
        [msgContent setFileThumbPath:@""];
        [msgContent setDuration:seconds];
        
        FNMsgEntity *msgEntity = [[FNMsgEntity alloc] init];
        msgEntity.event = eventType;
        msgEntity.msgAttribute = nil;
        msgEntity.senderId = self.senderId;
        msgEntity.senderNickname = self.senderDisplayName;
        msgEntity.peerID = toUserid;
        msgEntity.msgType = FNMsgTypeVideo;
        msgEntity.msgContent = [msgContent toJString];
        msgEntity.msgId = msgId;
        msgEntity.sendPortraitUrl = @"llllllllllllllllllllll";
        msgEntity.pushDesc = @"给你发了一段视频";
        
  //------------------------------------RCSSDK-----------------------------------------
        
        //获取视频截图，作为小图传送路径
        AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:fullPath] options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc]initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:CMTimeMakeWithSeconds(1, 60) actualTime:&actualTime error:&error];
        UIImage *thumbImage = [[UIImage alloc]initWithCGImage:image];
        
        UIImage * image2 = [self scaleImage:thumbImage toScale:0.2];
        
        NSData *imageData1 = UIImageJPEGRepresentation(image2,1);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:@"audio.png"];
        
        [imageData1 writeToFile:savedImagePath atomically:YES];
        
        
        //发送视频
        [globalRcsApi msgsendfile:R number:toUserid messageId:msgId filePath:fullPath contentType:ContentTypeVIDEO fileName:fileName needReport:YES start:0 thumbnail:savedImagePath isBurn:NO directedType:DirectedTypeNONE needReadReport:NO callback:^(rcs_state* R, MessageResult *s) {
            if (s) {
                if (s->error_code == 200) {
                    
                    NSLog(@"send file ok");
                    message.sendingFlag = NO;
                    message.sendFailureFlag =  NO;
                    [self finishSendingMessage];
                    
                    dispatch_async(dispatch_get_main_queue(),^{
                        
                        [self.collectionView reloadData];
                        
                    });
                }
                else
                {
                    NSLog(@"send file failed");
                    message.sendingFlag = NO;
                    message.sendFailureFlag = YES;
                    [self finishSendingMessage];
                    [self.collectionView reloadData];
                }
            }
        }];
        
 //-----------------------------------end------------------------------------------------
        
//        __block FNSendRichTextMsgRequest *imageReq = [[FNSendRichTextMsgRequest alloc] init];
//        imageReq.msgEntity = msgEntity;
//        imageReq.msgContent = msgContent;
//        
//        [FNMsgLogic saveRichTextMessage:imageReq];
//        [FNMsgLogic uploadRichTextFilePath:fullPath msgId:msgEntity.msgId fileType:FNMsgTypePic tid:self.toUserid callBack:^(FNFileUploadResponse *serviceRsp){
//            int32_t statusCode = serviceRsp.statusCode;
//            imageReq.msgContent.fileDownloadUrl = serviceRsp.fileInfo.downloadURL ;
//            imageReq.msgContent.fileId = serviceRsp.fileInfo.fileId;
//            imageReq.msgContent.fileSize = serviceRsp.fileInfo.fileSize;
//            imageReq.msgContent.fileWidth = serviceRsp.fileInfo.fileWidth;
//            imageReq.msgContent.fileHeight = serviceRsp.fileInfo.fileHeight;
//            [FNMsgLogic updateLocalData:serviceRsp.fileInfo.downloadURL msgId:msgEntity.msgId fileId:serviceRsp.fileInfo.fileId fileName:serviceRsp.fileInfo.fileName fileSize:serviceRsp.fileInfo.fileSize fileWidth:serviceRsp.fileInfo.fileWidth fileHeight:serviceRsp.fileInfo.fileHeight sendStatus:statusCode];
//            if(statusCode ==200)
//            {
//                void(^sendRichMsgCallback)(FNSendRichTextMsgResponse *rspArgs) = ^(FNSendRichTextMsgResponse *rspArgs) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (200 == rspArgs.msgRsp.statusCode) {
//                            NSLog(@"send rich msg success!");
//                             message.sendingFlag = NO;
//                            message.sendFailureFlag =  NO;
//                             [self finishSendingMessage];
//                            [self.collectionView reloadData];
//
//                        } else {
//                            NSLog(@"发送失败");
//                             message.sendingFlag = NO;
//                            message.sendFailureFlag = YES;
//                             [self finishSendingMessage];
//                            [self.collectionView reloadData];
//
//                        }
//                        
//                        [FNSystemSoundPlayer fn_playMessageSentSound];
//                        
//                        [self finishSendingMessage];
//                    });
//                };
//                [FNMsgLogic bopSendRichTextMsg:imageReq callback:sendRichMsgCallback];}
//            else
//            {
//                NSLog(@"上传视频失败");
//                 message.sendingFlag = NO;
//                message.sendingFlag = YES;
//                [self finishSendingMessage];
//                [self.collectionView reloadData];
//            }
//        }];
        
    }
    else if ([source isEqualToString:@"group"]){
        FNMsgContent *msgContent = [FNMsgContent msgContentWithType:VideoMsg];
        [msgContent setFilePath:fullPath];
        [msgContent setContent:@"[视频]"];
        [msgContent setContentType:FNMsgTypeVideo];
        [msgContent setFileName:fileName];
        [msgContent setFileThumbPath:@""];
        //[msgContent setFileDownloadUrl:serviceRsp.fileInfo.downloadURL];
        //[msgContent setFileSize:serviceRsp.fileInfo.fileSize];
        //[msgContent setFileId:serviceRsp.fileInfo.fileId];
        //[msgContent setFileWidth:serviceRsp.fileInfo.fileWidth];
        //  [msgContent setFileHeight:serviceRsp.fileInfo.fileHeight];
        [msgContent setDuration:seconds];
        
        FNMsgEntity *msgEntity = [[FNMsgEntity alloc] init];
        msgEntity.event = eventType;
        msgEntity.msgAttribute = nil;
        msgEntity.senderId = self.senderId;
        msgEntity.senderNickname = self.senderDisplayName;
        msgEntity.peerID = toUserid;
        msgEntity.msgType = FNMsgTypeVideo;
        msgEntity.msgContent = [msgContent toJString];
        msgEntity.msgId = msgId;
        msgEntity.sendPortraitUrl = @"llllllllllllllllllllll";
        msgEntity.pushDesc = @"给你发了一段视频";
        
        __block FNSendRichTextMsgRequest *imageReq = [[FNSendRichTextMsgRequest alloc] init];
        imageReq.msgEntity = msgEntity;
        imageReq.msgContent = msgContent;
        
        //        [FNGroupMsgLogic sendRichTextMsg:imageReq callback:^(FNSendRichTextMsgResponse *rspArgs) {
        //            NSLog(@"send rich msg %d",rspArgs.msgRsp.statusCode);
        //            [FNSystemSoundPlayer fn_playMessageSentSound];
        //            [self finishSendingMessage];
        //        }];
        [FNGroupMsgLogic saveRichTextMessage:imageReq];
        
        [FNGroupMsgLogic uploadRichTextFilePath:fullPath msgId:msgEntity.msgId fileType:FNMsgTypePic tid:self.toUserid callBack:^(FNFileUploadResponse *serviceRsp){
            int32_t statusCode = serviceRsp.statusCode;
            imageReq.msgContent.fileDownloadUrl = serviceRsp.fileInfo.downloadURL ;
            imageReq.msgContent.fileId = serviceRsp.fileInfo.fileId;
            imageReq.msgContent.fileSize = serviceRsp.fileInfo.fileSize;
            imageReq.msgContent.fileWidth = serviceRsp.fileInfo.fileWidth;
            imageReq.msgContent.fileHeight = serviceRsp.fileInfo.fileHeight;
            [FNGroupMsgLogic updateLocalData:serviceRsp.fileInfo.downloadURL msgId:msgEntity.msgId fileId:serviceRsp.fileInfo.fileId fileName:serviceRsp.fileInfo.fileName fileSize:serviceRsp.fileInfo.fileSize fileWidth:serviceRsp.fileInfo.fileWidth fileHeight:serviceRsp.fileInfo.fileHeight sendStatus:statusCode];
            
            if(statusCode ==200)
            {
                
                void(^sendRichMsgCallback)(FNSendRichTextMsgResponse *rspArgs) = ^(FNSendRichTextMsgResponse *rspArgs) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (200 == rspArgs.msgRsp.statusCode) {
                            NSLog(@"send rich msg success!");
                             message.sendingFlag = NO;
                            message.sendFailureFlag =  NO;
                             [self finishSendingMessage];
                            [self.collectionView reloadData];

                        } else {
                            NSLog(@"发送失败");
                             message.sendingFlag = NO;
                            message.sendFailureFlag = YES;
                             [self finishSendingMessage];
                            [self.collectionView reloadData];

                        }
                        
                        [FNSystemSoundPlayer fn_playMessageSentSound];
                        [self finishSendingMessage];
                    });
                };
                
                [FNGroupMsgLogic bopSendRichTextMsg:imageReq callback:sendRichMsgCallback];
            }else
            {
                NSLog(@"上传视频失败");
                 message.sendingFlag = NO;
                message.sendFailureFlag = YES;
                [self finishSendingMessage];
                [self.collectionView reloadData];
                
            }
        }];
        
    }
}


//获取视频文件大小
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

// 发送音频
- (void)sendAudioWithNSString:(NSString *)filePath
{
    NSString *msgId = [FNMsgBasicLogic generateUUID];
    NSString *fileName = [NSString stringWithFormat:@"%@.amr",msgId];
    NSString *fullPath = [[[FNUserConfig getInstance].filePath stringByAppendingPathComponent:fileName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSFileManager *manage = [NSFileManager defaultManager];
    [manage createFileAtPath:fullPath contents:nil attributes:nil];
    
    NSString *needPath = [filePath substringFromIndex:7];
    [VoiceConverter ConvertWavToAmr:needPath amrSavePath:fullPath];
    NSURL *url = [NSURL fileURLWithPath:needPath];
    AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    CMTime time = audioAsset.duration;
    NSTimeInterval seconds = CMTimeGetSeconds(time);
    
    NSURL *voice = [NSURL URLWithString:fullPath];
    FNMessage *message = [self.msgDataModel makeAudioMediaMessage:voice duration:seconds bitrate:@"7400" sender:self.senderId name:self.senderDisplayName msgID:msgId];
    [self.msgDataModel.messages addObject:message];
    message.sendingFlag = YES;
    message.isOutgoing = YES;
    [self finishSendingMessage];
    
    if (!message.isReSent)
    {
        [self finishSendingMessage];
    }
    [self.msgDataModel setAvatarWithDefaultSenderID:self.senderId];
    
    FNAudioMediaItem *item = (FNAudioMediaItem *)message.media;
    if ([source isEqualToString:@"private"])
    {
        FNMsgContent *msgContent = [FNMsgContent msgContentWithType:AudioMsg];
        [msgContent setFilePath:item.fileURL.path];
        [msgContent setContent:@"[音频]"];
        [msgContent setContentType:FNMsgTypeAudio];
        [msgContent setFileName:item.fileURL.path.lastPathComponent];
        [msgContent setDuration:item.duration];
        [msgContent setBitrate:[item.bitrate integerValue]];
        
        FNMsgEntity *msgEntity = [[FNMsgEntity alloc] init];
        msgEntity.event = eventType;
        msgEntity.msgAttribute = nil;
        msgEntity.peerID = toUserid;
        msgEntity.senderId = self.senderId;
        msgEntity.senderNickname = self.senderDisplayName;
        msgEntity.msgType = FNMsgTypeAudio;
        msgEntity.msgContent = [msgContent toJString];
        msgEntity.msgId = message.msgId;
        msgEntity.senderNickname = self.senderDisplayName;
        msgEntity.sendPortraitUrl = @"hahahhhhhhhhtest";
        msgEntity.pushDesc = @"发了一段音频";
        msgEntity.receiveNickname = self.toDisplayName;
        
        FNSendRichTextMsgRequest *imageReq = [[FNSendRichTextMsgRequest alloc] init];
        imageReq.msgEntity = msgEntity;
        imageReq.msgContent = msgContent;
        
        
        [FNMsgLogic saveRichTextMessage:imageReq];
        
//----------------------------RCSSDK--------------------------------------------------
        
        
//        AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:needPath] options:nil];
//        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc]initWithAsset:asset];
//        gen.appliesPreferredTrackTransform = YES;
//        NSError *error = nil;
//        CMTime actualTime;
//        CGImageRef image = [gen copyCGImageAtTime:CMTimeMakeWithSeconds(1, 60) actualTime:&actualTime error:&error];
//        UIImage *thumbImage = [[UIImage alloc]initWithCGImage:image];
//        
//        UIImage * image2 = [self scaleImage:thumbImage toScale:0.2];
//        
//        NSData *imageData1 = UIImageJPEGRepresentation(image2,1);
//        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        
//        NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:@"video.png"];
//        
//        [imageData1 writeToFile:savedImagePath atomically:YES];
        
        //获取时间戳作为imdnId
        //        UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
        //        NSString * msgId = [NSString stringWithFormat:@"%lld", recordTime];
        //        NSLog(@"----------%llu,-----------%@",recordTime,msgId);
        
        NSString * thumbnailPath = [[NSBundle mainBundle]pathForResource:@"yinpin" ofType:@"png"];
        [globalRcsApi msgsendfile:R number:toUserid messageId:msgEntity.msgId filePath:item.fileURL.path contentType:ContentTypeAUDIO fileName:item.fileURL.path.lastPathComponent needReport:YES start:0 thumbnail:thumbnailPath isBurn:NO directedType:DirectedTypeNONE needReadReport:NO callback:^(rcs_state* R, MessageResult *s) {
            if (s) {
                if (s->error_code == 200) {
                    
                    NSLog(@"send audio ok");
                    message.sendingFlag = NO;
                    message.sendFailureFlag =  NO;
//                    [self finishSendingMessage];
                    
                    [FNMsgTable updateSendMsgStatus:msgEntity.msgId syncId:0 sendStatus:MsgSendSuccess sendTime:[FNSystemConfig dateToString:[FNSystemConfig getLocalDate]]];
                    
                    dispatch_async(dispatch_get_main_queue(),^{
                        
                        [self.collectionView reloadData];
                        
                    });
                    
                }
                else
                {
                    NSLog(@"send audio failed");
                    message.sendingFlag = NO;
                    message.sendFailureFlag = YES;
                    [self finishSendingMessage];
                    [self.collectionView reloadData];
                    
                }
            }
        }];
        
        
        
//------------------------------------end---------------------------------------------------
        
//        FNSendRichTextMsgRequest *imageReq = [[FNSendRichTextMsgRequest alloc] init];
//        imageReq.msgEntity = msgEntity;
//        imageReq.msgContent = msgContent;
//        
//        
//        [FNMsgLogic saveRichTextMessage:imageReq];
//        
//        [FNMsgLogic uploadRichTextFilePath:fullPath msgId:msgEntity.msgId fileType:FNMsgTypePic tid:self.toUserid callBack:^(FNFileUploadResponse *serviceRsp){
//            int32_t statusCode = serviceRsp.statusCode;
//            if(statusCode ==200)
//            {
//                imageReq.msgContent.fileDownloadUrl = serviceRsp.fileInfo.downloadURL ;
//                imageReq.msgContent.fileId = serviceRsp.fileInfo.fileId;
//                imageReq.msgContent.fileSize = serviceRsp.fileInfo.fileSize;
//                imageReq.msgContent.fileWidth = serviceRsp.fileInfo.fileWidth;
//                imageReq.msgContent.fileHeight = serviceRsp.fileInfo.fileHeight;
//                [FNMsgLogic updateLocalData:serviceRsp.fileInfo.downloadURL msgId:msgEntity.msgId fileId:serviceRsp.fileInfo.fileId fileName:serviceRsp.fileInfo.fileName fileSize:serviceRsp.fileInfo.fileSize fileWidth:serviceRsp.fileInfo.fileWidth fileHeight:serviceRsp.fileInfo.fileHeight sendStatus:statusCode];
//                void(^sendRichMsgCallback)(FNSendRichTextMsgResponse *rspArgs) = ^(FNSendRichTextMsgResponse *rspArgs) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (200 == rspArgs.msgRsp.statusCode) {
//                            NSLog(@"send rich msg success!");
//                             message.sendingFlag = NO;
//                            message.sendFailureFlag =  NO;
//                             [self finishSendingMessage];
//                            [self.collectionView reloadData];
//                        } else {
//                            NSLog(@"发送失败");
//                             message.sendingFlag = NO;
//                            message.sendFailureFlag = YES;
//                             [self finishSendingMessage];
//                            [self.collectionView reloadData];
//
//                        }
//                        
//                        [FNSystemSoundPlayer fn_playMessageSentSound];
//    
//                        [self finishSendingMessage];
//                    });
//                };
//                [FNMsgLogic bopSendRichTextMsg:imageReq callback:sendRichMsgCallback];}
//            else
//            {
//                NSLog(@"上传音频失败");
//                 message.sendingFlag = NO;
//                message.sendFailureFlag = YES;
//                 [self finishSendingMessage];
//                [self.collectionView reloadData];
//                
//            }
//        }];
//        
        
        
    } else if ([source isEqualToString:@"group"])
    {
        FNMsgContent *msgContent = [FNMsgContent msgContentWithType:AudioMsg];
        [msgContent setFilePath:item.fileURL.path];
        [msgContent setContent:@"[音频]"];
        [msgContent setContentType:FNMsgTypeAudio];
        [msgContent setFileName:item.fileURL.path.lastPathComponent];
        [msgContent setDuration:item.duration];
        [msgContent setBitrate:[item.bitrate integerValue]];
        
        FNMsgEntity *msgEntity = [[FNMsgEntity alloc] init];
        msgEntity.event = eventType;
        msgEntity.msgAttribute = nil;
        msgEntity.peerID = toUserid;
        msgEntity.senderId = self.senderId;
        
        msgEntity.msgType = FNMsgTypeAudio;
        msgEntity.msgContent = [msgContent toJString];
        msgEntity.msgId = message.msgId;
        msgEntity.senderNickname = self.senderDisplayName;
        msgEntity.sendPortraitUrl = @"hahahhhhhhhhtest";
        msgEntity.pushDesc = @"给你发了一段音频";
        
        FNSendRichTextMsgRequest *imageReq = [[FNSendRichTextMsgRequest alloc] init];
        imageReq.msgEntity = msgEntity;
        imageReq.msgContent = msgContent;
        
        [FNGroupMsgLogic saveRichTextMessage:imageReq];
        
        [FNGroupMsgLogic uploadRichTextFilePath:fullPath msgId:msgEntity.msgId fileType:FNMsgTypePic tid:self.toUserid callBack:^(FNFileUploadResponse *serviceRsp){
            int32_t statusCode = serviceRsp.statusCode;
            if(statusCode ==200)
            {
                imageReq.msgContent.fileDownloadUrl = serviceRsp.fileInfo.downloadURL ;
                imageReq.msgContent.fileId = serviceRsp.fileInfo.fileId;
                imageReq.msgContent.fileSize = serviceRsp.fileInfo.fileSize;
                imageReq.msgContent.fileWidth = serviceRsp.fileInfo.fileWidth;
                imageReq.msgContent.fileHeight = serviceRsp.fileInfo.fileHeight;
                [FNGroupMsgLogic updateLocalData:serviceRsp.fileInfo.downloadURL msgId:msgEntity.msgId fileId:serviceRsp.fileInfo.fileId fileName:serviceRsp.fileInfo.fileName fileSize:serviceRsp.fileInfo.fileSize fileWidth:serviceRsp.fileInfo.fileWidth fileHeight:serviceRsp.fileInfo.fileHeight sendStatus:statusCode];
                void(^sendRichMsgCallback)(FNSendRichTextMsgResponse *rspArgs) = ^(FNSendRichTextMsgResponse *rspArgs) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (200 == rspArgs.msgRsp.statusCode) {
                            NSLog(@"send rich msg success!");
                             message.sendingFlag = NO;
                            message.sendFailureFlag =  NO;
                             [self finishSendingMessage];
                            [self.collectionView reloadData];
                        } else {
                            NSLog(@"发送失败");
                             message.sendingFlag = NO;
                            message.sendFailureFlag = YES;
                             [self finishSendingMessage];
                            [self.collectionView reloadData];
                        }
                        
                        [FNSystemSoundPlayer fn_playMessageSentSound];
                        
                        [self finishSendingMessage];
                    });
                };
                [FNGroupMsgLogic bopSendRichTextMsg:imageReq callback:sendRichMsgCallback];}
            else
            {
                NSLog(@"上传音频失败");
                 message.sendingFlag = NO;
                 [self finishSendingMessage];
                message.sendFailureFlag = YES;
                [self.collectionView reloadData];
            }
        }];
    }
    
}


- (void)sendMessage:(FNMessage *)message
{
    [self.msgDataModel setAvatarWithDefaultSenderID:self.senderId];
    message.sendingFlag = YES;
    message.isOutgoing = YES;
    if (!message.isReSent) {
        [self finishSendingMessage];
    }
    NSLog(@"[FNUserConfig getInstance].loginStatus = %lu", (unsigned long)[FNUserConfig getInstance].loginStatus);
    
    switch (message.messageType)
    {
        case FNMessageTypePicture:
        {
            NSString *name = [NSString stringWithFormat:@"%@.jpg", message.msgId];
            
            FNPhotoMediaItem *picItem = (FNPhotoMediaItem *) message.media;
            
            //            CGFloat compressionQuality = 1.0f;
            //            if (picItem.image.size.width * picItem.image.size.height  >  3656000) {
            //                compressionQuality = 0.8f;
            //            }
            //            NSData *picData = UIImageJPEGRepresentation(picItem.image, compressionQuality);
            
            
            FNMsgContent *msgContent = [FNMsgContent msgContentWithType:ImageMsg];
            [msgContent setFilePath:picItem.imagePath];
            [msgContent setContent:@"[图片]"];
            [msgContent setContentType:FNMsgTypePic];
            [msgContent setFileName:name];
            [msgContent setFileThumbPath:@""];
            [msgContent setFileWidth:picItem.image.size.width];
            [msgContent setFileHeight:picItem.image.size.height];
            
            FNMsgEntity *msgEntity = [[FNMsgEntity alloc] init];
            msgEntity.event = eventType;
            msgEntity.msgAttribute = nil;
            msgEntity.peerID = toUserid;
            msgEntity.senderNickname = self.senderDisplayName;
            msgEntity.msgId = [FNMsgBasicLogic generateUUID];
            msgEntity.sendPortraitUrl = @"hahahhhhhhhhtest";
            msgEntity.pushDesc = @"给你发了一张图片";
            
            FNSendRichTextMsgRequest *imageReq = [[FNSendRichTextMsgRequest alloc] init];
            imageReq.msgEntity = msgEntity;
            imageReq.msgContent = msgContent;
            
            void(^sendRichMsgCallback)(FNSendRichTextMsgResponse *rspArgs) = ^(FNSendRichTextMsgResponse *rspArgs) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    message.sendFailureFlag = YES;
                    if (200 == rspArgs.msgRsp.statusCode) {
                        message.sendFailureFlag = NO;
                        NSLog(@"send rich msg success!");
                    } else if (250 == rspArgs.msgRsp.statusCode) {
                        
                        NSLog(@"上传富文本消息文件失败：%@", rspArgs.msgRsp.reason);
                    }
                    
                    [FNSystemSoundPlayer fn_playMessageSentSound];
                });
            };
            
            if ([source isEqualToString:@"private"])
            {
                [FNMsgLogic sendRichTextMsg:imageReq callback:sendRichMsgCallback];
            }
            else if ([source isEqualToString:@"group"])
            {
                [FNGroupMsgLogic sendRichTextMsg:imageReq callback:sendRichMsgCallback];
            }
        }
            break;
            
        case FNMessageTypeAudio:
        {
            FNAudioMediaItem *item = (FNAudioMediaItem *)message.media;
            
            FNMsgContent *audioContent = [FNMsgContent msgContentWithType:AudioMsg];
            [audioContent setFilePath:item.fileURL.path];
            [audioContent setContent:@"[音频]"];
            [audioContent setContentType:FNMsgTypeAudio];
            [audioContent setFileName:item.fileURL.path.lastPathComponent];
            [audioContent setDuration:item.duration];
            [audioContent setBitrate:[item.bitrate integerValue]];
            
            FNMsgEntity *audioEntity = [[FNMsgEntity alloc] init];
            audioEntity.event = eventType;
            audioEntity.msgAttribute = nil;
            audioEntity.peerID = toUserid;
            audioEntity.msgId = message.msgId;
            audioEntity.senderNickname = self.senderDisplayName;
            audioEntity.sendPortraitUrl = @"hahahhhhhhhhtest";
            audioEntity.pushDesc = @"给你发了一段音频";
            
            FNSendRichTextMsgRequest *audioReq = [[FNSendRichTextMsgRequest alloc] init];
            audioReq.msgEntity = audioEntity;
            audioReq.msgContent = audioContent;
            
            void(^sendRichMsgCallback)(FNSendRichTextMsgResponse *rspArgs) = ^(FNSendRichTextMsgResponse *rspArgs) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    message.sendFailureFlag = YES;
                    if (200 == rspArgs.msgRsp.statusCode) {
                        message.sendFailureFlag = NO;
                        NSLog(@"send rich msg success!");
                    } else if (250 == rspArgs.msgRsp.statusCode) {
                        NSLog(@"上传富文本消息文件失败：%@", rspArgs.msgRsp.reason);
                    }
                    
                    [FNSystemSoundPlayer fn_playMessageSentSound];
                });
            };
            
            if ([source isEqualToString:@"private"])
            {
                [FNMsgLogic sendRichTextMsg:audioReq callback:sendRichMsgCallback];
            }
            else if ([source isEqualToString:@"group"])
            {
                [FNGroupMsgLogic sendRichTextMsg:audioReq callback:sendRichMsgCallback];
            }
        }
            break;
            
        case FNMessageTypeVideo:
        {
            FNVideoMediaItem *item = (FNVideoMediaItem *)message.media;
            
            FNVideoMsgContent *msgContent = [FNVideoMsgContent msgContentWithType:VideoMsg];
            [msgContent setFilePath:item.fileURL.path];
            [msgContent setContent:@"[视频]"];
            [msgContent setContentType:FNMsgTypeVideo];
            [msgContent setFileName:item.fileURL.path.lastPathComponent];
            [msgContent setFileThumbPath:@""];
            [msgContent setDuration:0];
            
            FNMsgEntity *msgEntity = [[FNMsgEntity alloc] init];
            msgEntity.event = eventType;
            msgEntity.msgAttribute = nil;
            msgEntity.peerID = toUserid;
            msgEntity.msgId = [FNMsgBasicLogic generateUUID];
            msgEntity.pushDesc = @"给你发了一段视频";
            msgEntity.sendPortraitUrl = @"hahahhhhhhhhtest";
            
            FNSendRichTextMsgRequest *richReq = [[FNSendRichTextMsgRequest alloc] init];
            richReq.msgEntity = msgEntity;
            richReq.msgContent = msgContent;
            
            void(^sendRichMsgCallback)(FNSendRichTextMsgResponse *rspArgs) = ^(FNSendRichTextMsgResponse *rspArgs) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    message.sendFailureFlag = YES;
                    if (200 == rspArgs.msgRsp.statusCode) {
                        NSLog(@"send rich msg success!");
                        message.sendFailureFlag = NO;
                    } else if (250 == rspArgs.msgRsp.statusCode) {
                        NSLog(@"上传富文本消息文件失败：%@", rspArgs.msgRsp.reason);
                    }
                    
                    [FNSystemSoundPlayer fn_playMessageSentSound];
                });
            };
            
            if ([source isEqualToString:@"private"])
            {
                [FNMsgLogic sendRichTextMsg:richReq callback:sendRichMsgCallback];
            }
            else if ([source isEqualToString:@"group"])
            {
                [FNGroupMsgLogic sendRichTextMsg:richReq callback:sendRichMsgCallback];
            }
        }
            break;
            
        case FNMessageTypePlainText:
        {
            NSString * tempMsgId = [FNMsgBasicLogic generateUUID];
            
            FNSendTextMsgRequest *textMsgReq = [[FNSendTextMsgRequest alloc] init];
            textMsgReq.peerID = toUserid;//toUserid;
            textMsgReq.content = message.text;
            textMsgReq.senderNickname = self.senderDisplayName;
            textMsgReq.senderId = self.senderId;
            textMsgReq.sendPortraitUrl = @"hahahhhhhhhhtest";
            textMsgReq.contentType = @"String";
            textMsgReq.msgAttribute = @"buring";
            textMsgReq.msgId = tempMsgId;
            textMsgReq.pushDesc = message.text;
            textMsgReq.name = self.toDisplayName;
            
//------------------------------RCSSDK --------------------------------------------------------
 
        [globalRcsApi msgsendtext:R number:toUserid messageId:tempMsgId content:message.text needReport:YES isBurn:YES directedType:DirectedTypeNONE needReadReport:NO callback:^(rcs_state* R, MessageResult *s) {
                    if (s->error_code == 200) {
            
                        NSLog(@"send text ok");
                        message.sendingFlag = NO;
                        message.sendFailureFlag = NO;
                        
                        [FNMsgTable updateSendMsgStatus:tempMsgId syncId:0 sendStatus:MsgSendSuccess sendTime:[FNSystemConfig dateToString:[FNSystemConfig getLocalDate]]];
       
                        dispatch_async(dispatch_get_main_queue(),^{
                            
                            [self.collectionView reloadData];
                            
                        });
            
                    }
                    else
                    {
                        message.sendingFlag = NO;
                        message.sendFailureFlag = YES;
                        [self.collectionView reloadData];
                        NSLog(@"send text failed");
                        
                    }
                    
//                    @synchronized(sync){
//                        [self finishSendingMessage];
//                        [FNSystemSoundPlayer fn_playMessageSentSound];
//                    }
            
                }];
            

            
 //-------------------------------------end-----------------------------------------------
            
//            void(^sendTextMsgCallback)(FNSendMsgResponse *rspArgs) = ^(FNSendMsgResponse *rspArgs) {
//                NSLog(@"send msg result args: %d", rspArgs.statusCode);
//                
//                int32_t sc = rspArgs.statusCode;
//                if (200 == sc)
//                {
//                    message.sendingFlag = NO;
//                    message.sendFailureFlag = NO;
//                    [self.collectionView reloadData];
//                }
//                else
//                {
//                    message.sendingFlag = NO;
//                    message.sendFailureFlag = YES;
//                    [self.collectionView reloadData];
//                    NSLog(@"send msg failed with status code:%d %@", sc, rspArgs.reason);
//                }
//                
//                @synchronized(sync){
//                    [self finishSendingMessage];
//                    [FNSystemSoundPlayer fn_playMessageSentSound];
//                }
//            };
//            
//            if ([source isEqualToString:@"private"])
//            {
            [DBManager initDBWithUserId:[FNUserInfo ShareStaticConst].localNum];

                [FNMsgLogic sendTextMsg:textMsgReq callback:nil];
//                                [self sendSimpleMsg:textMsgReq.content];
//            }
//            else if ([source isEqualToString:@"group"])
//            {
//                //[FNGroupMsgLogic sendTextMsg:textMsgReq callback:sendTextMsgCallback];
//            }
            
        }
            break;
        default:
            break;
    }
}
//TEST发送自定义消息
- (void)sendSimpleMsg:(NSString *)msg
{
    FNSendSimpleMsgRequest *req = [[FNSendSimpleMsgRequest alloc] init];
    req.toBopId = toUserid;
    req.msg = msg;
    
    [FNMsgLogic sendSimpleMsg:req
                     callback:^(FNSendSimpleMsgResponse *rspArgs) {
                     }];
}



- (void)dealloc
{
    NSLog(@"ConversationController delloc");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"groupListChange" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_HAS_NEW_MSG object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_HAS_NEW_GROUP_MSG object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}











#pragma mark - -------------------------------registerListener-----------------------------------


- (void)registerMsgListener
{
    __weak typeof(self) weakSelf = self;
    
    //服务端推送SINGLE(一对一聊天)、GROUP(群组聊天)、PUBLIC_ACCOUNT(公众账号消息)、BROADCAST(广播消息)、DIRECTED(定向消息)文本消息事件监听器
    
    [globalRcsApi setMsgTextListener:^(rcs_state*R, MessageTextSession* s)
     {
         //[weakSelf AddLogC:s->content];
         NSLog(@"content=======%s",s->content);
         
         MessageEntity *m = [MessageEntity new];
         
         m.content=[NSString stringWithFormat:@"%s",s->content];
         m.fromUserId = [NSString stringWithFormat:@"%s",s->from];
         m.toUserid = [NSString stringWithFormat:@"%s",s->to];
         m.chatType = s->chat_type;
         m.directed_type = s->directed_type;
         
//-------------------------------------------------------------------------------
         
         
//         int32_t msgNum = (int32_t)((NSArray *)notify.object).count;
//         NSArray *recvMsgs;
//         NSArray *fnTables = notify.object;
//         if ([source isEqualToString:@"private"])
//         {
//             NSInteger syncId = [[fnTables lastObject] syncId];
//             recvMsgs = [FNMsgTable getUnreadMsgForTid:toUserid num:msgNum andSyncId:syncId];
//             
//             
//         } else if ([source isEqualToString:@"group"]) {
//             
//             NSInteger syncId=[[fnTables lastObject] syncId];
//             recvMsgs=[FNGroupMsgTable getUnreadMsgForGroupId:toUserid num:msgNum andSyncId:syncId];
//         }
//         
//         for (int i = 0; i < recvMsgs.count; i++)
//         {
//             FNMsgTable *messageData = (FNMsgTable *)recvMsgs[i];
//             [self scrollToBottomAnimated:YES];
//             
//             if ([messageData.msgType isEqualToString:FNMsgTypePlain])
//             {
//                 // 文本消息直接刷新UI
//                 FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject:messageData]
//                                                             mediaData:nil].lastObject;
//                 
//                 [FNSystemSoundPlayer fn_playMessageReceivedSound];
//                 [self.msgDataModel.messages addObject:fnMsg];
//                 [self finishReceivingMessage];
//                 
//             } else {
//                 // 富文本信息 先下载 接收消息时，发送完图片之后接着发文字，文本先到，要排序
//                 NSData *data;
//                 if (messageData.receiveStatus != MsgReceiveSuccess) {
//                     data = [FNImage dataWithName:@"failure3"];
//                 }
//                 
//                 FNMessage *fnMsg = [self.msgDataModel makeTargetFNMsg:[NSArray arrayWithObject: messageData]
//                                                             mediaData:data].lastObject;
//                 if (fnMsg != nil)
//                 {
//                     [self.msgDataModel.messages addObject:fnMsg];
//                     
//                     if (fnMsg.isMediaMessage) {
//                         id<FNMessageMediaData> mediaData = fnMsg.media;
//                         // 媒体文件分类
//                         if ([mediaData isKindOfClass:[FNPhotoMediaItem class]]) {
//                             FNPhotoMediaItem *photoItemCopy = (FNPhotoMediaItem *)mediaData;
//                             photoItemCopy.appliesMediaViewMaskAsOutgoing = NO;
//                             [self.collectionView reloadData];
//                             
//                         }
//                         else if ([mediaData isKindOfClass:[FNVideoMediaItem class]]) {
//                             FNVideoMediaItem *avItemCopy = (FNVideoMediaItem *)mediaData;
//                             avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
//                             avItemCopy.isReadyToPlay = YES;
//                             [self.collectionView reloadData];
//                         }
//                         else if ([mediaData isKindOfClass:[FNAudioMediaItem class]]) {
//                             FNAudioMediaItem *avItemCopy = (FNAudioMediaItem *)mediaData;
//                             avItemCopy.appliesMediaViewMaskAsOutgoing = NO;
//                             [self.collectionView reloadData];
//                         }
//                         else {
//                             NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
//                         }
//                         
//                         // self.showTypingIndicator = !self.showTypingIndicator;
//                         [FNSystemSoundPlayer fn_playMessageReceivedSound];
//                         [self finishReceivingMessage];
//                     }
//                 }
//             }
//         }
//         [FNRecentConversationTable updateUnReadCount:self.toUserid];
//         
//         
//       
         
         
//-----------------------------------------------------------------------------
         
         
         //         NSString *content = [NSString stringWithUTF8String:s->content];
         //         [_contentArray addObject:content];
         //         NSLog(@"%lu",(unsigned long)_contentArray.count);
         
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
         
         //[weakSelf AddLogC:"receive MessageFTSession"];
         NSLog(@"receive MessageFtSession");
         
         if(!s->is_report && s->file_size > 0)
         {
             NSString* messageId = [NSString stringWithUTF8String:s->imdn_id];
             NSString* transferId = [NSString stringWithUTF8String:s->transfer_id];
             
             NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             
             NSString *filePath = [docPaths objectAtIndex:0];
             
             UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
             
             NSString * filename = [NSString stringWithFormat:@"%lld", recordTime];
             
             NSString* newfilePath = [NSString stringWithFormat:@"%@/%@.jpg", filePath,filename];
             
             [globalRcsApi msgfetchfile:R number:weakSelf.localNum
                              messageId:messageId
                               chatType:s->chat_type
                               filePath:newfilePath
                            contentType:s->content_type
                               fileName:@""
                             transferId:transferId
                                  start:0
                               fileSize:s->file_size
                                   hash:@""
                                 isBurn:s->is_burn
                               callback:^(rcs_state* R, MessageResult *s) {
                                   if (s->error_code == 200) {
                                       //[weakSelf AddLogC:"fetch file ok"];
                                       NSLog(@"fetch file ok");
                                   }
                                   else
                                   {
                                       // [weakSelf AddLogC:"fetch file failed"];
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


- (void)registerListeners
{
    [self registerMsgListener];
    [self registerGroupNotifyListener];
    [self registerGroupListListener];
    [self registerGroupInfoListener];
    [self registerGroupEventListener];
}


@end
