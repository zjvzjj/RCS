//
//  XMCircleView.m
//  DragScrollView
//
//  Created by iPhone on 10-12-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "XMCircleView.h"

@implementation XMCircleView

+ (id)circleViewWithFrame:(CGRect)aFrame Color:(UIColor *)aColor
{
	XMCircleView *newCircleView = [[XMCircleView alloc] initWithFrame:aFrame Color:aColor];
	
	return newCircleView;
}

- (id)initWithFrame:(CGRect)aFrame Color:(UIColor *)aColor
{
    self = [super initWithFrame:aFrame];
	self.backgroundColor = [UIColor clearColor];
    if (self)
    {
		currentFrame = aFrame;
		currentColor = aColor;
		mylabel = [[UILabel alloc] initWithFrame:CGRectZero];
		mylabel.font = [UIFont systemFontOfSize:12.0];
		mylabel.textColor = [UIColor whiteColor];
		mylabel.textAlignment = NSTextAlignmentCenter;
		mylabel.backgroundColor = [UIColor clearColor];
		[self addSubview:mylabel];
    }
    
    return self;
}

- (void)changeColor:(UIColor *)aColor
{
	currentColor = aColor;
	[self setNeedsDisplay];
}

- (void)setTextChange:(NSString *)text
{
	if ([text isEqualToString:mylabel.text] == NO)
	{
		mylabel.text = text;
		if ([mylabel.text length] > 0)
        {
			currentColor = [UIColor whiteColor];
        }
        else if (currentColor != [UIColor greenColor])
        {
            currentColor = [UIColor yellowColor];
        }
        
		[self setNeedsDisplay];
	}
}

- (void)drawRect:(CGRect)rect 
{
	CGContextRef context = UIGraphicsGetCurrentContext();			
	UIImage *image = nil;
	if (currentColor == [UIColor whiteColor])
    {
		image = [UIImage imageNamed:@"XMBeside.bundle/images/XMdot_news_default"];
	}
	else if (currentColor == [UIColor greenColor])
	{
        image = [UIImage imageNamed:@"XMBeside.bundle/images/XMdot_select_default"];
	}
    else if (currentColor == [UIColor yellowColor])
    {
		image = [UIImage imageNamed:@"XMBeside.bundle/images/XMdot_nor_default"];
    }
    
    CGContextDrawImage(context, rect, image.CGImage);
	
    CGRect newRect = CGRectMake(rect.origin.x + 2, rect.origin.y + 2, rect.size.width - 4, rect.size.height - 4);
	[mylabel drawTextInRect:newRect];
}

@end
