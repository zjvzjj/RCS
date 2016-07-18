//
//  FNMessageCancleImageDataSource.h
//  Fetion
//
//  Created by Dominate on 15/9/14.
//  Copyright (c) 2015年 xinrui.com. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FNMessageCancleImageDataSource <NSObject>

@required


- (UIImage *)messageCancleImage;

- (UIImage *)messageCancleHighlightedImage;

@end
