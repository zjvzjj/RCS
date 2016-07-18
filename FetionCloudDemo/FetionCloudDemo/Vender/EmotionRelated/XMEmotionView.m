//
//  XMEmotionView.m
//  Fetion
//
//  Created by jiaoruixue on 11-12-20.
//  Copyright (c) 2011年 xinrui.com. All rights reserved.
//

#import "XMEmotionView.h"
#import "FNImage.h"

@implementation XMEmotionView

@synthesize emojreceiver;

@synthesize textViewDelegate = _textViewDelegate;
@synthesize delegate = _delegate;
@synthesize viewControllerDelegate = _viewControllerDelegate;
@synthesize defaultEmotionPage = _defaultEmotionPage;
@synthesize pageControl = _pageControl;
@synthesize sendButton = _sendButton;
@synthesize resignButton = _resignButton;
@synthesize defaultScrollView = _defaultScrollView;
@synthesize emotionArray = _emotionArray;

- (id)initWithType:(XMEmotionViewType)type
{
    self = [super initWithFrame:CGRectMake(0, 480, [UIScreen mainScreen].bounds.size.width, 216)];
    if (self)
    {
        _type = type;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [[FNImage imageWithName:@"XMrichtext_view_bg"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
        [self addSubview:imageView];

        [self initPageControl];
        [self initDefaultScrollView];        
    }
    
    return self;
}

- (void)initPageControl
{
    _pageControl = [[XMPageControl alloc] initWithFrame:CGRectMake(0, 197, [UIScreen mainScreen].bounds.size.width, 16)];
    _pageControl.backgroundColor = [UIColor clearColor];
    [_pageControl circlesCount:3];
    [_pageControl currentCount:(int)_defaultEmotionPage];
    [self addSubview:_pageControl];
}

- (void)initDefaultScrollView
{
    defaultViewShown = YES;
    _defaultEmotionPage = 0;

    _defaultScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 197)];
    _defaultScrollView.backgroundColor = [UIColor clearColor];
    _defaultScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 197);
    _defaultScrollView.showsHorizontalScrollIndicator = NO;
    _defaultScrollView.showsVerticalScrollIndicator = NO;
    _defaultScrollView.pagingEnabled = YES;
    _defaultScrollView.delegate = self;
    int x = 0, y = 0;
    UIButton *btn;
    UIImage *image;
    int count = 0;
    NSString *imageName = nil;
    for (int page = 0; page < 3; page++)
    {
        y = 18;
        for (int row = 0; row < 4; row++)
        {
            x = page * [UIScreen mainScreen].bounds.size.width + 10;
            int columnCount = 0;
            if (_type != XMEmotionViewType_PublishBroadcast && row == 3)
            {
                columnCount = 6;
            }
            else
            {
                columnCount = 7;
            }
            
            for (int column = 0; column < columnCount && count < 84; column++)
            {
                if (row == (_type != XMEmotionViewType_PublishBroadcast ? 2 : 3) && column == 6)
                {
                    btn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 48 + page * [UIScreen mainScreen].bounds.size.width, y + 1, 38, 27)];
                    [btn addTarget:self action:@selector(deleteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                    [btn setBackgroundImage:[FNImage imageWithName:@"XMbutton_Delete_normal"] forState:UIControlStateNormal];
                    [_defaultScrollView addSubview:btn];
                }
                else if (_type != XMEmotionViewType_PublishBroadcast && row == 3 && column == 5)
                {
                }
                else if (count < 71)
                {
                    count++;
                    btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 29, 29)];
                    [btn addTarget:self action:@selector(defaultEmotionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    NSDictionary *nameDictionary = [self.emotionArray objectAtIndex:0];
                    imageName = [nameDictionary objectForKey:[NSString stringWithFormat:@"%d", count]];
                    imageName = [imageName stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]];
                    image = [FNImage emojWithName:imageName];
                    [btn setBackgroundImage:image forState:UIControlStateNormal];
                    [_defaultScrollView addSubview:btn];
                    btn.tag = count;
                }
                
                if (_type != XMEmotionViewType_PublishBroadcast && row == 3 && column == 5)
                {
                    x += 91;
                }
                else
                {
                    x += ([UIScreen mainScreen].bounds.size.width - 20 - 29 * 7) / 6 + 29;
                }
            }
            if (_type != XMEmotionViewType_PublishBroadcast && row == 3)
            {
                y += 56;
            }
            else
            {
                y += 45;
            }
        }
    }
    if (_type == XMEmotionViewType_Comment)
    {
        btn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - (([UIScreen mainScreen].bounds.size.width - 20 - 29 * 7) / 6 + 29 * 2 + 10), 147, ([UIScreen mainScreen].bounds.size.width - 20 - 29 * 7) / 6 + 29 * 2, 40)];
        [btn addTarget:self action:@selector(sendButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[FNImage imageWithName:@"XM_button_Send_normal"] forState:UIControlStateNormal];
        [btn setTitle:@"发送" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:49/255.0 green:146/255.0 blue:223/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [_defaultScrollView addSubview:btn];
        self.sendButton = btn;
    }
    else if (_type == XMEmotionViewType_PublishTopic)
    {
        btn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - (([UIScreen mainScreen].bounds.size.width - 20 - 29 * 7) / 6 + 29 * 2 + 10), 147, ([UIScreen mainScreen].bounds.size.width - 20 - 29 * 7) / 6 + 29 * 2, 40)];
        [btn addTarget:self action:@selector(resignButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[FNImage imageWithName:@"XM_button_Send_normal"] forState:UIControlStateNormal];
        [btn setTitle:@"返回键盘" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:49/255.0 green:146/255.0 blue:223/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [_defaultScrollView addSubview:btn];
        self.resignButton = btn;
    }
    
    [self addSubview:_defaultScrollView];
}

