// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class RegisterWithCertPicRspRets;
@class RegisterWithCertPicRspRets_Builder;
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


@interface RegisterWithCertPicRspRetsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface RegisterWithCertPicRspRets : PBGeneratedMessage {
@private
  BOOL hasRetCode_:1;
  BOOL hasBopUid_:1;
  int32_t retCode;
  NSString* bopUid;
}
- (BOOL) hasRetCode;
- (BOOL) hasBopUid;
@property (readonly) int32_t retCode;
@property (readonly, retain) NSString* bopUid;

+ (RegisterWithCertPicRspRets*) defaultInstance;
- (RegisterWithCertPicRspRets*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (RegisterWithCertPicRspRets_Builder*) builder;
+ (RegisterWithCertPicRspRets_Builder*) builder;
+ (RegisterWithCertPicRspRets_Builder*) builderWithPrototype:(RegisterWithCertPicRspRets*) prototype;
- (RegisterWithCertPicRspRets_Builder*) toBuilder;

+ (RegisterWithCertPicRspRets*) parseFromData:(NSData*) data;
+ (RegisterWithCertPicRspRets*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RegisterWithCertPicRspRets*) parseFromInputStream:(NSInputStream*) input;
+ (RegisterWithCertPicRspRets*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RegisterWithCertPicRspRets*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (RegisterWithCertPicRspRets*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface RegisterWithCertPicRspRets_Builder : PBGeneratedMessage_Builder {
@private
  RegisterWithCertPicRspRets* result;
}

- (RegisterWithCertPicRspRets*) defaultInstance;

- (RegisterWithCertPicRspRets_Builder*) clear;
- (RegisterWithCertPicRspRets_Builder*) clone;

- (RegisterWithCertPicRspRets*) build;
- (RegisterWithCertPicRspRets*) buildPartial;

- (RegisterWithCertPicRspRets_Builder*) mergeFrom:(RegisterWithCertPicRspRets*) other;
- (RegisterWithCertPicRspRets_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (RegisterWithCertPicRspRets_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasRetCode;
- (int32_t) retCode;
- (RegisterWithCertPicRspRets_Builder*) setRetCode:(int32_t) value;
- (RegisterWithCertPicRspRets_Builder*) clearRetCode;

- (BOOL) hasBopUid;
- (NSString*) bopUid;
- (RegisterWithCertPicRspRets_Builder*) setBopUid:(NSString*) value;
- (RegisterWithCertPicRspRets_Builder*) clearBopUid;
@end

