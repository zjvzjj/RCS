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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  A `FNMessagesMediaPlaceholderView` object represents a loading or placeholder
 *  view for media message objects whose media attachments are not yet available. 
 *  When sending or receiving media messages that must be uploaded or downloaded from the network,
 *  you may display this view temporarily until the media attachement is available.
 *  You should return an instance of this class from the `mediaPlaceholderView` method in
 *  the `FNMessageMediaData` protocol.
 *
 *  @see FNMessageMediaData.
 */
@interface FNMessagesMediaPlaceholderView : UIView

/**
 *  Returns the activity indicator view for this placeholder view, or `nil` if it does not exist.指示器
 */
@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityIndicatorView;

/**
 *  Returns the image view for this placeholder view, or `nil` if it does not exist.要显示的图片
 */
@property (nonatomic, weak, readonly) UIImageView *imageView;

/**
 *  Creates a media placeholder view object with a light gray background and
 *  a centered activity indicator.指示器类型的占位view
 *
 *  @discussion When initializing a `FNMessagesMediaPlaceholderView` with this method,
 *  its imageView property will be nil.
 *
 *  @return An initialized `FNMessagesMediaPlaceholderView` object if successful, `nil` otherwise.
 */
+ (instancetype)viewWithActivityIndicator;

/**
 *  Creates a media placeholder view object with a light gray background and
 *  a centered paperclip attachment icon.默认图片类型占位view
 *
 *  @discussion When initializing a `FNMessagesMediaPlaceholderView` with this method,
 *  its activityIndicatorView property will be nil.
 *
 *  @return An initialized `FNMessagesMediaPlaceholderView` object if successful, `nil` otherwise.
 */
+ (instancetype)viewWithAttachmentIcon;

/**
 *  Creates a media placeholder view having the given frame, backgroundColor, and activityIndicatorView.
 *
 *  @param frame                 A rectangle defining the frame of the view. This value must be a non-zero, non-null rectangle.
 *  @param backgroundColor       The background color of the view. This value must not be `nil`.
 *  @param activityIndicatorView An initialized activity indicator to be added and centered in the view. This value must not be `nil`.
 *
 *  @return An initialized `FNMessagesMediaPlaceholderView` object if successful, `nil` otherwise.
 */
- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
        activityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView;

/**
 *  Creates a media placeholder view having the given frame, backgroundColor, and imageView.
 *
 *  @param frame           A rectangle defining the frame of the view. This value must be a non-zero, non-null rectangle.
 *  @param backgroundColor The background color of the view. This value must not be `nil`.
 *  @param imageView       An initialized image view to be added and centered in the view. This value must not be `nil`.
 *
 *  @return An initialized `FNMessagesMediaPlaceholderView` object if successful, `nil` otherwise.
 */
- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)backgroundColor
                    imageView:(UIImageView *)imageView;

@end
