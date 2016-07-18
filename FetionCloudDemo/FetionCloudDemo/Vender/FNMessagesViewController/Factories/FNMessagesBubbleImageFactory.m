//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/FNMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/FNMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "FNMessagesBubbleImageFactory.h"

#import "UIImage+FNMessages.h"
#import "UIColor+FNMessages.h"
#import "FNImage.h"


@interface FNMessagesBubbleImageFactory ()

@property (strong, nonatomic, readonly) UIImage *bubbleIncomingImage;
@property (strong, nonatomic, readonly) UIImage *bubbleOutgoingImage;

@property (strong, nonatomic, readonly) UIImage *cancleOutgoingImage;
@property (strong, nonatomic, readonly) UIImage *cancleIncomingImage;

@property (strong, nonatomic, readonly) UIImage *sendingImage;

@property (strong, nonatomic, readonly) UIImage *audioNotPlayImage;

@property (assign, nonatomic, readonly) UIEdgeInsets capInsets;

- (UIEdgeInsets)fn_centerPointEdgeInsetsForImageSize:(CGSize)bubbleImageSize;

- (FNMessagesBubbleImage *)fn_messagesBubbleImageWithColor:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming;

- (FNMessagesCancleImage *)fn_messagesCancleImageWithFlippedForIncoming:(BOOL)flippedForIncoming;

- (UIImage *)fn_horizontallyFlippedImageFromImage:(UIImage *)image;

- (UIImage *)fn_stretchableImageFromImage:(UIImage *)image withCapInsets:(UIEdgeInsets)capInsets;

@end



@implementation FNMessagesBubbleImageFactory

#pragma mark - Initialization

- (instancetype)initWithOutgoingBubbleImage:(UIImage *)bubbleOutgoingImage incomingImage:(UIImage *)bubbleIncomingImage capInsets:(UIEdgeInsets)capInsets
{
	NSParameterAssert(bubbleOutgoingImage != nil);
    NSParameterAssert(bubbleIncomingImage != nil);
    
	self = [super init];
	if (self) {
		_bubbleOutgoingImage = bubbleOutgoingImage;
        _bubbleIncomingImage = bubbleIncomingImage;
        
        _cancleOutgoingImage = [UIImage fn_outgoingCancleImage];
        _cancleIncomingImage = [UIImage fn_incomingCancleImage];
        
        _sendingImage = [UIImage fn_sendingImage];
        
        _audioNotPlayImage = [UIImage fn_audioNoPlayImage];
        
        if (UIEdgeInsetsEqualToEdgeInsets(capInsets, UIEdgeInsetsZero)) {
            _capInsets = [self fn_centerPointEdgeInsetsForImageSize:_bubbleOutgoingImage.size];
        }
        else {
            _capInsets = capInsets;
        }
	}
	return self;
}

- (instancetype)init
{
    return [self initWithOutgoingBubbleImage:[UIImage fn_OutgoingbubbleCompactImage] incomingImage:[UIImage fn_IncomingbubbleCompactImage] capInsets:UIEdgeInsetsZero];
}

- (void)dealloc
{
    _bubbleOutgoingImage = nil;
    _bubbleIncomingImage = nil;
    _cancleIncomingImage = nil;
    _cancleOutgoingImage = nil;
}

#pragma mark - Public

- (FNMessagesBubbleImage *)outgoingMessagesBubbleImageWithColor:(UIColor *)color
{
    return [self fn_messagesBubbleImageWithColor:color flippedForIncoming:NO];
}

- (FNMessagesBubbleImage *)incomingMessagesBubbleImageWithColor:(UIColor *)color
{
    return [self fn_messagesBubbleImageWithColor:color flippedForIncoming:YES];
}

- (FNMessagesBubbleImage *)outgoingMessagesBubbleImage
{
    UIImage *image = [FNImage imageWithName:@"outgoingbubble_min"];
    
    UIEdgeInsets insets = UIEdgeInsetsMake((image.size.height/2.0)-1, (image.size.width/2.0)-1, image.size.height/2.0, image.size.width/2.0);

    UIImage *bubble = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return [[FNMessagesBubbleImage alloc] initWithMessageBubbleImage:bubble highlightedImage:bubble];

}

- (FNMessagesBubbleImage *)incomingMessagesBubbleImage
{
    UIImage *image = [FNImage imageWithName:@"incomingbubble_min"];
    
    UIEdgeInsets insets = UIEdgeInsetsMake((image.size.height/2.0)-1, (image.size.width/2.0)-1, image.size.height/2.0, image.size.width/2.0);
    
    UIImage *bubble = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return [[FNMessagesBubbleImage alloc] initWithMessageBubbleImage:bubble highlightedImage:bubble];
}

