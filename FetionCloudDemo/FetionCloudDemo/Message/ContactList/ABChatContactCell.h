//
//  FZChatContactCell.h
//  FANSZ
//
//  Created by feinno on 16/1/20.
//  Copyright © 2016年 FANSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABChatContactCell : UITableViewCell

@property (nonatomic, strong) UIImageView *checkView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

- (void)checkTypeCell:(BOOL)check;

@end
