//
//  ShapedImageView.h
//  制作聊天显示的不规则图片
//
//  Created by  易庆萍 on 16/1/11.
//  Copyright © 2016年 易庆萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNImage.h"

@interface ShapedImageView : UIImageView
- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString*)inageName;
@end
