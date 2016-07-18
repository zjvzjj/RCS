//
//  FNContactTable.m
//  feinno-sdk-db
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "FNContactTable.h"
#import "BOPFMDB.h"
#import "FNDBManager.h"

@implementation FNContactTable

+ (NSMutableArray *)get
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"select * from Contact";
        BOPFMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            FNContactTable *cli   = [[FNContactTable alloc] init];
            cli.name              = [rs stringForColumnIndex:0];
            cli.mobileNo          = [rs stringForColumnIndex:1];
            cli.email             = [rs stringForColumnIndex:2];
            cli.userID            = [rs stringForColumnIndex:3];
            cli.registerStatus    = [rs intForColumnIndex:4];
            cli.relationship      = [rs intForColumnIndex:5];
            cli.relationshipUserID= [rs stringForColumnIndex:6];
            cli.extension         = [rs stringForColumnIndex:7];
            cli.version           = [rs longForColumnIndex:8];
            
            [array addObject:cli];
        }
    }];
    return array;
}

+ (instancetype)get:(NSString *)userId
{
    __block FNContactTable *table = [[FNContactTable alloc] init];
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"select * from Contact where userId=?";
        BOPFMResultSet *rs = [db executeQuery:sql, userId];
        while ([rs next])
        {
            table.name              = [rs stringForColumnIndex:0];
            table.mobileNo          = [rs stringForColumnIndex:1];
            table.email             = [rs stringForColumnIndex:2];
            table.userID            = [rs stringForColumnIndex:3];
            table.registerStatus    = [rs intForColumnIndex:4];
            table.relationship      = [rs intForColumnIndex:5];
            table.relationshipUserID= [rs stringForColumnIndex:6];
            table.extension         = [rs stringForColumnIndex:7];
            table.version           = [rs longForColumnIndex:8];
        }
    }];
    return table;
}

+ (BOOL)insert:(FNContactTable *)contact
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"replace into Contact values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        result = [db executeUpdate:sql,
                  contact.name,
                  contact.mobileNo,
                  contact.email,
                  contact.userID,
                  [NSNumber numberWithInt:contact.registerStatus],
                  [NSNumber numberWithInt:contact.relationship],
                  contact.relationshipUserID,
                  contact.extension,
                  [NSNumber numberWithLongLong:contact.version]];
    }];
    return result;
}

+ (BOOL)delete:(NSString *)mobileNo
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from Contact where mobileNo=?";
        result = [db executeUpdate:sql, mobileNo];
    }];
    return result;
}

+ (BOOL)clearAll
{
    __block BOOL result = NO;
    BOPFMDatabaseQueue *queue = [FNDBManager sharedDatabaseQueue];
    [queue inDatabase:^(BOPFMDatabase *db) {
        NSString *sql = @"delete from Contact";
        result = [db executeUpdate:sql];
//        if (result)
//        {
//            sql = [NSString stringWithFormat:@"alter table Contact AUTO_INCREMENT = 1"];
//            result = [db executeUpdate:sql];
//        }
    }];
    return result;
}

@end
