//
//  BaseView.h
//  Pinche
//
//  Created by haole on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//
// BaseView实现功能
// 1，继承自UIScrollView，实现视图上下弹拉效果
// 2，视图空白处触摸，实现键盘消失效果
// 3，避免视图上的空间输入文字时键盘遮挡效果
//

@interface BaseView : UIScrollView
{
    UIEdgeInsets    _priorInset;
    BOOL            _priorInsetSaved;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    CGSize          _originalContentSize;
}

- (void)adjustOffsetIfNeeded;

@end
