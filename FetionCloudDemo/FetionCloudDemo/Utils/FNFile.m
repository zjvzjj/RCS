//
//  FNFile.m
//  FetionCloudDemo
//
//  Created by feinno on 16/1/6.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNFile.h"

@implementation FNFile

+ (NSData *)fileWithName:(NSString *)name
{
    return [self fileWithName:name ext:nil];
}

+ (NSData *)fileWithName:(NSString *)name ext:(NSString *)ext
{
    NSString *path = [FNBundleName pathForResource:name ofType:ext inDirectory:FNBundleDirectoryFile];
    
    return [NSData dataWithContentsOfFile:path];
}

@end
