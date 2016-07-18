//
//  FZConversationOddCell.h
//  FANSZ
//
//  Created by yiqingping on 16/1/24.
//  Copyright © 2016年 FANSZ. All rights reserved.
//

#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height
#define kCellHeight 74
#define kMarginX 16
#define kMarginY  21

#define kMarginX2  16
#define kMarginY2  10

#define kImageWidth 43
#define kMarginY3 26
#define kMarginY4 13

#define kUnreadW  18
#import "MessageTableCell.h"
#import <UIKit/UIKit.h>
#import "MessageTableModel.h"

@interface MessageTableCell : UITableViewCell

@property(nonatomic,strong) MessageTableModel *dataModel ;

+ (instancetype)messageListCellWithTableView:(UITableView *)tableView;



@end
