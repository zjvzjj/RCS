
// created by lixing

#import "Utility.h"

#import "FNServerConfig.h"
#import "McpRequest.h"
#import "NSString+Extension.h"

@implementation Utility
//TODO:判断不一致 发通知
+ (NSString *)userIdWithAppKey:(NSString *)userId
{
    NSString *result = nil;
#ifdef APPKEY_MODE
    NSString *appKey = [FNServerConfig getInstance].appKey;
    result = [userId rangeOfString:@"PG:"].location != NSNotFound ? userId : (![userId isContain:appKey] ? [NSString stringWithFormat:@"%@@%@", userId, appKey] : userId);
#else
    result = userId;
#endif
    
    return result;
}

+ (NSString *)userIdWithoutAppKey:(NSString *)userId
{
    NSString *result = nil;
#ifdef APPKEY_MODE
    NSString *appKey = [FNServerConfig getInstance].appKey;
    result = [userId isContain:appKey] ? [userId stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"@%@", appKey] withString:@""] : userId;
#else
    result = userId;
#endif
    
    return result;
}

+ (NSArray *)userIdListWithAppkeys:(NSArray *)uidArray
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSInteger i = 0; i < uidArray.count; ++i)
    {
        NSString *buddyUid = [uidArray objectAtIndex:i];
        [array addObject:[Utility userIdWithAppKey:buddyUid]];
    }
    
    return array;
}

+ (McpRequest *)initMcpRequest
{
    NSString *address = [FNServerConfig getInstance].serviceAddress;
    NSArray *array = [address componentsSeparatedByString:@":"];
    NSString *ip = [array objectAtIndex:0];
    NSString *port = [array objectAtIndex:1];
    McpRequest *mcpRequest = [[McpRequest alloc] initWithIp:ip port:port.intValue];

    return mcpRequest;
}

+ (void)writeLog:(NSString *)text
{
#ifdef LOG_FLAG
    NSLog(@"%@", text);
#endif
}

@end
