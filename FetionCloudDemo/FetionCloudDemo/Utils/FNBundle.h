//
//  FNBundle.h
//  FetionCloudDemo
//
//  Created by feinno on 16/1/6.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSBundle *FNBundleName;

extern NSString *FNBundleDirectoryFile;

extern NSString *FNBundleDirectoryImage;

extern NSString *FNBundleDirectoryEmotion;

extern NSString *FNBundleDirectorySounds;

@interface FNBundle : NSObject

+ (BOOL)bundleWithName:(NSString *)name;

@end
