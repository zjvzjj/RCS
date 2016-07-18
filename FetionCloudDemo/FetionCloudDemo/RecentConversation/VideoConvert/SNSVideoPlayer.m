//
//  SNSVideoPlayer.m
//  Circles
//
//  Created by ouyangyifeng on 14/11/3.
//  Copyright (c) 2014年 FeinnoCommunicationTech. All rights reserved.
//

#import "SNSVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface SNSVideoPlayer()

@property (nonatomic, retain) AVPlayer *player;

@end

@implementation SNSVideoPlayer

- (id)initWithFrame:(CGRect)frame videoPath:(NSString*)videoPath
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (![videoPath rangeOfString:@".mp4"].length)
            videoPath = [videoPath stringByAppendingString:@".mp4"];
        self.videoPath = videoPath;
        
        [self initLayer];
    }
    return self;
}

- (void)initLayer
{
    if (self.playerLayer)
        [self.playerLayer removeFromSuperlayer];
    
    CGSize size = self.frame.size;
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:self.videoPath] options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player = player;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    [self.layer addSublayer:playerLayer];
    self.playerLayer = playerLayer;
    CGFloat height = size.width * [UIScreen mainScreen].scale;
    playerLayer.frame = CGRectMake(0, -(height - size.height) / 2, size.width, height);
    //playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(end:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
}

- (void)play
{
    [self initLayer];
    [self.player play];
}

- (void)end:(NSNotification *)notification
{
    [self stop];
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoPlayerDidFinishPlaying:time:)])
        [self.delegate videoPlayerDidFinishPlaying:self time:[self time]];
}

- (void)stop
{
    [self.player pause];
    [self.player seekToTime:kCMTimeZero];
}

- (double)time
{
    CMTime time = self.player.currentItem.duration;
    return time.value * 1.0 / time.timescale;
}

- (double)curTime
{
    CMTime time = self.player.currentItem.currentTime;
    return time.value * 1.0 / time.timescale;
}

- (void)clear
{
    [self stop];
}

@end