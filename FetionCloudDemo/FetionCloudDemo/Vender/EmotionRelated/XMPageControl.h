//
//  XMPageControl.h
//  DragScrollView
//
//  Created by iPhone on 10-12-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XMCircleView;

@interface XMPageControl : UIView
{
    
	XMCircleView *circleView;
	NSMutableArray *circleViewArray;
}

- (void)circlesCount:(int)circlesCount;
- (void)currentCount:(int)circleCount;
- (void)setNewMsgCount:(int)circleCount msgCount:(int)msgcount;

@end
