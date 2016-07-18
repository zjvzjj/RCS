//
//  MessageFacilitiesView.m
//  Fetion
//
//  Created by songhaowen on 8/18/15.
//  Copyright (c) 2015 xinrui.com. All rights reserved.
//

#import "ConversationFacilitiesView.h"
#import "XMEmotionView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "FNMsgBasicLogic.h"
#import "UIView+Toast.h"
#import "FNImage.h"
#include <ImageIO/ImageIOBase.h>
#include <ImageIO/ImageIO.h>
#import "FNUserConfig.h"
#import "VoiceConverter.h"
#import "SNSVideoPlayer.h"
#import "SNSVideoRecorder.h"
#import "RYRecorderViewController.h"

@class UIImagePickerController;

@interface ConversationFacilitiesView ()
 <UITextViewDelegate,
  EmojiSending,
  UINavigationControllerDelegate,
  UIImagePickerControllerDelegate,
  CLLocationManagerDelegate,
  ZLPhotoPickerViewControllerDelegate
>

{
    BOOL shown;
    
    BOOL recording;
    
    BOOL isLocated;
    
    CGFloat scrollerHeight;
    
    CGFloat keyboardLocation;
    
    NSTimer *_timer;
    
    UIButton *more;
    
    UIButton *emoj;
    
    UIButton *voice;
    
    UIImageView *inputFrame;
    
    UIScrollView *inputScroller;
    
    UITextView *inputView;
    
    UIView *facility;
    
    XMEmotionView *emojView;
    
    NSMutableArray *_plugItems;
    
    CLLocationManager *_locationManager;
    
    void (^FNTextBlock) (NSString *text);
    
    void (^FNImageBlock) (UIImage *image);
    
    void (^FNLocationBlock) (CLLocation *location);
    
    void (^FNVideoBlock) (NSURL *url,ALAsset *asset);
    
    void (^FNAudioBlock) (NSString *url);
}

- (void) reconfigure:(NSNotification *)note;

- (void) sendPhoto:(UIButton *)sender;

- (void) sendImage:(UIButton *)sender;

- (void) showmore:(UIButton *)sender;

- (void) showemoji:(UIButton *)sender;

- (void) recordvoice:(UIButton *)sender;

- (void) keyboardShow:(NSNotification *)note;

- (void) keyboardChange:(NSNotification *)note;

- (void) keyboardHide:(NSNotification *)note;

@property (nonatomic, strong) NSURL *recordedFile;

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) UIView *voiceView;

@property (nonatomic, strong) UILabel *label;
@property(nonatomic,weak)UIView *backView;

@end

@implementation ConversationFacilitiesView

@synthesize navoffset;

