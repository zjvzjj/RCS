//
//  PacketHeader.h
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-8-25.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef family_sdk_protocol_PacketHeader_h
#define family_sdk_protocol_PacketHeader_h
#pragma pack(1)

#define UID_LEN 65

typedef struct _RequestHeader{
    uint16_t length;
    uint8_t version;
    uint32_t userId_unused;
    uint32_t cmd;
    uint16_t seq;
    uint8_t offset;
    uint8_t format;
    uint8_t flag;
    uint16_t clientType;
    uint16_t clientVersion;
    uint8_t blank;
//    uint8_t opt[4];
    char *opt;
}RequestHeader;


typedef struct _ResponseHeader{
    uint16_t length;
    uint8_t version;
    uint32_t userId_unused;
    uint32_t cmd;
    uint16_t seq;
    uint8_t offset;
    uint8_t format;
    uint8_t flag;
    uint16_t clientType;
    uint16_t clientVersion;
    uint8_t blank;
    char *opt;
}ResponseHeader;

#endif
