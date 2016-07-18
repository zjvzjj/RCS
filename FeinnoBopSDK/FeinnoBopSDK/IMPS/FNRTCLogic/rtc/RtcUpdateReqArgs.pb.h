// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class RtcUpdateReqArgs;
@class RtcUpdateReqArgs_Builder;
@class RtcUpdateReqArgs_CallInfo;
@class RtcUpdateReqArgs_CallInfo_Builder;
#ifndef __has_feature
  #define __has_feature(x) 0 // Compatibility with non-clang compilers.
#endif // __has_feature

#ifndef NS_RETURNS_NOT_RETAINED
  #if __has_feature(attribute_ns_returns_not_retained)
    #define NS_RETURNS_NOT_RETAINED __attribute__((ns_returns_not_retained))
  #else
    #define NS_RETURNS_NOT_RETAINED
  #endif
#endif


@interface RtcUpdateReqArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface RtcUpdateReqArgs : PBGeneratedMessage {
@private
  BOOL hasAction_:1;
  BOOL hasCallInfo_:1;
  int32_t action;
  RtcUpdateReqArgs_CallInfo* callInfo;
}
- (BOOL) hasCallInfo;
- (BOOL) hasAction;
@property (readonly, retain) RtcUpdateReqArgs_CallInfo* callInfo;
@property (readonly) int32_t action;

+ (RtcUpdateReqArgs*) defaultInstance;
- (RtcUpdateReqArgs*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (RtcUpdateReqArgs_Builder*) builder;
+ (RtcUpdateReqArgs_Builder*) builder;
+ (RtcUpdateReqArgs_Builder*) builderWithPrototype:(RtcUpdateReqArgs*) prototype;
- (RtcUpdateReqArgs_Builder*) toBuilder;

+ (RtcUpdateReqArgs*) parseFromData:(NSData*) data;
+ (RtcUpdateReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RtcUpdateReqArgs*) parseFromInputStream:(NSInputStream*) input;
+ (RtcUpdateReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RtcUpdateReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (RtcUpdateReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface RtcUpdateReqArgs_CallInfo : PBGeneratedMessage {
@private
  BOOL hasPeerUserId_:1;
  BOOL hasCallId_:1;
  NSString* peerUserId;
  NSString* callId;
}
- (BOOL) hasPeerUserId;
- (BOOL) hasCallId;
@property (readonly, retain) NSString* peerUserId;
@property (readonly, retain) NSString* callId;

+ (RtcUpdateReqArgs_CallInfo*) defaultInstance;
- (RtcUpdateReqArgs_CallInfo*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (RtcUpdateReqArgs_CallInfo_Builder*) builder;
+ (RtcUpdateReqArgs_CallInfo_Builder*) builder;
+ (RtcUpdateReqArgs_CallInfo_Builder*) builderWithPrototype:(RtcUpdateReqArgs_CallInfo*) prototype;
- (RtcUpdateReqArgs_CallInfo_Builder*) toBuilder;

+ (RtcUpdateReqArgs_CallInfo*) parseFromData:(NSData*) data;
+ (RtcUpdateReqArgs_CallInfo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RtcUpdateReqArgs_CallInfo*) parseFromInputStream:(NSInputStream*) input;
+ (RtcUpdateReqArgs_CallInfo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RtcUpdateReqArgs_CallInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (RtcUpdateReqArgs_CallInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface RtcUpdateReqArgs_CallInfo_Builder : PBGeneratedMessage_Builder {
@private
  RtcUpdateReqArgs_CallInfo* result;
}

- (RtcUpdateReqArgs_CallInfo*) defaultInstance;

- (RtcUpdateReqArgs_CallInfo_Builder*) clear;
- (RtcUpdateReqArgs_CallInfo_Builder*) clone;

- (RtcUpdateReqArgs_CallInfo*) build;
- (RtcUpdateReqArgs_CallInfo*) buildPartial;

- (RtcUpdateReqArgs_CallInfo_Builder*) mergeFrom:(RtcUpdateReqArgs_CallInfo*) other;
- (RtcUpdateReqArgs_CallInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (RtcUpdateReqArgs_CallInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasPeerUserId;
- (NSString*) peerUserId;
- (RtcUpdateReqArgs_CallInfo_Builder*) setPeerUserId:(NSString*) value;
- (RtcUpdateReqArgs_CallInfo_Builder*) clearPeerUserId;

- (BOOL) hasCallId;
- (NSString*) callId;
- (RtcUpdateReqArgs_CallInfo_Builder*) setCallId:(NSString*) value;
- (RtcUpdateReqArgs_CallInfo_Builder*) clearCallId;
@end

@interface RtcUpdateReqArgs_Builder : PBGeneratedMessage_Builder {
@private
  RtcUpdateReqArgs* result;
}

- (RtcUpdateReqArgs*) defaultInstance;

- (RtcUpdateReqArgs_Builder*) clear;
- (RtcUpdateReqArgs_Builder*) clone;

- (RtcUpdateReqArgs*) build;
- (RtcUpdateReqArgs*) buildPartial;

- (RtcUpdateReqArgs_Builder*) mergeFrom:(RtcUpdateReqArgs*) other;
- (RtcUpdateReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (RtcUpdateReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasCallInfo;
- (RtcUpdateReqArgs_CallInfo*) callInfo;
- (RtcUpdateReqArgs_Builder*) setCallInfo:(RtcUpdateReqArgs_CallInfo*) value;
- (RtcUpdateReqArgs_Builder*) setCallInfoBuilder:(RtcUpdateReqArgs_CallInfo_Builder*) builderForValue;
- (RtcUpdateReqArgs_Builder*) mergeCallInfo:(RtcUpdateReqArgs_CallInfo*) value;
- (RtcUpdateReqArgs_Builder*) clearCallInfo;

- (BOOL) hasAction;
- (int32_t) action;
- (RtcUpdateReqArgs_Builder*) setAction:(int32_t) value;
- (RtcUpdateReqArgs_Builder*) clearAction;
@end

