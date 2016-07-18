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

@class FNMessagesLoadEarlierHeaderView;

/**
 *  A constant defining the default height of a `FNMessagesLoadEarlierHeaderView`.
 */
FOUNDATION_EXPORT const CGFloat kFNMessagesLoadEarlierHeaderViewHeight;

/**
 *  The `FNMessagesLoadEarlierHeaderViewDelegate` defines methods that allow you to
 *  respond to interactions within the header view.
 */
@protocol FNMessagesLoadEarlierHeaderViewDelegate <NSObject>

@required

/**
 *  Tells the delegate that the loadButton has received a touch event.
 *
 *  @param headerView The header view that contains the sender.
 *  @param sender     The button that received the touch.
 */
- (void)headerView:(FNMessagesLoadEarlierHeaderView *)headerView didPressLoadButton:(UIButton *)sender;

@end


/**
 *  The `FNMessagesLoadEarlierHeaderView` class implements a reusable view that can be placed
 *  at the top of a `FNMessagesCollectionView`. This view contains a "load earlier messages" button
 *  and can be used as a way for the user to load previously sent messages.
 */
@interface FNMessagesLoadEarlierHeaderView : UICollectionReusableView

/**
 *  The object that acts as the delegate of the header view.
 */
@property (weak, nonatomic) id<FNMessagesLoadEarlierHeaderViewDelegate> delegate;

/**
 *  Returns the load button of the header view.
 */
@property (weak, nonatomic, readonly) UIButton *loadButton;

#pragma mark - Class methods

/**
 *  Returns the `UINib` object initialized for the collection reusable view.
 *
 *  @return The initialized `UINib` object or `nil` if there were errors during
 *  initialization or the nib file could not be located.
 */
+ (UINib *)nib;

/**
 *  Returns the default string used to identify the reusable header view.
 *
 *  @return The string used to identify the reusable header view.
 */
+ (NSString *)headerReuseIdentifier;

@end
