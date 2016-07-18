
// created by lixing

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LOG_FLAG
#define APPKEY_MODE

@class McpRequest;

@interface Utility : NSObject

/**
 *  获取带appKey的用户ID
 *
 *  @param userId 原始用户ID
 *
 *  @return 带appKey的用户ID
 */

+ (NSString *)userIdWithAppKey:(NSString *)userId;

/**
 *  获取不带appKey的用户ID
 *
 *  @param userId 原始用户ID
 *
 *  @return 不带appKey的用户ID
 */

+ (NSString *)userIdWithoutAppKey:(NSString *)userId;

/**
 *  获取带appKey的用户ID数组
 *
 *  @param uidArray 原始用户ID数组
 *
 *  @return 带appKey的用户ID数组
 */
+ (NSArray *)userIdListWithAppkeys:(NSArray *)uidArray;

/**
 *  初始化长连接
 */
+ (McpRequest *)initMcpRequest;

/**
 *  记录日志
 *
 *  @param text 日志信息
 */
+ (void)writeLog:(NSString *)text;

@end
