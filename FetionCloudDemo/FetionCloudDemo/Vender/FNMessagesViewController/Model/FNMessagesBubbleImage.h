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

#import "FNMessageBubbleImageDataSource.h"

/**
 *  A `FNMessagesBubbleImage` model object represents a message bubble image, and is immutable. 
 *  This is a concrete class that implements the `FNMessageBubbleImageDataSource` protocol.
 *  It contains a regular message bubble image and a highlighted message bubble image.
 *
 *  @see FNMessagesBubbleImageFactory.
 */
@interface FNMessagesBubbleImage : NSObject <FNMessageBubbleImageDataSource, NSCopying>

/**
 *  Returns the message bubble image for a regular display state.
 */
@property (strong, nonatomic, readonly) UIImage *messageBubbleImage;

/**
 *  Returns the message bubble image for a highlighted display state.
 */
@property (strong, nonatomic, readonly) UIImage *messageBubbleHighlightedImage;

/**
 *  Initializes and returns a message bubble image object having the specified regular image and highlighted image.
 *
 *  @param image            The regular message bubble image. This value must not be `nil`.
 *  @param highlightedImage The highlighted message bubble image. This value must not be `nil`.
 *
 *  @return An initialized `FNMessagesBubbleImage` object if successful, `nil` otherwise.
 *
 *  @see FNMessagesBubbleImageFactory.
 */
- (instancetype)initWithMessageBubbleImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

@end
