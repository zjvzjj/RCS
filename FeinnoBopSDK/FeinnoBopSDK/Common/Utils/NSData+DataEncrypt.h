//
//  DataEncryptor.h
//  feinno-sdk-utils
//
//  Created by doujinkun on 14-7-28.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSData(DataEncrypt)

- (NSData *)sha1;

- (NSData *)md5Digest;

- (NSString *)bytesToHexString;

- (NSString *)encodeToBase64String;

- (NSString *)decodeBase64ToString;

- (NSData *)decodeBase64ToData;

- (NSData *)aes128EncryptWithKey:(NSData *)key;

- (NSData *)aes128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSData *)aes128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

@end
