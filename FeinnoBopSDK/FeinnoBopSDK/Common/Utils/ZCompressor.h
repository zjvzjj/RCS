//
//  ZCompressor.h
//  family-sdk-utils
//
//  Created by huangjingjing on 14-7-7.
//  Copyright (c) 2014年 feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <zlib.h>

@interface ZCompressor : NSObject
-(NSData*)decompressData:(NSData*)compressedData;

@end
