//  
//  MessageFacilitiesView.h
//  Fetion
//
//  Created by songhaowen on 8/18/15.
//  Copyright (c) 2015 xinrui.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import "ZLPhoto.h"

@protocol KeyboardObserving <NSObject>
@optional
- (void) KeyboardFacilityChange:(CGFloat)yorigin curve:(UIViewAnimationOptions)ops duration:(double)duration;
- (void) sendTextMessage:(NSString *)textString;
- (void) sendAudio;
- (void) sendEmoj;
- (void) sendPhoto;
- (void) sendCamera;
- (void) sendVideo;
- (void) sendLocation;
- (void) showTips:(UIView *)tipsView;
- (void) hideTips:(UIView *)tipsView;

@end

@interface ConversationFacilitiesView : UIView

@property (nonatomic, assign) CGFloat navoffset;

@property (nonatomic, assign) id <KeyboardObserving> observer;

- (BOOL) isShow;

- (void) resign;

- (void) clearContent;

- (void) removeObserverForkeyBorad;

- (void) addObserverForKeyBoard;

- (void) setText:(void (^) (NSString *text))block;

- (void) setImage:(void (^) (UIImage *image))block;

- (void) setLocation:(void (^) (CLLocation *location))block;

- (void) setVideo:(void (^) (NSURL *url,ALAsset *asset))block;

- (void) setAudio:(void (^) (NSString *url))block;

@end
