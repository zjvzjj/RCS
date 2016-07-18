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

#import "FNMessagesCollectionView.h"

#import "FNMessagesCollectionViewFlowLayout.h"
#import "FNMessagesCollectionViewCellIncoming.h"
#import "FNMessagesCollectionViewCellOutgoing.h"

#import "FNMessagesTypingIndicatorFooterView.h"
#import "FNMessagesLoadEarlierHeaderView.h"

#import "UIColor+FNMessages.h"


@interface FNMessagesCollectionView () <FNMessagesLoadEarlierHeaderViewDelegate>

- (void)fn_configureCollectionView;

@end


@implementation FNMessagesCollectionView

#pragma mark - Initialization

- (void)fn_configureCollectionView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.alwaysBounceVertical = YES;
    self.bounces = YES;
    
    [self registerNib:[FNMessagesCollectionViewCellIncoming nib]
          forCellWithReuseIdentifier:[FNMessagesCollectionViewCellIncoming cellReuseIdentifier]];
    
    [self registerNib:[FNMessagesCollectionViewCellOutgoing nib]
          forCellWithReuseIdentifier:[FNMessagesCollectionViewCellOutgoing cellReuseIdentifier]];
    
    [self registerNib:[FNMessagesCollectionViewCellIncoming nib]
          forCellWithReuseIdentifier:[FNMessagesCollectionViewCellIncoming mediaCellReuseIdentifier]];
    
    [self registerNib:[FNMessagesCollectionViewCellOutgoing nib]
          forCellWithReuseIdentifier:[FNMessagesCollectionViewCellOutgoing mediaCellReuseIdentifier]];
    
    [self registerNib:[FNMessagesTypingIndicatorFooterView nib]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
          withReuseIdentifier:[FNMessagesTypingIndicatorFooterView footerReuseIdentifier]];
    
    [self registerNib:[FNMessagesLoadEarlierHeaderView nib]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
          withReuseIdentifier:[FNMessagesLoadEarlierHeaderView headerReuseIdentifier]];

    _typingIndicatorDisplaysOnLeft = YES;
    _typingIndicatorMessageBubbleColor = [UIColor fn_messageBubbleLightGrayColor];
    _typingIndicatorEllipsisColor = [_typingIndicatorMessageBubbleColor fn_colorByDarkeningColorWithValue:0.3f];

    _loadEarlierMessagesHeaderTextColor = [UIColor fn_messageBubbleBlueColor];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self fn_configureCollectionView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self fn_configureCollectionView];
}

#pragma mark - Typing indicator

- (FNMessagesTypingIndicatorFooterView *)dequeueTypingIndicatorFooterViewForIndexPath:(NSIndexPath *)indexPath
{
    FNMessagesTypingIndicatorFooterView *footerView = [super dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                 withReuseIdentifier:[FNMessagesTypingIndicatorFooterView footerReuseIdentifier]
                                                                                        forIndexPath:indexPath];

    [footerView configureWithEllipsisColor:self.typingIndicatorEllipsisColor
                        messageBubbleColor:self.typingIndicatorMessageBubbleColor
                       shouldDisplayOnLeft:self.typingIndicatorDisplaysOnLeft
                         forCollectionView:self];

    return footerView;
}

#pragma mark - Load earlier messages header

- (FNMessagesLoadEarlierHeaderView *)dequeueLoadEarlierMessagesViewHeaderForIndexPath:(NSIndexPath *)indexPath
{
    FNMessagesLoadEarlierHeaderView *headerView = [super dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                             withReuseIdentifier:[FNMessagesLoadEarlierHeaderView headerReuseIdentifier]
                                                                                    forIndexPath:indexPath];

    headerView.loadButton.tintColor = self.loadEarlierMessagesHeaderTextColor;
    headerView.delegate = self;

    return headerView;
}

#pragma mark - Load earlier messages header delegate

- (void)headerView:(FNMessagesLoadEarlierHeaderView *)headerView didPressLoadButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(collectionView:header:didTapLoadEarlierMessagesButton:)]) {
        [self.delegate collectionView:self header:headerView didTapLoadEarlierMessagesButton:sender];
    }
}

#pragma mark - Messages collection view cell delegate

- (void)messagesCollectionViewCellDidTapAvatar:(FNMessagesCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionView:didTapAvatarImageView:atIndexPath:)])
    {
        [self.delegate collectionView:self didTapAvatarImageView:cell.avatarImageView atIndexPath:indexPath];
    }
}

- (void)messagesCollectionViewCellDidLongTapAvatar:(FNMessagesCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionView:didLongTapAvatarImageView:atIndexPath:)])
    {
        [self.delegate collectionView:self didLongTapAvatarImageView:cell.avatarImageView atIndexPath:indexPath];
    }
}

- (void)messagesCollectionViewCellDidTapMessageBubble:(FNMessagesCollectionViewCell *)cell atPosition:(CGPoint)position
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionView:didTapMessageBubbleAtIndexPath:touchLocation:)])
    {
        [self.delegate collectionView:self didTapMessageBubbleAtIndexPath:indexPath touchLocation:position];
    }
}

- (void)messagesCollectionViewCellDidTapCancle:(FNMessagesCollectionViewCell *)cell atPosition:(CGPoint)position
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }

    if ([self.delegate respondsToSelector:@selector(collectionView:didTapMessageCancleAtIndexPath:touchLocation:)])
    {
        [self.delegate collectionView:self didTapMessageCancleAtIndexPath:indexPath touchLocation:position];
    }
}

- (void)messagesCollectionViewCellDidTapCell:(FNMessagesCollectionViewCell *)cell atPosition:(CGPoint)position
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionView:didTapCellAtIndexPath:touchLocation:)])
    {
        [self.delegate collectionView:self didTapCellAtIndexPath:indexPath touchLocation:position];
    }
}

- (void)messagesCollectionViewCellDidLongTapMessageBubble:(FNMessagesCollectionViewCell *)cell atPosition:(CGPoint)position
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionView:didLongTapCellAtIndexPath:touchLocation:)])
    {
        [self.delegate collectionView:self didLongTapCellAtIndexPath:indexPath touchLocation:position];
    }
}

@end
