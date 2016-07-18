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

#import <UIKit/UIKit.h>

@protocol LinkOpening <NSObject>

- (void) goToLink:(NSString *)address ofType:(NSTextCheckingType)type;

@end

@interface CTRunDeRef : NSObject

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, retain) NSString *name;

@end

@interface FNMessagesCellTextView : UIView

@property (nonatomic, assign) id <LinkOpening> delegate;

@property (nonatomic, assign) UIEdgeInsets edge;

@property (nonatomic, retain) NSString *text;

@property (assign, nonatomic) BOOL isHaveLink;

+ (CGSize) estimatedSize:(CGSize)fits string:(NSString *)text;

@end
