//
//  FNFile.h
//  FetionCloudDemo
//
//  Created by feinno on 16/1/6.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNBundle.h"

@interface FNFile : FNBundle

+ (NSData *)fileWithName:(NSString *)name;

+ (NSData *)fileWithName:(NSString *)name ext:(NSString *)ext;

@end
