//
//  FZChatContactCell.m
//  FANSZ
//
//  Created by feinno on 16/1/20.
//  Copyright © 2016年 FANSZ. All rights reserved.
//

#import "ABChatContactCell.h"

@interface ABChatContactCell ()
{

}

@end

@implementation ABChatContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _checkView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 15, 25, 25)];
        
        _checkView.image = [UIImage imageNamed:@"check_weixuan"];
        
        [self.contentView addSubview:_checkView];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(_checkView.frame.origin.x+_checkView.frame.size.width+12, 5, 40, 40)];
        
        _iconView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconView.frame.origin.x+_iconView.frame.size.width+10, 15, self.frame.size.width-_iconView.frame.size.width-_iconView.frame.origin.x-10, 20)];
        
        _titleLabel.textColor = [UIColor blackColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        _titleLabel.shadowColor = [UIColor whiteColor];
        
        _titleLabel.shadowOffset = CGSizeMake(0, 1);
        
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(_iconView.frame.origin.x+_iconView.frame.size.width+10, 15, self.frame.size.width-_iconView.frame.size.width-_iconView.frame.origin.x-10, 20);
}


- (void)checkTypeCell:(BOOL)check
{
    if (check)
    {
        _checkView.image = [UIImage imageNamed:@"check_xuanzhong"];
    }
    else
    {
        _checkView.image = [UIImage imageNamed:@"check_weixuan"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
