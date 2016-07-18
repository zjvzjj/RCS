//
//  UserConfig.m
//  feinno-sdk-imps
//
//  Created by doujinkun on 14-11-14.
//  Copyright (c) 2014年 open. All rights reserved.
//


#import "FNUserConfig.h"
#import "FNServerConfig.h"
#import "Utility.h"
#import "FNAccountNotify.h"
#import "FNDBManager.h"
#import "BOPFMDatabase.h"



//  在初始化的时候建立的文件夹

// 日志
#define KLogDict  @"user_log"

// 历史记录
#define KDBDict @"user_db"

// 图片
#define KPhotoDict @"user_photo"

// 音视频
#define KMediaDict @"user_media"


static FNUserConfig *instance = nil;

@interface FNUserConfig ()

@property (nonatomic, readwrite) NSString *userID;
@property (nonatomic, readwrite) NSString *userIDWithKey;
@property (nonatomic, readwrite) NSString *nickname;
@property (nonatomic, readwrite) NSString *cStr;

@property (nonatomic, readwrite) NSString *filePath;
//// 历史记录路径
@property (nonatomic, readwrite) NSString *dbPath;

// 缩略文件夹路径
@property (nonatomic, readwrite) NSString *thumbPath;

// 图片文件路径
@property (nonatomic, readwrite) NSString *picPath;

// 日志文件夹路径
@property (nonatomic, readwrite) NSString *logPath;

// 音视频文件夹路径
@property (nonatomic, readwrite) NSString *mediaPath;


@end

@implementation FNUserConfig

+ (instancetype)initWithUserid:(NSString *)uid
{
    @synchronized(self) {
        if (!instance)
        {
            instance = [[self alloc] init];
        }
        instance.userID = [Utility userIdWithoutAppKey:uid];
        instance.userIDWithKey = [Utility userIdWithAppKey:uid];
        instance.loginStatus = FNLoginStatusWaitReconnect;//TODO:根据初始化时机来确定
        
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        // 历史记录 (获得DB的大小)
        NSString *userPath = [[cachePath stringByAppendingPathComponent:@"BOPDB"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%ld", uid, (long)[FNServerConfig getInstance].environment]];
        
        
        // 表路径
        instance.dbPath = userPath;
        // 生成文件缓存路径
        instance.filePath = [userPath stringByAppendingPathComponent:@"files"];
        // 生成图片路径
        instance.thumbPath = [userPath stringByAppendingPathComponent:@"thumbs"];
        
        // 图片文件夹
        instance.picPath = [userPath stringByAppendingPathComponent:KPhotoDict];
        // 生成音频文件夹路径
        instance.mediaPath = [userPath stringByAppendingPathComponent:KMediaDict];
        // 生成日志文件夹路径
        instance.logPath =  [[cachePath stringByAppendingPathComponent:@"BOPDB"]stringByAppendingPathComponent:KLogDict];
        
        BOOL isDir = NO;
        // 表文件路径
        if (![[NSFileManager defaultManager] fileExistsAtPath:userPath isDirectory:&isDir])
        {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:userPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error)
            {
                NSLog(@"create dbpath error : %@", error);
            }
        }
        // 文件文件夹路径
        if (![[NSFileManager defaultManager] fileExistsAtPath:instance.filePath isDirectory:&isDir])
        {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:instance.filePath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error)
            {
                NSLog(@"create filepath error : %@", error);
            }
        }
        // 缩略文件夹路径
        if (![[NSFileManager defaultManager] fileExistsAtPath:instance.thumbPath isDirectory:&isDir])
        {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:instance.thumbPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error)
            {
                NSLog(@"create thumbpath error : %@", error);
            }
        }
        // 图片文件夹路径
        if (![[NSFileManager defaultManager] fileExistsAtPath:instance.picPath isDirectory:&isDir])
        {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:instance.picPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error)
            {
                NSLog(@"create picPath error : %@", error);
            }
        }
        // 音视频文件夹路径
        if (![[NSFileManager defaultManager] fileExistsAtPath:instance.mediaPath isDirectory:&isDir])
        {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:instance.mediaPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error)
            {
                NSLog(@"create mediaPath error : %@", error);
            }
        }
        // 日志文件夹路径
        if (![[NSFileManager defaultManager] fileExistsAtPath:instance.logPath isDirectory:&isDir])
        {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:instance.logPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error)
            {
                NSLog(@"create thumbpath error : %@", error);
            }
        }
    }
    
    return instance;
}


