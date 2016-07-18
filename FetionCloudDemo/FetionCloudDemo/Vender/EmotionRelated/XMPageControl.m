//
//  XMPageControl.m
//  DragScrollView
//
//  Created by iPhone on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.


#import "XMPageControl.h"
#import "XMCircleView.h"

@implementation XMPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
		circleViewArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)circlesCount:(int)circlesCount
{
	for (UIView *view in [self subviews])
	{
		if ([view isKindOfClass:[UIImageView class]])
        {
			continue;
        }
        
		[view removeFromSuperview];
	}
    
	[circleViewArray removeAllObjects];
	for (int i = 0; i < circlesCount; i++)
	{
		int current_x = 0;
		if (i <= circlesCount / 2)
        {
			current_x = self.frame.size.width / 2 - (circlesCount / 2 - i) * 10;
        }
		else
        {
			current_x = self.frame.size.width / 2 + (i - circlesCount / 2) * 10;
        }
        
		CGRect circleViewframe = CGRectMake(current_x, 0, 7, 7);
		circleView = [XMCircleView circleViewWithFrame:circleViewframe Color:[UIColor yellowColor]];
		[circleViewArray addObject:circleView];
		[self addSubview:circleView];
	}
}

- (void)currentCount:(int)circleCount
{
    if (circleViewArray && [circleViewArray count] > 0 && [circleViewArray count] > circleCount)
    {
        for (XMCircleView *aCircleView in circleViewArray)
        {
            if ([circleViewArray indexOfObject:aCircleView] == circleCount)
            {
                [aCircleView changeColor:[UIColor greenColor]];
            }
            else
            {
                [aCircleView changeColor:[UIColor whiteColor]];
            }
        }
    }
}

- (void)setNewMsgCount:(int)circleCount msgCount:(int)msgcount 
{
	if (circleCount >= [circleViewArray count])
    {
		return;
    }
    
	XMCircleView *aCircleView = [circleViewArray objectAtIndex:circleCount];
	if (aCircleView)
	{
		if (msgcount > 0 && msgcount < 10)
        {
			[aCircleView setTextChange:[NSString stringWithFormat:@"%d", msgcount]];
        }
		else if (msgcount >= 10)
        {
			[aCircleView setTextChange:@"n"];
        }
		else
        {
			[aCircleView setTextChange:nil];
        }
	}
}

- (void)drawRect:(CGRect)rect
{
}

@end
