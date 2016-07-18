//
//  GroupDetailController.h
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/18.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailController : UIViewController

@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, assign) NSInteger enterType;//辨别是由最近会话进入还是群列表进入

@end
