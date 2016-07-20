// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class PullMsgReqArgs;
@class PullMsgReqArgs_Builder;
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


@interface PullMsgReqArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface PullMsgReqArgs : PBGeneratedMessage {
@private
  BOOL hasSyncId_:1;
  BOOL hasCount_:1;
  int64_t syncId;
  int32_t count;
}
- (BOOL) hasCount;
- (BOOL) hasSyncId;
@property (readonly) int32_t count;
@property (readonly) int64_t syncId;

+ (PullMsgReqArgs*) defaultInstance;
- (PullMsgReqArgs*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PullMsgReqArgs_Builder*) builder;
+ (PullMsgReqArgs_Builder*) builder;
+ (PullMsgReqArgs_Builder*) builderWithPrototype:(PullMsgReqArgs*) prototype;
- (PullMsgReqArgs_Builder*) toBuilder;

+ (PullMsgReqArgs*) parseFromData:(NSData*) data;
+ (PullMsgReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PullMsgReqArgs*) parseFromInputStream:(NSInputStream*) input;
+ (PullMsgReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PullMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PullMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PullMsgReqArgs_Builder : PBGeneratedMessage_Builder {
@private
  PullMsgReqArgs* result;
}

- (PullMsgReqArgs*) defaultInstance;

- (PullMsgReqArgs_Builder*) clear;
- (PullMsgReqArgs_Builder*) clone;

- (PullMsgReqArgs*) build;
- (PullMsgReqArgs*) buildPartial;

- (PullMsgReqArgs_Builder*) mergeFrom:(PullMsgReqArgs*) other;
- (PullMsgReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PullMsgReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasCount;
- (int32_t) count;
- (PullMsgReqArgs_Builder*) setCount:(int32_t) value;
- (PullMsgReqArgs_Builder*) clearCount;

- (BOOL) hasSyncId;
- (int64_t) syncId;
- (PullMsgReqArgs_Builder*) setSyncId:(int64_t) value;
- (PullMsgReqArgs_Builder*) clearSyncId;
@end
