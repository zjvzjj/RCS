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

#import "FNMessagesViewController.h"

#import "FNMessageData.h"
#import "FNMessageBubbleImageDataSource.h"
#import "FNMessageCancleImageDataSource.h"
#import "FNMessageAvatarImageDataSource.h"

#import "FNMessagesCollectionViewCellIncoming.h"
#import "FNMessagesCollectionViewCellOutgoing.h"

#import "FNMessagesTypingIndicatorFooterView.h"
#import "FNMessagesLoadEarlierHeaderView.h"

#import "FNMessagesTimestampFormatter.h"

#import "NSString+FNMessages.h"
#import "UIColor+FNMessages.h"
#import "UIDevice+FNMessages.h"

static void * kFNMessagesKeyValueObservingContext = &kFNMessagesKeyValueObservingContext;



@interface FNMessagesViewController ()

@property (weak, nonatomic) IBOutlet FNMessagesCollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottomLayoutGuide;

@property (weak, nonatomic) UIView *snapshotView;

@property (assign, nonatomic) BOOL fn_isObserving;

@property (strong, nonatomic) NSIndexPath *selectedIndexPathForMenu;

- (void)fn_configureMessagesViewController;

- (NSString *)fn_currentlyComposedMessageText;

- (void)fn_handleDidChangeStatusBarFrameNotification:(NSNotification *)notification;
- (void)fn_didReceiveMenuWillShowNotification:(NSNotification *)notification;
- (void)fn_didReceiveMenuWillHideNotification:(NSNotification *)notification;

- (void)fn_updateKeyboardTriggerPoint;
- (void)fn_setToolbarBottomLayoutGuideConstant:(CGFloat)constant;

- (void)fn_handleInteractivePopGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

- (BOOL)fn_inputToolbarHasReachedMaximumHeight;
- (void)fn_adjustInputToolbarForComposerTextViewContentSizeChange:(CGFloat)dy;
- (void)fn_adjustInputToolbarHeightConstraintByDelta:(CGFloat)dy;
- (void)fn_scrollComposerTextViewToBottomAnimated:(BOOL)animated;

- (void)fn_updateCollectionViewInsets;
- (void)fn_setCollectionViewInsetsTopValue:(CGFloat)top bottomValue:(CGFloat)bottom;

- (BOOL)fn_isMenuVisible;

- (void)fn_registerForNotifications:(BOOL)registerForNotifications;

@end



@implementation FNMessagesViewController

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([FNMessagesViewController class])
                          bundle:[NSBundle mainBundle]];
}

+ (instancetype)messagesViewController
{
    return [[[self class] alloc] initWithNibName:NSStringFromClass([FNMessagesViewController class])
                                          bundle:[NSBundle mainBundle]];
}

#pragma mark - Initialization

- (void)fn_configureMessagesViewController
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.fn_isObserving = NO;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.senderId = @"FNDefaultSender";
    self.senderDisplayName = @"FNDefaultSender";
    
    self.automaticallyScrollsToMostRecentMessage = YES;
    
    self.outgoingCellIdentifier = [FNMessagesCollectionViewCellOutgoing cellReuseIdentifier];
    self.outgoingMediaCellIdentifier = [FNMessagesCollectionViewCellOutgoing mediaCellReuseIdentifier];
    
    self.incomingCellIdentifier = [FNMessagesCollectionViewCellIncoming cellReuseIdentifier];
    self.incomingMediaCellIdentifier = [FNMessagesCollectionViewCellIncoming mediaCellReuseIdentifier];
    
    self.showTypingIndicator = NO;
    
    self.showLoadEarlierMessagesHeader = NO;
    
    self.collectionView.collectionViewLayout.springinessEnabled = NO;
    
    self.topContentAdditionalInset = 0.0f;
    
    [self fn_updateCollectionViewInsets];
}

- (void)dealloc
{
    [self fn_registerForNotifications:NO];
    
    _collectionView.dataSource = nil;
    _collectionView.delegate = nil;
    _collectionView = nil;
    
    _toolbarHeightConstraint = nil;
    _toolbarBottomLayoutGuide = nil;
    
    _senderId = nil;
    _senderDisplayName = nil;
    _outgoingCellIdentifier = nil;
    _incomingCellIdentifier = nil;
}

#pragma mark - Setters

