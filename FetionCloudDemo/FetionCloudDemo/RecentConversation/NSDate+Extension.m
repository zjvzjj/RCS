

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
/**
 *  是否是与当前时间是同一年
 *
 *  @param date 传入对比的时间
 *
 *  @return <#return value description#>
 */
+ (BOOL)isThisYearWithDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    //当前创建的时间
    NSDate *createDate = date;
    //取出当前时间
    NSDate *currentDate = [NSDate date];
    formatter.dateFormat = @"yyyy";
    //取出年份-->判断是否同一年,只要拿着年份进行对比一下,看一下是否一样
    NSString *createDateYearStr = [formatter stringFromDate:createDate];
    NSString *currentDateYearStr = [formatter stringFromDate:currentDate];
    
    //对比年份的时间字符串,如果不是同一年的话返回NO
    return [createDateYearStr isEqualToString:currentDateYearStr];
}


/**
 *  判断与今天否是同一天,是否是今天
 *
 *  @param date
 *
 *  @return
 */
+ (BOOL)isTodayWithDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //拿着创建时间与当前时间进行对比-->只格式化年份-月份-天
    formatter.dateFormat = @"yyyy-MM-dd";
    //当前创建的时间
    NSDate *createDate = date;
    //取出当前时间
    NSDate *currentDate = [NSDate date];
    
    //取出年份-->判断是否是今天,
    NSString *createDateYearStr = [formatter stringFromDate:createDate];
    NSString *currentDateYearStr = [formatter stringFromDate:currentDate];
    
    //对比年份的时间字符串,如果不是同一年的话返回NO
    return [createDateYearStr isEqualToString:currentDateYearStr];
}


/**
 *  与当前时间对比,判断是否是昨天
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isYesterdayWithDate:(NSDate *)date{

    NSDate *currentDate = [NSDate date];
    
    //取出当前日历对象
    NSCalendar *canlendar = [NSCalendar currentCalendar];
    //设置对比对象
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    //时间比较的结果
    NSDateComponents *components = [canlendar components:unit fromDate:date toDate:currentDate options:NSCalendarWrapComponents];
    //对比两个时间的day差值是否为
    return components.day == 1;
}

@end
