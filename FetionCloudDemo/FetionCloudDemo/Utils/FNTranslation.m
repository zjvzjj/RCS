//
//  FNTranslation.m
//  FetionCloudDemo
//
//  Created by feinno on 16/1/15.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#import "FNTranslation.h"

static NSString *FNTranslationAPIKey    =   @"1913939857";

static NSString *FNTranslationKeyFrom   =   @"imcloud";

@implementation FNTranslation

+ (void)translate:(NSString *)text callback:(void (^) (NSString *result))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"http://fanyi.youdao.com/openapi.do?keyfrom=%@&key=%@&type=data&doctype=json&version=1.1&q=%@",FNTranslationKeyFrom,FNTranslationAPIKey,text];
    
    NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:encodingString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
    
        callback(responseObject[@"translation"][0]);

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    
        callback(nil);
    }];
}
@end
