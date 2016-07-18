//
//  UIImage+FNRound.m
//  FetionCloudDemo
//
//  Created by feinno on 16/1/4.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "UIImage+FNRound.h"

@implementation UIImage (FNRound)

+ (UIImage *)roundWithImage:(UIImage *)image diameter:(CGFloat)diameter
{
    CGRect frame = CGRectMake(0, 0, 100, 100);
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:15];
    
    [path addClip];
    
    [image drawInRect:frame];
    
    CGContextRestoreGState(ctx);
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();

    return result;
}

@end
