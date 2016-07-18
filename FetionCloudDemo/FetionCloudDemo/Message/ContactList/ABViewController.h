//
//  ABViewController.h
//  FetionCloudDemo
//
//  Created by Nemo on 16/3/3.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *ABGroupAddMsg;

@interface ABViewController : UITableViewController

@property (nonatomic, retain) NSString *groupId;

@property (nonatomic, assign) BOOL isNewGroup;  //是 创建 or 添加

@property (nonatomic, assign) BOOL isDisGroup;  //是否是讨论组


@end
