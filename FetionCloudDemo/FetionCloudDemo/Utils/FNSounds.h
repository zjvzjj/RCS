
//  FNSounds.h
//  FetionCloudDemo
//
//  Created by feinno on 16/1/7.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNBundle.h"

@interface FNSounds : FNBundle

+ (NSString *)pathWithName:(NSString *)name;

+ (NSString *)pathWithName:(NSString *)name ext:(NSString *)ext;

+ (NSURL *)urlWithName:(NSString *)name ext:(NSString *)ext;

@end