#pragma mark 提供的接口
#pragma mark获得日志大小, 历史记录大小,图片大小 ,音视频大
-(NSDictionary *)getLocalCacheSize
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *dirPath = [cachePath stringByAppendingPathComponent:@"BOPDB"];
    NSFileManager *fileManager =[NSFileManager defaultManager];
    NSArray * contentArray = [fileManager contentsOfDirectoryAtPath:dirPath error:nil];
    float logSize = 0.0;
    float dBSize=0.0;
    float photoSize=0.0;
    float mediaSize=0.0;
    // 直接获取所有Db的大小
    dBSize = [self getLocalAllDbSize];
    
    for (NSString *userPath in contentArray) {
        
        NSString *userdict =[dirPath stringByAppendingPathComponent:userPath];
        logSize  +=[self getDirectSizeAtPath:[userdict stringByAppendingPathComponent:KLogDict]];
        photoSize +=[self getDirectSizeAtPath:[userdict stringByAppendingPathComponent:KPhotoDict]];
        mediaSize +=[self getDirectSizeAtPath:[userdict stringByAppendingPathComponent:KMediaDict]];
    }
    
    [mutableDict setObject:[NSNumber numberWithFloat:logSize] forKey:KLogDict];
    [mutableDict setObject:[NSNumber numberWithFloat:dBSize] forKey:KDBDict];
    [mutableDict setObject:[NSNumber numberWithFloat:photoSize] forKey:KPhotoDict];
    [mutableDict setObject:[NSNumber numberWithFloat:mediaSize] forKey:KMediaDict];
    
    return mutableDict.copy;
}
// 清理缓存，参数类型（日志，历史纪录，聊天附件，ALL）
-(void)deleteCacheByType:(KPathType) typePath
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *dirPath = [cachePath stringByAppendingPathComponent:@"BOPDB"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents =[fileManager contentsOfDirectoryAtPath:dirPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    __block BOOL result = NO;
    NSString *fileName;
    while ((fileName = [e nextObject])) {
        
        if (typePath==KPathLog) {
            if ([fileName isEqualToString:KLogDict]) {
                // 删除日志文件夹
                NSString *logPath = [dirPath stringByAppendingPathComponent:fileName];
                [self deleteContent:logPath];
            }
        }
        
        NSRange range = [fileName rangeOfString:self.userID];
        if(range.location == NSNotFound)//不是当前用户
        {
            [fileManager removeItemAtPath:[dirPath stringByAppendingPathComponent:fileName] error:NULL];
        }
        else
        {
            //当前用户文件夹
            NSString *currentUsetCachPath = [dirPath stringByAppendingPathComponent:fileName];
            switch (typePath) {
                case KPathPhoto:
                {
                    // 删除图片文件夹下内容 不能删除文件夹
                    NSString *photoPath = [currentUsetCachPath stringByAppendingPathComponent:KPhotoDict];
                    [self deleteContent:photoPath];
                }
                    break;
                    
                case KPathMedia:
                {
                    // 删除音视频文件夹下内容
                    NSString *mediaPath=[currentUsetCachPath stringByAppendingPathComponent:KMediaDict];
                    [self deleteContent:mediaPath];
                }
                    break;
                case KpathDb:
                {
                    // 删除历史记录
                    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
                    [queue inDatabase:^(BOPFMDatabase *db) {
                        NSString *sql = @"delete from Message;delete from RichTextMsg;delete from GroupMsg;";
                        result = [db executeUpdate:sql];
                    }];
                    
                }
                    break;
                default:
                    break;
            }
            
        }
    }
    
}
//  日志文件提取接口，参数（提取日期），返回（日志文件路径），
-(NSString *)getLogPathWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *dirPath = [cachePath stringByAppendingPathComponent:@"BOPDB"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:dirPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *fileName;
    while ((fileName = [e nextObject])) {
        
        if ([fileName isEqualToString:KLogDict]) {
            NSString *logPath =[dirPath stringByAppendingPathComponent:fileName];
            NSArray *arr = [fileManager subpathsAtPath:logPath];
            for(NSString *name in arr)
            {
                NSRange range = [name rangeOfString:[formatter stringFromDate:date] ];
                if(range.location!=NSNotFound)
                {
                    return [logPath stringByAppendingPathComponent:name];
                }
            }
        }
    }
    return nil;
    
}

#pragma mark 删除所有(人)的缓存数据
-(BOOL)deleteTotalData
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *dirPath = [cachePath stringByAppendingPathComponent:@"BOPDB"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents =[fileManager contentsOfDirectoryAtPath:dirPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    __block BOOL result = NO;
    NSString *fileName;
    while ((fileName = [e nextObject])) {
        //判断文件后缀名 删除对应db里面的数据
        NSRange range = [fileName rangeOfString:self.userID];
        if(range.location == NSNotFound)//不是当前用户
        {
            [fileManager removeItemAtPath:[dirPath stringByAppendingPathComponent:fileName] error:NULL];
        }
        else
        {
            //当前用户文件夹
            NSString *currentUsetCachPath = [dirPath stringByAppendingPathComponent:fileName];
            // 删除日志文件夹
            NSString *logPath = [currentUsetCachPath stringByAppendingPathComponent:KLogDict];
            [self deleteContent:logPath];
            
            // 删除历史记录
            BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
            [queue inDatabase:^(BOPFMDatabase *db) {
                NSString *sql = @"delete from Message;delete from RichTextMsg;delete from GroupMsg;";
                result = [db executeUpdate:sql];
            }];
            NSString *photoPath = [currentUsetCachPath stringByAppendingPathComponent:KPhotoDict];
            [self deleteContent:photoPath];
            
            NSString *mediaPath=[currentUsetCachPath stringByAppendingPathComponent:KMediaDict];
            [self deleteContent:mediaPath];
        }
    }
    return  result;
}

#pragma mark 返回本地缓存的总大小
- (float) getLocalTotalSizeAtPath
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *folderPath = [cachePath stringByAppendingPathComponent:@"BOPDB"];
    
    return [self getDirectSizeAtPath:folderPath];
}


#pragma mark 返回一个文件夹内容的大小
-(float)getDirectSizeAtPath:(NSString *)dictPath
{
    NSFileManager *manage =[NSFileManager defaultManager];
    long long folderSize = 0;
    if(![manage fileExistsAtPath:dictPath])
    {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manage subpathsAtPath:dictPath]objectEnumerator];
    NSString *fileName;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString *fileAbsolutePath = [dictPath stringByAppendingPathComponent:fileName];
        folderSize += [self getSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

#pragma mark 返回单个文件的大小
-(CGFloat)getSizeAtPath:(NSString*)directStr
{
    NSFileManager *manager =[NSFileManager defaultManager];
    if([manager fileExistsAtPath:directStr])
    {
        return [[manager attributesOfItemAtPath:directStr error:nil]fileSize];
    }
    return 0;
}

// 清理缓存，参数（日志，历史纪录，聊天附件，ALL）
- (void)deleteContent:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSEnumerator *childFileEnumerator = [[manager subpathsAtPath:path]objectEnumerator];
    NSString *fileName;
    while ((fileName = [childFileEnumerator nextObject])!= nil) {
        NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        [manager removeItemAtPath:fileAbsolutePath error:NULL];
    }
}

#pragma mark 获得所有用户DB文件的大小
-(float)getLocalAllDbSize
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *dirPath = [cachePath stringByAppendingPathComponent:@"BOPDB"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *contentArray=[ fileManager contentsOfDirectoryAtPath:dirPath error:nil];
    
    float DBSize=0.0;
    for (NSString *userPath in contentArray) {
        NSString *userdict=[dirPath stringByAppendingPathComponent:userPath];
        NSEnumerator *childFilesEnumerator = [[fileManager subpathsAtPath:userdict] objectEnumerator];
        for (NSString *fileName in childFilesEnumerator) {
            if ([[fileName pathExtension] isEqualToString:@"db"])
            {
                DBSize += [self getSizeAtPath:[userdict stringByAppendingPathComponent:fileName]];
            }
        }
        
    }
    return DBSize;
    
}

#pragma mark 获得当前用户DB文件的大小
-(float)getLocalCurrentDbSize
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSEnumerator *childFilesEnumerator = [[fileManager subpathsAtPath:self.dbPath] objectEnumerator];
    
    for (NSString *fileName in childFilesEnumerator) {
        if ([[fileName pathExtension] isEqualToString:@"db"])
        {
            return [self getSizeAtPath:[self.dbPath stringByAppendingPathComponent:fileName]];
        }
    }
    return 0;
}

