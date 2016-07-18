//
//  PacketParse.m
//  feinno-sdk-protocol
//
//  Created by wangshuying on 14-8-28.
//  Copyright (c) 2014年 feinno. All rights reserved.
//

#import <objc/runtime.h>
#import "PacketParser.h"
#import "CMD.h"
#import "ZCompressor.h"
#import "NSData+DataEncrypt.h"

@implementation PacketParser

- (id)init
{
    self = [super init];
    if (self)
    {
        [self loadArgClassNames];
	}
	return self;
}

- (id)initWithBytes:(uint8_t *)bytes length:(uint16_t)length
{
    self = [super init];
    if (self)
    {
        self.data = [NSMutableData dataWithBytes:bytes length:length];
        [self loadArgClassNames];
    }
    return self;
}

- (id)initWithData:(NSData *)data
{
    self = [super init];
    if (self)
    {
        self.data = [NSMutableData dataWithData:data];
        [self loadArgClassNames];
    }
    return self;
}

- (void)loadArgClassNames
{
    argClassNames = [[NSMutableDictionary alloc] initWithCapacity:30];
    //account
    argClassNames[[NSString stringWithFormat:@"%d", CMD_MAKE_PIC]] = @"MakeCertPicRspRets";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_REG]] = @"RegisterWithCertPicRspRets";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_REG2]] = @"LoginWithPwdRspRets";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_UN_REG]] = @"StatusRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_KEEP_ALIVE]] = @"KeepAliveResult";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_IS_REGISTER]] = @"IsRegisterRspArgs";

    argClassNames[[NSString stringWithFormat:@"%d", CMD_GET_ADDRESS_LIST]] = @"GetAddressListRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_RESET_PWD]] = @"ResetPwdRspRets";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_MODIFY_PWD]] = @"ModifyPwdRspRets";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_UP_ADDRESSLIST]] = @"SimpleRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_DEL_ADDRESS_LIST]] = @"SimpleRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SEND_MSG_CONTACT]] = @"SendMsgResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SEND_MSG_GROUP]] = @"SendMsgResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_GET_MSG_CONTACT]] = @"PullMsgResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_GET_MSG_GROUP]] = @"PullMsgResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_GET_NOTIFY]] = @"PullNotifyResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_DEL_MSG_CONTACT]] = @"DelMsgResult";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_DEL_MSG_GROUP]] = @"DelMsgResult";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_DEL_NOTIFY]] = @"DelMsgResult";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_GET_HISTORY_MSG_CONTACT]] = @"GetRoamingMsgResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SEND_SIMPLE_MSG]] = @"SendSimpleMsgResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SIMPLE_MSG_NOTIFY]] = @"SendSimpleMsgNotify";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SEND_MULTI_MSG_CONTACT]] = @"SendMsgResults";

    argClassNames[[NSString stringWithFormat:@"%d", CMD_GET_GROUP_LIST]] = @"GetGroupListResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_GET_GROUP_MEMBER]] = @"GetGroupMemberListResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_GET_GROUP_FILE_CREDENCIAL]] = @"GetGroupFileCredencialResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_CREATE_GROUP]] = @"CreateGroupResult";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_DELETE_GROUP]] = @"StatusRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_EXIT_GROUP]] = @"StatusRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_INVITE_JOIN_GROUP]] = @"StatusRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_KICKOUT_GROUP]] = @"StatusRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SET_GROUP_INFO]] = @"StatusRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SEND_GROUP_MSG]] = @"SendMsgResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_GROUP_CHANGE_OWNER]] = @"ChangeGroupOwnerResults";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SET_GROUP_MEMBERINFO]] = @"SetGroupMemberInfoRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_BATCH_KICKOUT_GROUP]] = @"BatchKickOutGroupRspArgs";

    // 通知
    argClassNames[[NSString stringWithFormat:@"%d", CMD_KICK_NOTIFY]] = @"BNKickNotifyArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_RTC_INVITE]] = @"RtcInviteReqArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_RTC_REPLY]] = @"RtcReplyReqArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_RTC_UPDATE]] = @"RtcUpdateReqArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_NEW_MSG_NOTIFY]] = @"NewMsgNotifyArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_NOTIFY_INFO]] = @"AVNotifyInfo";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_GROUP_LIST_CHAGE_NTF]] = @"GroupListChangedArgs";
    
    // 首次登录
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SEND_WELCOMELANGUAGE]] = @"SendWelcomeLanguageRspArgs";
    argClassNames[[NSString stringWithFormat:@"%d", CMD_SEND_GROUPWELCOMElANGUAGE]] = @"SendWelcomeLanguageRspArgs";

}