- (FNMessagesCancleImage *)outgoingMessageCancleImage
{
    return [self fn_messagesCancleImageWithFlippedForIncoming:NO];
}

- (FNMessagesCancleImage *)incomingMessageCancleImage
{
    return [self fn_messagesCancleImageWithFlippedForIncoming:YES];
}

- (FNMessagesCancleImage *) sendingMessageImage
{
    return [self fn_sendingMessageImage];
}

- (FNMessagesCancleImage *)audioMessageNotPlayImages
{
    return [self fn_messagesAudioNotPlayImage];
}

#pragma mark - Private

- (UIEdgeInsets)fn_centerPointEdgeInsetsForImageSize:(CGSize)bubbleImageSize
{
    // make image stretchable from center point
    CGPoint center = CGPointMake(bubbleImageSize.width / 2.0f, bubbleImageSize.height / 2.0f);
    return UIEdgeInsetsMake(0, center.x, 0, center.x);
}

- (FNMessagesBubbleImage *)fn_messagesBubbleImageWithColor:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming
{
    NSParameterAssert(color != nil);
    
    UIImage *bubbleImage = nil;
    UIImage *normalBubble = nil;
    UIImage *highlightedBubble = nil;
    
    if (flippedForIncoming)
    {
//        bubbleImage = self.bubbleIncomingImage;
        normalBubble = self.bubbleIncomingImage;
        highlightedBubble = self.bubbleIncomingImage;
//        [UIImage imageNamed:@"FNMessagesAssets.bundle/Images/incomingbubble_min_highlight"];
    }
    else
    {
//        bubbleImage = self.bubbleOutgoingImage;
        normalBubble = self.bubbleOutgoingImage;
//        [bubbleImage fn_imageMaskedWithColor:color];
        highlightedBubble = self.bubbleOutgoingImage;
//        [UIImage imageNamed:@"FNMessagesAssets.bundle/Images/outgoingbubble_min_highlight"];
//        [bubbleImage fn_imageMaskedWithColor:[color fn_colorByDarkeningColorWithValue:0.12f]];
    }
    
    normalBubble = [self fn_stretchableImageFromImage:normalBubble withCapInsets:self.capInsets];
    highlightedBubble = [self fn_stretchableImageFromImage:highlightedBubble withCapInsets:self.capInsets];
    
    return [[FNMessagesBubbleImage alloc] initWithMessageBubbleImage:normalBubble highlightedImage:highlightedBubble];
}

- (FNMessagesCancleImage *) fn_sendingMessageImage
{
    UIImage *normalCancle = self.sendingImage;
    UIImage *highlightedCancle = self.sendingImage;
    return [[FNMessagesCancleImage alloc] initWithMessageCancleImage:normalCancle highlightedImage:highlightedCancle];
}

- (FNMessagesCancleImage *)fn_messagesAudioNotPlayImage
{
    UIImage *normalCancle = self.audioNotPlayImage;
    UIImage *highlightedCancle = self.audioNotPlayImage;
    return [[FNMessagesCancleImage alloc] initWithMessageCancleImage:normalCancle highlightedImage:highlightedCancle];
}

- (FNMessagesCancleImage *)fn_messagesCancleImageWithFlippedForIncoming:(BOOL)flippedForIncoming
{
    UIImage *normalCancle = nil;
    UIImage *highlightedCancle = nil;
    if (flippedForIncoming)
    {
        normalCancle = self.cancleIncomingImage;
        highlightedCancle = self.cancleIncomingImage;
    }
    else
    {
        normalCancle = self.cancleOutgoingImage;
        highlightedCancle = self.cancleOutgoingImage;
    }
    
    return [[FNMessagesCancleImage alloc] initWithMessageCancleImage:normalCancle highlightedImage:highlightedCancle];
}

- (UIImage *)fn_horizontallyFlippedImageFromImage:(UIImage *)image
{
    return [UIImage imageWithCGImage:image.CGImage
                               scale:image.scale
                         orientation:UIImageOrientationUpMirrored];
}

- (UIImage *)fn_stretchableImageFromImage:(UIImage *)image withCapInsets:(UIEdgeInsets)capInsets
{
    return [[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] stretchableImageWithLeftCapWidth:27 topCapHeight:18];
}

@end
