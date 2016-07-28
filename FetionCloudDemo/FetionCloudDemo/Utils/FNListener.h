//
//  FNListener.h
//  FetionCloudDemo
//
//  Created by feinno on 16/7/28.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNListener : NSObject

@property (nonatomic,strong) NSMutableArray *buddyIDArray;
@property (nonatomic,strong)NSMutableArray *addBuddyArray;
@property (nonatomic,copy) NSString* localNum;


+ (instancetype)ShareStaticConst;

- (void)registerBuddyEventListener;
- (void)registerBuddyListListener;
- (void)registerMsgListener;

@end
