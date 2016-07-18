//
//  FNMessagesCancleImage.h
//  Fetion
//
//  Created by Dominate on 15/9/14.
//  Copyright (c) 2015年 xinrui.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNMessageCancleImageDataSource.h"

@interface FNMessagesCancleImage : NSObject <FNMessageCancleImageDataSource,NSCopying>

@property (strong, nonatomic, readonly) UIImage *messageCancleImage;

@property (strong, nonatomic, readonly) UIImage *messageCancleHighlightedImage;

- (instancetype)initWithMessageCancleImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

@end
