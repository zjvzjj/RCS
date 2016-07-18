//
//  Header.h
//  FetionCloudDemo
//
//  Created by 姜晓光 on 16/1/6.
//  Copyright © 2016年 Fetion. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate) //代理类

// 系统相关信息
#define SYSTEM_MODEL (([[UIDevice currentDevice] model]))
#define SYSTEM_VERSION ([[UIDevice currentDevice] systemVersion])

#define IOS7_OR_LATER (SYSTEM_VERSION.floatValue >= 7.0) //判断是否为iOS7及以后版本
#define IOS8_OR_LATER (SYSTEM_VERSION.floatValue >= 8.0)
#define SCREEN_3_5INCH_OR_LAGER ([[UIScreen mainScreen] bounds].size.height <= 480) //判断屏幕是比3.5英寸大
#define SCREEN_4INCH_OR_LAGER ([[UIScreen mainScreen] bounds].size.height>=568) //判断屏幕是比4英寸大
#define SCREEN_4_7INCH_OR_LAGER ([[UIScreen mainScreen] bounds].size.height>=667) //判断屏幕是等于或者比4.7英寸大
#define SCREEN_5_5INCH ([[UIScreen mainScreen] bounds].size.height>=736) //判断屏幕是等于5.5英寸

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width    //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height  //屏幕宽度

// 获取常用文件路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// 定义weakSelf
#define WS(weakSelf)        __weak __typeof(&*self)weakSelf = self

// 定义UserDefaults
#define UserDefaults        [NSUserDefaults standardUserDefaults]

//
#define FileManager         [NSFileManager defaultManager]

//
#define SharedApplication   [UIApplication sharedApplication]

// AppDelegate
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

// KeyWindow
#define KeyWindow           (ApplicationDelegate).window

// Notification center //通知中心
#define NOTIFICATION_CENTER [NSNotificationCenter defaultCenter]

// Color of RGBA
#define UIColorFromRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define UIColorFrom16RGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
//判断数据是否为null
#define CheckNull(value)  ([value isEqual:[NSNull null]] || value == nil || ([value count] == 0) ? (YES) : (NO))

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
//
////DEBUG  模式下打印日志,当前行
//#ifdef DEBUG
//#define NSLog(format, ...) do {                                                             \
////fprintf(stderr, "<%s : %d> %s\n",                                           \
////[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
////__LINE__, __func__);                                                        \
////(NSLog)((format), ##__VA_ARGS__);                                           \
////fprintf(stderr, "-------\n");                                               \
////} while (0)
////#else
////#define NSLog(...)
//#endif
//


#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#endif /* Header_h */
