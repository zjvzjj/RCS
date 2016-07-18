//
//  FNAudioMediaItem.h
//  FetionCloudDemo
//
//  Created by feinno on 15/12/24.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "FNMediaItem.h"

typedef enum : NSUInteger {
    kAudioStatusReadyForDL,
    kAudioStatusReadyForPL,
    kAudioStatusPlaying,
} AudioStatus;

@interface FNAudioMediaItem : FNMediaItem

@property (nonatomic, assign) AudioStatus status;

@property (nonatomic, assign) double duration;

@property (nonatomic, retain) NSURL *fileURL;

@property (nonatomic, assign) BOOL isPlayed;

@property (nonatomic, copy) NSString *bitrate;

- (void)startAnimation;

- (void)stopAnimation;

@end
