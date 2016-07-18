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

#import "FNMessagesBubbleImage.h"
#import "FNMessagesCancleImage.h"

/**
 *  `FNMessagesBubbleImageFactory` is a factory that provides a means for creating and styling 
 *  `FNMessagesBubbleImage` objects to be displayed in a `FNMessagesCollectionViewCell` of a `FNMessagesCollectionView`.
 */
@interface FNMessagesBubbleImageFactory : NSObject

/**
 *  Creates and returns a new instance of `FNMessagesBubbleImageFactory` that uses the
 *  default bubble image assets and cap insets.
 *
 *  @return An initialized `FNMessagesBubbleImageFactory` object if created successfully, `nil` otherwise.
 */
- (instancetype)init;

/**
 *  Creates and returns a new instance of `FNMessagesBubbleImageFactory` having the specified
 *  bubbleImage and capInsets. These values are used internally in the factory to produce
 *  `FNMessagesBubbleImage` objects.
 *
 *  @param bubbleImage A template bubble image from which all images will be generated.
 *  The image should represent the *outgoing* message bubble image, which will be flipped
 *  horizontally for generating the corresponding *incoming* message bubble images. This value must not be `nil`.
 *
 *  @param capInsets   The values to use for the cap insets that define the unstretchable regions of the image.
 *  Specify `UIEdgeInsetsZero` to have the factory create insets that allow the image to stretch from its center point.
 *
 *  @return An initialized `FNMessagesBubbleImageFactory` object if created successfully, `nil` otherwise.
 */
- (instancetype)initWithOutgoingBubbleImage:(UIImage *)bubbleOutgoingImage incomingImage:(UIImage *)bubbleIncomingImage capInsets:(UIEdgeInsets)capInsets;

/**
 *  Creates and returns a `FNMessagesBubbleImage` object with the specified color for *outgoing* message image bubbles.
 *  The `messageBubbleImage` property of the `FNMessagesBubbleImage` is configured with a flat bubble image, masked to the given color.
 *  The `messageBubbleHighlightedImage` property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be `nil`.
 *
 *  @return An initialized `FNMessagesBubbleImage` object if created successfully, `nil` otherwise.
 */
- (FNMessagesBubbleImage *)outgoingMessagesBubbleImageWithColor:(UIColor *)color;

/**
 *  Creates and returns a `FNMessagesBubbleImage` object with the specified color for *incoming* message image bubbles.
 *  The `messageBubbleImage` property of the `FNMessagesBubbleImage` is configured with a flat bubble image, masked to the given color.
 *  The `messageBubbleHighlightedImage` property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be `nil`.
 *
 *  @return An initialized `FNMessagesBubbleImage` object if created successfully, `nil` otherwise.
 */
- (FNMessagesBubbleImage *)incomingMessagesBubbleImageWithColor:(UIColor *)color;

- (FNMessagesBubbleImage *)outgoingMessagesBubbleImage;

- (FNMessagesBubbleImage *)incomingMessagesBubbleImage;

- (FNMessagesCancleImage *)outgoingMessageCancleImage;

- (FNMessagesCancleImage *)incomingMessageCancleImage;

- (FNMessagesCancleImage *) sendingMessageImage;

- (FNMessagesCancleImage *)audioMessageNotPlayImages;

@end
