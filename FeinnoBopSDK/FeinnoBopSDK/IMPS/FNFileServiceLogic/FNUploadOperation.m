//
//  FNUploadOperation.m
//  FeinnoBopSDK
//
//  Created by yiqingping on 15/11/8.
//  Copyright © 2015年 Feinno. All rights reserved.
//

#import "FNUploadOperation.h"
#import "BOPReachability.h"

static id _shareInstance;

@implementation FNUploadOperation

+ (instancetype)shareUploadQueue
{
    if (!_shareInstance){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            _shareInstance = [[self alloc]init];
        });
    }
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!_shareInstance){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            _shareInstance = [super allocWithZone:zone];
        });
    }
    return _shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _uploadServer = [[NSMutableArray alloc]init];
        _requestArray = [[NSMutableArray alloc]init];
        _callBackArray = [[NSMutableArray alloc]init];
        
        // 检测网络变化的通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachablityChanged:) name:_kBOPReachabilityChangedNotification object:nil];
    }
    return self;
}

- (void)reachablityChanged:(NSNotification *)note
{
    BOPReachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[BOPReachability class]]);
    BOPNetworkStatus netStatus = [curReach currentReachabilityStatus];
    if(netStatus == BOPNotReachable)
    {
        // 无网络
        [self.opetationQueue setSuspended:YES];
    }else {
        // 有网络
        [self.opetationQueue setSuspended:NO];
    }
}

// 移除请求头以及相对应的数组元素
- (void)removeRequestCurrentTime:(FNFileUploadRequest *)request
{
    if ([self.requestArray containsObject:request])
    {
        NSInteger num = [self.requestArray indexOfObject:request];
        [self.requestArray removeObject:request];
        [self.callBackArray removeObjectAtIndex:num];
        [self.uploadServer removeObjectAtIndex:num];
    }
}

// 移除一对多消息的请求头及其相对应的数组元素
- (void)removeMultiRequestCurrentTime:(FNMultiFileUploadRequest *)request
{
    if ([self.requestArray containsObject:request])
    {
        NSInteger num = [self.requestArray indexOfObject:request];
        [self.requestArray removeObject:request];
        [self.callBackArray removeObjectAtIndex:num];
        [self.uploadServer removeObjectAtIndex:num];
    }
}
- (NSOperationQueue *)opetationQueue
{
    if (!_opetationQueue)
    {
        _opetationQueue = [[NSOperationQueue alloc]init];
        _opetationQueue.maxConcurrentOperationCount = 3;
        
    }
    return _opetationQueue;
}
@end
