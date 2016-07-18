//
//  GroupMemberController.h
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/18.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  群成员和讨论组成员类，在此类中删除群成员
 */

extern NSString *DeleteGroupMsg;

@interface GroupMemberController : UITableViewController

@property (nonatomic, copy) NSString *groupID;
@property (nonatomic, assign) BOOL isOwner;
@property (nonatomic, assign) int groupType;

@end
