//
//  XMEmotionView.h
//  Fetion
//
//  Created by jiaoruixue on 11-12-20.
//  Copyright (c) 2011年 xinrui.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPageControl.h"
#import "RegexKitLite.h"

typedef enum
{
    XMEmotionViewType_Comment = 0,
    XMEmotionViewType_PublishBroadcast = 1,
    XMEmotionViewType_PublishTopic = 2,
}XMEmotionViewType;

@protocol XMTextViewDelegate;

@protocol EmojiSending <NSObject>

- (void) emojiSelected:(UIImage *)image name:(NSString *)name emojid:(NSString *)ID;

- (void) emojRemove;

- (void) emojSend;

@end

@interface XMEmotionView : UIView <UIScrollViewDelegate>
{
    
//    id<XMTextViewDelegate> _textViewDelegate;
//    id _delegate;
//    id _viewControllerDelegate;
@private
    NSUInteger _defaultEmotionPage;
    XMPageControl * _pageControl;
    UIScrollView * _defaultScrollView;
    UIButton * _sendButton;
    UIButton * _resignButton;
    BOOL defaultViewShown;
    XMEmotionViewType _type;
}

@property (nonatomic, assign) id <EmojiSending> emojreceiver;

@property (nonatomic, assign) id<XMTextViewDelegate> textViewDelegate;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) id viewControllerDelegate;
@property (nonatomic, assign) NSUInteger defaultEmotionPage;
@property (nonatomic, strong) XMPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *defaultScrollView;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *resignButton;
@property (nonatomic, strong) NSArray *emotionArray;

- (id)initWithType:(XMEmotionViewType)type;
- (void)initPageControl;
- (void)initDefaultScrollView;
- (void)show;
- (void)defaultEmotionButtonPressed:(id)sender;
- (void)deleteButtonPressed;
- (void)sendButtonPressed;
- (void)resignButtonPressed;
- (void)updateEmotonViewButtonsStatus;

@end

@protocol XMTextViewDelegate <NSObject>

@required
- (NSString *)getCurrentText;
- (NSRange)getCurrentRange;
- (void)setCurrentRange:(NSRange)aRange;
- (void)updateWithText:(NSString *)text;

@end
