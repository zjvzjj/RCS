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

#import <UIKit/UIKit.h>

@interface UIImage (FNMessages)

/**
 *  Creates and returns a new image object that is masked with the specified mask color.
 *
 *  @param maskColor The color value for the mask. This value must not be `nil`.
 *
 *  @return A new image object masked with the specified color.
 */
- (UIImage *)fn_imageMaskedWithColor:(UIColor *)maskColor;

/**
 *  @return The regular message bubble image.
 */
+ (UIImage *)fn_bubbleRegularImage;

/**
 *  @return The regular message bubble image without a tail.
 */
+ (UIImage *)fn_bubbleRegularTaillessImage;

/**
 *  @return The regular message bubble image stroked, not filled.
 */
+ (UIImage *)fn_bubbleRegularStrokedImage;

/**
 *  @return The regular message bubble image stroked, not filled and without a tail.
 */
+ (UIImage *)fn_bubbleRegularStrokedTaillessImage;

/**
 *  @return The compact message bubble image. 
 *
 *  @disscussion This is the default bubble image used by `FNMessagesBubbleImageFactory`.
 */
+ (UIImage *)fn_OutgoingbubbleCompactImage;

+ (UIImage *)fn_IncomingbubbleCompactImage;

/**
 *  @return The compact message bubble image without a tail.
 */
+ (UIImage *)fn_bubbleCompactTaillessImage;

/**
 *  @return The default input toolbar accessory image.
 */
+ (UIImage *)fn_defaultAccessoryImage;

/**
 *  @return The default typing indicator image.
 */
+ (UIImage *)fn_defaultTypingIndicatorImage;

/**
 *  @return The default play icon image.
 */
+ (UIImage *)fn_defaultPlayImage;

+ (UIImage *)fn_outgoingCancleImage;

+ (UIImage *)fn_incomingCancleImage;

+ (UIImage *)fn_sendingImage;

+ (UIImage *)fn_audioNoPlayImage;
    

@end
