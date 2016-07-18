//
//  FNTranslation.h
//  FetionCloudDemo
//
//  Created by feinno on 16/1/15.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"

@interface FNTranslation : NSObject

+ (void)translate:(NSString *)text callback:(void (^) (NSString *result))callback;

@end