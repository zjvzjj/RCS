// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class CreateGroupResult;
@class CreateGroupResult_Builder;
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


@interface CreateGroupResultsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface CreateGroupResult : PBGeneratedMessage {
@private
  BOOL hasReCode_:1;
  BOOL hasGroupId_:1;
  int32_t reCode;
  NSString* groupId;
}
- (BOOL) hasReCode;
- (BOOL) hasGroupId;
@property (readonly) int32_t reCode;
@property (readonly, retain) NSString* groupId;

+ (CreateGroupResult*) defaultInstance;
- (CreateGroupResult*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (CreateGroupResult_Builder*) builder;
+ (CreateGroupResult_Builder*) builder;
+ (CreateGroupResult_Builder*) builderWithPrototype:(CreateGroupResult*) prototype;
- (CreateGroupResult_Builder*) toBuilder;

+ (CreateGroupResult*) parseFromData:(NSData*) data;
+ (CreateGroupResult*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CreateGroupResult*) parseFromInputStream:(NSInputStream*) input;
+ (CreateGroupResult*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (CreateGroupResult*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (CreateGroupResult*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface CreateGroupResult_Builder : PBGeneratedMessage_Builder {
@private
  CreateGroupResult* result;
}

- (CreateGroupResult*) defaultInstance;

- (CreateGroupResult_Builder*) clear;
- (CreateGroupResult_Builder*) clone;

- (CreateGroupResult*) build;
- (CreateGroupResult*) buildPartial;

- (CreateGroupResult_Builder*) mergeFrom:(CreateGroupResult*) other;
- (CreateGroupResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (CreateGroupResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasReCode;
- (int32_t) reCode;
- (CreateGroupResult_Builder*) setReCode:(int32_t) value;
- (CreateGroupResult_Builder*) clearReCode;

- (BOOL) hasGroupId;
- (NSString*) groupId;
- (CreateGroupResult_Builder*) setGroupId:(NSString*) value;
- (CreateGroupResult_Builder*) clearGroupId;
@end

