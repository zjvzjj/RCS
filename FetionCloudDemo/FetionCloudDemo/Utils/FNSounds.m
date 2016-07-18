//
//  FNSounds.m
//  FetionCloudDemo
//
//  Created by feinno on 16/1/7.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNSounds.h"

@implementation FNSounds

+ (NSString *)pathWithName:(NSString *)name
{
    return [self pathWithName:name ext:@"aiff"];
}

+ (NSString *)pathWithName:(NSString *)name ext:(NSString *)ext
{
    return [FNBundleName pathForResource:name ofType:ext inDirectory:FNBundleDirectorySounds];
}

+ (NSURL *)urlWithName:(NSString *)name ext:(NSString *)ext
{
    return [FNBundleName URLForResource:name withExtension:ext subdirectory:FNBundleDirectorySounds];
}

@end
