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

@class FNMessagesCollectionView;
@class FNMessagesCollectionViewFlowLayout;
@class FNMessagesCollectionViewCell;
@class FNMessagesLoadEarlierHeaderView;


/**
*  The `FNMessagesCollectionViewDelegateFlowLayout` protocol defines methods that allow you to
*  manage additional layout information for the collection view and respond to additional actions on its items.
*  The methods of this protocol are all optional.
*/
@protocol FNMessagesCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@optional

/**
 *  Asks the delegate for the height of the `cellTopLabel` for the item at the specified indexPath.
 *
 *  @param collectionView       The collection view object displaying the flow layout.
 *  @param collectionViewLayout The layout object requesting the information.
 *  @param indexPath            The index path of the item.
 *
 *  @return The height of the `cellTopLabel` for the item at indexPath.
 *
 *  @see FNMessagesCollectionViewCell.
 */
- (CGFloat)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the delegate for the height of the `messageBubbleTopLabel` for the item at the specified indexPath.
 *
 *  @param collectionView       The collection view object displaying the flow layout.
 *  @param collectionViewLayout The layout object requesting the information.
 *  @param indexPath            The index path of the item.
 *
 *  @return The height of the `messageBubbleTopLabel` for the item at indexPath.
 *
 *  @see FNMessagesCollectionViewCell.
 */
- (CGFloat)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 * AvatarViewSize
 */

- (CGSize)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout sizeForAvatarViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the delegate for the height of the `cellBottomLabel` for the item at the specified indexPath.
 *
 *  @param collectionView       The collection view object displaying the flow layout.
 *  @param collectionViewLayout The layout object requesting the information.
 *  @param indexPath            The index path of the item.
 *
 *  @return The height of the `cellBottomLabel` for the item at indexPath.
 *
 *  @see FNMessagesCollectionViewCell.
 */
- (CGFloat)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the avatar image view at the specified indexPath did receive a tap event.
 *
 *  @param collectionView  The collection view object that is notifying the delegate of the tap event.
 *  @param avatarImageView The avatar image view that was tapped.
 *  @param indexPath       The index path of the item for which the avatar was tapped.
 */
- (void)collectionView:(FNMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(FNMessagesCollectionView *)collectionView didLongTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the message bubble at the specified indexPath did receive a tap event.
 *
 *  @param collectionView The collection view object that is notifying the delegate of the tap event.
 *  @param indexPath      The index path of the item for which the message bubble was tapped.
 */
- (void)collectionView:(FNMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation;

- (void)collectionView:(FNMessagesCollectionView *)collectionView didTapMessageCancleAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation;

/**
 *  Notifies the delegate that the cell at the specified indexPath did receive a tap event at the specified touchLocation.
 *
 *  @param collectionView The collection view object that is notifying the delegate of the tap event.
 *  @param indexPath      The index path of the item for which the message bubble was tapped.
 *  @param touchLocation  The location of the touch event in the cell's coordinate system.
 *
 *  @warning This method is *only* called if position is *not* within the bounds of the cell's
 *  avatar image view or message bubble image view. In other words, this method is *not* called when the cell's
 *  avatar or message bubble are tapped. There are separate delegate methods for these two cases.
 *
 *  @see `collectionView:didTapAvatarImageView:atIndexPath:`
 *  @see `collectionView:didTapMessageBubbleAtIndexPath:atIndexPath:`
 */
- (void)collectionView:(FNMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation;

- (void)collectionView:(FNMessagesCollectionView *)collectionView didLongTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation;

/**
 *  Notifies the delegate that the collection view's header did receive a tap event.
 *
 *  @param collectionView The collection view object that is notifying the delegate of the tap event.
 *  @param headerView     The header view in the collection view.
 *  @param sender         The button that was tapped.
 */
- (void)collectionView:(FNMessagesCollectionView *)collectionView
                header:(FNMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender;

@end
