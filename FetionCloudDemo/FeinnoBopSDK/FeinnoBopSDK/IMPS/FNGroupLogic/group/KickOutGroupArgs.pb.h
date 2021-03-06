// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class KickOutGroupArgs;
@class KickOutGroupArgs_Builder;
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


@interface KickOutGroupArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface KickOutGroupArgs : PBGeneratedMessage {
@private
  BOOL hasGroupId_:1;
  BOOL hasKickedUserId_:1;
  NSString* groupId;
  NSString* kickedUserId;
}
- (BOOL) hasGroupId;
- (BOOL) hasKickedUserId;
@property (readonly, retain) NSString* groupId;
@property (readonly, retain) NSString* kickedUserId;

+ (KickOutGroupArgs*) defaultInstance;
- (KickOutGroupArgs*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (KickOutGroupArgs_Builder*) builder;
+ (KickOutGroupArgs_Builder*) builder;
+ (KickOutGroupArgs_Builder*) builderWithPrototype:(KickOutGroupArgs*) prototype;
- (KickOutGroupArgs_Builder*) toBuilder;

+ (KickOutGroupArgs*) parseFromData:(NSData*) data;
+ (KickOutGroupArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (KickOutGroupArgs*) parseFromInputStream:(NSInputStream*) input;
+ (KickOutGroupArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (KickOutGroupArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (KickOutGroupArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface KickOutGroupArgs_Builder : PBGeneratedMessage_Builder {
@private
  KickOutGroupArgs* result;
}

- (KickOutGroupArgs*) defaultInstance;

- (KickOutGroupArgs_Builder*) clear;
- (KickOutGroupArgs_Builder*) clone;

- (KickOutGroupArgs*) build;
- (KickOutGroupArgs*) buildPartial;

- (KickOutGroupArgs_Builder*) mergeFrom:(KickOutGroupArgs*) other;
- (KickOutGroupArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (KickOutGroupArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasGroupId;
- (NSString*) groupId;
- (KickOutGroupArgs_Builder*) setGroupId:(NSString*) value;
- (KickOutGroupArgs_Builder*) clearGroupId;

- (BOOL) hasKickedUserId;
- (NSString*) kickedUserId;
- (KickOutGroupArgs_Builder*) setKickedUserId:(NSString*) value;
- (KickOutGroupArgs_Builder*) clearKickedUserId;
@end

