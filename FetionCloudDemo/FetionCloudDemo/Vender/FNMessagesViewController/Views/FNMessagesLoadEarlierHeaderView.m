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


#import "FNMessagesLoadEarlierHeaderView.h"

const CGFloat kFNMessagesLoadEarlierHeaderViewHeight = 32.0f;


@interface FNMessagesLoadEarlierHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *loadButton;

- (IBAction)loadButtonPressed:(UIButton *)sender;

@end



@implementation FNMessagesLoadEarlierHeaderView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([FNMessagesLoadEarlierHeaderView class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)headerReuseIdentifier
{
    return NSStringFromClass([FNMessagesLoadEarlierHeaderView class]);
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
//    [self.loadButton setTitle:NSLocalizedStringFromTable(@"Load Earlier Messages", @"FNMessages", @"Text for button to load previously sent messages")
//                     forState:UIControlStateNormal];
    [self.loadButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
}

- (void)dealloc
{
    _loadButton = nil;
    _delegate = nil;
}

#pragma mark - Reusable view

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.loadButton.backgroundColor = backgroundColor;
}

#pragma mark - Actions

- (IBAction)loadButtonPressed:(UIButton *)sender
{
    [self.delegate headerView:self didPressLoadButton:sender];
}

@end
