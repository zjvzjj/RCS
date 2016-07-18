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

#import "FNPhotoMediaItem.h"
#import "FNMessagesMediaPlaceholderView.h"
#import "FNMessagesMediaViewBubbleImageMasker.h"
#import "FNMessagesBubbleImageFactory.h"
#import "FNMessagesBubbleImage.h"
#import "UIColor+FNMessages.h"
#import "FNMessagesCancleImage.h"
#import "ShapedImageView.h"
#import "UIView+ZLExtension.h"

@interface FNPhotoMediaItem ()

@property (strong, nonatomic) UIImageView *cachedImageView;
@property (strong, nonatomic) UIImageView *uploadView;
@property (strong, nonatomic) UIImageView *loadView;

@end


@implementation FNPhotoMediaItem

#pragma mark - Initialization

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = [UIImage imageWithCGImage:image.CGImage];
        _cachedImageView = nil;
    }
    return self;
}

- (void)dealloc
{
    _image = nil;
    _cachedImageView = nil;
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    _image = [UIImage imageWithCGImage:image.CGImage];
    _cachedImageView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedImageView = nil;
}

- (CGSize)mediaViewDisplaySize
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        return CGSizeMake(315.0f, 225.0f);
    }
    
    if (self.image.size.width == self.image.size.height)
    {
        return CGSizeMake(150.0f, 150.0f);
    }
    else if (self.image.size.width < self.image.size.height)
    {
        return CGSizeMake(100.0f, 150.0f);
    }
    else
    {
        return CGSizeMake(150.0f, 100.0f);
    }
}

#pragma mark - FNMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.image == nil) {
        return nil;
    }
    
    if (self.cachedImageView == nil)
    {
        CGSize size = [self mediaViewDisplaySize];
        
        ShapedImageView *imageView = nil;
        
        if (!self.appliesMediaViewMaskAsOutgoing)
        {
            imageView = [[ShapedImageView alloc]initWithFrame:CGRectMake(0,0,size.width,size.height) withImage:@"incomingbubble_min"];
        }
        else
        {
            imageView = [[ShapedImageView alloc]initWithFrame:CGRectMake(0,0,size.width,size.height) withImage:@"outgoingbubble_min"];
        }
        
        [imageView setImage:self.image];
        UILabel *progressLabel = [[UILabel alloc]init];
        progressLabel.frame = CGRectMake((size.width -60)*0.5, (size.height-30)*0.5, 60,30);
        progressLabel.tag = 2999;
        progressLabel.hidden = YES;
        progressLabel.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:progressLabel];
        self.cachedImageView = imageView;
    }
    
    return self.cachedImageView;
}

- (void)beginLoadViewAnimating
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.duration = 1.0f;
    animation.repeatCount = HUGE_VALF;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:(M_PI * 2)];
    animation.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    
    [_loadView.layer addAnimation:animation forKey:@"transform"];
}

- (void)removeUploadFromSuperView
{
    [_uploadView removeFromSuperview];
//    [_loadView removeFromSuperview];
//    [_loadView.layer removeAllAnimations];
}

- (void)addUploadViewToSuperView
{
    UIImageView *imgMessageView = (UIImageView *)[[self.cachedImageView subviews] lastObject];
    [imgMessageView addSubview:_uploadView];
//    [imgMessageView addSubview:_loadView];
//    [self beginLoadViewAnimating];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![super isEqual:object]) {
        return NO;
    }
    
    FNPhotoMediaItem *photoItem = (FNPhotoMediaItem *)object;
    
    return [self.image isEqual:photoItem.image];
}

- (NSUInteger)hash
{
    return self.image.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: image=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.image, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.image forKey:NSStringFromSelector(@selector(image))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    FNPhotoMediaItem *copy = [[[self class] allocWithZone:zone] initWithImage:self.image];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
