// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class RegisterWithSmsRspRets;
@class RegisterWithSmsRspRets_Builder;
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


@interface RegisterWithSmsRspRetsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface RegisterWithSmsRspRets : PBGeneratedMessage {
@private
  BOOL hasRetCode_:1;
  BOOL hasBopUid_:1;
  BOOL hasSecurityKey_:1;
  int32_t retCode;
  NSString* bopUid;
  NSString* securityKey;
}
- (BOOL) hasRetCode;
- (BOOL) hasBopUid;
- (BOOL) hasSecurityKey;
@property (readonly) int32_t retCode;
@property (readonly, retain) NSString* bopUid;
@property (readonly, retain) NSString* securityKey;

+ (RegisterWithSmsRspRets*) defaultInstance;
- (RegisterWithSmsRspRets*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (RegisterWithSmsRspRets_Builder*) builder;
+ (RegisterWithSmsRspRets_Builder*) builder;
+ (RegisterWithSmsRspRets_Builder*) builderWithPrototype:(RegisterWithSmsRspRets*) prototype;
- (RegisterWithSmsRspRets_Builder*) toBuilder;

+ (RegisterWithSmsRspRets*) parseFromData:(NSData*) data;
+ (RegisterWithSmsRspRets*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RegisterWithSmsRspRets*) parseFromInputStream:(NSInputStream*) input;
+ (RegisterWithSmsRspRets*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RegisterWithSmsRspRets*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (RegisterWithSmsRspRets*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface RegisterWithSmsRspRets_Builder : PBGeneratedMessage_Builder {
@private
  RegisterWithSmsRspRets* result;
}

- (RegisterWithSmsRspRets*) defaultInstance;

- (RegisterWithSmsRspRets_Builder*) clear;
- (RegisterWithSmsRspRets_Builder*) clone;

- (RegisterWithSmsRspRets*) build;
- (RegisterWithSmsRspRets*) buildPartial;

- (RegisterWithSmsRspRets_Builder*) mergeFrom:(RegisterWithSmsRspRets*) other;
- (RegisterWithSmsRspRets_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (RegisterWithSmsRspRets_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasRetCode;
- (int32_t) retCode;
- (RegisterWithSmsRspRets_Builder*) setRetCode:(int32_t) value;
- (RegisterWithSmsRspRets_Builder*) clearRetCode;

- (BOOL) hasBopUid;
- (NSString*) bopUid;
- (RegisterWithSmsRspRets_Builder*) setBopUid:(NSString*) value;
- (RegisterWithSmsRspRets_Builder*) clearBopUid;

- (BOOL) hasSecurityKey;
- (NSString*) securityKey;
- (RegisterWithSmsRspRets_Builder*) setSecurityKey:(NSString*) value;
- (RegisterWithSmsRspRets_Builder*) clearSecurityKey;
@end
