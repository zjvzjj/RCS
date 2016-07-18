//
//  FNConfig.h
//  FeinnoBopSDK
//
//  Created by 姜晓光 on 16/1/11.
//  Copyright © 2016年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNEnum.h"

/**
 *  SDK初始化配置类
 */
@interface FNConfig : NSObject

/**
 *  App初始化SDK调用方法
 *
 *  @param appkey          应用appkey
 *  @param appid           应用appid
 *  @param islaunch        是否启动日志文件
 *  @param severEnviroment 服务器环境（功能，生产）
 */
+ (void)initWithAppKey:(NSString *)appkey AppId:(NSString *)appid isLaunchLogFile:(BOOL)islaunch SeverEnviroment:(LoginEnvironment)severEnviroment;

/**
 *  设置AppToken
 *
 *  @param appToken 从后台获取用来激活sdk,每次应用进入活跃状态时调用
 */
+ (void)setAppToken:(NSString *)appToken userId:(NSString *)userid;

/**
 *  初始化本地数据缓存
 *
 *  @param userId 当前app用户id
 */
+ (void)initDataBase:(NSString *)userId;

@end