@synthesize observer;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //
        NSURL *recordedFile = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/11.wav",strUrl]];
        
        self.recordedFile = recordedFile;
        
        scrollerHeight = 29.0f;
        
        keyboardLocation = [UIScreen mainScreen].bounds.size.height;//???
        
        self.backgroundColor = [UIColor whiteColor];

        //语音按钮
        voice = [UIButton buttonWithType:UIButtonTypeCustom];
        
        voice.layer.cornerRadius = 5;

        voice.frame = CGRectMake(10.0f, (44.0f - 30.0f ) / 2.0f, frame.size.width - 20.0f, 30.0f);
        
        voice.tag = - 1;
        
        [voice setTitle:@"录音" forState:UIControlStateNormal];
        
        voice.backgroundColor = [UIColor colorWithRed:(235.0f / 255.0f) green:(235.0f / 255.0f) blue:(235.0f / 255.0f) alpha:1.0f];
        
        [voice addTarget:self action:@selector(recordTouchDown) forControlEvents:UIControlEventTouchDown];
        
        [voice addTarget:self action:@selector(recordTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        
        [voice addTarget:self action:@selector(recordTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        
//        [voice addTarget:self action:@selector(recordDragOutside) forControlEvents:UIControlEventTouchDragOutside];
        
//        [voice addTarget:self action:@selector(recordDragInside) forControlEvents:UIControlEventTouchDragInside];
        
        [self addSubview:voice];
        
        voice.hidden = YES;
    
        UIImage *image = [FNImage imageWithName:@"chatroom_input_frame"];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(15.0f, 12.5f, 15.0f, 12.5f);
        
        UIImage *inputFrameImage = [image resizableImageWithCapInsets:insets];
        
        inputFrame = [[UIImageView alloc] initWithImage:[inputFrameImage stretchableImageWithLeftCapWidth:20 topCapHeight:15]];
        
        inputFrame.userInteractionEnabled = YES;
        
        inputFrame.frame = CGRectMake(10.0f, (44.0f - 30.0f ) / 2.0f, frame.size.width - 20.0f, 30.0f);
        
        inputScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width - 20.0f, 30.0f)];
        
        inputScroller.backgroundColor = [UIColor whiteColor];
        
        inputScroller.contentSize = CGSizeMake(frame.size.width - 88.0f - 50.0f, 30.0f);
        
        inputView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width - 20.0f, 30.0f)];
        
        inputView.backgroundColor = [UIColor colorWithRed:(235.0f / 255.0f) green:(235.0f / 255.0f) blue:(235.0f / 255.0f) alpha:1.0f];
        
        [inputView.layer setCornerRadius:5];
        
        inputView.textContainerInset = UIEdgeInsetsMake(6.0f, 12.5f, 6.0f, 12.5f);
        
        inputView.returnKeyType = UIReturnKeySend;
        
        inputView.keyboardAppearance = UIKeyboardAppearanceLight;
        
        inputView.enablesReturnKeyAutomatically = YES;
        
        inputView.font = [UIFont systemFontOfSize:16.0f];
        
        inputView.delegate = self;
        
        [inputScroller addSubview:inputView];
        
        [inputFrame addSubview:inputScroller];
        
        [self addSubview:inputFrame];
        

        facility = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, frame.size.width, 44.0f)];
        
        facility.backgroundColor = [UIColor colorWithRed:(235.0f / 255.0f) green:(235.0f / 255.0f) blue:(235.0f / 255.0f) alpha:1.0f];
        
        [self addSubview:facility];
        
        _plugItems = [[NSMutableArray alloc] init];
        

        emojView = [[XMEmotionView alloc] initWithType:XMEmotionViewType_Comment];
        
        emojView.backgroundColor = [UIColor greenColor];
        
        emojView.frame = CGRectMake(0.0f, 44.0f, frame.size.width, 216.0f);
        
        emojView.emojreceiver = self;
        
        [self addSubview:emojView];

        
        [self reconfigure:nil];
        
        [self sendSubviewToBack:emojView];
    }
    
    return self;
}


#pragma mark - Extensions

- (void) reconfigure:(NSNotification *)note
{
    NSArray *subviews = facility.subviews;
    
    for (UIView *view in subviews)
    {
        if ([view isKindOfClass:[UIButton class]] && view.tag >= 0)
        {
            [view removeFromSuperview];
        }
    }
    
    [_plugItems removeAllObjects];
    
    NSArray *items = @[@"chat_facility_voice",@"chat_facility_emoj",@"chat_facility_photo",@"chat_facility_capture",@"chat_facility_video",@"chat_facility_film",];
    
    NSUInteger index = 0;
    
    NSInteger width = self.frame.size.width;
    
    NSInteger side = 28.0f;
    
    NSInteger padding = (width - (12.0f * 2) - (side * items.count)) / (items.count - 1);
    
    for (NSString *icon in items)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = index;
        
        button.frame = CGRectMake(12.0f + (side + padding) * index, 8.0f, side, side);
        
        [button setImage:[FNImage imageWithName:icon] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [facility addSubview:button];
        
        [_plugItems addObject:button];
        
        index++;
    }
}

