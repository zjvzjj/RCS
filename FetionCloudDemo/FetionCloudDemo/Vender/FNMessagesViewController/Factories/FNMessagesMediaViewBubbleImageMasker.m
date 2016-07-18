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

#import "FNMessagesMediaViewBubbleImageMasker.h"

#import "FNMessagesBubbleImageFactory.h"


@interface FNMessagesMediaViewBubbleImageMasker ()

- (void)fn_maskView:(UIView *)view withImage:(UIImage *)image;

@end


@implementation FNMessagesMediaViewBubbleImageMasker

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithBubbleImageFactory:[[FNMessagesBubbleImageFactory alloc] init]];
}

- (instancetype)initWithBubbleImageFactory:(FNMessagesBubbleImageFactory *)bubbleImageFactory
{
    NSParameterAssert(bubbleImageFactory != nil);
    
    self = [super init];
    if (self) {
        _bubbleImageFactory = bubbleImageFactory;
    }
    return self;
}

#pragma mark - View masking

- (void)applyOutgoingBubbleImageMaskToMediaView:(UIView *)mediaView
{
    FNMessagesBubbleImage *bubbleImageData = [self.bubbleImageFactory outgoingMessagesBubbleImageWithColor:[UIColor clearColor]];
    [self fn_maskView:mediaView withImage:[bubbleImageData messageBubbleImage]];
}

- (void)applyIncomingBubbleImageMaskToMediaView:(UIView *)mediaView
{
    FNMessagesBubbleImage *bubbleImageData = [self.bubbleImageFactory incomingMessagesBubbleImageWithColor:[UIColor clearColor]];
    [self fn_IncomingmaskView:mediaView withImage:[bubbleImageData messageBubbleImage]];
}

+ (void)applyBubbleImageMaskToMediaView:(UIView *)mediaView isOutgoing:(BOOL)isOutgoing
{
    FNMessagesMediaViewBubbleImageMasker *masker = [[FNMessagesMediaViewBubbleImageMasker alloc] init];
    if (isOutgoing) {
        [masker applyOutgoingBubbleImageMaskToMediaView:mediaView];
    }
    else {
        [masker applyIncomingBubbleImageMaskToMediaView:mediaView];
    }
}

#pragma mark - Private
//将照片绘制成圆角（为什么不是 消息那种类型的？）
- (void)fn_maskView:(UIView *)view withImage:(UIImage *)image
{
    NSParameterAssert(view != nil);
    NSParameterAssert(image != nil);
    CGRect maskRect = CGRectInset(view.frame, 2.0f, 2.0f);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:maskRect byRoundingCorners: UIRectCornerAllCorners cornerRadii:CGSizeMake(16, 16)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = maskRect;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void)fn_IncomingmaskView:(UIView *)view withImage:(UIImage *)image
{
    NSParameterAssert(view != nil);
    NSParameterAssert(image != nil);
    CGRect maskRect = CGRectInset(view.frame, 5.0f, 2.0f);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:maskRect byRoundingCorners: UIRectCornerAllCorners cornerRadii:CGSizeMake(16, 16)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = maskRect;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

@end
