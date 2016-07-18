//
//  ContactListController.h
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactListController : UITableViewController

@property (strong,nonatomic) NSMutableArray *buddyIDArray;


//@property (nonatomic,strong)NSMutableArray *buddyInfoArray;

@property (strong,nonatomic)NSMutableArray *buddyPortraitPath;


@property (copy,nonatomic)NSString *imgPath;

@end
