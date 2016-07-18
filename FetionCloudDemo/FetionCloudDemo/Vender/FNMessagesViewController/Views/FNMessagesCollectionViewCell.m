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

#import "FNMessagesCollectionViewCell.h"

#import "FNMessagesCollectionViewCellIncoming.h"
#import "FNMessagesCollectionViewCellOutgoing.h"
#import "FNMessagesCollectionViewLayoutAttributes.h"

#import "UIView+FNMessages.h"
#import "UIDevice+FNMessages.h"
#import "FNTranslation.h"


@interface FNMessagesCollectionViewCell () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet FNMessagesLabel *cellTopLabel;
@property (weak, nonatomic) IBOutlet FNMessagesLabel *messageBubbleTopLabel;
@property (weak, nonatomic) IBOutlet FNMessagesLabel *cellBottomLabel;

@property (weak, nonatomic) IBOutlet UIView *messageBubbleContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *messageBubbleImageView;
@property (weak, nonatomic) IBOutlet FNMessagesCellTextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;

@property (weak, nonatomic) IBOutlet UIView *cancleContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *cancleImageView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleContainerWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewTopVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewAvatarHorizontalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginHorizontalSpaceConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTopLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleTopLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellBottomLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewHeightConstraint;

@property (assign, nonatomic) CGSize cancleImageViewSize;

@property (assign, nonatomic) UIEdgeInsets textViewFrameInsets;

@property (assign, nonatomic) CGSize avatarViewSize;

@property (weak, nonatomic, readwrite) UITapGestureRecognizer *tapGestureRecognizer;

- (void)fn_handleTapGesture:(UITapGestureRecognizer *)tap;

- (void)fn_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant;

@end



@implementation FNMessagesCollectionViewCell

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (NSString *)mediaCellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@_FNMedia", NSStringFromClass([self class])];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:(244.0 / 255.0) green:(244.0 / 255.0) blue:(244.0 / 255.0) alpha:1.0];
    
    self.cellTopLabelHeightConstraint.constant = 0.0f;
    self.messageBubbleTopLabelHeightConstraint.constant = 0.0f;
    self.cellBottomLabelHeightConstraint.constant = 0.0f;
    
    self.avatarViewSize = CGSizeZero;
    
    self.cancleImageViewSize = CGSizeZero;
    
    self.cellTopLabel.textAlignment = NSTextAlignmentCenter;
    self.cellTopLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    self.cellTopLabel.textColor = [UIColor lightGrayColor];
    
    self.messageBubbleTopLabel.font = [UIFont systemFontOfSize:12.0f];
    self.messageBubbleTopLabel.textColor = [UIColor lightGrayColor];
    
    self.cellBottomLabel.font = [UIFont systemFontOfSize:11.0f];
    self.cellBottomLabel.textColor = [UIColor lightGrayColor];
    
    self.textView.delegate = self;
        
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fn_handleTapGesture:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    self.tapGestureRecognizer = tap;
    
    //    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(fn_handleLongTapGesture:)];
//    longTap.minimumPressDuration = 1.5f;
//    [_avatarContainerView addGestureRecognizer:longTap];
//    [longTap requireGestureRecognizerToFail:tap];
}

- (void)dealloc
{
    _delegate = nil;
    
    _cellTopLabel = nil;
    _messageBubbleTopLabel = nil;
    _cellBottomLabel = nil;
    
    _textView = nil;
    _messageBubbleImageView = nil;
    _mediaView = nil;
    
    _avatarImageView = nil;
    
    [_tapGestureRecognizer removeTarget:nil action:NULL];
    _tapGestureRecognizer = nil;
    
    _webview = nil;
}

