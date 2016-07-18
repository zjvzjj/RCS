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

#import "FNMessagesCollectionViewFlowLayout.h"
#import "FNMessagesCollectionViewDelegateFlowLayout.h"
#import "FNMessagesCollectionViewDataSource.h"
#import "FNMessagesCollectionViewCell.h"

@class FNMessagesTypingIndicatorFooterView;
@class FNMessagesLoadEarlierHeaderView;


/**
 *  The `FNMessagesCollectionView` class manages an ordered collection of message data items and presents
 *  them using a specialized layout for messages.
 */
@interface FNMessagesCollectionView : UICollectionView <FNMessagesCollectionViewCellDelegate>

/**
 *  The object that provides the data for the collection view.
 *  The data source must adopt the `FNMessagesCollectionViewDataSource` protocol.
 */
@property (weak, nonatomic) id<FNMessagesCollectionViewDataSource> dataSource;

/**
 *  The object that acts as the delegate of the collection view. 
 *  The delegate must adpot the `FNMessagesCollectionViewDelegateFlowLayout` protocol.
 */
@property (weak, nonatomic) id<FNMessagesCollectionViewDelegateFlowLayout> delegate;

/**
 *  The layout used to organize the collection view’s items.
 */
@property (strong, nonatomic) FNMessagesCollectionViewFlowLayout *collectionViewLayout;

/**
 *  Specifies whether the typing indicator displays on the left or right side of the collection view
 *  when shown. That is, whether it displays for an "incoming" or "outgoing" message.
 *  The default value is `YES`, meaning that the typing indicator will display on the left side of the
 *  collection view for incoming messages.
 *
 *  @discussion If your `FNMessagesViewController` subclass displays messages for right-to-left
 *  languages, such as Arabic, set this property to `NO`.
 *
 */
@property (assign, nonatomic) BOOL typingIndicatorDisplaysOnLeft;

/**
 *  The color of the typing indicator message bubble. The default value is a light gray color.
 */
@property (strong, nonatomic) UIColor *typingIndicatorMessageBubbleColor;

/**
 *  The color of the typing indicator ellipsis. The default value is a dark gray color.
 */
@property (strong, nonatomic) UIColor *typingIndicatorEllipsisColor;

/**
 *  The color of the text in the load earlier messages header. The default value is a bright blue color.
 */
@property (strong, nonatomic) UIColor *loadEarlierMessagesHeaderTextColor;

/**
 *  Returns a `FNMessagesTypingIndicatorFooterView` object for the specified index path
 *  that is configured using the collection view's properties:
 *  typingIndicatorDisplaysOnLeft, typingIndicatorMessageBubbleColor, typingIndicatorEllipsisColor.
 *
 *  @param indexPath The index path specifying the location of the supplementary view in the collection view. This value must not be `nil`.
 *
 *  @return A valid `FNMessagesTypingIndicatorFooterView` object.
 */
- (FNMessagesTypingIndicatorFooterView *)dequeueTypingIndicatorFooterViewForIndexPath:(NSIndexPath *)indexPath;

/**
 *  Returns a `FNMessagesLoadEarlierHeaderView` object for the specified index path
 *  that is configured using the collection view's loadEarlierMessagesHeaderTextColor property.
 *
 *  @param indexPath The index path specifying the location of the supplementary view in the collection view. This value must not be `nil`.
 *
 *  @return A valid `FNMessagesLoadEarlierHeaderView` object.
 */
- (FNMessagesLoadEarlierHeaderView *)dequeueLoadEarlierMessagesViewHeaderForIndexPath:(NSIndexPath *)indexPath;

@end
