//
//  SNSVideoRecorder.h
//  Circles
//
//  Created by ouyangyifeng on 14/10/30.
//  Copyright (c) 2014年 FeinnoCommunicationTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SNSVideoDevicePosition)
{
    SNSVideoDevicePositionUnspecified         = 0,
    SNSVideoDevicePositionBack                = 1,
    SNSVideoDevicePositionFront               = 2
} NS_AVAILABLE(10_7, 4_0);

@interface SNSVideoRecorder : UIView

@property (nonatomic, retain) NSString *imagePath;
@property (nonatomic, retain) NSString *videoPath;
@property (nonatomic, assign) BOOL isRecord;

- (id)initWithFrame:(CGRect)frame videoPath:(NSString*)videoPath;
- (void)start;
- (void)stop;
- (void)record;
- (void)changeCamera:(SNSVideoDevicePosition)position;
- (void)setTorch:(BOOL)torch;
- (double)size;
- (void)clear;

@end