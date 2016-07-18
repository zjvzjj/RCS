//
//  FNUploadOperation.h
//  FeinnoBopSDK
//
//  Created by yiqingping on 15/11/8.
//  Copyright © 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNFileServiceArgs.h"
#import "FNFileServiceLogic.h"
#import "NSMutableArray+AddObject.h"

@interface FNUploadOperation : NSObject

// 操作
@property (nonatomic, strong) NSOperationQueue *opetationQueue;
// 请求头数组
@property (nonatomic, strong) NSMutableArray *requestArray;
// 回调数组
@property (nonatomic, strong) NSMutableArray *callBackArray;
// 对应的上传类
@property (nonatomic, strong) NSMutableArray*uploadServer;

+ (instancetype)shareUploadQueue;

// 移除请求头以及相对应的数组元素
- (void)removeRequestCurrentTime:(FNFileUploadRequest*)request;

// 移除一对多消息的请求头及其相对应的数组元素
- (void)removeMultiRequestCurrentTime:(FNMultiFileUploadRequest *)request;
@end
