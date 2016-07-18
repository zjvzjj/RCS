//
//  FNImage.m
//  FetionCloudDemo
//
//  Created by feinno on 16/1/6.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNImage.h"

@implementation FNImage

+ (UIImage *)imageWithName:(NSString *)name
{
    return [self imageWithName:name ext:@"png"];
}

+ (UIImage *)imageWithName:(NSString *)name ext:(NSString *)ext
{
    NSString *path = [FNBundleName pathForResource:name ofType:ext inDirectory:FNBundleDirectoryImage];
    
    return [UIImage imageWithContentsOfFile:path];
}

+ (NSData *)dataWithName:(NSString *)name
{
    return UIImagePNGRepresentation([self imageWithName:name]);
}

@end

@implementation FNImage (Emoj)

+ (NSString *)emojPlist
{
    return [FNBundleName pathForResource:@"XMEmotion" ofType:@"plist" inDirectory:FNBundleDirectoryEmotion];
}

+ (UIImage *)emojWithName:(NSString *)name
{
    NSString *path = [FNBundleName pathForResource:name ofType:@"png" inDirectory:FNBundleDirectoryEmotion];
    
    return [UIImage imageWithContentsOfFile:path];
}

@end


@implementation FNImage (Avatar)

+ (UIImage *)avatarWithIndex:(NSInteger)index
{
    UIImage *image = nil;
    
    switch (index%3)
    {
        case 0:
            image = [FNImage imageWithName:@"head_portrait_0"];
            break;
        case 1:
            image = [FNImage imageWithName:@"head_portrait_1"];
            break;
        case 2:
            image = [FNImage imageWithName:@"head_portrait_2"];
            break;
            
        default:
            break;
    }

    return image;
}

+ (NSString *)avatarName:(NSInteger)index
{
    return [NSString stringWithFormat:@"head_portrait_%ld",index%3];
}

@end