// 获取文件后缀名
-(NSString*)getExtensionName:(NSString*)filePath
{
    NSString *exestr = [filePath lastPathComponent];
    // 获得文件名（不带后缀）
    exestr = [exestr stringByDeletingPathExtension];
    // 获得文件的后缀名（不带'.'）
    exestr = [filePath pathExtension];
    return exestr;
}

// 删除整个图片文件夹下的内容
+ (BOOL)delateTotalImage:(NSString*)dirPath
{
    //NSString *dirPath = [self applicationImageFileDirectory];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:dirPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        //判断文件后缀名
        //if ([[filename pathExtension] isEqualToString:extension])
        [fileManager removeItemAtPath:[dirPath stringByAppendingPathComponent:filename] error:NULL];
    }
    //删除对应db里面的数据
    
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from Message;delete from RichTextMsg;delete from GroupMsg;";
        result = [db executeUpdate:sql];
        
    }];
    
    return result;
    
}

// 遍历文件夹获得文件夹大小，返回多少M
- (float)folderSizeAtPath:(NSString*)folderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self getSizeOfDirectory:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
// 单个文件的大小
- (CGFloat)getSizeOfDirectory:(NSString*)directStr
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:directStr]){
        return [[manager attributesOfItemAtPath:directStr error:nil] fileSize];
    }
    return 0;
}