- (void)itemSelected:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 0:
        {
            // 语音
            if ([observer respondsToSelector:@selector(sendAudio)])
            {
                [observer sendAudio];
            }
            else
            {
                [self showAudio];
            }
        }
            break;
        case 1:
        {
            // emoj
            if ([observer respondsToSelector:@selector(sendEmoj)])
            {
                [observer sendEmoj];
            }
            else
            {
                [self showEmoj];
            }
        }
            break;
        case 2:
        {
            // 从相册选择图片
            if ([observer respondsToSelector:@selector(sendPhoto)])
            {
                [observer sendPhoto];
            }
            else
            {
                [self showPhoto];
            }
        }
            break;
        case 3:
        {
            // 拍照
            if ([observer respondsToSelector:@selector(sendCamera)])
            {
                [observer sendCamera];
            }
            else
            {
                [self showPicture];
            }
            
        }
            break;
        case 4:
        {
            //TODO: This function will be reused.
            
//            // 视频
//            if ([observer respondsToSelector:@selector(sendPhoto)])
//            {
//                [observer sendPhoto];
//            }
//            else
//            {
//                [self showLocalVideo];
//            }
            
            FNLocationBlock(@"");
        }
            break;
            
        case 5:
        {            
            // 录像
            if ([observer respondsToSelector:@selector(sendVideo)])
            {
                [observer sendVideo];
            }
            else
            {
                [self showCamera];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void) showEmoj
{
    if (recording)
    {
        UIImage *voiceImage = [FNImage imageWithName:@"chat_facility_keyboard"];
        
        [_plugItems[0] setImage:voiceImage forState:UIControlStateNormal];
    }
    

    if (shown)
    {
        [self sendSubviewToBack:emojView];
        
        if (emojView.hidden)
        {
            UIImage *image = [FNImage imageWithName:@"chat_facility_emoj"];
            
            [_plugItems[1] setImage:image forState:UIControlStateNormal];
            
            /*
             */
            
            emojView.hidden = NO;
        }
        else
        {
            UIImage *image = [FNImage imageWithName:@"chat_facility_emoj"];
            
            [_plugItems[1] setImage:image forState:UIControlStateNormal];
            
            [self resign];
        }
    }
    else
    {
        UIImage *image = [FNImage imageWithName:@"chat_facility_emoj"];
        
        [_plugItems[1] setImage:image forState:UIControlStateNormal];
        
        shown = YES;
    
        recording = NO;
        
        emojView.hidden = NO;
        
        if (inputView.isFirstResponder)
        {
            
            [inputView resignFirstResponder];
        }
        else
        {
            [self bringSubviewToFront:emojView];
            
            CGRect frame = self.frame;
            
            CGRect fframe = facility.frame;
            
            CGRect eframe = emojView.frame;
            
            keyboardLocation = [UIScreen mainScreen].bounds.size.height - 216.0f;
            
            CGFloat y = keyboardLocation - navoffset - scrollerHeight - 88.0f + 29.0f;
            
            frame.origin.y = y;

            fframe.origin.y = scrollerHeight + 44 - 29.0f;
            
            if (!recording)
            {
                eframe.origin.y = scrollerHeight + 88.0f - 29.0f;
            }
            else
            {
                eframe.origin.y = scrollerHeight + 44.0f - 29.0f;
            }
            
            
            keyboardLocation -= 44;
            
            [UIView animateWithDuration:0.25f animations:^{
                
                self.frame = frame;
                
                facility.frame = fframe;
                
                emojView.frame = eframe;
                
                inputFrame.hidden = NO;
                
            }];
            
            if ([observer respondsToSelector:@selector(KeyboardFacilityChange:curve:duration:)])
            {
                [observer KeyboardFacilityChange:y curve:UIViewAnimationOptionCurveEaseInOut duration:0.25f];
            }
        }
    }
}

- (void) showAudio
{
    if (recording)
    {
        inputFrame.hidden = NO;
        
        voice.hidden = YES;
        
        [_plugItems[0] setImage:[FNImage imageWithName:@"chat_facility_voice"] forState:UIControlStateNormal];
        
        [inputView becomeFirstResponder];

    }
    else
    {
        if ([inputView isFirstResponder] || shown)
        {
            [self resign];
        }
        
        inputFrame.hidden = YES;
        
        voice.hidden = NO;
        
        [_plugItems[0] setImage:[FNImage imageWithName:@"chat_facility_keyboard"] forState:UIControlStateNormal];
    }
    
    recording = !recording;
}
// 图片选择
- (void) showPhoto
{
    [self jumpToMutableImagesPickerController];
}

- (void)showLocalVideo
{
    [self jumpToVideoPickerController];
}
// 跳转到多张图片选择的界面
- (void)jumpToMutableImagesPickerController
{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.delegate = self;
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:pickerVc animated:YES completion:nil];
}

// 跳转到视频文件选择的界面
- (void)jumpToVideoPickerController
{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.status = PickerViewShowStatusVideo;
    pickerVc.delegate = self;
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:pickerVc animated:YES completion:nil];
}

- (void)showPicture
{
    [self jumpToImagePickerController];
}
//  摄像拍照界面选择
- (void) showCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        RYRecorderViewController *recordCon=[[RYRecorderViewController alloc]init];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:recordCon];
        //  __weak typeof (recordCon)weakSelf = recordCon;
        //
        recordCon.sendDataWithVideoPathAndImagePath=^(NSString *VideoPath,NSString*ImagePath){
            NSURL *url = [NSURL fileURLWithPath:VideoPath];
            
            if (FNVideoBlock)
            {
                FNVideoBlock(url,nil);
            }
            
            UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        };
        
        
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [vc presentViewController:nav animated:YES completion:nil];     }else
     {
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fetion Cloud" message:@"摄像头不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
         [alert show];
     }
}

