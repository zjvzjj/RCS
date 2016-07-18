//
//  FNAudioMediaItem.m
//  FetionCloudDemo
//
//  Created by feinno on 15/12/24.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "FNAudioMediaItem.h"

#import "FNMessagesMediaPlaceholderView.h"
#import "FNMessagesMediaViewBubbleImageMasker.h"
#import "FNMessagesBubbleImage.h"
#import "FNMessagesBubbleImageFactory.h"
#import "UIColor+FNMessages.h"
#import "UIImage+FNMessages.h"

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kAudioMaxWidth (iPhone6_Plus ? 300.0f : (iPhone6 ? 250.0f : 200.0f))
#define kAudioMinWidth 60.0f

@interface FNAudioMediaItem ()
{
    UIView *_audioView;
    UILabel *_timeLabel;
    UIImageView *_voicePlayView;
}

@end

@implementation FNAudioMediaItem

@synthesize status;
@synthesize duration;
@synthesize fileURL;
@synthesize bitrate;

- (id) initWithMaskAsOutgoing:(BOOL)maskAsOutgoing
{
    self = [super initWithMaskAsOutgoing:maskAsOutgoing];
    
    if (self)
    {
        self.isPlayed = NO;
        self.appliesMediaViewMaskAsOutgoing = maskAsOutgoing;
        _audioView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 5.0f, 60.0f, 36.0f)];
        _audioView.autoresizesSubviews = YES;
        if (maskAsOutgoing == YES)
        {
            FNMessagesBubbleImageFactory *bubbleFactory = [[FNMessagesBubbleImageFactory alloc] init];
            FNMessagesBubbleImage *outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor fn_messageBubbleLightGrayColor]];
            
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.frame = CGRectMake(0, 0, _audioView.frame.size.width, _audioView.frame.size.height);
            imgView.image = outgoingBubbleImageData.messageBubbleImage;
            imgView.highlightedImage = outgoingBubbleImageData.messageBubbleHighlightedImage;
            imgView.autoresizesSubviews = YES;
            imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_audioView addSubview:imgView];
            
            _timeLabel = [[UILabel alloc] init];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.textColor = [UIColor colorWithRed:(102.0 / 255.0) green:(102.0 / 255.0) blue:(102.0 / 255.0) alpha:1.0];
            _timeLabel.frame = CGRectMake(0, 0, 40, imgView.frame.size.height);
            _timeLabel.textAlignment = NSTextAlignmentLeft;
            _timeLabel.font = [UIFont systemFontOfSize:12];
            _timeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
            [imgView addSubview:_timeLabel];
            
            _voicePlayView = [[UIImageView alloc] init];
            _voicePlayView.frame = CGRectMake(imgView.frame.size.width - 18 -8, (imgView.frame.size.height - 12) / 2.0, 8, 12);
            _voicePlayView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            _voicePlayView.image = [FNImage imageWithName:@"voice_bubble_out"];
            UIImage *image0 = [UIImage imageNamed:@"chatroom_voice_play1"];
            UIImage *image1 = [UIImage imageNamed:@"chatroom_voice_play2"];
            UIImage *image2 = [UIImage imageNamed:@"chatroom_voice_play3"];
            _voicePlayView.animationImages = @[image0,image1,image2];
            _voicePlayView.animationDuration = 1 ;
            
            [imgView addSubview:_voicePlayView];
        }
        else
        {
            FNMessagesBubbleImageFactory *bubbleFactory = [[FNMessagesBubbleImageFactory alloc] init];
            FNMessagesBubbleImage *ingoingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor fn_messageBubbleLightGrayColor]];
            
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.frame = CGRectMake(0, 0, _audioView.frame.size.width, _audioView.frame.size.height);
            imgView.image = ingoingBubbleImageData.messageBubbleImage;
            imgView.highlightedImage = ingoingBubbleImageData.messageBubbleHighlightedImage;
            imgView.autoresizesSubviews = YES;
            imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_audioView addSubview:imgView];
            
            _timeLabel = [[UILabel alloc] init];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.textColor = [UIColor colorWithRed:(102.0 / 255.0) green:(102.0 / 255.0) blue:(102.0 / 255.0) alpha:1.0];
            _timeLabel.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height);
            _timeLabel.textAlignment = NSTextAlignmentRight;
            _timeLabel.font = [UIFont systemFontOfSize:12];
            _timeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            [imgView addSubview:_timeLabel];
            
            _voicePlayView = [[UIImageView alloc] init];
            _voicePlayView.frame = CGRectMake(18, (imgView.frame.size.height - 12) / 2.0, 8, 12);
            _voicePlayView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
            _voicePlayView.image = [FNImage imageWithName:@"voice_bubble_in"];
            UIImage *image0 = [UIImage imageNamed:@"chatroom_voice_play_men1"];
            UIImage *image1 = [UIImage imageNamed:@"chatroom_voice_play_men2"];
            UIImage *image2 = [UIImage imageNamed:@"chatroom_voice_play_men3"];
            _voicePlayView.animationImages = @[image0,image1,image2];
            _voicePlayView.animationDuration = 1 ;
            [imgView addSubview:_voicePlayView];
        }
    }
    
    return self;
}

