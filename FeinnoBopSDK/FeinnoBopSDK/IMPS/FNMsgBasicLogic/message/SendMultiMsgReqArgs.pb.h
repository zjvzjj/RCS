// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

// @@protoc_insertion_point(imports)

@class MsgEntitys;
@class MsgEntitysBuilder;
@class SendMultiMsgReqArgs;
@class SendMultiMsgReqArgs_Builder;



@interface SendMultiMsgReqArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define SendMultiMsgReqArgs_fromBopId @"fromBopId"
#define SendMultiMsgReqArgs_toBopId @"toBopId"
#define SendMultiMsgReqArgs_msg @"msg"
#define SendMultiMsgReqArgs_sendDate @"sendDate"
@interface SendMultiMsgReqArgs : PBGeneratedMessage {
@private
  BOOL hasFromBopId_:1;
  BOOL hasSendDate_:1;
  BOOL hasMsg_:1;
  NSString* fromBopId;
  NSString* sendDate;
  MsgEntitys* msg;
  NSMutableArray * toBopIdArray;
}
- (BOOL) hasFromBopId;
- (BOOL) hasMsg;
- (BOOL) hasSendDate;
@property (readonly, strong) NSString* fromBopId;
@property (readonly, strong) NSArray * toBopId;
@property (readonly, strong) MsgEntitys* msg;
@property (readonly, strong) NSString* sendDate;
- (NSString*)toBopIdAtIndex:(NSUInteger)index;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (SendMultiMsgReqArgs_Builder*) builder;
+ (SendMultiMsgReqArgs_Builder*) builder;
+ (SendMultiMsgReqArgs_Builder*) builderWithPrototype:(SendMultiMsgReqArgs*) prototype;
- (SendMultiMsgReqArgs_Builder*) toBuilder;

