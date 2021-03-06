// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class IsRegisterRspArgs;
@class IsRegisterRspArgs_Builder;
@class IsRegisterRspArgs_RegisterStatusCombo;
@class IsRegisterRspArgs_RegisterStatusCombo_Builder;
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


@interface IsRegisterRspArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface IsRegisterRspArgs : PBGeneratedMessage {
@private
  BOOL hasRetCode_:1;
  BOOL hasRetDesc_:1;
  int32_t retCode;
  NSString* retDesc;
  PBAppendableArray * regiserStatusArray;
}
- (BOOL) hasRetCode;
- (BOOL) hasRetDesc;
@property (readonly) int32_t retCode;
@property (readonly, retain) NSString* retDesc;
@property (readonly, retain) PBArray * regiserStatus;
- (IsRegisterRspArgs_RegisterStatusCombo*)regiserStatusAtIndex:(NSUInteger)index;

+ (IsRegisterRspArgs*) defaultInstance;
- (IsRegisterRspArgs*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (IsRegisterRspArgs_Builder*) builder;
+ (IsRegisterRspArgs_Builder*) builder;
+ (IsRegisterRspArgs_Builder*) builderWithPrototype:(IsRegisterRspArgs*) prototype;
- (IsRegisterRspArgs_Builder*) toBuilder;

+ (IsRegisterRspArgs*) parseFromData:(NSData*) data;
+ (IsRegisterRspArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (IsRegisterRspArgs*) parseFromInputStream:(NSInputStream*) input;
+ (IsRegisterRspArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (IsRegisterRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (IsRegisterRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface IsRegisterRspArgs_RegisterStatusCombo : PBGeneratedMessage {
@private
  BOOL hasRegisterStatus_:1;
  BOOL hasUserId_:1;
  int32_t registerStatus;
  NSString* userId;
}
- (BOOL) hasUserId;
- (BOOL) hasRegisterStatus;
@property (readonly, retain) NSString* userId;
@property (readonly) int32_t registerStatus;

+ (IsRegisterRspArgs_RegisterStatusCombo*) defaultInstance;
- (IsRegisterRspArgs_RegisterStatusCombo*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) builder;
+ (IsRegisterRspArgs_RegisterStatusCombo_Builder*) builder;
+ (IsRegisterRspArgs_RegisterStatusCombo_Builder*) builderWithPrototype:(IsRegisterRspArgs_RegisterStatusCombo*) prototype;
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) toBuilder;

+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromData:(NSData*) data;
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromInputStream:(NSInputStream*) input;
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface IsRegisterRspArgs_RegisterStatusCombo_Builder : PBGeneratedMessage_Builder {
@private
  IsRegisterRspArgs_RegisterStatusCombo* result;
}

- (IsRegisterRspArgs_RegisterStatusCombo*) defaultInstance;

- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) clear;
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) clone;

- (IsRegisterRspArgs_RegisterStatusCombo*) build;
- (IsRegisterRspArgs_RegisterStatusCombo*) buildPartial;

- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) mergeFrom:(IsRegisterRspArgs_RegisterStatusCombo*) other;
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserId;
- (NSString*) userId;
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) setUserId:(NSString*) value;
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) clearUserId;

- (BOOL) hasRegisterStatus;
- (int32_t) registerStatus;
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) setRegisterStatus:(int32_t) value;
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) clearRegisterStatus;
@end

@interface IsRegisterRspArgs_Builder : PBGeneratedMessage_Builder {
@private
  IsRegisterRspArgs* result;
}

- (IsRegisterRspArgs*) defaultInstance;

- (IsRegisterRspArgs_Builder*) clear;
- (IsRegisterRspArgs_Builder*) clone;

- (IsRegisterRspArgs*) build;
- (IsRegisterRspArgs*) buildPartial;

- (IsRegisterRspArgs_Builder*) mergeFrom:(IsRegisterRspArgs*) other;
- (IsRegisterRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (IsRegisterRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasRetCode;
- (int32_t) retCode;
- (IsRegisterRspArgs_Builder*) setRetCode:(int32_t) value;
- (IsRegisterRspArgs_Builder*) clearRetCode;

- (BOOL) hasRetDesc;
- (NSString*) retDesc;
- (IsRegisterRspArgs_Builder*) setRetDesc:(NSString*) value;
- (IsRegisterRspArgs_Builder*) clearRetDesc;

- (PBAppendableArray *)regiserStatus;
- (IsRegisterRspArgs_RegisterStatusCombo*)regiserStatusAtIndex:(NSUInteger)index;
- (IsRegisterRspArgs_Builder *)addRegiserStatus:(IsRegisterRspArgs_RegisterStatusCombo*)value;
- (IsRegisterRspArgs_Builder *)setRegiserStatusArray:(NSArray *)array;
- (IsRegisterRspArgs_Builder *)setRegiserStatusValues:(const IsRegisterRspArgs_RegisterStatusCombo* *)values count:(NSUInteger)count;
- (IsRegisterRspArgs_Builder *)clearRegiserStatus;
@end