#pragma mark - Collection view cell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.cellTopLabel.text = nil;
    self.messageBubbleTopLabel.text = nil;
    self.cellBottomLabel.text = nil;
    
    self.textView.text = nil;
    self.textView.delegate = self;
    
    self.avatarImageView.image = nil;
    self.avatarImageView.highlightedImage = nil;
    
    self.cancleImageView.image = nil;
    self.cancleImageView.highlighted = nil;
    
    self.webview = nil;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    FNMessagesCollectionViewLayoutAttributes *customAttributes = (FNMessagesCollectionViewLayoutAttributes *)layoutAttributes;
    
    self.textViewFrameInsets = customAttributes.textViewFrameInsets;
    
    [self fn_updateConstraint:self.messageBubbleContainerWidthConstraint
                  withConstant:customAttributes.messageBubbleContainerViewWidth];
    
    [self fn_updateConstraint:self.cellTopLabelHeightConstraint
                  withConstant:customAttributes.cellTopLabelHeight];
    
    [self fn_updateConstraint:self.messageBubbleTopLabelHeightConstraint
                  withConstant:customAttributes.messageBubbleTopLabelHeight];
    
    [self fn_updateConstraint:self.cellBottomLabelHeightConstraint
                  withConstant:customAttributes.cellBottomLabelHeight];
    
    self.cancleImageViewSize = customAttributes.cancleImageViewSize;
    
    if ([self isKindOfClass:[FNMessagesCollectionViewCellIncoming class]])
    {
        self.avatarViewSize = customAttributes.incomingAvatarViewSize;
    }
    else if ([self isKindOfClass:[FNMessagesCollectionViewCellOutgoing class]])
    {
        self.avatarViewSize = customAttributes.outgoingAvatarViewSize;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.messageBubbleImageView.highlighted = highlighted;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.messageBubbleImageView.highlighted = selected;
}

//  FIXME: radar 18326340
//         remove when fixed
//         hack for Xcode6 / iOS 8 SDK rendering bug that occurs on iOS 7.x
//         see issue #484
//         https://github.com/jessesquires/FNMessagesViewController/issues/484
//
- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    if ([UIDevice fn_isCurrentDeviceBeforeiOS8]) {
        self.contentView.frame = bounds;
    }
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    self.cellTopLabel.backgroundColor = backgroundColor;
    self.messageBubbleTopLabel.backgroundColor = backgroundColor;
    self.cellBottomLabel.backgroundColor = backgroundColor;
    
    self.messageBubbleImageView.backgroundColor = backgroundColor;
    self.avatarImageView.backgroundColor = backgroundColor;
    
    self.messageBubbleContainerView.backgroundColor = backgroundColor;
    self.avatarContainerView.backgroundColor = backgroundColor;
    
    self.cancleImageView.backgroundColor = [UIColor clearColor];
    self.cancleContainerView.backgroundColor = backgroundColor;
}

- (void)setAvatarViewSize:(CGSize)avatarViewSize
{
    if (CGSizeEqualToSize(avatarViewSize, self.avatarViewSize)) {
        return;
    }
    
    [self fn_updateConstraint:self.avatarContainerViewWidthConstraint withConstant:avatarViewSize.width];
    [self fn_updateConstraint:self.avatarContainerViewHeightConstraint withConstant:avatarViewSize.height];
}

- (void)setTextViewFrameInsets:(UIEdgeInsets)textViewFrameInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(textViewFrameInsets, self.textViewFrameInsets)) {
        return;
    }
    
    [self fn_updateConstraint:self.textViewTopVerticalSpaceConstraint withConstant:textViewFrameInsets.top];
    [self fn_updateConstraint:self.textViewBottomVerticalSpaceConstraint withConstant:textViewFrameInsets.bottom];
    [self fn_updateConstraint:self.textViewAvatarHorizontalSpaceConstraint withConstant:textViewFrameInsets.right];
    [self fn_updateConstraint:self.textViewMarginHorizontalSpaceConstraint withConstant:textViewFrameInsets.left];
}

- (void)setMediaView:(UIView *)mediaView
{
    if ([_mediaView isEqual:mediaView]) {
        return;
    }
    
    [self.messageBubbleImageView removeFromSuperview];
    [self.textView removeFromSuperview];
    
    [mediaView setTranslatesAutoresizingMaskIntoConstraints:NO];
    mediaView.frame = self.messageBubbleContainerView.bounds;
    
    [self.messageBubbleContainerView addSubview:mediaView];
    [self.messageBubbleContainerView fn_pinAllEdgesOfSubview:mediaView];
    _mediaView = mediaView;
    
    //  because of cell re-use (and caching media views, if using built-in library media item)
    //  we may have dequeued a cell with a media view and add this one on top
    //  thus, remove any additional subviews hidden behind the new media view
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSUInteger i = 0; i < self.messageBubbleContainerView.subviews.count; i++) {
            if (self.messageBubbleContainerView.subviews[i] != _mediaView) {
                [self.messageBubbleContainerView.subviews[i] removeFromSuperview];
            }
        }
    });
}

