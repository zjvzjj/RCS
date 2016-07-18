//
//  FNBundle.m
//  FetionCloudDemo
//
//  Created by feinno on 16/1/6.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNBundle.h"

@implementation FNBundle

NSBundle *FNBundleName = nil;

NSString *FNBundleDirectoryFile = @"files/";

NSString *FNBundleDirectoryImage = @"images/";

NSString *FNBundleDirectoryEmotion = @"images/emotions/";

NSString *FNBundleDirectorySounds = @"sounds/";

+ (BOOL)bundleWithName:(NSString *)name
{
    NSAssert(name, @"Bundle name can't be nil");
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"bundle"];
    
    FNBundleName = [NSBundle bundleWithPath:path];
        
    if (FNBundleName && FNBundleName.bundlePath.length)
    {
        return YES;
    }

    return NO;
}

@end