#pragma mark - FNMessageMediaData protocol

- (UIView *)mediaView
{
    if (fileURL)
    {
        return _audioView;
    }
    else
    {
        return nil;
    }
}

- (CGSize)mediaViewDisplaySize
{
    CGSize size = CGSizeMake(kAudioMinWidth + ((kAudioMaxWidth - kAudioMinWidth) / 59.0) * duration, 36.0);
    if (size.width > kAudioMaxWidth)
    {
        size.width = kAudioMaxWidth;
    }
    return size;
}

- (UIView *)mediaPlaceholderView
{
    return _audioView;
}

#pragma mark - NSObject

- (BOOL) isEqual:(id)object
{
    if ([super isEqual:object])
    {
        FNAudioMediaItem *audioItem = (FNAudioMediaItem *)object;
        
        return [fileURL isEqual:audioItem.fileURL];
    }
    else
    {
        return NO;
    }
}

- (NSUInteger) hash
{
    return self.fileURL.hash;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"<%@: fileURL=%@, status=%@, appliesMediaViewMaskAsOutgoing=%@>", [self class], fileURL, @(status), @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        status = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(status))];
        
        fileURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(fileURL))];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInteger:status forKey:NSStringFromSelector(@selector(status))];
    
    [aCoder encodeObject:fileURL forKey:NSStringFromSelector(@selector(fileURL))];
}

- (void)setDuration:(double)aduration
{
    duration = aduration;
    _timeLabel.frame = CGRectMake(15, 0, 100, _timeLabel.frame.size.height);
    
    _audioView.frame = CGRectMake(_audioView.frame.origin.x, _audioView.frame.origin.y, kAudioMinWidth + (((kAudioMaxWidth - kAudioMinWidth) / 59.0) * duration), _audioView.frame.size.height);
    
    if (self.appliesMediaViewMaskAsOutgoing)
    {
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.frame = CGRectMake(_voicePlayView.frame.origin.x + _voicePlayView.frame.size.width, 0, _audioView.frame.size.width - (_voicePlayView.frame.origin.x + _voicePlayView.frame.size.width) - 10, _audioView.frame.size.height);
    }
    
    _timeLabel.text = [NSString stringWithFormat:@"%d\"",(int)duration];
}

#pragma mark - NSCopying

- (instancetype) copyWithZone:(NSZone *)zone
{
    FNAudioMediaItem *item = [[FNAudioMediaItem alloc] initWithMaskAsOutgoing:self.appliesMediaViewMaskAsOutgoing];
    item.status = self.status;
    item.fileURL = self.fileURL;
    
    return item;
}

#pragma mark
#pragma mark -- Animation

- (void)startAnimation
{
    [_voicePlayView startAnimating];
}

- (void)stopAnimation
{
    if (_voicePlayView.isAnimating == YES)
    {
        [_voicePlayView stopAnimating];
    }
}

@end
