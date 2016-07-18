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

@class FNMessagesBubbleImageFactory;

/**
 *  An instance of `FNMessagesMediaViewBubbleImageMasker` is an object that masks
 *  media views for a `FNMessageMediaData` object. Given a view, it will mask the view
 *  with a bubble image for an outgoing or incoming media view.
 *
 *  @see FNMessageMediaData.
 *  @see FNMessagesBubbleImageFactory.
 *  @see FNMessagesBubbleImage.
 */
@interface FNMessagesMediaViewBubbleImageMasker : NSObject

/**
 *  Returns the bubble image factory that the masker uses to mask media views.
 */
@property (strong, nonatomic, readonly) FNMessagesBubbleImageFactory *bubbleImageFactory;

/**
 *  Creates and returns a new instance of `FNMessagesMediaViewBubbleImageMasker`
 *  that uses a default instance of `FNMessagesBubbleImageFactory`. The masker uses the `FNMessagesBubbleImage`
 *  objects returned by the factory to mask media views.
 *
 *  @return An initialized `FNMessagesMediaViewBubbleImageMasker` object if created successfully, `nil` otherwise.
 *
 *  @see FNMessagesBubbleImageFactory.
 *  @see FNMessagesBubbleImage.
 */
- (instancetype)init;

/**
 *  Creates and returns a new instance of `FNMessagesMediaViewBubbleImageMasker`
 *  having the specified bubbleImageFactory. The masker uses the `FNMessagesBubbleImage`
 *  objects returned by the factory to mask media views.
 *
 *  @param bubbleImageFactory An initialized `FNMessagesBubbleImageFactory` object to use for masking media views. This value must not be `nil`.
 *
 *  @return An initialized `FNMessagesMediaViewBubbleImageMasker` object if created successfully, `nil` otherwise.
 *
 *  @see FNMessagesBubbleImageFactory.
 *  @see FNMessagesBubbleImage.
 */
- (instancetype)initWithBubbleImageFactory:(FNMessagesBubbleImageFactory *)bubbleImageFactory;

/**
 *  Applies an outgoing bubble image mask to the specified mediaView.
 *
 *  @param mediaView The media view to mask.
 */
- (void)applyOutgoingBubbleImageMaskToMediaView:(UIView *)mediaView;

/**
 *  Applies an incoming bubble image mask to the specified mediaView.
 *
 *  @param mediaView The media view to mask.
 */
- (void)applyIncomingBubbleImageMaskToMediaView:(UIView *)mediaView;

/**
 *  A convenience method for applying a bubble image mask to the specified mediaView.
 *  This method uses the default instance of `FNMessagesBubbleImageFactory`.
 *
 *  @param mediaView  The media view to mask.
 *  @param isOutgoing A boolean value specifiying whether or not the mask should be for an outgoing or incoming view.
 *  Specify `YES` for outgoing and `NO` for incoming.
 */
+ (void)applyBubbleImageMaskToMediaView:(UIView *)mediaView isOutgoing:(BOOL)isOutgoing;

@end
