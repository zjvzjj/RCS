//
//  XMCircleView.h
//  DragScrollView
//
//  Created by iPhone on 10-12-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMCircleView : UIView
{
    
	CGRect currentFrame;
	UIColor *currentColor;
	UILabel *mylabel;
}

+ (id)circleViewWithFrame:(CGRect)aFrame Color:(UIColor *)aColor;
- (id)initWithFrame:(CGRect)aFrame Color:(UIColor *)aColor;
- (void)changeColor:(UIColor *)aColor;
- (void)setTextChange:(NSString *)text;

@end
