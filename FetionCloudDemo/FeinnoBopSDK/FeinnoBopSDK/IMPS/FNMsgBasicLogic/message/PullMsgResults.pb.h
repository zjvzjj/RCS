// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

// @@protoc_insertion_point(imports)

@class PullMsgResults;
@class PullMsgResultsBuilder;
@class PullMsgResultsMsgEntityArgs;
@class PullMsgResultsMsgEntityArgsBuilder;
@class PullMsgResultsMsgEntityArgsMsgEntity;
@class PullMsgResultsMsgEntityArgsMsgEntityBuilder;



@interface PullMsgResultsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define PullMsgResults_statusCode @"statusCode"
#define PullMsgResults_readMsgRspArgsList @"readMsgRspArgsList"
#define PullMsgResults_isCompleted @"isCompleted"
#define PullMsgResults_syncId @"syncId"
@interface PullMsgResults : PBGeneratedMessage {
@private
  BOOL hasIsCompleted_:1;
  BOOL hasSyncId_:1;
  BOOL hasStatusCode_:1;
  BOOL isCompleted_:1;
  SInt64 syncId;
  SInt32 statusCode;
  NSMutableArray * readMsgRspArgsListArray;
}
- (BOOL) hasStatusCode;
- (BOOL) hasIsCompleted;
- (BOOL) hasSyncId;
@property (readonly) SInt32 statusCode;
@property (readonly, strong) NSArray * readMsgRspArgsList;
- (BOOL) isCompleted;
@property (readonly) SInt64 syncId;
- (PullMsgResultsMsgEntityArgs*)readMsgRspArgsListAtIndex:(NSUInteger)index;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PullMsgResultsBuilder*) builder;
+ (PullMsgResultsBuilder*) builder;
+ (PullMsgResultsBuilder*) builderWithPrototype:(PullMsgResults*) prototype;
- (PullMsgResultsBuilder*) toBuilder;

+ (PullMsgResults*) parseFromData:(NSData*) data;
+ (PullMsgResults*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PullMsgResults*) parseFromInputStream:(NSInputStream*) input;
+ (PullMsgResults*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PullMsgResults*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PullMsgResults*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

#define MsgEntityArgs_fromBopId @"fromBopId"
#define MsgEntityArgs_toUserId @"toUserId"
#define MsgEntityArgs_msg @"msg"
#define MsgEntityArgs_sendDate @"sendDate"
#define MsgEntityArgs_sendClientType @"sendClientType"
#define MsgEntityArgs_sendClientPortraitUrl @"sendClientPortraitUrl"
@interface PullMsgResultsMsgEntityArgs : PBGeneratedMessage {
@private
  BOOL hasSendClientType_:1;
  BOOL hasFromBopId_:1;
  BOOL hasToUserId_:1;
  BOOL hasSendDate_:1;
  BOOL hasSendClientPortraitUrl_:1;
  BOOL hasMsg_:1;
  SInt32 sendClientType;
  NSString* fromBopId;
  NSString* toUserId;
  NSString* sendDate;
  NSString* sendClientPortraitUrl;
  PullMsgResultsMsgEntityArgsMsgEntity* msg;
}
- (BOOL) hasFromBopId;
- (BOOL) hasToUserId;
- (BOOL) hasMsg;
- (BOOL) hasSendDate;
- (BOOL) hasSendClientType;
- (BOOL) hasSendClientPortraitUrl;
@property (readonly, strong) NSString* fromBopId;
@property (readonly, strong) NSString* toUserId;
@property (readonly, strong) PullMsgResultsMsgEntityArgsMsgEntity* msg;
@property (readonly, strong) NSString* sendDate;
@property (readonly) SInt32 sendClientType;
@property (readonly, strong) NSString* sendClientPortraitUrl;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PullMsgResultsMsgEntityArgsBuilder*) builder;
+ (PullMsgResultsMsgEntityArgsBuilder*) builder;
+ (PullMsgResultsMsgEntityArgsBuilder*) builderWithPrototype:(PullMsgResultsMsgEntityArgs*) prototype;
- (PullMsgResultsMsgEntityArgsBuilder*) toBuilder;

