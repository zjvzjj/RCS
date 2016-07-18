// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class UpAddressListReqArgs;
@class UpAddressListReqArgs_AddresslistIdDetailCombo;
@class UpAddressListReqArgs_AddresslistIdDetailCombo_Builder;
@class UpAddressListReqArgs_Builder;
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


@interface UpAddressListReqArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface UpAddressListReqArgs : PBGeneratedMessage {
@private
  BOOL hasType_:1;
  NSString* type;
  PBAppendableArray * addressListArray;
}
- (BOOL) hasType;
@property (readonly, retain) NSString* type;
@property (readonly, retain) PBArray * addressList;
- (UpAddressListReqArgs_AddresslistIdDetailCombo*)addressListAtIndex:(NSUInteger)index;

+ (UpAddressListReqArgs*) defaultInstance;
- (UpAddressListReqArgs*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (UpAddressListReqArgs_Builder*) builder;
+ (UpAddressListReqArgs_Builder*) builder;
+ (UpAddressListReqArgs_Builder*) builderWithPrototype:(UpAddressListReqArgs*) prototype;
- (UpAddressListReqArgs_Builder*) toBuilder;

+ (UpAddressListReqArgs*) parseFromData:(NSData*) data;
+ (UpAddressListReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (UpAddressListReqArgs*) parseFromInputStream:(NSInputStream*) input;
+ (UpAddressListReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (UpAddressListReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (UpAddressListReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface UpAddressListReqArgs_AddresslistIdDetailCombo : PBGeneratedMessage {
@private
  BOOL hasAddresslistId_:1;
  BOOL hasType_:1;
  BOOL hasAddresslistDetail_:1;
  NSString* addresslistId;
  NSString* type;
  NSData* addresslistDetail;
}
- (BOOL) hasAddresslistId;
- (BOOL) hasAddresslistDetail;
- (BOOL) hasType;
@property (readonly, retain) NSString* addresslistId;
@property (readonly, retain) NSData* addresslistDetail;
@property (readonly, retain) NSString* type;

+ (UpAddressListReqArgs_AddresslistIdDetailCombo*) defaultInstance;
- (UpAddressListReqArgs_AddresslistIdDetailCombo*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) builder;
+ (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) builder;
+ (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) builderWithPrototype:(UpAddressListReqArgs_AddresslistIdDetailCombo*) prototype;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) toBuilder;

+ (UpAddressListReqArgs_AddresslistIdDetailCombo*) parseFromData:(NSData*) data;
+ (UpAddressListReqArgs_AddresslistIdDetailCombo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (UpAddressListReqArgs_AddresslistIdDetailCombo*) parseFromInputStream:(NSInputStream*) input;
+ (UpAddressListReqArgs_AddresslistIdDetailCombo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (UpAddressListReqArgs_AddresslistIdDetailCombo*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (UpAddressListReqArgs_AddresslistIdDetailCombo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface UpAddressListReqArgs_AddresslistIdDetailCombo_Builder : PBGeneratedMessage_Builder {
@private
  UpAddressListReqArgs_AddresslistIdDetailCombo* result;
}

- (UpAddressListReqArgs_AddresslistIdDetailCombo*) defaultInstance;

- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) clear;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) clone;

- (UpAddressListReqArgs_AddresslistIdDetailCombo*) build;
- (UpAddressListReqArgs_AddresslistIdDetailCombo*) buildPartial;

- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) mergeFrom:(UpAddressListReqArgs_AddresslistIdDetailCombo*) other;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasAddresslistId;
- (NSString*) addresslistId;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) setAddresslistId:(NSString*) value;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) clearAddresslistId;

- (BOOL) hasAddresslistDetail;
- (NSData*) addresslistDetail;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) setAddresslistDetail:(NSData*) value;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) clearAddresslistDetail;

- (BOOL) hasType;
- (NSString*) type;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) setType:(NSString*) value;
- (UpAddressListReqArgs_AddresslistIdDetailCombo_Builder*) clearType;
@end

@interface UpAddressListReqArgs_Builder : PBGeneratedMessage_Builder {
@private
  UpAddressListReqArgs* result;
}

- (UpAddressListReqArgs*) defaultInstance;

- (UpAddressListReqArgs_Builder*) clear;
- (UpAddressListReqArgs_Builder*) clone;

- (UpAddressListReqArgs*) build;
- (UpAddressListReqArgs*) buildPartial;

- (UpAddressListReqArgs_Builder*) mergeFrom:(UpAddressListReqArgs*) other;
- (UpAddressListReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (UpAddressListReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasType;
- (NSString*) type;
- (UpAddressListReqArgs_Builder*) setType:(NSString*) value;
- (UpAddressListReqArgs_Builder*) clearType;

- (PBAppendableArray *)addressList;
- (UpAddressListReqArgs_AddresslistIdDetailCombo*)addressListAtIndex:(NSUInteger)index;
- (UpAddressListReqArgs_Builder *)addAddressList:(UpAddressListReqArgs_AddresslistIdDetailCombo*)value;
- (UpAddressListReqArgs_Builder *)setAddressListArray:(NSArray *)array;
- (UpAddressListReqArgs_Builder *)setAddressListValues:(const UpAddressListReqArgs_AddresslistIdDetailCombo* *)values count:(NSUInteger)count;
- (UpAddressListReqArgs_Builder *)clearAddressList;
@end

