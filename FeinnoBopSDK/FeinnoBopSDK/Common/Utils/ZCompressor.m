//
//  ZCompressor.m
//  family-sdk-utils
//
//  Created by huangjingjing on 14-7-7.
//  Copyright (c) 2014年 feinno. All rights reserved.
//

#import "ZCompressor.h"


@implementation ZCompressor

-(NSData*)decompressData:(NSData*)compressedData{
    z_stream zs;
    zs.zalloc=Z_NULL;
    zs.zfree=Z_NULL;
    zs.opaque=Z_NULL;
    zs.avail_in=0;
    zs.next_in=0;
    
    int status=inflateInit2(&zs, (15+32));
    if(status!=Z_OK){
        return nil;
    }
    Bytef *bytes=(Bytef*)[compressedData bytes];
    NSUInteger length=[compressedData length];
    NSUInteger halfLength=length/2;
    NSMutableData *uncompressedData=[NSMutableData dataWithLength:length+halfLength];
    zs.next_in=bytes;
    zs.avail_in=(unsigned int)length;
    zs.avail_out=0;
    NSInteger bytesProcessedAlready=zs.total_out;
    while (zs.avail_in!=0) {
        if(zs.total_out-bytesProcessedAlready>=[uncompressedData length]){
            [uncompressedData increaseLengthBy:halfLength];
        }
        zs.next_out=(Bytef*)[uncompressedData mutableBytes]+zs.total_out-bytesProcessedAlready;
        zs.avail_out=(unsigned int)([uncompressedData length]-(zs.total_out-bytesProcessedAlready));
        status=inflate(&zs, Z_NO_FLUSH);
        if(status==Z_STREAM_END){
            break;
        }
        else if(status!=Z_OK){
            return nil;
        }
    }
    status=inflateEnd(&zs);
    if(status!=Z_OK){
        return nil;
    }
    
    [uncompressedData setLength:zs.total_out-bytesProcessedAlready];
    return uncompressedData;
    
}

@end
