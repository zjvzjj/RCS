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

#import "FNMessagesMediaPlaceholderView.h"

#import "UIColor+FNMessages.h"
#import "UIImage+FNMessages.h"


@implementation FNMessagesMediaPlaceholderView

#pragma mark - Init

+ (instancetype)viewWithActivityIndicator
{
    UIColor *lightGrayColor = [UIColor fn_messageBubbleLightGrayColor];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.color = [lightGrayColor fn_colorByDarkeningColorWithValue:0.4f];
    
    FNMessagesMediaPlaceholderView *view = [[FNMessagesMediaPlaceholderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 120.0f)
                                                                                   backgroundColor:lightGrayColor
                                                                             activityIndicatorView:spinner];
    return view;
}

+ (instancetype)viewWithAttachmentIcon
{
    UIColor *lightGrayColor = [UIColor fn_messageBubbleLightGrayColor];
    UIImage *paperclip = [[UIImage fn_defaultAccessoryImage] fn_imageMaskedWithColor:[lightGrayColor fn_colorByDarkeningColorWithValue:0.4f]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:paperclip];
    
    FNMessagesMediaPlaceholderView *view =[[FNMessagesMediaPlaceholderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 120.0f)
                                                                                  backgroundColor:lightGrayColor
                                                                                        imageView:imageView];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
        activityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView
{
    NSParameterAssert(activityIndicatorView != nil);
    
    self = [self initWithFrame:frame backgroundColor:backgroundColor];
    if (self) {
        [self addSubview:activityIndicatorView];
        _activityIndicatorView = activityIndicatorView;
        _activityIndicatorView.center = self.center;
        [_activityIndicatorView startAnimating];
        _imageView = nil;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                    imageView:(UIImageView *)imageView
{
    NSParameterAssert(imageView != nil);
    
    self = [self initWithFrame:frame backgroundColor:backgroundColor];
    if (self) {
        [self addSubview:imageView];
        _imageView = imageView;
        _imageView.center = self.center;
        _activityIndicatorView = nil;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    NSParameterAssert(!CGRectEqualToRect(frame, CGRectNull));
    NSParameterAssert(!CGRectEqualToRect(frame, CGRectZero));
    NSParameterAssert(backgroundColor != nil);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = backgroundColor;
        self.userInteractionEnabled = NO;
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.activityIndicatorView) {
        self.activityIndicatorView.center = self.center;
    }
    else if (self.imageView) {
        self.imageView.center = self.center;
    }
}

@end
