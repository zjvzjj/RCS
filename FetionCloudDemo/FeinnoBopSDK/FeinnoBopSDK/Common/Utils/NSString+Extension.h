//
//  NSString+Extension.h
//  family-sdk-protocol
//
//  Created by doujinkun on 14-7-4.
//  Copyright (c) 2014年 yds. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSString的扩展category
 */
@interface NSString (Extension)

/**
 *  将16进制格式的字符串转化成为bytes
 *
 *  @return 返回的数据
 */
- (NSData *)hexStringToBytes;

/**
 *  去除文本消息中的HTML格式的标签
 *
 *  @return 返回的处理后的内容
 */
- (NSString *)removeHtml;

/**
 *  判断字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 判断结果，YES 空，NO 非空
 */
+ (BOOL)isNullString:(NSString *)string;

/**
 *  获取URL编码后的字符串
 *
 *  @param string 输入的字符串
 *
 *  @return 编码后的字符串
 */
+ (NSString *)urlEncode:(NSString *)string;

/**
 *  判断字符串是否包含子串
 *
 *  @param string 子串
 *
 *  @return 判断结果，YES 包含，NO 不包含
 */
- (BOOL)isContain:(NSString *)string;

/**
 *  汉字转化为拼音
 *
 *  @param chinese 要转化的汉语字符串
 *
 *  @return 返回英文字母
 */
+ (NSString *)getPinyin:(NSString *)chinese;

/**
 *  判断输入的账号是否符合要求
 *
 *  @param string 输入的字符
 *
 *  @return 判断结果，YES复合，NO不符合
 */
+ (BOOL)isEligible:(NSString *)string;

@end