// 跳转到拍照,录像界面
- (void)jumpToImagePickerController
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie,(NSString*)kUTTypeMovie,nil];
        
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
        imagePickerController.videoMaximumDuration = 20;
        
        imagePickerController.allowsEditing = NO;
        imagePickerController.delegate = self;
        
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [vc presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fetion Cloud" message:@"摄像头不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void) showImagePicker:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil];
    imagePickerController.allowsEditing = YES;
    imagePickerController.delegate = self;
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;

    switch (type)
    {
        case UIImagePickerControllerSourceTypeCamera:
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [vc presentViewController:imagePickerController animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fetion Cloud" message:@"摄像头不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
            }

            break;
            
        case UIImagePickerControllerSourceTypePhotoLibrary:
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                [vc presentViewController:imagePickerController animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fetion Cloud" message:@"相册不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            break;
            
        default:

            break;
    }
}

- (BOOL) isShow
{
    return  inputView.isFirstResponder;
}

- (void) resign
{
    if (shown)
    {
        [self sendSubviewToBack:emojView];
        
        shown = NO;
        
        UIImage *image = [FNImage imageWithName:@"chat_facility_emoj"];
        
        [_plugItems[1] setImage:image forState:UIControlStateNormal];
        
        keyboardLocation = [UIScreen mainScreen].bounds.size.height;
        
        CGRect frame = self.frame;
        
        CGFloat y = keyboardLocation - navoffset - scrollerHeight - 88.0f + 29.0f;
        
        if (frame.origin.y != y)
        {
            frame.origin.y = y;
            
            [UIView animateWithDuration:0.25f animations:^{
                
                self.frame = frame;
            }];
            
            if ([observer respondsToSelector:@selector(KeyboardFacilityChange:curve:duration:)])
            {
                [observer KeyboardFacilityChange:y curve:UIViewAnimationOptionCurveEaseInOut duration:0.25f];
            }
        }
    }
    else
    {
        [inputView resignFirstResponder];
    }
}

- (void) clearContent
{
    [inputView setText:@""];
    
    [self textViewDidChange:inputView];
}

- (void) setText:(void (^)(NSString *))block
{
    FNTextBlock = nil;
    
    FNTextBlock = block;
}

- (void) setImage:(void (^)(UIImage *))block
{
    FNImageBlock = nil;
    
    FNImageBlock = block;
}

- (void) setLocation:(void (^)(CLLocation *))block
{
    FNLocationBlock = nil;
    
    FNLocationBlock = block;
}

- (void)setVideo:(void (^)(NSURL *,ALAsset *asset))block
{
    FNVideoBlock = nil;
    
    FNVideoBlock = block;
}

- (void)setAudio:(void (^)(NSString *))block
{
    FNAudioBlock = nil;
    
    FNAudioBlock = block;
}

- (void) removeObserverForkeyBorad
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void) addObserverForKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (BOOL)bCanRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                }
                else {
                    bCanRecord = NO;
                    
                }
            }];
        }
    }
    return bCanRecord;
}


