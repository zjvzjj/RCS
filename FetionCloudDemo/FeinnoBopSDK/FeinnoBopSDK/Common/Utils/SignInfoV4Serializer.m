//
//  SignInfoV4Serializer.m
//  FeinnoBopSDK
//
//  Created by zym on 15/3/17.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "SignInfoV4Serializer.h"
#import "SignInfoV4.h"

@implementation SignInfoV4Serializer

+ (void) putIntDotNet : (Byte *)buffer input:(int32_t)info index:(int32_t)index
{
    buffer[index + 0] = (Byte)(info >> 0);
    buffer[index + 1] = (Byte)(info >> 8);
    buffer[index + 2] = (Byte)(info >> 16);
    buffer[index + 3] = (Byte)(info >> 24);
}

+ (void) putLongDotNet:(Byte *)buffer input:(int64_t)info index:(int32_t)index
{
    buffer[index + 0] = (Byte)(info >> 0);
    buffer[index + 1] = (Byte)(info >> 8);
    buffer[index + 2] = (Byte)(info >> 16);
    buffer[index + 3] = (Byte)(info >> 24);
    buffer[index + 4] = (Byte)(info >> 32);
    buffer[index + 5] = (Byte)(info >> 40);
    buffer[index + 6] = (Byte)(info >> 48);
    buffer[index + 7] = (Byte)(info >> 56);
}

+ (int32_t)getIntDoNet:(Byte *)buffer index:(int32_t)index
{
    return (int32_t)(((buffer[index + 3] & 0xff) << 24) |
                     ((buffer[index + 2] & 0xff) << 16) |
                     ((buffer[index + 1] & 0xff) << 8) |
                     ((buffer[index + 0] & 0xff) << 0)
                     );
    
}

+ (int64_t)getLongDoNet:(Byte *)buffer index:(int32_t)index
{
    return ((((int64_t) buffer[index + 0] & 0xff) << 56)
            | (((int64_t) buffer[index + 1] & 0xff) << 48)
            | (((int64_t) buffer[index + 2] & 0xff) << 40)
            | (((int64_t) buffer[index + 3] & 0xff) << 32)
            
            | (((int64_t) buffer[index + 4] & 0xff) << 24)
            | (((int64_t) buffer[index + 5] & 0xff) << 16)
            | (((int64_t) buffer[index + 6] & 0xff) << 8)
            | (((int64_t) buffer[index + 7] & 0xff) << 0));
}

+ (NSData *)serialize:(SignInfoV4 *)info
{
    NSUInteger size = 33 + info.userId.length + info.indexId.length;
    
    Byte buffer[size];
    
    int32_t index  = 0;
    [self putIntDotNet:buffer input:info.noce index:index];
    
    index = index + 4;
    [self putLongDotNet:buffer input:(long)[info.createTime timeIntervalSince1970] index:index];
    
    index = index + 8;
    [self putLongDotNet:buffer input:(long)[info.expireTime timeIntervalSince1970] index:index];
    
    index = index + 8;
    [self putLongDotNet:buffer input:info.userIp index:index];
    
    index = index + 8;
    [self putLongDotNet:buffer input:info.indexCaps index:index];
    
    index = index + 4;
    
    Byte len = (Byte)info.userId.length;
    
    buffer[index] = len;
    index = index + 1;
    
    int64_t userIdLen = [info.userId length];
    NSData *data = [info.userId dataUsingEncoding:NSUTF8StringEncoding];
    Byte *userIdByte = (Byte *)[data bytes];
    
    for (int i = index ,j = 0; j < userIdLen; i ++, j++) {
        buffer[i] = userIdByte[j];
    }
    index = index + (int32_t)userIdLen;
    
    int64_t indexIdLen = [info.indexId length];
    data = [info.indexId dataUsingEncoding:NSUTF8StringEncoding];
    Byte *indexByte = (Byte *)[data bytes];
    
    for (int i = index ,j = 0; j < indexIdLen; i ++, j++) {
        buffer[i] = indexByte[j];
    }

    NSData *bufferData = [[NSData alloc] initWithBytes:buffer length:size];
    return bufferData;
}

+ (SignInfoV4 *)deSerialize:(NSData *)dataBuffer offset:(int32_t)offset
{
    NSUInteger size = [dataBuffer length];
    Byte *buffer = (Byte *)[dataBuffer bytes];
    
    SignInfoV4 *info = [[SignInfoV4 alloc] init];
    info.noce = [self getIntDoNet:buffer index:offset];
    offset = offset + 4;
    
    info.createTime = [NSDate dateWithTimeIntervalSince1970:[self getLongDoNet:buffer index:offset]];
    offset = offset + 8;
    
    info.expireTime = [NSDate dateWithTimeIntervalSince1970:[self getLongDoNet:buffer index:offset]];
    offset = offset + 8;
    
    info.userIp = [self getLongDoNet:buffer index:offset];
    offset = offset + 8;
    
    info.indexCaps = [self getIntDoNet:buffer index:offset];
    offset = offset + 4;
    
    NSUInteger userIdLength = buffer[offset];
    info.userId = [[NSString alloc] initWithBytes:&buffer[offset] length:userIdLength encoding:NSUTF8StringEncoding];
    
    offset = offset + userIdLength;
    
    NSLog(@"the userid is %@", info.userId);
    
    NSUInteger indexIdLen = size - offset;
    info.indexId = [[NSString alloc] initWithBytes:buffer length:indexIdLen encoding:NSUTF8StringEncoding];
    
    return info;
}

@end
