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

#import "UIView+FNMessages.h"

@implementation UIView (FNMessages)

- (void)fn_pinSubview:(UIView *)subview toEdge:(NSLayoutAttribute)attribute
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:attribute
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:subview
                                                     attribute:attribute
                                                    multiplier:1.0f
                                                      constant:0.0f]];
}

- (void)fn_pinAllEdgesOfSubview:(UIView *)subview
{
    [self fn_pinSubview:subview toEdge:NSLayoutAttributeBottom];
    [self fn_pinSubview:subview toEdge:NSLayoutAttributeTop];
    [self fn_pinSubview:subview toEdge:NSLayoutAttributeLeading];
    [self fn_pinSubview:subview toEdge:NSLayoutAttributeTrailing];
}

@end