- (void)setShowTypingIndicator:(BOOL)showTypingIndicator
{
    if (_showTypingIndicator == showTypingIndicator) {
        return;
    }
    
    _showTypingIndicator = showTypingIndicator;
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)setShowLoadEarlierMessagesHeader:(BOOL)showLoadEarlierMessagesHeader
{
    if (_showLoadEarlierMessagesHeader == showLoadEarlierMessagesHeader) {
        return;
    }
    
    _showLoadEarlierMessagesHeader = showLoadEarlierMessagesHeader;
    
    [self.collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)setTopContentAdditionalInset:(CGFloat)topContentAdditionalInset
{
    _topContentAdditionalInset = topContentAdditionalInset;
    [self fn_updateCollectionViewInsets];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self class] nib] instantiateWithOwner:self options:nil];
    [self fn_configureMessagesViewController];
    [self fn_registerForNotifications:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    if (self.automaticallyScrollsToMostRecentMessage) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self scrollToBottomAnimated:YES];
            [self.collectionView.collectionViewLayout invalidateLayout];
        });
    }
    
    [self fn_updateKeyboardTriggerPoint];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([UIDevice fn_isCurrentDeviceBeforeiOS8]) {
        [self.snapshotView removeFromSuperview];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self fn_setToolbarBottomLayoutGuideConstant:0.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"MEMORY WARNING: %s", __PRETTY_FUNCTION__);
}

#pragma mark - View rotation

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - Messages view controller

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    NSAssert(NO, @"Error! required method not implemented in subclass. Need to implement %s", __PRETTY_FUNCTION__);
}

- (void)didPressAccessoryButton:(UIButton *)sender { }

- (void)finishSendingMessage
{
    [self.collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self scrollToBottomAnimated:YES];

//    if (self.automaticallyScrollsToMostRecentMessage)
//    {
        //[self scrollToBottomAnimated:YES];
    //}
}