+ (instancetype)getInstance
{
    return instance;
}

+ (void)setNickName:(NSString *)userNickName
{
    if (instance)
    {
        instance.nickname = [userNickName copy];
    }
}

+ (void)setCStr:(NSString *)cStr
{
    if (instance)
    {
        NSString *c = [cStr copy];
        instance.cStr = [c stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
}

+ (void)updateLoginStatus:(FNLoginStatus)status
{
    if (instance)
    {
        instance.loginStatus = status;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_LOGIN_STATUS_CHANGED
                                                            object:[NSNumber numberWithInteger:status]];
    }
}
- (void)redirectNSLogToDocumentFolder
{
    // 如果已经连接Xcode调试则不输出到文件
    if(isatty(STDOUT_FILENO)) {
        return;
    }
    
    UIDevice *device = [UIDevice currentDevice];
    if([[device model] hasSuffix:@"Simulator"]){ //在模拟器不保存到文件中
        return;
    }
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 生成日志文件夹路径
    NSString *logDirectory =  [[cachePath stringByAppendingPathComponent:@"BOPDB"]stringByAppendingPathComponent:KLogDict];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyyMMdd"]; //每次启动后都保存一个新的日志文件中
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/fxcloud-log--%@.log",dateStr];
    if(![fileManager fileExistsAtPath:logFilePath])
    {
        [fileManager createFileAtPath:logFilePath contents:nil attributes:nil];
    }
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    //未捕获的Objective-C异常日志
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

void UncaughtExceptionHandler(NSException* exception)
{
    NSString* name = [ exception name ];
    NSString* reason = [ exception reason ];
    NSArray* symbols = [ exception callStackSymbols ]; // 异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ]; //将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [ strSymbols appendString: item ];
        [ strSymbols appendString: @"\r\n" ];
    }
    
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 生成日志文件夹路径
    NSString *logDirectory =  [[cachePath stringByAppendingPathComponent:@"BOPDB"]stringByAppendingPathComponent:KLogDict];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:logDirectory]) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"UncaughtException.log"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/fxcloud-log--%@.log",dateStr];
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ Fe Symbols Start ]\r\n%@[ Fe Symbols End ]\r\n\r\n", dateStr, name, reason, strSymbols];
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
    
}

@end
