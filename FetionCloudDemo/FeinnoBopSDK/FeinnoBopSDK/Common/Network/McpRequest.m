//
//  McpRequest.m
//  feinno-sdk-net
//
//  Created by wangshuying on 14-8-27.
//  Copyright (c) 2014年 open. All rights reserved.
//

#import "McpRequest.h"
#import "GCDAsyncSocket.h"
#import "HeaderMaker.h"
#import "PacketMaker.h"
#import "PacketParser.h"
#import "CMD.h"

#define TIMEOUT 30

static McpRequest *instance;
static GCDAsyncSocket *_socket;
static NSString *ip;
static uint16_t port;

NSMutableData *bufferData;
int32_t fullLength;
uint32_t cmdValue;
BOOL combineFlag;
int16_t seqValue;
//static int16_t offsetValue = 24; // 包头至少的长度

NSMutableDictionary *msgDict;

/*
 * 请求的seq放在此Array中，当收到应答时，从Array中remove掉
 * 使用定时器遍历该Array，判断某个请求的应答是否超时
 */
NSMutableArray *timeoutArray;
NSMutableArray *notifyCmdArray;

@implementation McpRequest

- (id)initWithIp:(NSString *)strIp
            port:(uint16_t)nPort
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[McpRequest alloc] init];
            msgDict = [[NSMutableDictionary alloc] init];
            timeoutArray = [[NSMutableArray alloc] init];
            notifyCmdArray = [[NSMutableArray alloc] initWithObjects:
                              [NSString stringWithFormat:@"%d", CMD_RTC_INVITE],
                              [NSString stringWithFormat:@"%d", CMD_RTC_REPLY],
                              [NSString stringWithFormat:@"%d", CMD_RTC_UPDATE],
                              [NSString stringWithFormat:@"%d", CMD_NOTIFY_INFO],
                              [NSString stringWithFormat:@"%d", CMD_GROUP_LIST_CHAGE_NTF],
                              [NSString stringWithFormat:@"%d", CMD_KICK_NOTIFY],
                              [NSString stringWithFormat:@"%d", CMD_NEW_MSG_NOTIFY],
                              [NSString stringWithFormat:@"%d", CMD_SIMPLE_MSG_NOTIFY],
                              [NSString stringWithFormat:@"%d", CMD_NEW_FC_THEME_NOTIFY],
                              [NSString stringWithFormat:@"%d", CMD_NEW_FC_COMMENT_NOTIFY],
                              nil];
        }
    });
    ip = [[NSString alloc] initWithString:strIp];
    port = nPort;
    
    return instance;
}

+ (McpRequest *)sharedInstance
{
    return instance;
}

- (void)connect
{
    if (!_socket)
    {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSError *error = nil;
        BOOL result = [_socket connectToHost:ip onPort:port error:&error];
        if (!result)
        {
            NSLog(@"connectToHost with error : %@", [error description]);
        }
    }
}

- (void)reConnect
{
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    BOOL result = [_socket connectToHost:ip onPort:port error:&error];
    if (!result)
    {
        NSLog(@"reConnectToHost with error : %@", [error description]);
    }
}

- (void)disConnect
{
	if (_socket != nil)
	{
        _socket.delegate = nil;
		[_socket disconnect];
        _socket = nil;
	}
    for (int i = 0; i < [msgDict count]; i++)
    {
        
        [self finishGetWholeData:nil cmd:0 seqId:[[[msgDict allKeys] objectAtIndex:i] integerValue]];
    }
    bufferData = nil;
    combineFlag = NO;
    cmdValue = 0;
    seqValue = 0;
    fullLength = 0;
}

- (NSData *)makeHeader:(uint32_t)cmd
                userid:(NSString *)userid
                   seq:(int16_t)seq
            bodyLength:(uint16_t)length
{
    return [HeaderMaker makeRequestHeaderWithCmd:cmd
                                      bodyLength:length
                                         version:0x1E
                                          userId:userid
                                             seq:seq
                                            flag:0
                                      clientType:15
                                   clientVersion:1];
}


- (void)send:(uint32_t)cmd
      userid:(NSString *)userid
        body:(NSData *)body
    callback:(void(^)(NSData *data))callback
{
    int16_t seqId = (arc4random() % 32767) + 1;
    NSString *seqStr = [NSString stringWithFormat:@"%d", seqId];
    while ([[msgDict allKeys] containsObject:seqStr])
    {
        seqId++;
        seqStr = [NSString stringWithFormat:@"%d", seqId];
    }
    [self sendByHeader:[self makeHeader:cmd
                                 userid:userid
                                    seq:seqId
                             bodyLength:[body length]]
                   seq:seqId
                  body:body
              callback:callback];
}

