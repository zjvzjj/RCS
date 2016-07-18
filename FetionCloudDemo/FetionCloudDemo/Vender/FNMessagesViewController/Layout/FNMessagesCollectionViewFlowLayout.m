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
//
//  Ideas for springy collection view layout taken from Ash Furrow
//  ASHSpringyCollectionView
//  https://github.com/AshFurrow/ASHSpringyCollectionView
//

#import "FNMessagesCollectionViewFlowLayout.h"

#import "FNMessageData.h"

#import "FNMessagesCollectionView.h"
#import "FNMessagesCollectionViewCell.h"

#import "FNMessagesCollectionViewLayoutAttributes.h"

#import "UIImage+FNMessages.h"


const CGFloat kFNMessagesCollectionViewCellLabelHeightDefault = 20.0f;
const CGFloat kFNMessagesCollectionViewAvatarSizeDefault = 30.0f;


@interface FNMessagesCollectionViewFlowLayout ()

@property (strong, nonatomic) NSCache *messageBubbleCache;

@property (assign, nonatomic) CGFloat latestDelta;

@property (assign, nonatomic, readonly) NSUInteger bubbleImageAssetWidth;

- (void)fn_configureFlowLayout;

- (void)fn_didReceiveApplicationMemoryWarningNotification:(NSNotification *)notification;
- (void)fn_didReceiveDeviceOrientationDidChangeNotification:(NSNotification *)notification;

- (void)fn_resetLayout;

- (void)fn_configureMessageCellLayoutAttributes:(FNMessagesCollectionViewLayoutAttributes *)layoutAttributes;
- (CGSize)fn_avatarSizeForIndexPath:(NSIndexPath *)indexPath;

@end



@implementation FNMessagesCollectionViewFlowLayout

#pragma mark - Initialization

- (void)fn_configureFlowLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 4.0f, 10.0f, 4.0f);
    self.minimumLineSpacing = 4.0f;
    
    _bubbleImageAssetWidth = 0;
    
    _messageBubbleCache = [NSCache new];
    _messageBubbleCache.name = @"FNMessagesCollectionViewFlowLayout.messageBubbleCache";
    _messageBubbleCache.countLimit = 200;
    
    _messageBubbleFont = [UIFont systemFontOfSize:16.0f];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        _messageBubbleLeftRightMargin = 240.0f;
    }
    else {
        _messageBubbleLeftRightMargin = 24.0f;
    }
    
    _messageBubbleTextViewFrameInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    _messageBubbleTextViewTextContainerInsets = UIEdgeInsetsMake(10.0f, 15.0f, 10.0f, 15.0f);
    
    CGSize defaultAvatarSize = CGSizeMake(kFNMessagesCollectionViewAvatarSizeDefault, kFNMessagesCollectionViewAvatarSizeDefault);
    _incomingAvatarViewSize = defaultAvatarSize;
    _outgoingAvatarViewSize = defaultAvatarSize;
    
    _springinessEnabled = NO;
    _springResistanceFactor = 1000;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fn_didReceiveApplicationMemoryWarningNotification:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fn_didReceiveDeviceOrientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self fn_configureFlowLayout];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self fn_configureFlowLayout];
}

+ (Class)layoutAttributesClass
{
    return [FNMessagesCollectionViewLayoutAttributes class];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _messageBubbleFont = nil;
    
    [_messageBubbleCache removeAllObjects];
    _messageBubbleCache = nil;
}

#pragma mark - Setters

- (void)setSpringinessEnabled:(BOOL)springinessEnabled
{
    if (_springinessEnabled == springinessEnabled) {
        return;
    }
    
    _springinessEnabled = springinessEnabled;
    
    [self invalidateLayout];
}

- (void)setMessageBubbleFont:(UIFont *)messageBubbleFont
{
    if ([_messageBubbleFont isEqual:messageBubbleFont]) {
        return;
    }
    
    NSParameterAssert(messageBubbleFont != nil);
    _messageBubbleFont = messageBubbleFont;
    [self invalidateLayout];
}

- (void)setMessageBubbleLeftRightMargin:(CGFloat)messageBubbleLeftRightMargin
{
    NSParameterAssert(messageBubbleLeftRightMargin >= 0.0f);
    _messageBubbleLeftRightMargin = ceilf(messageBubbleLeftRightMargin);
    [self invalidateLayout];
}

- (void)setMessageBubbleTextViewTextContainerInsets:(UIEdgeInsets)messageBubbleTextContainerInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_messageBubbleTextViewTextContainerInsets, messageBubbleTextContainerInsets)) {
        return;
    }
    
    _messageBubbleTextViewTextContainerInsets = messageBubbleTextContainerInsets;
    [self invalidateLayout];
}