#pragma mark - 录音
- (void) recordTouchDown
{
    if(!([self bCanRecord]))
    {
        [[[UIAlertView alloc] initWithTitle:@"无法录音"
                                    message:@"请在iPhone的\"设置-隐私-麦克风\"选项中,允许FetionCloud访问你的手机麦克风"
                                   delegate:nil
                          cancelButtonTitle:@"好"
                          otherButtonTitles:nil] show];
        return ;
    }
    else{
        
       
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error:nil];
        
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat:8000], AVSampleRateKey,
                                  [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
                                  [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey,
                                  [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,
                                  [NSNumber numberWithBool:NO], AVLinearPCMIsFloatKey,
                                  [NSNumber numberWithInteger:7400], AVEncoderBitRateKey,
                                  nil];
        
        NSError *error = nil;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:self.recordedFile settings:settings error:&error];
        self.recorder.meteringEnabled = YES;
        [self.recorder prepareToRecord];
        if ([self.recorder prepareToRecord])
        {
            [self.recorder record];
        }
        
        CGRect rect = [UIScreen mainScreen].bounds;
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor =[UIColor clearColor];
        backView.frame =[UIScreen mainScreen].bounds;
        self.backView = backView;
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        view.frame = CGRectMake((rect.size.width-150)*0.5, (rect.size.height-160)*0.5, 150, 120);
        view.layer.cornerRadius = 10;
        self.voiceView = view;
        
        [self.backView addSubview:self.voiceView];
        [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
        
        UIImageView *leftImage = [[UIImageView alloc] init];
        leftImage.image = [UIImage imageNamed:@"yuyin"];
        leftImage.frame = CGRectMake(40, 25, 30, 60);
        [self.voiceView addSubview:leftImage];
        
        UIImageView *rightImage = [[UIImageView alloc] init];
        rightImage.image = [UIImage imageNamed:@"yinjie（1）"];
        rightImage.tag = 1001;
        rightImage.frame = CGRectMake(80, 80, 10, 5);
        [self.voiceView addSubview:rightImage];
        
        UIImageView *rightImageTwo = [[UIImageView alloc] init];
        rightImageTwo.image = [UIImage imageNamed:@"yinjie（2）"];
        rightImageTwo.tag = 1002;
        rightImageTwo.hidden = YES;
        rightImageTwo.frame = CGRectMake(80, 60, 20, 15);
        [self.voiceView addSubview:rightImageTwo];
        
        UIImageView *rightImageThr = [[UIImageView alloc] init];
        rightImageThr.image = [UIImage imageNamed:@"yinjie（3）"];
        rightImageThr.tag = 1003;
        rightImageThr.hidden = YES;
        rightImageThr.frame = CGRectMake(80, 30, 35, 25);
        [self.voiceView addSubview:rightImageThr];
 
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        label.text = @"手指上滑,取消发送";
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.frame = CGRectMake(10, 100, 130, 15);
        self.label = label;
        [self.voiceView addSubview:self.label];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    }
    
}

- (void)changeImage {
    [self.recorder updateMeters];//更新测量值
    float avg = [self.recorder averagePowerForChannel:0];
    float minValue = -60;
    float range = 60;
    float outRange = 100;
    if (avg < minValue) {
        avg = minValue;
    }
    float decibels = (avg + range) / range * outRange;
    
    UIImageView *imageTwo = (UIImageView *)[self.voiceView viewWithTag:1002];
    UIImageView *imageThr = (UIImageView *)[self.voiceView viewWithTag:1003];
    
    if (decibels < 30)
    {
        imageTwo.hidden = YES;
        imageThr.hidden = YES;
    }
    else if (decibels>= 30 && decibels < 50)
    {
        imageTwo.hidden = NO;
        imageThr.hidden = YES;
    }
    else
    {
        imageTwo.hidden = NO;
        imageThr.hidden = NO;
    }
}

- (void) recordDragInside
{
    self.label.text = @"录音中";
}
- (void) recordTouchUpInside
{
    float cTime = self.recorder.currentTime;
    if(cTime < 1)
    {
        self.label.text = @"录音时间过短!";
        voice.enabled = NO;
        [_timer invalidate];
        _timer = nil;
        self.label.hidden = YES;
        [self.backView removeFromSuperview];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:self.recordedFile.absoluteString])
        {
            [fileManager removeItemAtURL:self.recordedFile error:nil];
        }
        
        voice.enabled = YES;
    }
    else
    {
      if (FNAudioBlock)
      {
          [_timer invalidate];
          _timer = nil;
          [self.backView removeFromSuperview];
          [self.recorder stop];
           FNAudioBlock(self.recordedFile.absoluteString);
          
          NSFileManager *fileManager = [NSFileManager defaultManager];
          if([fileManager fileExistsAtPath:self.recordedFile.absoluteString])
          {
              [fileManager removeItemAtURL:self.recordedFile error:nil];
          }
      }
    }
    
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    

}


- (void) recordDragOutside
{
    self.label.text = @"松开手指，取消发送!";
}

//  手指上滑后并松开 的顺间
- (void) recordTouchUpOutside
{
    [_timer invalidate];
    _timer = nil;
    [self.backView removeFromSuperview];
    [self.recorder stop];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:self.recordedFile.absoluteString])
    {
        
        [fileManager removeItemAtURL:self.recordedFile error:nil];
    }
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}

#pragma mark - Keyboard

