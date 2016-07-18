//
//  SNSVideoPlayer.h
//  Circles
//
//  Created by ouyangyifeng on 14/11/3.
//  Copyright (c) 2014年 FeinnoCommunicationTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@class SNSVideoPlayer;

@protocol SNSVideoPlayerDelegate <NSObject>

@optional

- (void)videoPlayerDidFinishPlaying:(SNSVideoPlayer *)player time:(float)time;

@end

@interface SNSVideoPlayer : UIView

@property (nonatomic, retain) NSString *videoPath;
@property (nonatomic, retain) AVPlayerLayer *playerLayer;

@property (assign, nonatomic) id<SNSVideoPlayerDelegate> delegate;

- (id)initWithFrame:(CGRect)frame videoPath:(NSString*)videoPath;
- (void)play;
- (void)stop;
- (double)time;
- (double)curTime;
- (void)clear;

@end