- (void)setIncomingAvatarViewSize:(CGSize)incomingAvatarViewSize
{
    if (CGSizeEqualToSize(_incomingAvatarViewSize, incomingAvatarViewSize)) {
        return;
    }
    
    _incomingAvatarViewSize = incomingAvatarViewSize;
    [self invalidateLayout];
}

- (void)setOutgoingAvatarViewSize:(CGSize)outgoingAvatarViewSize
{
    if (CGSizeEqualToSize(_outgoingAvatarViewSize, outgoingAvatarViewSize)) {
        return;
    }
    
    _outgoingAvatarViewSize = outgoingAvatarViewSize;
    [self invalidateLayout];
}

- (void)setCacheLimit:(NSUInteger)cacheLimit
{
    self.messageBubbleCache.countLimit = cacheLimit;
}

#pragma mark - Getters

- (CGFloat)itemWidth
{
    return CGRectGetWidth(self.collectionView.frame) - self.sectionInset.left - self.sectionInset.right;
}

- (NSUInteger)cacheLimit
{
    return self.messageBubbleCache.countLimit;
}

#pragma mark - Notifications

- (void)fn_didReceiveApplicationMemoryWarningNotification:(NSNotification *)notification
{
    [self fn_resetLayout];
}

- (void)fn_didReceiveDeviceOrientationDidChangeNotification:(NSNotification *)notification
{
    [self fn_resetLayout];
    [self invalidateLayout];
}

#pragma mark - Collection view flow layout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesInRect = [super layoutAttributesForElementsInRect:rect];
    
    [attributesInRect enumerateObjectsUsingBlock:^(FNMessagesCollectionViewLayoutAttributes *attributesItem, NSUInteger idx, BOOL *stop) {
        if (attributesItem.representedElementCategory == UICollectionElementCategoryCell) {
            [self fn_configureMessageCellLayoutAttributes:attributesItem];
        }
        else
        {
            attributesItem.zIndex = -1;
        }
    }];
    
    return attributesInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FNMessagesCollectionViewLayoutAttributes *customAttributes = (FNMessagesCollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    
    if (customAttributes.representedElementCategory == UICollectionElementCategoryCell) {
        [self fn_configureMessageCellLayoutAttributes:customAttributes];
    }
    
    return customAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}
//
- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    
    [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem *updateItem, NSUInteger index, BOOL *stop) {
        if (updateItem.updateAction == UICollectionUpdateActionInsert) {
            
            CGFloat collectionViewHeight = CGRectGetHeight(self.collectionView.bounds);
            
            FNMessagesCollectionViewLayoutAttributes *attributes = [FNMessagesCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:updateItem.indexPathAfterUpdate];
            
            if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
                [self fn_configureMessageCellLayoutAttributes:attributes];
            }
            
            attributes.frame = CGRectMake(0.0f,
                                          collectionViewHeight + CGRectGetHeight(attributes.frame),
                                          CGRectGetWidth(attributes.frame),
                                          CGRectGetHeight(attributes.frame));
        }
    }];
}

#pragma mark - Invalidation utilities

- (void)fn_resetLayout
{
    [self.messageBubbleCache removeAllObjects];
}

#pragma mark - Message cell layout utilities

