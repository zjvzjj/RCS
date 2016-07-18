//
//  BOPReachability+Extension.m
//  FetionCloudDemo
//
//  Created by feinno on 16/1/11.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "BOPReachability+Extension.h"

@implementation BOPReachability (Extension)

+ (BOOL)isReachable
{
    BOPReachability *reach = [BOPReachability reachabilityWithHostName:@"http://www.baidu.com"];
    
    if (reach.currentReachabilityStatus == BOPNotReachable)
    {
        return NO;
    }
    
    return YES;
}

@end
