//
//  ShapedImageView.m
//  制作聊天显示的不规则图片
//
//  Created by  易庆萍on 16/1/11.
//  Copyright © 2016年 易庆萍. All rights reserved.
//

#import "ShapedImageView.h"


@interface ShapedImageView()
{
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
@end

@implementation ShapedImageView

- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString*)inageName
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChart:inageName];
    }
    return self;
}
//圆形图
- (void)setupCircle
{
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor redColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
}

//带尖角的聊天背景
- (void)setupChart:(NSString*)inageName
{
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;//非常关键设置自动拉伸的效果且不变形
    UIImage *image=[FNImage imageWithName:inageName];
    _maskLayer.contents = (id)image.CGImage;
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
}


- (void)setImage:(UIImage *)image
{
    _contentLayer.contents = (id)image.CGImage;
}

@end