- (void) keyboardShow:(NSNotification *)note
{
    shown = NO;
    
    UIImage *image = [FNImage imageWithName:@"chat_facility_emoj"];

    [_plugItems[1] setImage:image forState:UIControlStateNormal];
    
}

- (void) keyboardChange:(NSNotification *)note
{
    NSLog(@"%s",__func__);
    NSValue *end = note.userInfo[UIKeyboardFrameEndUserInfoKey];
    
    NSNumber *duration = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    
    NSNumber *curve = note.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    
    double dur = duration.doubleValue;
    
    UIViewAnimationCurve cur = curve.unsignedIntegerValue;
    
    UIViewAnimationOptions ops = 0;
    
    switch (cur)
    {
        case UIViewAnimationCurveEaseInOut:
        {
            ops = UIViewAnimationOptionCurveEaseInOut;
        }
            break;
            
        case UIViewAnimationCurveEaseIn:
        {
            ops = UIViewAnimationOptionCurveEaseIn;
        }
            break;
            
        case UIViewAnimationCurveEaseOut:
        {
            ops = UIViewAnimationOptionCurveEaseOut;
        }
            break;
            
        case UIViewAnimationCurveLinear:
        {
            ops = UIViewAnimationOptionCurveLinear;
        }
            break;
    }
    
    ops = (dur ? ops : UIViewAnimationOptionCurveEaseIn);
    
    dur = (dur ? dur : 0.25f);
    
    keyboardLocation = end.CGRectValue.origin.y;
    
    if (keyboardLocation == [UIScreen mainScreen].bounds.size.height)
    {
        keyboardLocation = shown ? [UIScreen mainScreen].bounds.size.height - 260.0f : keyboardLocation - 44.0f;
    }
    else
    {
        keyboardLocation -= 44;
    }
    
    CGRect frame = self.frame;
    
    CGRect iframe = inputFrame.frame;
    
    CGRect eframe = emojView.frame;
    
    if (recording)
    {
        CGFloat y = keyboardLocation - navoffset - 44.0f;
        
        if (frame.origin.y != y)
        {
            frame.origin.y = y;
            
            eframe.origin.y = 44.0f;
            
            [UIView animateWithDuration:dur
                                  delay:0
                                options:ops
                             animations:^ {
                                 
                                 self.frame = frame;
                                 
//                                 facility.frame = eframe;
                                 emojView.frame = eframe;
                                 
//                                 inputFrame.hidden = YES;
                                 
                             }
                             completion:nil];
            
            if ([observer respondsToSelector:@selector(KeyboardFacilityChange:curve:duration:)])
            {
                [observer KeyboardFacilityChange:y curve:ops duration:dur];
            }
        }
    }
    else
    {
        CGFloat y = keyboardLocation - navoffset - scrollerHeight - 44.0f + 29.0f;
        
        if (frame.origin.y != y)
        {
            frame.origin.y = y;
            
            eframe.origin.y = iframe.size.height + iframe.origin.y * 2.0f + 44;
            
            [UIView animateWithDuration:dur
                                  delay:0
                                options:ops
                             animations:^ {
                                 
                                 self.frame = frame;
                                 
//                                 facility.frame = eframe;
                                 emojView.frame = eframe;
                                 
                                 inputFrame.hidden = NO;
                                 
                             }
                             completion:nil];
            
            if ([observer respondsToSelector:@selector(KeyboardFacilityChange:curve:duration:)])
            {
                [observer KeyboardFacilityChange:y curve:ops duration:dur];
            }
        }
    }
}

- (void) keyboardHide:(NSNotification *)note
{
    
}

#pragma mark - Emoj

- (void) emojiSelected:(UIImage *)image name:(NSString *)name emojid:(NSString *)ID
{
    NSString* text = inputView.text;
    
    NSRange selectedNSRange = inputView.selectedRange;
    
    NSString* inputText = [text stringByReplacingCharactersInRange:selectedNSRange withString:name];
    
    NSRange nextRange = NSMakeRange(selectedNSRange.location + name.length, 0);
    
    [inputView setText:inputText];
    
    inputView.selectedRange = nextRange;
    
    [self textViewDidChange:inputView];
}

