// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class GetGroupMemberListArgs;
@class GetGroupMemberListArgs_Builder;
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


@interface GetGroupMemberListArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface GetGroupMemberListArgs : PBGeneratedMessage {
@private
  BOOL hasGroupId_:1;
  NSString* groupId;
}
- (BOOL) hasGroupId;
@property (readonly, retain) NSString* groupId;

+ (GetGroupMemberListArgs*) defaultInstance;
- (GetGroupMemberListArgs*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GetGroupMemberListArgs_Builder*) builder;
+ (GetGroupMemberListArgs_Builder*) builder;
+ (GetGroupMemberListArgs_Builder*) builderWithPrototype:(GetGroupMemberListArgs*) prototype;
- (GetGroupMemberListArgs_Builder*) toBuilder;

+ (GetGroupMemberListArgs*) parseFromData:(NSData*) data;
+ (GetGroupMemberListArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetGroupMemberListArgs*) parseFromInputStream:(NSInputStream*) input;
+ (GetGroupMemberListArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetGroupMemberListArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GetGroupMemberListArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface GetGroupMemberListArgs_Builder : PBGeneratedMessage_Builder {
@private
  GetGroupMemberListArgs* result;
}

- (GetGroupMemberListArgs*) defaultInstance;

- (GetGroupMemberListArgs_Builder*) clear;
- (GetGroupMemberListArgs_Builder*) clone;

- (GetGroupMemberListArgs*) build;
- (GetGroupMemberListArgs*) buildPartial;

- (GetGroupMemberListArgs_Builder*) mergeFrom:(GetGroupMemberListArgs*) other;
- (GetGroupMemberListArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GetGroupMemberListArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasGroupId;
- (NSString*) groupId;
- (GetGroupMemberListArgs_Builder*) setGroupId:(NSString*) value;
- (GetGroupMemberListArgs_Builder*) clearGroupId;
@end
