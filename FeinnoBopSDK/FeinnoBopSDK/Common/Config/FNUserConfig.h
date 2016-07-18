//
//  UserConfig.h
//  feinno-sdk-imps
//
//  Created by wangshuying on 14-9-4.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNEnum.h"

typedef enum : NSUInteger {
    KPathPhoto,
    KPathMedia,
    KPathLog,
    KpathDb
} KPathType;


/**
 *  用户配置信息
 */
@interface FNUserConfig : NSObject

// 当前登录用户的ID
@property (nonatomic, readonly) NSString *userID;

// 当前登录用户的ID（带appKey）
@property (nonatomic, readonly) NSString *userIDWithKey;

// 当前登录用户的昵称
@property (nonatomic, readonly) NSString *nickname;

// 用于信息解密和文件操作，由SDK赋值
@property (nonatomic, readonly) NSString *cStr;

// 在线状态
@property (nonatomic, assign) FNLoginStatus loginStatus;

// 数据缓存路径
@property (nonatomic, readonly) NSString *dbPath;

// 源文件缓存路径
@property (nonatomic, readonly) NSString *filePath;

// 缩略图缓存路径
@property (nonatomic, readonly) NSString *thumbPath;

// 图片文件路径
@property (nonatomic, readonly) NSString *picPath;

// 日志文件夹路径
@property (nonatomic, readonly) NSString *logPath;

// 音视频文件夹路径
@property (nonatomic, readonly) NSString *mediaPath;

/**
 *  获取该类的单例
 *
 *  @return 返回单例
 */
+ (instancetype)getInstance;

/**
 *  单例初始化方法
 *
 *  @param uid 用户ID
 */
+ (instancetype)initWithUserid:(NSString *)uid;

/**
 *  设置单例中的用户昵称，登录成功后调用
 *
 *  @param userNickName 用户昵称
 */
+ (void)setNickName:(NSString *)userNickName;

/**
 *  设置单例中的cStr
 *
 *  @param cStr 传入的参数，登录应答中的参数
 */
+ (void)setCStr:(NSString *)cStr;

/**
 *  更新在线状态
 *
 *  @param status 新的在线状态
 */
+ (void)updateLoginStatus:(FNLoginStatus)status;

/**
 *  获得本地缓存大小
 *
 *  @return 日志大小, 历史记录大小,图片大小 ,音视频大小
 */
-(NSDictionary *)getLocalCacheSize;

/**
 *  清理缓存
 *
 *  参数（日志，历史纪录，聊天附件，ALL）
 */
-(void)deleteCacheByType:(KPathType) typePath;

/**
 *  日志文件提取接口
 *
 *  @param date 提取日期
 *
 *  @return 日志文件路径
 */
-(NSString *)getLogPathWithDate:(NSDate *)date;



@end