- (void) emojRemove
{
    NSString *text = inputView.text;
    
    NSString *textLeft = nil;
    
    BOOL findEmoji = NO;
    
    NSRange seleteRange = inputView.selectedRange;
    NSRange nextRange = seleteRange;
    
    if (seleteRange.location == 0) {
        return;
    }
    
    if (text.length > 0) {
        NSString *lastChar = [text substringWithRange:NSMakeRange(seleteRange.location - 1, 1)];
        if ([lastChar isEqualToString:@"]"])
        {
            NSString *regex = @"\\[/[a-zA-Z0-9\\u4e00-\\u9fa5 ]+\\]";
            NSArray *array = [text componentsMatchedByRegex:regex];
            if ([array count] > 0)
            {
                NSString *last = [array objectAtIndex:[array count] - 1];
                NSArray *emotionArray = [[NSArray alloc] initWithContentsOfFile:[FNImage emojPlist]];
                NSDictionary *name2ImageDictionary = [emotionArray objectAtIndex:1];
                if ([[name2ImageDictionary objectForKey:last] length] > 0)
                {
                    textLeft = [text stringByReplacingCharactersInRange:NSMakeRange(seleteRange.location - last.length, last.length) withString:@""];
                    
                    nextRange.location = seleteRange.location - last.length;
                    nextRange.length = 0;
                    
                    findEmoji = YES;
                }
            }
        }
        if (!findEmoji) {
            
            textLeft = [text stringByReplacingCharactersInRange:NSMakeRange(seleteRange.location - 1, 1) withString:@""];
            
            nextRange.location = seleteRange.location - 1;
            nextRange.length = 0;

        }
        
        [inputView setText:textLeft];
        
        inputView.selectedRange = nextRange;
        
        [self textViewDidChange:inputView];
        
        if (textLeft.length == 0) {
            [inputView resignFirstResponder];
        }
    }
}

- (void) emojSend
{
    [self  textViewShouldReturn];
}

