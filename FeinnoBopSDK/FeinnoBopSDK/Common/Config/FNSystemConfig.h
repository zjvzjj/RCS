//
//  SystemConfig.h
//  feinno-sdk-imps
//
//  Created by doujinkun on 14/11/4.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  系统配置类
 */
@interface FNSystemConfig : NSObject

/**
 *  读取系统通讯录信息，适用于IOS6及以上系统, 此方法只提供了联系人的三个信息：姓名 手机号 邮箱
 *  如果想要获取更多的系统通讯录内的联系人信息，可以不用此方法，UI层自己开发
 *
 *  @param callback 获取之后的回调方法，数组内存储字典类型，共3个key:"name" "phone" "email"
 */
+ (void)readSystemAddressBook:(void(^)(NSMutableArray *contactInfo))callback;

/**
 *  检查是否是首次登录APP
 *
 *  @return 返回BOOL类型
 */
+ (BOOL)checkIsFirstLaunch;

/**
 *  与checkIsFirstLaunch方法一起使用，标记已经登录
 */
+ (void)handleFirstLaunch;

/**
 *  获取SDK的版本号
 *
 *  @return 版本号
 */
+ (NSString *)getVersion;

/**
 *  将SDK制定的字符串类型转换成NSDate类型
 *
 *  @param dateStr 时间字符串
 *
 *  @return 转换后的日期时间
 */
+ (NSDate *)stringToDate:(NSString *)dateStr;

/**
 *  将NSDate类型转换成SDK制定的字符串格式
 *
 *  @param time 时间
 *
 *  @return 处理后的字符串
 */
+ (NSString *)dateToString:(NSDate *)time;

/**
 *  获取本地的CST时间
 *
 *  @return 返回时间
 */
+ (NSDate *)getLocalDate;

/**
 *  获取当前的GMT时间，并以SDK制定的字符串格式返回
 *
 *  @return 字符串格式的时间表示
 */
+ (NSString *)getCurrentGMTDate;

@end
