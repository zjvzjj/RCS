//
//  DataEncryptor.m
//  feinno-sdk-utils
//
//  Created by doujinkun on 14-7-28.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "NSData+DataEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <GameController/GameController.h>
#import "GTMBase64.h"

@implementation NSData (DataEncrypt)

- (NSData *)sha1
{
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    unsigned int length = (unsigned int)self.length;
    CC_SHA1(self.bytes, length, digest);
    
    NSData *result=[NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    return result;
}

- (NSData *)md5Digest
{
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    unsigned int length = (unsigned int)self.length;
    CC_MD5(self.bytes, length, digest);
    NSData *data = [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    return data;
}

- (NSString *)bytesToHexString
{
    NSMutableString *str = [NSMutableString stringWithCapacity:self.length*2];
    uint8_t *bs = (uint8_t*)self.bytes;
    for (int i = 0; i < self.length; i++)
    {
        [str appendFormat:@"%02X", bs[i]];
    }
    return str;
}

- (NSString *)encodeToBase64String
{
    NSData *base64=[GTMBase64 encodeData:self];
    NSString *result=[[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)decodeBase64ToString
{
    
    NSData *base64 = [GTMBase64 decodeString:[[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding]];
    NSString *result = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    
    return result;
}

- (NSData *)decodeBase64ToData
{
    NSData *base64 = [GTMBase64 decodeString:[[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding]];
    
    return base64;
}

- (NSData *)aes128EncryptWithKey:(NSString *)key
                              iv:(NSString *)iv
{
    return [self aes128Operation:kCCEncrypt key:key iv:iv];
}

- (NSData *)aes128DecryptWithKey:(NSString *)key
                              iv:(NSString *)iv
{
    return [self aes128Operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)aes128Operation:(CCOperation)operation
                        key:(NSString *)key
                         iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    if (iv)
    {
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    }
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

- (NSData *)aes128EncryptWithKey:(NSData *)key
{
    const void *keyPtr = key.bytes;
    
    NSUInteger dataLength = self.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode + kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          NULL,
                                          self.bytes,   //dataPtr,
                                          dataLength,   //sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return data;
    }
    
    free(buffer);
    return nil;
}

@end
