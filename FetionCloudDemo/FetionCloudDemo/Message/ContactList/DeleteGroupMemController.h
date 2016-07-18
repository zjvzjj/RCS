//
//  DeleteGroupMemController.h
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/28.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *DisGroupAddMsg;

@interface DeleteGroupMemController : UITableViewController

/**
 *  群成员添加在此类中操作（不是删除）
 */

@property (nonatomic, copy) NSString *groupId;
//辨别讨论组的创建
@property (nonatomic, assign) BOOL isCreate;
//辨别是否添加联系人
@property (nonatomic, assign) BOOL isAdd;
//删除群成员时候需要传入的群成员数据
@property (nonatomic, strong) NSArray *personArray;
//群详情进入判别
@property (nonatomic, assign) BOOL isDetail;

@end