- (void)sendByHeader:(NSData *)header
                 seq:(int16_t)seq
                body:(NSData *)body
            callback:(void(^)(NSData *data))callback
{
    // 以seqid作为key来判断请求&应答的配对
    @synchronized(msgDict) {
        [msgDict setObject:[callback copy] forKey:[NSString stringWithFormat:@"%d", seq]];
    }
	
	NSData *data = [PacketMaker compose:header body:body];
    
    int32_t cmd = 0;
    [header getBytes:&cmd range:NSMakeRange(7, 4)];

    [self connect];
	[_socket writeData:data withTimeout:-1 tag:0];
    
//    [timeoutArray addObject:[NSString stringWithFormat:@"%d", seq]];
//
//    // 从发送时间开始计算TIMEOUT，判断服务器应答是否超时
//    [NSTimer scheduledTimerWithTimeInterval:TIMEOUT target:self selector:@selector(checkTimeout:) userInfo:[NSString stringWithFormat:@"%d", seq] repeats:NO];
    
	NSLog(@"\n\nSocket Send CMD:%d SEQ:%d...\n\n", cmd, seq);
}

- (void)socket:(GCDAsyncSocket *)sock
didConnectToHost:(NSString *)host
          port:(uint16_t)port
{
    NSLog(@"didConnectToHost:%@ port:%d\n\n", host, port);
    [_socket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock
   didReadData:(NSData *)data
       withTag:(long)tag
{
    [self handleBufferData:data tag:tag];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock
                  withError:(NSError *)err
{
    if (err)
    {
        NSLog(@"socketDidDisconnect with error : %@", [err description]);
    }
    for (int i = 0; i < [msgDict count]; i++)
    {
        [self finishGetWholeData:nil cmd:0 seqId:[[[msgDict allKeys] objectAtIndex:i] integerValue]];
    }
    if (sock)
    {
        [self disConnect];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BOPSocketErrorNotify" object:nil];
}

- (void)handleBufferData:(NSData *)data
                     tag:(long)tag
{
    int32_t dataLength = (int32_t)data.length;
    if (dataLength < 13)
    {
        // 数据过短，无法解析出包头信息
        combineFlag = YES;
        cmdValue = 0;
        seqValue = 0;
        fullLength = 0;
        bufferData = [[NSMutableData alloc] initWithData:data];
        NSLog(@"datalength : %d is not enough", dataLength);
        
        [_socket readDataWithTimeout:-1 tag:0];
    }
    else
    {
        if (combineFlag)
        {
            [self combineData:data fullLength:fullLength cmd:cmdValue seqId:seqValue];
        }
        else
        {
            uint16_t length = 0;
            [data getBytes:&length range:NSMakeRange(0, 2)];
            uint32_t cmd = 0;
            [data getBytes:&cmd range:NSMakeRange(7, 4)];
            int16_t seq = 0;
            [data getBytes:&seq range:NSMakeRange(11, 2)];
            
            //        [timeoutArray removeObject:[NSString stringWithFormat:@"%d", seq]];
            
            if (length == dataLength)
            {
                NSData *contentData = [data subdataWithRange:NSMakeRange(0, length)];
                [self finishGetWholeData:contentData cmd:cmd seqId:seq];
                
                NSLog(@"tcp data handle completed.");
                [_socket readDataWithTimeout:-1 tag:0];
            }
            else if (length < dataLength)
            {
                //有粘包，需拆分
                NSLog(@"start split tcp data...");
                
                //拆出一个完整包，然后继续处理剩余字节
                NSData *contentData = [data subdataWithRange:NSMakeRange(0, length)];
                [self finishGetWholeData:contentData cmd:cmd seqId:seq];
                
                combineFlag = NO;
                cmdValue = 0;
                seqValue = 0;
                [self handleBufferData:[data subdataWithRange:NSMakeRange(length, data.length - length)] tag:tag];
            }
            else if (length > dataLength)
            {
                //包被拆分了，需等待下一个包进来合并
                cmdValue = cmd;
                seqValue = seq;
                fullLength = length;
                combineFlag = YES;
                bufferData = [[NSMutableData alloc] initWithData:data];
                
                NSLog(@"wait next packet data to combine...");
                
                [_socket readDataWithTimeout:-1 tag:0];
            }
        }
    }
}

- (void)combineData:(NSData *)data
         fullLength:(int32_t)fullLength
                cmd:(uint32_t)cmd
              seqId:(int16_t)seqId
{
    [bufferData appendData:data];
    if (cmd == 0 || seqId == 0 || fullLength == 0)
    {
        [data getBytes:&fullLength range:NSMakeRange(0, 2)];
        [data getBytes:&cmd range:NSMakeRange(7, 4)];
        [data getBytes:&seqId range:NSMakeRange(11, 2)];
    }
    
//    NSLog(@"\nSocket data info:\n dataLength:%lu\n bufferDataLength:%lu\n fullLength:%d\n seq:%d\n\n", (unsigned long)data.length, (unsigned long)bufferData.length ,fullLength, seqId);
    
    int32_t bufferDataLength = (int32_t)bufferData.length;
    if (bufferDataLength == fullLength)
    {
        uint32_t aCmd = 0;
        [bufferData getBytes:&aCmd range:NSMakeRange(7, 4)];
        int16_t aSeq = 0;
        [bufferData getBytes:&aSeq range:NSMakeRange(11, 2)];
        
        NSLog(@"cmd<===>aCmd: %d<===>%d\nseq<===>aSeq: %d<===>%d", cmd, aCmd, seqId, aSeq);
        
        [self finishGetWholeData:bufferData cmd:cmd seqId:seqId];
        
        //完成一个完整数据包的合并后，把bufferData清空
        bufferData = nil;
        combineFlag = NO;
        cmdValue = 0;
        seqValue = 0;
        NSLog(@"-----tcp data combine completed.");
    }
    else if (bufferDataLength > fullLength)
    {
        NSData *onePacket = [bufferData subdataWithRange:NSMakeRange(0, fullLength)];
        [self finishGetWholeData:onePacket cmd:cmdValue seqId:seqValue];
        int32_t leftLength = bufferDataLength - fullLength;
        combineFlag = NO;// ((offsetValue > leftLength) ? NO : YES);
        cmdValue = 0;
        seqValue = 0;
        bufferData = [NSMutableData dataWithData:[bufferData subdataWithRange:NSMakeRange(fullLength, leftLength)]];
        [self handleBufferData:bufferData tag:0];
        
        NSLog(@"spilt packet second time!");
    }
    else if (bufferDataLength < fullLength)
    {
        //继续等待下一个包进来合并
        NSLog(@"keep waiting next packet data to combine...");
        combineFlag = YES;
    }
    
    [_socket readDataWithTimeout:-1 tag:0];
}

- (void)finishGetWholeData:(NSData *)data
                       cmd:(int32_t)cmd
                     seqId:(int16_t)seqId
{
    id obj = [msgDict valueForKey:[NSString stringWithFormat:@"%d", seqId]];
    if (!obj || [notifyCmdArray containsObject:[NSString stringWithFormat:@"%d", seqId]])
    {
        // 非客户端请求的应答，即服务器主动发送的Notify
        NSLog(@"NOTIFY!");

        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%d", cmd] object:data];
    }
    else if ([obj isKindOfClass:[NSArray class]])
    {
        NSArray *argAry = (NSArray *)obj;
        NSObject *target = argAry[0];
        NSObject *arg = argAry[1];
        SEL callback = NSSelectorFromString(argAry[2]);
        if (target != nil && [target respondsToSelector:callback])
        {
            [target performSelector:callback withObject:data withObject:arg];
        }
    }
    else
    {
        @synchronized(msgDict) {
            [msgDict removeObjectForKey:[NSString stringWithFormat:@"%d", seqId]];
        }
        void (^onfinish)(NSData *data);
        onfinish = obj;
        onfinish(data);
    }
}

- (void)checkTimeout:(NSTimer *)timer
{
    NSString *seq = [NSString stringWithFormat:@"%@", [timer userInfo]];
    for (NSString *value in timeoutArray) {
        if ([seq isEqualToString:value]) {
            NSLog(@"msg timeout, seq: %@", seq);
            [timeoutArray removeObject:seq];
        }
    }
    id obj = [msgDict valueForKey:seq];
    if (obj)
    {
        @synchronized(msgDict) {
            [msgDict removeObjectForKey:seq];
        }
        
        //TODO 应该告诉调用方请求已超时
        void (^onfinish) (NSData *data);
        onfinish = obj;
        onfinish(nil);
    }
}

+ (PacketObject *)parse:(NSData *)data
{
    PacketParser *packetParser = [[PacketParser alloc] initWithData:data];
	return [packetParser parse];
}

+ (PacketObject *)parseWithData:(NSData *)data
                            key:(NSString *)key
{
    PacketParser *packetParser = [[PacketParser alloc] initWithData:data];
    return [packetParser parseWithKey:key];
}

@end