- (PacketObject *)parse
{
    return [self parseWithKey:nil];
}

- (PacketObject *)parseWithKey:(NSString *)key
{
    _packetObject = [[PacketObject alloc] init];
    _packetObject.header = self.parseHeader;
    @try {
        _packetObject.args = [self parseBodyWithKey:key];
    }
    @catch (NSException *exception) {
        NSLog(@"NSException.name = %@" , exception.name);
        NSLog(@"NSException.reason = %@" , exception.reason);
    }
    @finally {
    }
    
    return _packetObject;
}

- (ResponseHeader)parseHeader
{
    if (self.data == nil)
    {
        @throw [NSException exceptionWithName:@"No Data" reason:@"" userInfo:nil];
    }
    
    // TODO self.date.length>=21 检查？ 否则在取范围时会崩溃
    
    uint16_t length = 0;
    [self.data getBytes:&length range:NSMakeRange(0, 2)];
    
    if (self.data.length < length)
    {
        @throw [NSException exceptionWithName:@"Data not enought" reason:@"" userInfo:nil];
    }
    
    uint8_t offset = 0;
    [self.data getBytes:&offset range:NSMakeRange(13, 1)];
    
    ResponseHeader header;
    [self.data getBytes:&header range:NSMakeRange(0, 21)];
    
//    header.opt = [[[NSString alloc] initWithData:[self.data subdataWithRange:NSMakeRange(21, offset - 21)] encoding:NSUTF8StringEncoding] UTF8String];
    
    NSLog(@"parse receive data:mLen:%ld<==>%d, off: %d cmd: %d", (long)self.data.length, length, offset, header.cmd);
//    printf("opt: %s, %d\n", header.opt, strlen(header.opt));
    
    return header;
}

- (NSObject *)parseBodyWithKey:(NSString *)key;
{
    NSString *cmd = [NSString stringWithFormat:@"%d", self.packetObject.header.cmd];
    Class cls = NSClassFromString([argClassNames objectForKey:cmd]);
    NSLog(@"parse body class : %@", [argClassNames objectForKey:cmd]);
    int length = self.packetObject.header.length;
    int offset = self.packetObject.header.offset;
    
    NSData *bodyData = [self.data subdataWithRange:NSMakeRange(offset, length - offset)];
        
    switch (self.packetObject.header.flag)
    {
        case 0:
            break;
        case 1:
        {
            ZCompressor *zc=[[ZCompressor alloc] init];
            bodyData = [zc decompressData:bodyData];
            break;
        }
        case 2:
        {
            bodyData = [PacketParser decryptMsgBody:bodyData key:key];
            break;
        }
        default:
            break;
    }
    
//    NSObject *body = [cls parseFromData:bodyData];
    if (cls != nil && [[cls class] respondsToSelector:NSSelectorFromString(@"parseFromData:")])
    {
        return [cls performSelector:NSSelectorFromString(@"parseFromData:") withObject:bodyData];
    }
    return nil;
    
//    return body;
}

// 解密方法
+ (NSData *)decryptMsgBody:(NSData *)data key:(NSString *)sKey
{
    NSData *rspData = nil;
    if (sKey)
    {
        NSData *enCodeFormat = [[sKey dataUsingEncoding:NSUTF8StringEncoding] md5Digest];
        rspData = [data aes128DecryptWithKey:[[NSString alloc] initWithData:enCodeFormat
                                                                   encoding:NSUTF8StringEncoding]
                                          iv:nil];
    }
    
    return rspData;
}

@end
