// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class AddressInfo;
@class AddressInfo_Builder;
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


@interface AddressInfoRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface AddressInfo : PBGeneratedMessage {
@private
  BOOL hasName_:1;
  BOOL hasMobile_:1;
  BOOL hasEmail_:1;
  NSString* name;
  NSString* mobile;
  NSString* email;
}
- (BOOL) hasName;
- (BOOL) hasMobile;
- (BOOL) hasEmail;
@property (readonly, retain) NSString* name;
@property (readonly, retain) NSString* mobile;
@property (readonly, retain) NSString* email;

+ (AddressInfo*) defaultInstance;
- (AddressInfo*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (AddressInfo_Builder*) builder;
+ (AddressInfo_Builder*) builder;
+ (AddressInfo_Builder*) builderWithPrototype:(AddressInfo*) prototype;
- (AddressInfo_Builder*) toBuilder;

+ (AddressInfo*) parseFromData:(NSData*) data;
+ (AddressInfo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (AddressInfo*) parseFromInputStream:(NSInputStream*) input;
+ (AddressInfo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (AddressInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (AddressInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface AddressInfo_Builder : PBGeneratedMessage_Builder {
@private
  AddressInfo* result;
}

- (AddressInfo*) defaultInstance;

- (AddressInfo_Builder*) clear;
- (AddressInfo_Builder*) clone;

- (AddressInfo*) build;
- (AddressInfo*) buildPartial;

- (AddressInfo_Builder*) mergeFrom:(AddressInfo*) other;
- (AddressInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (AddressInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasName;
- (NSString*) name;
- (AddressInfo_Builder*) setName:(NSString*) value;
- (AddressInfo_Builder*) clearName;

- (BOOL) hasMobile;
- (NSString*) mobile;
- (AddressInfo_Builder*) setMobile:(NSString*) value;
- (AddressInfo_Builder*) clearMobile;

- (BOOL) hasEmail;
- (NSString*) email;
- (AddressInfo_Builder*) setEmail:(NSString*) value;
- (AddressInfo_Builder*) clearEmail;
@end
