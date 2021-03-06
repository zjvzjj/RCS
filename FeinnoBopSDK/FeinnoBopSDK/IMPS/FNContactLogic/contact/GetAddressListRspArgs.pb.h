// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class GetAddressListRspArgs;
@class GetAddressListRspArgs_AddresslistIdDetailCombo;
@class GetAddressListRspArgs_AddresslistIdDetailCombo_Builder;
@class GetAddressListRspArgs_Builder;
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


@interface GetAddressListRspArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface GetAddressListRspArgs : PBGeneratedMessage {
@private
  BOOL hasIsEnd_:1;
  BOOL hasRetCode_:1;
  BOOL hasRetDesc_:1;
  BOOL hasNextAddresslistId_:1;
  BOOL isEnd_:1;
  int32_t retCode;
  NSString* retDesc;
  NSString* nextAddresslistId;
  PBAppendableArray * addressListArray;
}
- (BOOL) hasRetCode;
- (BOOL) hasRetDesc;
- (BOOL) hasIsEnd;
- (BOOL) hasNextAddresslistId;
@property (readonly) int32_t retCode;
@property (readonly, retain) NSString* retDesc;
- (BOOL) isEnd;
@property (readonly, retain) NSString* nextAddresslistId;
@property (readonly, retain) PBArray * addressList;
- (GetAddressListRspArgs_AddresslistIdDetailCombo*)addressListAtIndex:(NSUInteger)index;

+ (GetAddressListRspArgs*) defaultInstance;
- (GetAddressListRspArgs*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GetAddressListRspArgs_Builder*) builder;
+ (GetAddressListRspArgs_Builder*) builder;
+ (GetAddressListRspArgs_Builder*) builderWithPrototype:(GetAddressListRspArgs*) prototype;
- (GetAddressListRspArgs_Builder*) toBuilder;

+ (GetAddressListRspArgs*) parseFromData:(NSData*) data;
+ (GetAddressListRspArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetAddressListRspArgs*) parseFromInputStream:(NSInputStream*) input;
+ (GetAddressListRspArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetAddressListRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GetAddressListRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface GetAddressListRspArgs_AddresslistIdDetailCombo : PBGeneratedMessage {
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

+ (GetAddressListRspArgs_AddresslistIdDetailCombo*) defaultInstance;
- (GetAddressListRspArgs_AddresslistIdDetailCombo*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) builder;
+ (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) builder;
+ (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) builderWithPrototype:(GetAddressListRspArgs_AddresslistIdDetailCombo*) prototype;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) toBuilder;

+ (GetAddressListRspArgs_AddresslistIdDetailCombo*) parseFromData:(NSData*) data;
+ (GetAddressListRspArgs_AddresslistIdDetailCombo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetAddressListRspArgs_AddresslistIdDetailCombo*) parseFromInputStream:(NSInputStream*) input;
+ (GetAddressListRspArgs_AddresslistIdDetailCombo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetAddressListRspArgs_AddresslistIdDetailCombo*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GetAddressListRspArgs_AddresslistIdDetailCombo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface GetAddressListRspArgs_AddresslistIdDetailCombo_Builder : PBGeneratedMessage_Builder {
@private
  GetAddressListRspArgs_AddresslistIdDetailCombo* result;
}

- (GetAddressListRspArgs_AddresslistIdDetailCombo*) defaultInstance;

- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) clear;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) clone;

- (GetAddressListRspArgs_AddresslistIdDetailCombo*) build;
- (GetAddressListRspArgs_AddresslistIdDetailCombo*) buildPartial;

- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) mergeFrom:(GetAddressListRspArgs_AddresslistIdDetailCombo*) other;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasAddresslistId;
- (NSString*) addresslistId;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) setAddresslistId:(NSString*) value;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) clearAddresslistId;

- (BOOL) hasAddresslistDetail;
- (NSData*) addresslistDetail;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) setAddresslistDetail:(NSData*) value;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) clearAddresslistDetail;

- (BOOL) hasType;
- (NSString*) type;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) setType:(NSString*) value;
- (GetAddressListRspArgs_AddresslistIdDetailCombo_Builder*) clearType;
@end

@interface GetAddressListRspArgs_Builder : PBGeneratedMessage_Builder {
@private
  GetAddressListRspArgs* result;
}

- (GetAddressListRspArgs*) defaultInstance;

- (GetAddressListRspArgs_Builder*) clear;
- (GetAddressListRspArgs_Builder*) clone;

- (GetAddressListRspArgs*) build;
- (GetAddressListRspArgs*) buildPartial;

- (GetAddressListRspArgs_Builder*) mergeFrom:(GetAddressListRspArgs*) other;
- (GetAddressListRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GetAddressListRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasRetCode;
- (int32_t) retCode;
- (GetAddressListRspArgs_Builder*) setRetCode:(int32_t) value;
- (GetAddressListRspArgs_Builder*) clearRetCode;

- (BOOL) hasRetDesc;
- (NSString*) retDesc;
- (GetAddressListRspArgs_Builder*) setRetDesc:(NSString*) value;
- (GetAddressListRspArgs_Builder*) clearRetDesc;

- (BOOL) hasIsEnd;
- (BOOL) isEnd;
- (GetAddressListRspArgs_Builder*) setIsEnd:(BOOL) value;
- (GetAddressListRspArgs_Builder*) clearIsEnd;

- (BOOL) hasNextAddresslistId;
- (NSString*) nextAddresslistId;
- (GetAddressListRspArgs_Builder*) setNextAddresslistId:(NSString*) value;
- (GetAddressListRspArgs_Builder*) clearNextAddresslistId;

- (PBAppendableArray *)addressList;
- (GetAddressListRspArgs_AddresslistIdDetailCombo*)addressListAtIndex:(NSUInteger)index;
- (GetAddressListRspArgs_Builder *)addAddressList:(GetAddressListRspArgs_AddresslistIdDetailCombo*)value;
- (GetAddressListRspArgs_Builder *)setAddressListArray:(NSArray *)array;
- (GetAddressListRspArgs_Builder *)setAddressListValues:(const GetAddressListRspArgs_AddresslistIdDetailCombo* *)values count:(NSUInteger)count;
- (GetAddressListRspArgs_Builder *)clearAddressList;
@end