+ (PullMsgResultsMsgEntityArgs*) parseFromData:(NSData*) data;
+ (PullMsgResultsMsgEntityArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PullMsgResultsMsgEntityArgs*) parseFromInputStream:(NSInputStream*) input;
+ (PullMsgResultsMsgEntityArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PullMsgResultsMsgEntityArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PullMsgResultsMsgEntityArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

#define MsgEntity_msgId @"msgId"
#define MsgEntity_syncId @"syncId"
#define MsgEntity_msgType @"msgType"
#define MsgEntity_msgAttribute @"msgAttribute"
#define MsgEntity_msgContent @"msgContent"
#define MsgEntity_senderNickname @"senderNickname"
#define MsgEntity_senderId @"senderId"
#define MsgEntity_extend @"extend"
@interface PullMsgResultsMsgEntityArgsMsgEntity : PBGeneratedMessage {
@private
  BOOL hasSyncId_:1;
  BOOL hasMsgId_:1;
  BOOL hasMsgType_:1;
  BOOL hasMsgAttribute_:1;
  BOOL hasMsgContent_:1;
  BOOL hasSenderNickname_:1;
  BOOL hasSenderId_:1;
  BOOL hasExtend_:1;
  SInt64 syncId;
  NSString* msgId;
  NSString* msgType;
  NSString* msgAttribute;
  NSString* msgContent;
  NSString* senderNickname;
  NSString* senderId;
  NSData* extend;
}
- (BOOL) hasMsgId;
- (BOOL) hasSyncId;
- (BOOL) hasMsgType;
- (BOOL) hasMsgAttribute;
- (BOOL) hasMsgContent;
- (BOOL) hasSenderNickname;
- (BOOL) hasSenderId;
- (BOOL) hasExtend;
@property (readonly, strong) NSString* msgId;
@property (readonly) SInt64 syncId;
@property (readonly, strong) NSString* msgType;
@property (readonly, strong) NSString* msgAttribute;
@property (readonly, strong) NSString* msgContent;
@property (readonly, strong) NSString* senderNickname;
@property (readonly, strong) NSString* senderId;
@property (readonly, strong) NSData* extend;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) builder;
+ (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) builder;
+ (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) builderWithPrototype:(PullMsgResultsMsgEntityArgsMsgEntity*) prototype;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) toBuilder;

+ (PullMsgResultsMsgEntityArgsMsgEntity*) parseFromData:(NSData*) data;
+ (PullMsgResultsMsgEntityArgsMsgEntity*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PullMsgResultsMsgEntityArgsMsgEntity*) parseFromInputStream:(NSInputStream*) input;
+ (PullMsgResultsMsgEntityArgsMsgEntity*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PullMsgResultsMsgEntityArgsMsgEntity*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PullMsgResultsMsgEntityArgsMsgEntity*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PullMsgResultsMsgEntityArgsMsgEntityBuilder : PBGeneratedMessage_Builder {
@private
  PullMsgResultsMsgEntityArgsMsgEntity* resultMsgEntity;
}

- (PullMsgResultsMsgEntityArgsMsgEntity*) defaultInstance;

- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clear;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clone;

- (PullMsgResultsMsgEntityArgsMsgEntity*) build;
- (PullMsgResultsMsgEntityArgsMsgEntity*) buildPartial;

- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) mergeFrom:(PullMsgResultsMsgEntityArgsMsgEntity*) other;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasMsgId;
- (NSString*) msgId;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) setMsgId:(NSString*) value;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clearMsgId;

- (BOOL) hasSyncId;
- (SInt64) syncId;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) setSyncId:(SInt64) value;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clearSyncId;

- (BOOL) hasMsgType;
- (NSString*) msgType;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) setMsgType:(NSString*) value;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clearMsgType;

- (BOOL) hasMsgAttribute;
- (NSString*) msgAttribute;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) setMsgAttribute:(NSString*) value;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clearMsgAttribute;

- (BOOL) hasMsgContent;
- (NSString*) msgContent;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) setMsgContent:(NSString*) value;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clearMsgContent;

- (BOOL) hasSenderNickname;
- (NSString*) senderNickname;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) setSenderNickname:(NSString*) value;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clearSenderNickname;

- (BOOL) hasSenderId;
- (NSString*) senderId;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) setSenderId:(NSString*) value;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clearSenderId;

- (BOOL) hasExtend;
- (NSData*) extend;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) setExtend:(NSData*) value;
- (PullMsgResultsMsgEntityArgsMsgEntityBuilder*) clearExtend;
@end

@interface PullMsgResultsMsgEntityArgsBuilder : PBGeneratedMessage_Builder {
@private
  PullMsgResultsMsgEntityArgs* resultMsgEntityArgs;
}

