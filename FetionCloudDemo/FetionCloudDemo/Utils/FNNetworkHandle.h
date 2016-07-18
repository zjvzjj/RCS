//
//  FNNetworkHandle.h
//  FANSZ
//
//  Created by feinno on 16/1/21.
//  Copyright © 2016年 FANSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNNetworkHandle : NSObject

+ (instancetype)sharedInstance;
+ (void)handelNetwork;

@end