- (void)dealloc
{
    self.textViewDelegate = nil;
    self.delegate = nil;
    self.viewControllerDelegate = nil;
    self.pageControl = nil;
    self.defaultScrollView = nil;
    self.sendButton = nil;
    self.resignButton = nil;
    self.emotionArray = nil;
}

- (void)show
{
    if (defaultViewShown)
    {
        [_defaultScrollView flashScrollIndicators];
        [_pageControl circlesCount:3];
        [_pageControl currentCount:(int)_defaultEmotionPage];
    }
    
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216 - 64, [UIScreen mainScreen].bounds.size.width, 216);
    [self updateEmotonViewButtonsStatus];
}

- (void)defaultEmotionButtonPressed:(id)sender
{
	if ([sender isKindOfClass:[UIButton class]])
    {
		UIButton *btn = (UIButton *)sender;
		NSInteger count = btn.tag;

        NSDictionary *emojiDictionary = [self.emotionArray objectAtIndex:0];
        NSString *theEmotion = [emojiDictionary objectForKey:[NSString stringWithFormat:@"%ld", (long)count]];
        
        if ([emojreceiver respondsToSelector:@selector(emojiSelected:name:emojid:)])
        {
            NSDictionary *name2ImageDictionary = [self.emotionArray objectAtIndex:1];
            NSString *emojimgname = name2ImageDictionary[theEmotion];
            
            NSDictionary *name2IdDictionary = [self.emotionArray objectAtIndex:2];
            NSString *emojid = name2IdDictionary[theEmotion];
            
            UIImage *emojimg = [UIImage imageNamed:emojimgname];
            
            [emojreceiver emojiSelected:emojimg name:theEmotion emojid:emojid];
        }
        
        NSRange textRange = [_textViewDelegate getCurrentRange];
        NSString *content = [_textViewDelegate getCurrentText];
		if (content != nil && [content length] > 0)
        {
            if (_type == XMEmotionViewType_Comment)
            {
                NSUInteger maxLength = 400;
                if ([theEmotion length] > maxLength - [content length])
                {
                    /**
                     *  
                     */
//                    CGFloat y = [UIApplication sharedApplication].keyWindow.center.y - 125;
//                    [XmTipView showTipViewWithText:[NSString stringWithFormat:@"最多输入%lu字", (unsigned long)maxLength] andFrame:CGRectMake(10, y, 300, 40)];
                }
                else if (textRange.location != NSNotFound)
                {
                    NSString *preText = [content substringToIndex:textRange.location];
                    NSString *sufText = [content substringFromIndex:textRange.location];
                    content = [[preText stringByAppendingString:theEmotion] stringByAppendingString:sufText];
                }
                else
                {
                    content = [content stringByAppendingString:theEmotion];
                }
            }
            else
            {
                if (textRange.location != NSNotFound)
                {
                    NSString *preText = [content substringToIndex:textRange.location];
                    NSString *sufText = [content substringFromIndex:textRange.location];
                    content = [[preText stringByAppendingString:theEmotion] stringByAppendingString:sufText];
                }
                else
                {
                    content = [content stringByAppendingString:theEmotion];
                }
            }
		}
		else
        {
			content = [NSString stringWithString:theEmotion];
		}
        [_textViewDelegate updateWithText:content];
        [_textViewDelegate setCurrentRange:NSMakeRange(textRange.location + [theEmotion length], 0)];
        if (_delegate && [_delegate respondsToSelector:@selector(textViewDidChange:)])
        {
            [_delegate textViewDidChange:_delegate];
        }
    }
}

