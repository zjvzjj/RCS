//
//  BirthSelectSheet.h
//  FetionCloudDemo
//
//  Created by feinno on 16/8/1.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthSelectSheet : UIActionSheet

@property (nonatomic, copy) void(^GetSelectDate)(NSString *dateStr);
@property (nonatomic, strong) NSString * selectDate;

@end
