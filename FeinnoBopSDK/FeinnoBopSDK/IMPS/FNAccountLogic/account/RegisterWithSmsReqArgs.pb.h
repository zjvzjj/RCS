// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class RegisterWithSmsReqArgs;
@class RegisterWithSmsReqArgs_Builder;
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


@interface RegisterWithSmsReqArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface RegisterWithSmsReqArgs : PBGeneratedMessage {
@private
  BOOL hasIsNeedSecurityKey_:1;
  BOOL hasRegType_:1;
  BOOL hasRegValue_:1;
  BOOL hasPwd_:1;
  BOOL hasSmsKey_:1;
  BOOL hasSmsValue_:1;
  BOOL isNeedSecurityKey_:1;
  int32_t regType;
  NSString* regValue;
  NSString* pwd;
  NSString* smsKey;
  NSString* smsValue;
}
- (BOOL) hasRegType;
- (BOOL) hasRegValue;
- (BOOL) hasPwd;
- (BOOL) hasSmsKey;
- (BOOL) hasSmsValue;
- (BOOL) hasIsNeedSecurityKey;
@property (readonly) int32_t regType;
@property (readonly, retain) NSString* regValue;
@property (readonly, retain) NSString* pwd;
@property (readonly, retain) NSString* smsKey;
@property (readonly, retain) NSString* smsValue;
- (BOOL) isNeedSecurityKey;

+ (RegisterWithSmsReqArgs*) defaultInstance;
- (RegisterWithSmsReqArgs*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (RegisterWithSmsReqArgs_Builder*) builder;
+ (RegisterWithSmsReqArgs_Builder*) builder;
+ (RegisterWithSmsReqArgs_Builder*) builderWithPrototype:(RegisterWithSmsReqArgs*) prototype;
- (RegisterWithSmsReqArgs_Builder*) toBuilder;

+ (RegisterWithSmsReqArgs*) parseFromData:(NSData*) data;
+ (RegisterWithSmsReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RegisterWithSmsReqArgs*) parseFromInputStream:(NSInputStream*) input;
+ (RegisterWithSmsReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RegisterWithSmsReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (RegisterWithSmsReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface RegisterWithSmsReqArgs_Builder : PBGeneratedMessage_Builder {
@private
  RegisterWithSmsReqArgs* result;
}

- (RegisterWithSmsReqArgs*) defaultInstance;

- (RegisterWithSmsReqArgs_Builder*) clear;
- (RegisterWithSmsReqArgs_Builder*) clone;

- (RegisterWithSmsReqArgs*) build;
- (RegisterWithSmsReqArgs*) buildPartial;

- (RegisterWithSmsReqArgs_Builder*) mergeFrom:(RegisterWithSmsReqArgs*) other;
- (RegisterWithSmsReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (RegisterWithSmsReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasRegType;
- (int32_t) regType;
- (RegisterWithSmsReqArgs_Builder*) setRegType:(int32_t) value;
- (RegisterWithSmsReqArgs_Builder*) clearRegType;

- (BOOL) hasRegValue;
- (NSString*) regValue;
- (RegisterWithSmsReqArgs_Builder*) setRegValue:(NSString*) value;
- (RegisterWithSmsReqArgs_Builder*) clearRegValue;

- (BOOL) hasPwd;
- (NSString*) pwd;
- (RegisterWithSmsReqArgs_Builder*) setPwd:(NSString*) value;
- (RegisterWithSmsReqArgs_Builder*) clearPwd;

- (BOOL) hasSmsKey;
- (NSString*) smsKey;
- (RegisterWithSmsReqArgs_Builder*) setSmsKey:(NSString*) value;
- (RegisterWithSmsReqArgs_Builder*) clearSmsKey;

- (BOOL) hasSmsValue;
- (NSString*) smsValue;
- (RegisterWithSmsReqArgs_Builder*) setSmsValue:(NSString*) value;
- (RegisterWithSmsReqArgs_Builder*) clearSmsValue;

- (BOOL) hasIsNeedSecurityKey;
- (BOOL) isNeedSecurityKey;
- (RegisterWithSmsReqArgs_Builder*) setIsNeedSecurityKey:(BOOL) value;
- (RegisterWithSmsReqArgs_Builder*) clearIsNeedSecurityKey;
@end

