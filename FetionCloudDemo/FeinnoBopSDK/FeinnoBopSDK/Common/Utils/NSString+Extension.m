//
//  NSString+Extension.m
//  family-sdk-protocol
//
//  Created by doujinkun on 14-7-4.
//  Copyright (c) 2014年 yds. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSData *)hexStringToBytes
{
    NSString *tmp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (tmp.length % 2 != 0)
    {
        @throw [NSException exceptionWithName:@"Invalid string" reason:@"" userInfo:nil];
    }
    
    NSMutableData *result = [[NSMutableData alloc] init];

    for (int i = 0; i < tmp.length / 2; i++)
    {
        NSString *s2 = [tmp substringWithRange:NSMakeRange(i * 2, 2)];
        
        char *p = NULL;
        int8_t v = strtol([s2 UTF8String], &p, 16);
        
        [result appendBytes:&v length:1];
    }
    return [result autorelease];
}

- (NSString *)removeHtml
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSString *text = nil;
    NSString *result = self;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        
        result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    
    result = [[[[[result stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"]
                        stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"]
                        stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]
                        stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"]
                        stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    
    return result;
}

+ (BOOL)isNullString:(NSString *)string
{
    return (NULL == string ||
            [string isEqual:nil] ||
            [string isEqual:Nil] ||
            [string isEqual:[NSNull null]] ||
            0 == [string length] ||
            0 == [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] ||
            [string isEqualToString:@"(null)"]);
}

+ (NSString *)urlEncode:(NSString *)string
{
    NSString *newString = [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))) autorelease];
    
    return (nil != newString ? newString : @"");
}

- (BOOL)isContain:(NSString *)string
{
//    NSLog(@"%@", self);
    NSRange findResult = [self rangeOfString:string];
    
    return 0 != findResult.length;
}

+ (NSString *)getPinyin:(NSString *)chinese {
    NSMutableString *mutableString = [NSMutableString stringWithString:chinese];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    return mutableString;
}

+ (BOOL)isEligible:(NSString *)string
{
    NSString *regex = @"^[a-zA-Z0-9_]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([self isNullString:string])
    {
        return NO;
    }
    else if (![predicate evaluateWithObject:string])
    {
        return NO;
    }
    return YES;
}

@end
