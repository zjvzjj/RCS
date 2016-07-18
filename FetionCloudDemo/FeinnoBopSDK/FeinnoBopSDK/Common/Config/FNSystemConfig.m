//
//  SystemConfig.m
//  feinno-sdk-imps
//
//  Created by doujinkun on 14/11/4.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNSystemConfig.h"
#import <AddressBook/AddressBook.h>

static NSString *BOPFirstLaunch = @"BOPFirstLaunch";
static NSString *BOPEverLaunch = @"BOPEverLaunch";

@implementation FNSystemConfig

+ (BOOL)checkIsFirstLaunch
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:BOPFirstLaunch];
}

+ (void)handleFirstLaunch
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOPEverLaunch])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOPEverLaunch];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOPFirstLaunch];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:BOPFirstLaunch];
    }
}

+ (NSString *)getVersion
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    // 较详细的版本号
    NSString *appVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

// 获取通讯录
+ (void)readSystemAddressBook:(void(^)(NSMutableArray *contactInfo))callback
{
    //获取通讯录权限
    ABAddressBookRef ab = NULL;
    // ABAddressBookCreateWithOptions is iOS 6 and up.
    if (&ABAddressBookCreateWithOptions)
    {
        CFErrorRef error = nil;
        ab = ABAddressBookCreateWithOptions(NULL, &error);
        if (error)
        {
            NSLog(@"create address book error: %@", error);
        }
    }
    if (NULL == ab)
    {
        NSLog(@"hava no access to address book!");
        return;   // 是否该rerun？
    }
    // ABAddressBookRequestAccessWithCompletion is iOS 6 and up. 适配IOS6以上版本
    if (&ABAddressBookRequestAccessWithCompletion)
    {
        ABAddressBookRequestAccessWithCompletion(ab, ^(bool granted, CFErrorRef error) {
            if (granted)
            {
                // constructInThread: will CFRelease ab.
//                [NSThread detachNewThreadSelector:@selector(constructInThread:) toTarget:self withObject:CFBridgingRelease(ab)];
                //获取addressbook的权限
                [FNSystemConfig constructInThread:ab callback:callback];
            }
            else
            {
                CFRelease(ab);  //当ab为NULL时，会crash
                NSLog(@"get address book granted failed!");
                // UI alter
            }
        });
    }
}

// 获取到addressbook的权限
+ (void)constructInThread:(ABAddressBookRef)ab
                 callback:(void(^)(NSMutableArray *contactInfo))callback
{
    NSLog(@"got the access right to address book!");
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(ab);
    NSMutableArray* contactArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < CFArrayGetCount(results); i++)
    {
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        // 姓
        NSString *firstName = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        if (!firstName) {
            firstName = @"";
        }
        // 姓音标
//        NSString *firstNamePhonetic = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty));
        // 名
        NSString *lastname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        if (!lastname) {
            lastname = @"";
        }
        // 名音标
//        NSString *lastnamePhonetic = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty));
        // 公司
//        NSString *Organization = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonOrganizationProperty));
        // 读取jobtitle工作
//        NSString *jobtitle = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonJobTitleProperty));
        // 读取department部门
//        NSString *department = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonDepartmentProperty));
        // 读取birthday生日
//        NSDate *birthday = (NSDate*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonBirthdayProperty));
//        double birthdayString = [birthday timeIntervalSince1970];
        // 读取nickname呢称
//        NSString *nickname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonNicknameProperty));
        // 读取电话多值
        NSString * phoneString = @"";
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k < ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
//            NSString * personPhoneLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k)));
            //获取該Label下的电话值
            NSString * personPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, k));
            if (0 == k)
            {
                phoneString = [phoneString stringByAppendingFormat:@"%@",personPhone];
            }
            else
            {
                phoneString = [phoneString stringByAppendingFormat:@",%@",personPhone];
            }
            personPhone = nil;
        }
        CFRelease(phone);
        // 去掉括号 减号 空格
        if (phoneString.length > 0)
        {
            phoneString = [phoneString stringByReplacingOccurrencesOfString:@"(" withString:@""];
            phoneString = [phoneString stringByReplacingOccurrencesOfString:@")" withString:@""];
            phoneString = [phoneString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            phoneString = [phoneString stringByReplacingOccurrencesOfString:@" " withString:@""]; //这一行不能动，表示空格，其中的空格并非空格
        }
//        NSLog(@"phone number:%@!", [[phoneString substringToIndex:2] substringFromIndex:1]);
        
        //获取email多值
        NSString* emailString = @"";
        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
        for (int x = 0; x < ABMultiValueGetCount(email); x++)
        {
            //获取email Label
//            NSString* emailLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x)));
            //获取email值
            NSString* emailContent = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(email, x));
            if (0 == x)
            {
                emailString = [emailString stringByAppendingFormat:@"%@",emailContent];
            }
            else
            {
                emailString = [emailString stringByAppendingFormat:@",%@",emailContent];
            }
            
            emailContent = nil;
        }
        CFRelease(email);
        
        //获取URL多值
        NSString* urlString = @"";
        ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
        for (int m = 0; m < ABMultiValueGetCount(url); m++)
        {
            //获取电话Label
//            NSString * urlLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m)));
            //获取該Label下url值
            NSString * urlContent = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(url,m));
            urlString = [urlString stringByAppendingFormat:@",%@",urlContent];
            urlContent = nil;
        }
        CFRelease(url);
        // 先姓后
        NSString *fullName = nil;
        if (lastname && firstName)
        {
            fullName = [NSString stringWithFormat:@"%@ %@", lastname, firstName];
        }
        else if (lastname)
        {
            fullName = [NSString stringWithFormat:@"%@", lastname];
        }
        else
        {
            fullName = [NSString stringWithFormat:@"%@", firstName];
        }
        
        //构造字典
        NSDictionary* dic = @{@"name" : fullName?fullName:[NSNull null],
//                              @"last_name": lastname?lastname:[NSNull null],
                              @"phone" : phoneString?phoneString:[NSNull null],
                              @"email" : emailString?emailString:[NSNull null],
//                              @"company": Organization?Organization:[NSNull null],
//                              @"nick_name": nickname?nickname:[NSNull null],
//                              @"department": department?department:[NSNull null],
//                              @"birthday": [NSNumber numberWithDouble:birthdayString],
//                              @"blog_index": urlString?urlString:[NSNull null]
                              };
        [contactArray addObject:dic];
        emailString = nil;
        urlString = nil;
        phoneString = nil;
    }
    CFRelease(results);
    
    callback(contactArray);
}
//获取GMT时间
+ (NSString *)getCurrentGMTDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [df stringFromDate:[NSDate date]];
    
    return time;
}

+ (NSDate *)stringToDate:(NSString *)dateStr
{
    
    NSParameterAssert(dateStr.length > 0);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    if (nil == date)
    {
        NSLog(@"convert failure from string to date");
    }
    
    return date;
}

+ (NSString *)dateToString:(NSDate *)time
{
    NSParameterAssert(nil != time);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    if (nil == strDate)
    {
        NSLog(@"convert failure from date to string");
        return  nil;
    }
    return strDate;
}

+ (NSDate *)getLocalDate
{
    NSDate *GMTDate = [NSDate date];
    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [localTimeZone secondsFromGMT];
    NSDate *localDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:GMTDate];
    
    return localDate;
}

@end
