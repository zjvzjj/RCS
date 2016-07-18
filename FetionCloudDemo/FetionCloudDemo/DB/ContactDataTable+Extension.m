//
//  ContactDataTable+Extension.m
//  FetionCloudDemo
//
//  Created by Nemo on 16/3/8.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "ContactDataTable+Extension.h"

@implementation ContactDataTable (Extension)

+ (NSString *)formatWithUserId:(NSString *)userId
{
    if ([[userId componentsSeparatedByString:@"@"] count] >1 )
    {
        return userId;
    }
    
    return [NSString stringWithFormat:@"%@@%@",userId,APP_KEY];
}

@end
