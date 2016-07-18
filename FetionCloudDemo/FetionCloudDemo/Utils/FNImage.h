//
//  FNImage.h
//  FetionCloudDemo
//
//  Created by feinno on 16/1/6.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNBundle.h"

@interface FNImage : FNBundle

+ (UIImage *)imageWithName:(NSString *)name;

+ (UIImage *)imageWithName:(NSString *)name ext:(NSString *)ext;

+ (NSData *)dataWithName:(NSString *)name;

@end

@interface FNImage (Emoj)

+ (NSString *)emojPlist;

+ (UIImage *)emojWithName:(NSString *)name;

@end

@interface FNImage (Avatar)

+ (UIImage *)avatarWithIndex:(NSInteger)index;

+ (NSString *)avatarName:(NSInteger)index;

@end