#pragma mark - Input

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text == nil || textView.text.length > 1000)
    {
        return NO;
    }

    if ([text isEqualToString:@"\n"])
    {
        [self textViewShouldReturn];
        
        return NO;
    }
    
    if ([text length] == 0)
    {
        NSRange textRange = textView.selectedRange;
        if (textRange.location == 0 && textRange.length == [textView.text length])
        {
            return YES;
        }
        NSString *preText = [textView.text substringToIndex:textRange.location];
        NSString *sufText = [textView.text substringFromIndex:textRange.location];
        
        if ([preText length] == 0)
        {
            return NO;
        }
        
        NSInteger length = 1;
        NSString *lastChar = [preText substringWithRange:NSMakeRange([preText length] - 1, 1)];
        if ([lastChar isEqualToString:@"]"])
        {
            NSString *regex = @"\\[/[a-zA-Z0-9\\u4e00-\\u9fa5 ]+\\]";
            NSArray *array = [preText componentsMatchedByRegex:regex];
            if ([array count] > 0)
            {
                NSString *last = [array objectAtIndex:[array count] - 1];
                NSArray *emotionArray = [[NSArray alloc] initWithContentsOfFile:[FNImage emojPlist]];
                NSDictionary *name2ImageDictionary = [emotionArray objectAtIndex:1];
                if ([[name2ImageDictionary objectForKey:last] length] > 0)
                {
                    length = [last length];
                }
            }
        }
        if (length > 1)
        {
            preText = [preText substringToIndex:[preText length] - length];
            textView.text = [preText stringByAppendingString:sufText];
            [textView setSelectedRange:NSMakeRange(textRange.location - length, 0)];
            
            [self textViewDidChange:inputView];
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return YES;
}

- (void) textViewDidChange:(UITextView *)textView
{
    CGSize constraint = CGSizeMake(self.bounds.size.width - 20.0f, CGFLOAT_MAX);
    
    CGSize size = [inputView sizeThatFits:constraint];
    
    CGRect iframe = inputFrame.frame;
    
    CGRect sframe = inputScroller.frame;
    
    CGRect vframe = inputView.frame;
    
    CGRect eframe = emojView.frame;
    
    CGRect fframe = facility.frame;
    
    CGRect frame = self.frame;
    
    CGSize contentSize = inputScroller.contentSize;
    
    if (size.height > 100.0f)
    {
        scrollerHeight = 100.0f;
        
        frame.size.height = 100.0f + 44.0f - 29.0f + 216.0f;
        
        iframe.size.height = 100.0f;
        
        sframe.size.height = 100.0f;
        
        vframe.size.height = size.height;
        
        eframe.origin.y = 100.0f + 88.0f - 29.0f;
        
        fframe.origin.y = 100.0f + 44.0f - 29.0f;
        
        frame.origin.y = keyboardLocation - navoffset - scrollerHeight - 44.0f + 29.0f;
    }
    else if (size.height < 29.0f)
    {
        //TODO: test
        scrollerHeight = 29.0f;
        
        frame.size.height = 29.0f + 44.0f - 29.0f + 216.0f;
        
        iframe.size.height = 29.0f;
        
        sframe.size.height = 29.0f;
        
        vframe.size.height = 29.0f;
        
        eframe.origin.y = 29.0f + 44.0f - 29.0f;
        
        fframe.origin.y = 0;
        
        frame.origin.y = keyboardLocation - navoffset - scrollerHeight - 44.0f + 29.0f;
    }
    else
    {
        scrollerHeight = size.height;

        frame.size.height = size.height + 44.0f - 29.0f + 216.0f;

        iframe.size.height = size.height;
        
        sframe.size.height = size.height;
        
        vframe.size.height = size.height;
        
        eframe.origin.y = size.height + 59;
        
        fframe.origin.y = size.height + 15;

        frame.origin.y = keyboardLocation - navoffset - scrollerHeight - 44.0f + 29.0f;
    }
    
    inputFrame.frame = iframe;
    
    inputScroller.frame = sframe;
    
    inputView.frame = vframe;
    
    facility.frame = fframe;
    
    emojView.frame = eframe;
    
    contentSize.height = size.height;
    
    inputScroller.contentSize = contentSize;
    
    CGRect visible = CGRectMake(0.0f, contentSize.height - 1, contentSize.width, contentSize.height - 1);
    
    
    [inputScroller scrollRectToVisible:visible animated:YES];
    
    if ((floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_8_0) && size.height > 100.0f ) {
        
//        [inputView scrollRangeToVisible:NSMakeRange(inputView.text.length-1, 1)];
        [inputView scrollRangeToVisible:NSMakeRange(inputView.selectedRange.location+inputView.selectedRange.length, 1)];
    }
    
    self.frame = frame;
    
    if ([observer respondsToSelector:@selector(KeyboardFacilityChange:curve:duration:)])
    {
        [observer KeyboardFacilityChange:frame.origin.y curve:UIViewAnimationOptionCurveEaseInOut duration:0.0f];
    }
}

- (BOOL) textViewShouldReturn
{    
    if (FNTextBlock)
    {
        FNTextBlock(inputView.text);
    }
    
    inputView.text = @"";
    
    [self textViewDidChange:inputView];

    return NO;
}

#pragma mark - ImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
         
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
           
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        image  = [image copy];
        
        if (FNImageBlock)
        {
            FNImageBlock(image);
        }
    }
    else if ([type isEqualToString:(NSString *)kUTTypeVideo]||[type isEqualToString:(NSString *)kUTTypeMovie])
    {
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        
        if (FNVideoBlock)
        {
            FNVideoBlock(url,nil);
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 代理回调方法
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets
{
   
     for(ZLPhotoAssets *dict in assets)
        {
            ALAsset *asset = dict.asset;
            
            if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
            {
                ALAssetRepresentation *representation = [asset defaultRepresentation];
                CGImageRef ima=[representation fullScreenImage];
                UIImage *image =[UIImage imageWithCGImage:ima];
                
                if (FNImageBlock)
                {
                    FNImageBlock(image);
                }
            }
            else if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo])
            {
                if (FNVideoBlock)
                {
                    FNVideoBlock(nil,asset);
                }
                
            }
        }
        
}

#pragma mark - Location

- (void) getLocation
{
    
#if !TARGET_IPHONE_SIMULATOR
  
    if ([CLLocationManager locationServicesEnabled])
    {
        if (!_locationManager)
        {
            _locationManager = [[CLLocationManager alloc]init];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            {
                [_locationManager requestWhenInUseAuthorization];
            }
            _locationManager.delegate = self;

            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        }
        
        [_locationManager startUpdatingLocation];
        
        isLocated = NO;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fetion Cloud" message:@"无法定位，请检查设备" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }
#else
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:37.795313 longitude:-122.393757];
    
    if (FNLocationBlock)
    {
        FNLocationBlock(location);
    }
    
#endif
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fetion Cloud" message:@"定位失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (isLocated)
    {
        return;
    }
    
    [_locationManager stopUpdatingLocation];
    
    if (FNLocationBlock)
    {
        isLocated = YES;
        
        FNLocationBlock([locations lastObject]);
    }
}

//- (void)dealloc
//{
//    [self.voiceView removeFromSuperview];
//}
@end