- (void)finishReceivingMessage
{
    self.showTypingIndicator = NO;
    
    [self.collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    if (self.automaticallyScrollsToMostRecentMessage && ![self fn_isMenuVisible]) {
        [self scrollToBottomAnimated:YES];
    }
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    if ([self.collectionView numberOfSections] == 0) {
        return;
    }
    
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    
    if (items == 0) {
        return;
    }
        
    CGFloat collectionViewContentHeight = [self.collectionView.collectionViewLayout collectionViewContentSize].height;

    [self.collectionView scrollRectToVisible:CGRectMake(0.0, collectionViewContentHeight - 1.0f, 1.0f, 1.0f)
                                    animated:animated];
}

#pragma mark - FNMessages collection view data source

- (id<FNMessageData>)collectionView:(FNMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (id<FNMessageBubbleImageDataSource>)collectionView:(FNMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (id<FNMessageCancleImageDataSource>)collectionView:(FNMessagesCollectionView *)collectionView cancleImageForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (id<FNMessageAvatarImageDataSource>)collectionView:(FNMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (NSAttributedString *)collectionView:(FNMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSAttributedString *)collectionView:(FNMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSAttributedString *)collectionView:(FNMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(FNMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<FNMessageData> messageItem = [collectionView.dataSource collectionView:collectionView messageDataForItemAtIndexPath:indexPath];
    //NSParameterAssert(messageItem != nil);
    
    NSString *messageSenderId = [messageItem senderId];
   // NSParameterAssert(messageSenderId != nil);
    
    BOOL isOutgoingMessage = [messageSenderId isEqualToString:self.senderId];
    BOOL isMediaMessage = [messageItem isMediaMessage];
    
    BOOL isKick = NO;
    
    BOOL isTopic = NO;
    
    NSString *cellIdentifier = nil;
    if (isMediaMessage)
    {
        cellIdentifier = isOutgoingMessage ? self.outgoingMediaCellIdentifier : self.incomingMediaCellIdentifier;
    }
    else
    {
        cellIdentifier = isOutgoingMessage ? self.outgoingCellIdentifier : self.incomingCellIdentifier;
    }
    
    FNMessagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.autoresizingMask = UIViewAutoresizingNone;
    
    cell.delegate = collectionView;
    
    if (!isMediaMessage)
    {
        cell.textView.edge = UIEdgeInsetsMake(10.0f, 15.0f, 10.0f, 15.0f);
        
        if (isOutgoingMessage)
        {
            [cell.textView setText:[messageItem text]];
        }
        else
        {
            [cell.textView setText:[messageItem text]];
        }
        
        id<FNMessageBubbleImageDataSource> bubbleImageDataSource = [collectionView.dataSource collectionView:collectionView messageBubbleImageDataForItemAtIndexPath:indexPath];
        if (bubbleImageDataSource != nil) {
            cell.messageBubbleImageView.image = [bubbleImageDataSource messageBubbleImage];
            cell.messageBubbleImageView.highlightedImage = [bubbleImageDataSource messageBubbleHighlightedImage];
        }
    }
    else {
    
        id<FNMessageMediaData> messageMedia = [messageItem media];
        cell.mediaView = [messageMedia mediaView] ?: [messageMedia mediaPlaceholderView];
        NSParameterAssert(cell.mediaView != nil);
    }
    
    if (isKick || isTopic)
    {
        return cell;
    }
    BOOL needsAvatar = YES;
    if (isOutgoingMessage && CGSizeEqualToSize(collectionView.collectionViewLayout.outgoingAvatarViewSize, CGSizeZero)) {
        needsAvatar = NO;
    }
    else if (!isOutgoingMessage && CGSizeEqualToSize(collectionView.collectionViewLayout.incomingAvatarViewSize, CGSizeZero)) {
        needsAvatar = NO;
    }
    
    id<FNMessageAvatarImageDataSource> avatarImageDataSource = nil;
    if (needsAvatar) {
        avatarImageDataSource = [collectionView.dataSource collectionView:collectionView avatarImageDataForItemAtIndexPath:indexPath];
        if (avatarImageDataSource != nil) {
            cell.avatarImageView.image = [avatarImageDataSource avatarImage] ?: [avatarImageDataSource avatarPlaceholderImage];
            cell.avatarImageView.highlightedImage = [avatarImageDataSource avatarHighlightedImage];
        }
    }
    
    cell.cellTopLabel.attributedText = [collectionView.dataSource collectionView:collectionView attributedTextForCellTopLabelAtIndexPath:indexPath];
    cell.messageBubbleTopLabel.attributedText = [collectionView.dataSource collectionView:collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:indexPath];
    cell.cellBottomLabel.attributedText = [collectionView.dataSource collectionView:collectionView attributedTextForCellBottomLabelAtIndexPath:indexPath];
    
    id<FNMessageCancleImageDataSource> cancleImageDataSource = [collectionView.dataSource collectionView:collectionView cancleImageForItemAtIndexPath:indexPath];
    if (cancleImageDataSource != nil)
    {
        
        cell.cancleImageView.image = [cancleImageDataSource messageCancleImage];
        cell.cancleImageView.highlightedImage = [cancleImageDataSource messageCancleHighlightedImage];
    }
   
    
//    CGFloat bubbleTopLabelInset = (avatarImageDataSource != nil) ? 60.0f : 15.0f;
//    
//    if (isOutgoingMessage) {
//        cell.messageBubbleTopLabel.textInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 10.0f);
//    }
//    else {
//        cell.messageBubbleTopLabel.textInsets = UIEdgeInsetsMake(0.0f, bubbleTopLabelInset, 0.0f, 0.0f);
//    }
    
//    cell.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.layer.shouldRasterize = YES;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(FNMessagesCollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if (self.showTypingIndicator && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [collectionView dequeueTypingIndicatorFooterViewForIndexPath:indexPath];
    }
    else if (self.showLoadEarlierMessagesHeader && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [collectionView dequeueLoadEarlierMessagesViewHeaderForIndexPath:indexPath];
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (!self.showTypingIndicator) {
        return CGSizeZero;
    }
    
    return CGSizeMake([collectionViewLayout itemWidth], kFNMessagesTypingIndicatorFooterViewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (!self.showLoadEarlierMessagesHeader) {
        return CGSizeZero;
    }
    
    return CGSizeMake([collectionViewLayout itemWidth], kFNMessagesLoadEarlierHeaderViewHeight);
}

#pragma mark - Collection view delegate

- (BOOL)collectionView:(FNMessagesCollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //  disable menu for media messages
    id<FNMessageData> messageItem = [collectionView.dataSource collectionView:collectionView messageDataForItemAtIndexPath:indexPath];
    if ([messageItem isMediaMessage]) {
        return NO;
    }
    
    self.selectedIndexPathForMenu = indexPath;
    
    //  textviews are selectable to allow data detectors
    //  however, this allows the 'copy, define, select' UIMenuController to show
    //  which conflicts with the collection view's UIMenuController
    //  temporarily disable 'selectable' to prevent this issue
    FNMessagesCollectionViewCell *selectedCell = (FNMessagesCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    selectedCell.textView.selectable = NO;
    
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(copy:) || action == @selector(translate:))
    {
        return YES;
    }
    
    return NO;
}

- (void)collectionView:(FNMessagesCollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(copy:)) {
        id<FNMessageData> messageData = [self collectionView:collectionView messageDataForItemAtIndexPath:indexPath];
        [[UIPasteboard generalPasteboard] setString:[messageData text]];
    }
    else
    if(action == @selector(translate:))
    {
//        id<FNMessageData> messageData = [self collectionView:collectionView messageDataForItemAtIndexPath:indexPath];
        
    }
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(FNMessagesCollectionView *)collectionView
                  layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionViewLayout sizeForItemAtIndexPath:indexPath];
}

- (CGFloat)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (CGFloat)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (CGSize)collectionView:(FNMessagesCollectionView *)collectionView
                  layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout sizeForAvatarViewAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(FNMessagesCollectionView *)collectionView
                   layout:(FNMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (void)collectionView:(FNMessagesCollectionView *)collectionView
 didTapAvatarImageView:(UIImageView *)avatarImageView
           atIndexPath:(NSIndexPath *)indexPath {}

- (void)collectionView:(FNMessagesCollectionView *)collectionView didLongTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath
{

}

- (void)collectionView:(FNMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
}

- (void)collectionView:(FNMessagesCollectionView *)collectionView
 didTapCellAtIndexPath:(NSIndexPath *)indexPath
         touchLocation:(CGPoint)touchLocation
{
}

- (void)collectionView:(FNMessagesCollectionView *)collectionView didLongTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    
}

#pragma mark - Notifications

- (void)fn_handleDidChangeStatusBarFrameNotification:(NSNotification *)notification
{
    
}

- (void)fn_didReceiveMenuWillShowNotification:(NSNotification *)notification
{
    if (!self.selectedIndexPathForMenu) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillShowMenuNotification
                                                  object:nil];
    
    UIMenuController *menu = [notification object];
    
    [menu setMenuVisible:NO animated:NO];
    
    FNMessagesCollectionViewCell *selectedCell = (FNMessagesCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPathForMenu];
    CGRect selectedCellMessageBubbleFrame = [selectedCell convertRect:selectedCell.messageBubbleContainerView.frame toView:self.view];
    
    [menu setTargetRect:selectedCellMessageBubbleFrame inView:self.view];
    [menu setMenuVisible:YES animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fn_didReceiveMenuWillShowNotification:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:nil];
}

- (void)fn_didReceiveMenuWillHideNotification:(NSNotification *)notification
{
    if (!self.selectedIndexPathForMenu) {
        return;
    }
    
    //  per comment above in 'shouldShowMenuForItemAtIndexPath:'
    //  re-enable 'selectable', thus re-enabling data detectors if present
    FNMessagesCollectionViewCell *selectedCell = (FNMessagesCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPathForMenu];
//    selectedCell.textView.selectable = YES;
    self.selectedIndexPathForMenu = nil;
}

#pragma mark - Keyboard controller delegate

- (void)fn_setToolbarBottomLayoutGuideConstant:(CGFloat)constant
{
    self.toolbarBottomLayoutGuide.constant = constant;
    
    [self.view setNeedsUpdateConstraints];
    [self.view layoutIfNeeded];
    
    [self fn_updateCollectionViewInsets];
}

- (void)fn_updateKeyboardTriggerPoint
{
    
}

#pragma mark - Gesture recognizers

- (void)fn_handleInteractivePopGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            if ([UIDevice fn_isCurrentDeviceBeforeiOS8]) {
                [self.snapshotView removeFromSuperview];
            }
            
            if ([UIDevice fn_isCurrentDeviceBeforeiOS8]) {
                [UIView animateWithDuration:0.0
                                 animations:^{
                                     [self fn_setToolbarBottomLayoutGuideConstant:0.0f];
                                 }];
                
                UIView *snapshot = [self.view snapshotViewAfterScreenUpdates:YES];
                [self.view addSubview:snapshot];
                self.snapshotView = snapshot;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            
            if ([UIDevice fn_isCurrentDeviceBeforeiOS8]) {
                [self.snapshotView removeFromSuperview];
            }
            break;
        default:
            break;
    }
}

#pragma mark - Collection view utilities

- (void)fn_updateCollectionViewInsets
{
    
}

- (void)fn_setCollectionViewInsetsTopValue:(CGFloat)top bottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = UIEdgeInsetsMake(top, 0.0f, bottom, 0.0f);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

- (BOOL)fn_isMenuVisible
{
    //  check if cell copy menu is showing
    //  it is only our menu if `selectedIndexPathForMenu` is not `nil`
    return self.selectedIndexPathForMenu != nil && [[UIMenuController sharedMenuController] isMenuVisible];
}

#pragma mark - Utilities

- (void)fn_registerForNotifications:(BOOL)registerForNotifications
{
    if (registerForNotifications) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(fn_handleDidChangeStatusBarFrameNotification:)
                                                     name:UIApplicationDidChangeStatusBarFrameNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(fn_didReceiveMenuWillShowNotification:)
                                                     name:UIMenuControllerWillShowMenuNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(fn_didReceiveMenuWillHideNotification:)
                                                     name:UIMenuControllerWillHideMenuNotification
                                                   object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIApplicationDidChangeStatusBarFrameNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIMenuControllerWillShowMenuNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIMenuControllerWillHideMenuNotification
                                                      object:nil];
    }
}

@end