- (void)deleteButtonPressed
{
    if ([emojreceiver respondsToSelector:@selector(emojRemove)])
    {
        [emojreceiver emojRemove];
    }
    
    NSRange textRange = [_textViewDelegate getCurrentRange];
    if (textRange.location == 0 && textRange.length == [[_textViewDelegate getCurrentText] length])
    {
        [_textViewDelegate updateWithText:nil];
    }
    else
    {
        NSString *currentText = [_textViewDelegate getCurrentText];
        NSString *preText = textRange.location == NSNotFound ? currentText : [[_textViewDelegate getCurrentText] substringToIndex:textRange.location];
        NSString *sufText = textRange.location == NSNotFound ? nil : [[_textViewDelegate getCurrentText] substringFromIndex:textRange.location];
        if ([preText length] == 0)
        {
            return;
        }
        
        NSInteger length = 1;
        NSString *lastChar = [preText substringWithRange:NSMakeRange([preText length] - 1, 1)];
        if ([lastChar isEqualToString:@"]"])
        {
            NSString *regex = @"\\[/[a-zA-Z0-9\\u4e00-\\u9fa5 ]+\\]";
            NSArray *array = [preText componentsMatchedByRegex:regex];
            if ([array count] > 0)
            {
                NSString *last = [array objectAtIndex:[array count] - 1];
                NSDictionary *name2ImageDictionary = [self.emotionArray objectAtIndex:1];
                if ([[name2ImageDictionary objectForKey:last] length] > 0)
                {
                    length = [last length];
                }
            }
        }
        preText = [preText substringToIndex:[preText length] - length];
        [_textViewDelegate updateWithText:[sufText length] > 0 ? [preText stringByAppendingString:sufText] : preText];
        if (textRange.location != NSNotFound)
        {
            [_textViewDelegate setCurrentRange:NSMakeRange(textRange.location - length, 0)];
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [_delegate textViewDidChange:_delegate];
    }
    
    [self updateEmotonViewButtonsStatus];
}

- (void) sendButtonPressed
{
    if ([emojreceiver respondsToSelector:@selector(emojSend)])
    {
        [emojreceiver emojSend];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [_delegate textView:_delegate shouldChangeTextInRange:[_textViewDelegate getCurrentRange] replacementText:@"\n"];
    }
    [self updateEmotonViewButtonsStatus];
}

- (void)resignButtonPressed
{
    if (_viewControllerDelegate && [_viewControllerDelegate respondsToSelector:@selector(returnToKeyboard)])
    {
//        [_viewControllerDelegate returnToKeyboard];
    }
    
    [self updateEmotonViewButtonsStatus];
}

- (void)updateEmotonViewButtonsStatus
{
    if (_textViewDelegate != nil && [_textViewDelegate respondsToSelector:@selector(getCurrentText)])
    {
        if ([[_textViewDelegate getCurrentText] length] == 0)
        {
            _sendButton.enabled = NO;
        }
        else
        {
            _sendButton.enabled = YES;
        }
    }
}


#pragma mark -
#pragma mark ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 4) / scrollView.frame.size.width) + 1;
    [_pageControl currentCount:(int)page];
    if (defaultViewShown)
    {
        _defaultEmotionPage = page;
    }
    
    self.sendButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - (([UIScreen mainScreen].bounds.size.width - 20 - 29 * 7) / 6 + 29 * 2 + 10) + [UIScreen mainScreen].bounds.size.width * _defaultEmotionPage, 147, ([UIScreen mainScreen].bounds.size.width - 20 - 29 * 7) / 6 + 29 * 2, 40);
    self.resignButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - (([UIScreen mainScreen].bounds.size.width - 20 - 29 * 7) / 6 + 29 * 2 + 10) + [UIScreen mainScreen].bounds.size.width * _defaultEmotionPage, 147, ([UIScreen mainScreen].bounds.size.width - 20 - 29 * 7) / 6 + 29 * 2, 40);
}

#pragma mark -
#pragma mark getter

- (NSArray *)emotionArray
{
    if (!_emotionArray) {
        _emotionArray = [[NSArray alloc] initWithContentsOfFile:[FNImage emojPlist]];
    }
    return _emotionArray;
}
@end
