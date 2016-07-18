//
//  FNUserInfo.m
//  FetionCloudDemo
//
//  Created by feinno on 16/6/30.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNUserInfo.h"

@implementation FNUserInfo

+(instancetype)ShareStaticConst{

    static FNUserInfo * _static = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (_static == nil)
        {
            _static = [[FNUserInfo alloc]init];
        }
    });
    return _static;
    
}

@end