#pragma mark - Getters

- (CGSize)avatarViewSize
{
    return CGSizeMake(self.avatarContainerViewWidthConstraint.constant,
                      self.avatarContainerViewHeightConstraint.constant);
}

- (UIEdgeInsets)textViewFrameInsets
{
    return UIEdgeInsetsMake(self.textViewTopVerticalSpaceConstraint.constant,
                            self.textViewMarginHorizontalSpaceConstraint.constant,
                            self.textViewBottomVerticalSpaceConstraint.constant,
                            self.textViewAvatarHorizontalSpaceConstraint.constant);
}

#pragma mark - Utilities

- (void)fn_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant
{
    if (constraint.constant == constant) {
        return;
    }
    
    constraint.constant = constant;
}

#pragma mark - Gesture recognizers

- (void)fn_handleTapGesture:(UITapGestureRecognizer *)tap
{
    CGPoint touchPt = [tap locationInView:self];
    if (CGRectContainsPoint(self.avatarContainerView.frame, touchPt)) {
        [self.delegate messagesCollectionViewCellDidTapAvatar:self];
    }
    else if (CGRectContainsPoint(self.messageBubbleContainerView.frame, touchPt)) {
        [self.delegate messagesCollectionViewCellDidTapMessageBubble:self atPosition:touchPt];
    }
    else if (CGRectContainsPoint(self.cancleContainerView.frame, touchPt))
    {
        [self.delegate messagesCollectionViewCellDidTapCancle:self atPosition:touchPt];
    }
    else {
        [self.delegate messagesCollectionViewCellDidTapCell:self atPosition:touchPt];
    }
}

- (void)fn_handleLongTapGesture:(UILongPressGestureRecognizer *)longTap
{
    CGPoint touchPt = [longTap locationInView:self];
    
    if (CGRectContainsPoint(self.messageBubbleImageView.frame, touchPt))
    {
        [self.delegate messagesCollectionViewCellDidLongTapMessageBubble:self atPosition:touchPt];
    }
    else if (CGRectContainsPoint(self.avatarImageView.frame, touchPt))
    {
        [self.delegate messagesCollectionViewCellDidLongTapAvatar:self];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPt = [touch locationInView:self];

    if (CGRectContainsPoint(self.messageBubbleContainerView.frame, touchPt))
    {
        if (self.textView.isHaveLink == YES)
        {
            return NO;
        }
    }
     
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            if (CGRectContainsPoint(self.avatarContainerView.frame, touchPt))
            {
                return YES;
            }
            return CGRectContainsPoint(self.messageBubbleContainerView.frame, touchPt);
        }

    }

    return YES;
    
}

#pragma mark - Openlink Delegate

- (void) goToLink:(NSString *)address ofType:(NSTextCheckingType)type
{
    switch (type) {
        case NSTextCheckingTypeLink:
        {
            if (!([address hasPrefix:@"http://"] == YES || [address hasPrefix:@"https://"] == YES))
            {
                address = [NSString stringWithFormat:@"http://%@",address];
            }
        }
            break;
            
        case NSTextCheckingTypePhoneNumber:
        {
            NSString *telNumber = [NSString stringWithFormat:@"tel://%@", address];
            _webview = [[UIWebView alloc] init];
            [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:telNumber]]];
        }
            break;
            
        default:
            break;
    }
}

- (void)translate:(id)sender
{
    UIView* v = self;
    do {
        v = v.superview;
    } while (![v isKindOfClass:[UICollectionView class]]);
    
    UICollectionView* cv = (UICollectionView*) v;

    NSIndexPath* ip = [cv indexPathForCell:self];

    if (cv.delegate && [cv.delegate respondsToSelector:@selector(collectionView:performAction:forItemAtIndexPath:withSender:)])
    {
        [cv.delegate collectionView:cv performAction:_cmd forItemAtIndexPath:ip withSender:sender];
    }
}


@end
