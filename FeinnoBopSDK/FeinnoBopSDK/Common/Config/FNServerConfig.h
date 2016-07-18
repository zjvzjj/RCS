//
//  ServerConfig.h
//  feinno-sdk-imps
//
//  Created by doujinkun on 14-10-18.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNEnum.h"

/**
 *  服务端配置类
 */
@interface FNServerConfig : NSObject

// 登录、消息等服务端地址
@property (nonatomic, readonly) NSString *serviceAddress;

// 文件服务地址，用于富文本部分的文件上传 下载
@property (nonatomic, readonly) NSString *fileServiceAddress;

// 官网注册后，分配的appKey
@property (nonatomic, readonly) NSString *appKey;

//每个应用的唯一标识
@property (nonatomic, readonly) NSString *appId;

// 当前登录环境
@property (nonatomic, readwrite) LoginEnvironment environment;

//是否启动日志文件
@property (nonatomic, readwrite) BOOL isLaunchLogFile;

/**
 *  获取该类的单例
 *
 *  @return 返回单例
 */
+ (instancetype)getInstance;

/**
 *  初始化BOP服务的各个服务地址，这两个地址根据具体服务部署而定，可以相同，可以不同
 *
 *  @param serviceAddress       登录、消息等服务端地址
 *  @param fileServiceAddress   文件服务地址
 *  @param appkey               官网注册后，分配的appKey
 *
 *  @return 返回该类的一个单例
 */
+ (instancetype)initWithServiceAddress:(NSString *)serviceAddress
                    fileServiceAddress:(NSString *)fileServiceAddress
                                appKey:(NSString *)appkey
                                 appId:(NSString *)appid;

@end