- (CGSize)messageBubbleSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<FNMessageData> messageItem = [self.collectionView.dataSource collectionView:self.collectionView messageDataForItemAtIndexPath:indexPath];
    if (![[messageItem senderId] isEqualToString:self.senderId])
    {
        _messageBubbleTextViewFrameInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        _messageBubbleTextViewTextContainerInsets = UIEdgeInsetsZero;
    }
    else
    {
        _messageBubbleTextViewFrameInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        _messageBubbleTextViewTextContainerInsets = UIEdgeInsetsZero;
    }
    //???
    NSValue *cachedSize = [self.messageBubbleCache objectForKey:@(messageItem.hash)];
    if (cachedSize != nil) {
        return [cachedSize CGSizeValue];
    }
    
    CGSize finalSize = CGSizeZero;
    
    if ([messageItem isMediaMessage])
    {
        finalSize = [[messageItem media] mediaViewDisplaySize];
    }
    else
    {
        CGSize avatarSize = [self fn_avatarSizeForIndexPath:indexPath];
        
        //  from the cell xibs, there is a 2 point space between avatar and bubble
        CGFloat spacingBetweenAvatarAndBubble = 5.0f;
        CGFloat horizontalContainerInsets = self.messageBubbleTextViewTextContainerInsets.left + self.messageBubbleTextViewTextContainerInsets.right;
        CGFloat horizontalFrameInsets = self.messageBubbleTextViewFrameInsets.left + self.messageBubbleTextViewFrameInsets.right;
        
        CGFloat horizontalInsetsTotal = horizontalContainerInsets + horizontalFrameInsets + spacingBetweenAvatarAndBubble;
        CGFloat maximumTextWidth = self.itemWidth - avatarSize.width * 2 - self.messageBubbleLeftRightMargin - horizontalInsetsTotal - 15.0f - 15.0f;
        
//        CGRect stringRect = [[messageItem text] boundingRectWithSize:CGSizeMake(maximumTextWidth, CGFLOAT_MAX)
//                                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
//                                                          attributes:@{ NSFontAttributeName : self.messageBubbleFont }
//                                                             context:nil];
        //计算文本的size
        CGSize stringSize = [FNMessagesCellTextView estimatedSize:CGSizeMake(maximumTextWidth, HUGE_VALF) string:[messageItem text]];
        
        stringSize = CGSizeMake(stringSize.width + 15.0f + 15.0f, stringSize.height + 10.0f + 10.0f);
        
        CGFloat verticalContainerInsets = self.messageBubbleTextViewTextContainerInsets.top + self.messageBubbleTextViewTextContainerInsets.bottom;
        CGFloat verticalFrameInsets = self.messageBubbleTextViewFrameInsets.top + self.messageBubbleTextViewFrameInsets.bottom;
        
        //  add extra 2 points of space, because `boundingRectWithSize:` is slightly off
        //  not sure why. magix. (shrug) if you know, submit a PR
        CGFloat verticalInsets = verticalContainerInsets + verticalFrameInsets;
        
        //  same as above, an extra 2 points of magix
        CGFloat finalWidth = MAX(stringSize.width + horizontalInsetsTotal, self.bubbleImageAssetWidth) - 3.0f;
        
        finalSize = CGSizeMake(finalWidth + 1, stringSize.height + verticalInsets);
    }
    
    [self.messageBubbleCache setObject:[NSValue valueWithCGSize:finalSize] forKey:@(messageItem.hash)];
    
    return finalSize;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize messageBubbleSize = [self messageBubbleSizeForItemAtIndexPath:indexPath];
    FNMessagesCollectionViewLayoutAttributes *attributes = (FNMessagesCollectionViewLayoutAttributes *)[self layoutAttributesForItemAtIndexPath:indexPath];
    //最后高度
    CGFloat finalHeight = messageBubbleSize.height;
    finalHeight += attributes.cellTopLabelHeight;
    finalHeight += attributes.messageBubbleTopLabelHeight;
    finalHeight += attributes.cellBottomLabelHeight;
    
    return CGSizeMake(self.itemWidth, ceilf(finalHeight));
}

- (void)fn_configureMessageCellLayoutAttributes:(FNMessagesCollectionViewLayoutAttributes *)layoutAttributes
{
    NSIndexPath *indexPath = layoutAttributes.indexPath;
    
    CGSize messageBubbleSize = [self messageBubbleSizeForItemAtIndexPath:indexPath];
    
    layoutAttributes.messageBubbleContainerViewWidth = messageBubbleSize.width;
    
    layoutAttributes.textViewFrameInsets = self.messageBubbleTextViewFrameInsets;
    
    layoutAttributes.textViewTextContainerInsets = self.messageBubbleTextViewTextContainerInsets;
    
    layoutAttributes.messageBubbleFont = self.messageBubbleFont;
    
    layoutAttributes.incomingAvatarViewSize = self.incomingAvatarViewSize;
    
    layoutAttributes.outgoingAvatarViewSize = self.outgoingAvatarViewSize;
    layoutAttributes.cancleImageViewSize = self.cancleIamgeViewSize;
    
    layoutAttributes.cellTopLabelHeight = [self.collectionView.delegate collectionView:self.collectionView
                                                                                layout:self
                                                      heightForCellTopLabelAtIndexPath:indexPath];
    
    layoutAttributes.messageBubbleTopLabelHeight = [self.collectionView.delegate collectionView:self.collectionView
                                                                                         layout:self
                                                      heightForMessageBubbleTopLabelAtIndexPath:indexPath];
    
    layoutAttributes.cellBottomLabelHeight = [self.collectionView.delegate collectionView:self.collectionView
                                                                                   layout:self
                                                      heightForCellBottomLabelAtIndexPath:indexPath];
}

- (CGSize)fn_avatarSizeForIndexPath:(NSIndexPath *)indexPath
{
    id<FNMessageData> messageData = [self.collectionView.dataSource collectionView:self.collectionView messageDataForItemAtIndexPath:indexPath];
    NSString *messageSender = [messageData senderId];
   
    if ([messageSender isEqualToString:[self.collectionView.dataSource senderId]]) {
        return self.outgoingAvatarViewSize;
    }
    
    return self.incomingAvatarViewSize;
}

@end