+ (SendMultiMsgReqArgs*) parseFromData:(NSData*) data;
+ (SendMultiMsgReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SendMultiMsgReqArgs*) parseFromInputStream:(NSInputStream*) input;
+ (SendMultiMsgReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SendMultiMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (SendMultiMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface SendMultiMsgReqArgs_Builder : PBGeneratedMessage_Builder {
@private
  SendMultiMsgReqArgs* resultSendMultiMsgReqArgs;
}

- (SendMultiMsgReqArgs*) defaultInstance;

- (SendMultiMsgReqArgs_Builder*) clear;
- (SendMultiMsgReqArgs_Builder*) clone;

- (SendMultiMsgReqArgs*) build;
- (SendMultiMsgReqArgs*) buildPartial;

- (SendMultiMsgReqArgs_Builder*) mergeFrom:(SendMultiMsgReqArgs*) other;
- (SendMultiMsgReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (SendMultiMsgReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasFromBopId;
- (NSString*) fromBopId;
- (SendMultiMsgReqArgs_Builder*) setFromBopId:(NSString*) value;
- (SendMultiMsgReqArgs_Builder*) clearFromBopId;

- (NSMutableArray *)toBopId;
- (NSString*)toBopIdAtIndex:(NSUInteger)index;
- (SendMultiMsgReqArgs_Builder *)addToBopId:(NSString*)value;
- (SendMultiMsgReqArgs_Builder *)setToBopIdArray:(NSArray *)array;
- (SendMultiMsgReqArgs_Builder *)clearToBopId;

- (BOOL) hasMsg;
- (MsgEntitys*) msg;
- (SendMultiMsgReqArgs_Builder*) setMsg:(MsgEntitys*) value;
- (SendMultiMsgReqArgs_Builder*) setMsgBuilder:(MsgEntitysBuilder*) builderForValue;
- (SendMultiMsgReqArgs_Builder*) mergeMsg:(MsgEntitys*) value;
- (SendMultiMsgReqArgs_Builder*) clearMsg;

- (BOOL) hasSendDate;
- (NSString*) sendDate;
- (SendMultiMsgReqArgs_Builder*) setSendDate:(NSString*) value;
- (SendMultiMsgReqArgs_Builder*) clearSendDate;
@end

#define MsgEntitys_msgId @"msgId"
#define MsgEntitys_syncId @"syncId"
#define MsgEntitys_msgType @"msgType"
#define MsgEntitys_msgAttribute @"msgAttribute"
#define MsgEntitys_msgContent @"msgContent"
#define MsgEntitys_senderNickName @"senderNickName"
#define MsgEntitys_senderId @"senderId"
#define MsgEntitys_extend @"extend"
@interface MsgEntitys : PBGeneratedMessage {
@private
  BOOL hasSyncId_:1;
  BOOL hasMsgId_:1;
  BOOL hasMsgType_:1;
  BOOL hasMsgAttribute_:1;
  BOOL hasMsgContent_:1;
  BOOL hasSenderNickName_:1;
  BOOL hasSenderId_:1;
  SInt64 syncId;
  NSString* msgId;
  NSString* msgType;
  NSString* msgAttribute;
  NSString* msgContent;
  NSString* senderNickName;
  NSString* senderId;
  NSMutableArray * extendArray;
}
- (BOOL) hasMsgId;
- (BOOL) hasSyncId;
- (BOOL) hasMsgType;
- (BOOL) hasMsgAttribute;
- (BOOL) hasMsgContent;
- (BOOL) hasSenderNickName;
- (BOOL) hasSenderId;
@property (readonly, strong) NSString* msgId;
@property (readonly) SInt64 syncId;
@property (readonly, strong) NSString* msgType;
@property (readonly, strong) NSString* msgAttribute;
@property (readonly, strong) NSString* msgContent;
@property (readonly, strong) NSString* senderNickName;
@property (readonly, strong) NSString* senderId;
@property (readonly, strong) NSArray * extend;
- (NSData*)extendAtIndex:(NSUInteger)index;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MsgEntitysBuilder*) builder;
+ (MsgEntitysBuilder*) builder;
+ (MsgEntitysBuilder*) builderWithPrototype:(MsgEntitys*) prototype;
- (MsgEntitysBuilder*) toBuilder;

+ (MsgEntitys*) parseFromData:(NSData*) data;
+ (MsgEntitys*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MsgEntitys*) parseFromInputStream:(NSInputStream*) input;
+ (MsgEntitys*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MsgEntitys*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MsgEntitys*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MsgEntitysBuilder : PBGeneratedMessage_Builder {
@private
  MsgEntitys* resultMsgEntitys;
}

- (MsgEntitys*) defaultInstance;

- (MsgEntitysBuilder*) clear;
- (MsgEntitysBuilder*) clone;

- (MsgEntitys*) build;
- (MsgEntitys*) buildPartial;

- (MsgEntitysBuilder*) mergeFrom:(MsgEntitys*) other;
- (MsgEntitysBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MsgEntitysBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasMsgId;
- (NSString*) msgId;
- (MsgEntitysBuilder*) setMsgId:(NSString*) value;
- (MsgEntitysBuilder*) clearMsgId;

- (BOOL) hasSyncId;
- (SInt64) syncId;
- (MsgEntitysBuilder*) setSyncId:(SInt64) value;
- (MsgEntitysBuilder*) clearSyncId;

- (BOOL) hasMsgType;
- (NSString*) msgType;
- (MsgEntitysBuilder*) setMsgType:(NSString*) value;
- (MsgEntitysBuilder*) clearMsgType;

- (BOOL) hasMsgAttribute;
- (NSString*) msgAttribute;
- (MsgEntitysBuilder*) setMsgAttribute:(NSString*) value;
- (MsgEntitysBuilder*) clearMsgAttribute;

- (BOOL) hasMsgContent;
- (NSString*) msgContent;
- (MsgEntitysBuilder*) setMsgContent:(NSString*) value;
- (MsgEntitysBuilder*) clearMsgContent;

- (BOOL) hasSenderNickName;
- (NSString*) senderNickName;
- (MsgEntitysBuilder*) setSenderNickName:(NSString*) value;
- (MsgEntitysBuilder*) clearSenderNickName;

- (BOOL) hasSenderId;
- (NSString*) senderId;
- (MsgEntitysBuilder*) setSenderId:(NSString*) value;
- (MsgEntitysBuilder*) clearSenderId;

- (NSMutableArray *)extend;
- (NSData*)extendAtIndex:(NSUInteger)index;
- (MsgEntitysBuilder *)addExtend:(NSData*)value;
- (MsgEntitysBuilder *)setExtendArray:(NSArray *)array;
- (MsgEntitysBuilder *)clearExtend;
@end


// @@protoc_insertion_point(global_scope)