- (PullMsgResultsMsgEntityArgs*) defaultInstance;

- (PullMsgResultsMsgEntityArgsBuilder*) clear;
- (PullMsgResultsMsgEntityArgsBuilder*) clone;

- (PullMsgResultsMsgEntityArgs*) build;
- (PullMsgResultsMsgEntityArgs*) buildPartial;

- (PullMsgResultsMsgEntityArgsBuilder*) mergeFrom:(PullMsgResultsMsgEntityArgs*) other;
- (PullMsgResultsMsgEntityArgsBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PullMsgResultsMsgEntityArgsBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasFromBopId;
- (NSString*) fromBopId;
- (PullMsgResultsMsgEntityArgsBuilder*) setFromBopId:(NSString*) value;
- (PullMsgResultsMsgEntityArgsBuilder*) clearFromBopId;

- (BOOL) hasToUserId;
- (NSString*) toUserId;
- (PullMsgResultsMsgEntityArgsBuilder*) setToUserId:(NSString*) value;
- (PullMsgResultsMsgEntityArgsBuilder*) clearToUserId;

- (BOOL) hasMsg;
- (PullMsgResultsMsgEntityArgsMsgEntity*) msg;
- (PullMsgResultsMsgEntityArgsBuilder*) setMsg:(PullMsgResultsMsgEntityArgsMsgEntity*) value;
- (PullMsgResultsMsgEntityArgsBuilder*) setMsgBuilder:(PullMsgResultsMsgEntityArgsMsgEntityBuilder*) builderForValue;
- (PullMsgResultsMsgEntityArgsBuilder*) mergeMsg:(PullMsgResultsMsgEntityArgsMsgEntity*) value;
- (PullMsgResultsMsgEntityArgsBuilder*) clearMsg;

- (BOOL) hasSendDate;
- (NSString*) sendDate;
- (PullMsgResultsMsgEntityArgsBuilder*) setSendDate:(NSString*) value;
- (PullMsgResultsMsgEntityArgsBuilder*) clearSendDate;

- (BOOL) hasSendClientType;
- (SInt32) sendClientType;
- (PullMsgResultsMsgEntityArgsBuilder*) setSendClientType:(SInt32) value;
- (PullMsgResultsMsgEntityArgsBuilder*) clearSendClientType;

- (BOOL) hasSendClientPortraitUrl;
- (NSString*) sendClientPortraitUrl;
- (PullMsgResultsMsgEntityArgsBuilder*) setSendClientPortraitUrl:(NSString*) value;
- (PullMsgResultsMsgEntityArgsBuilder*) clearSendClientPortraitUrl;
@end

@interface PullMsgResultsBuilder : PBGeneratedMessage_Builder {
@private
  PullMsgResults* resultPullMsgResults;
}

- (PullMsgResults*) defaultInstance;

- (PullMsgResultsBuilder*) clear;
- (PullMsgResultsBuilder*) clone;

- (PullMsgResults*) build;
- (PullMsgResults*) buildPartial;

- (PullMsgResultsBuilder*) mergeFrom:(PullMsgResults*) other;
- (PullMsgResultsBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PullMsgResultsBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasStatusCode;
- (SInt32) statusCode;
- (PullMsgResultsBuilder*) setStatusCode:(SInt32) value;
- (PullMsgResultsBuilder*) clearStatusCode;

- (NSMutableArray *)readMsgRspArgsList;
- (PullMsgResultsMsgEntityArgs*)readMsgRspArgsListAtIndex:(NSUInteger)index;
- (PullMsgResultsBuilder *)addReadMsgRspArgsList:(PullMsgResultsMsgEntityArgs*)value;
- (PullMsgResultsBuilder *)setReadMsgRspArgsListArray:(NSArray *)array;
- (PullMsgResultsBuilder *)clearReadMsgRspArgsList;

- (BOOL) hasIsCompleted;
- (BOOL) isCompleted;
- (PullMsgResultsBuilder*) setIsCompleted:(BOOL) value;
- (PullMsgResultsBuilder*) clearIsCompleted;

- (BOOL) hasSyncId;
- (SInt64) syncId;
- (PullMsgResultsBuilder*) setSyncId:(SInt64) value;
- (PullMsgResultsBuilder*) clearSyncId;
@end


// @@protoc_insertion_point(global_scope)
