// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class GetRelationShipRspArgs;
@class GetRelationShipRspArgs_AddressListRelationsEntity;
@class GetRelationShipRspArgs_AddressListRelationsEntity_Builder;
@class GetRelationShipRspArgs_Builder;
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


@interface GetRelationShipRspArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface GetRelationShipRspArgs : PBGeneratedMessage {
@private
  BOOL hasIsEnd_:1;
  BOOL hasRetCode_:1;
  BOOL hasExtentNo_:1;
  BOOL hasRetDesc_:1;
  BOOL hasTargetUserId_:1;
  BOOL hasNextUserId_:1;
  BOOL isEnd_:1;
  int32_t retCode;
  int32_t extentNo;
  NSString* retDesc;
  NSString* targetUserId;
  NSString* nextUserId;
  PBAppendableArray * relationsArray;
}
- (BOOL) hasRetCode;
- (BOOL) hasRetDesc;
- (BOOL) hasExtentNo;
- (BOOL) hasTargetUserId;
- (BOOL) hasIsEnd;
- (BOOL) hasNextUserId;
@property (readonly) int32_t retCode;
@property (readonly, retain) NSString* retDesc;
@property (readonly) int32_t extentNo;
@property (readonly, retain) NSString* targetUserId;
- (BOOL) isEnd;
@property (readonly, retain) NSString* nextUserId;
@property (readonly, retain) PBArray * relations;
- (GetRelationShipRspArgs_AddressListRelationsEntity*)relationsAtIndex:(NSUInteger)index;

+ (GetRelationShipRspArgs*) defaultInstance;
- (GetRelationShipRspArgs*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GetRelationShipRspArgs_Builder*) builder;
+ (GetRelationShipRspArgs_Builder*) builder;
+ (GetRelationShipRspArgs_Builder*) builderWithPrototype:(GetRelationShipRspArgs*) prototype;
- (GetRelationShipRspArgs_Builder*) toBuilder;

+ (GetRelationShipRspArgs*) parseFromData:(NSData*) data;
+ (GetRelationShipRspArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetRelationShipRspArgs*) parseFromInputStream:(NSInputStream*) input;
+ (GetRelationShipRspArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetRelationShipRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GetRelationShipRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface GetRelationShipRspArgs_AddressListRelationsEntity : PBGeneratedMessage {
@private
  BOOL hasVersion_:1;
  BOOL hasUserid_:1;
  BOOL hasAddresslistId_:1;
  int64_t version;
  NSString* userid;
  NSString* addresslistId;
}
- (BOOL) hasUserid;
- (BOOL) hasAddresslistId;
- (BOOL) hasVersion;
@property (readonly, retain) NSString* userid;
@property (readonly, retain) NSString* addresslistId;
@property (readonly) int64_t version;

+ (GetRelationShipRspArgs_AddressListRelationsEntity*) defaultInstance;
- (GetRelationShipRspArgs_AddressListRelationsEntity*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) builder;
+ (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) builder;
+ (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) builderWithPrototype:(GetRelationShipRspArgs_AddressListRelationsEntity*) prototype;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) toBuilder;

+ (GetRelationShipRspArgs_AddressListRelationsEntity*) parseFromData:(NSData*) data;
+ (GetRelationShipRspArgs_AddressListRelationsEntity*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetRelationShipRspArgs_AddressListRelationsEntity*) parseFromInputStream:(NSInputStream*) input;
+ (GetRelationShipRspArgs_AddressListRelationsEntity*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetRelationShipRspArgs_AddressListRelationsEntity*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GetRelationShipRspArgs_AddressListRelationsEntity*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface GetRelationShipRspArgs_AddressListRelationsEntity_Builder : PBGeneratedMessage_Builder {
@private
  GetRelationShipRspArgs_AddressListRelationsEntity* result;
}

- (GetRelationShipRspArgs_AddressListRelationsEntity*) defaultInstance;

- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) clear;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) clone;

- (GetRelationShipRspArgs_AddressListRelationsEntity*) build;
- (GetRelationShipRspArgs_AddressListRelationsEntity*) buildPartial;

- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) mergeFrom:(GetRelationShipRspArgs_AddressListRelationsEntity*) other;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserid;
- (NSString*) userid;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) setUserid:(NSString*) value;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) clearUserid;

- (BOOL) hasAddresslistId;
- (NSString*) addresslistId;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) setAddresslistId:(NSString*) value;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) clearAddresslistId;

- (BOOL) hasVersion;
- (int64_t) version;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) setVersion:(int64_t) value;
- (GetRelationShipRspArgs_AddressListRelationsEntity_Builder*) clearVersion;
@end

@interface GetRelationShipRspArgs_Builder : PBGeneratedMessage_Builder {
@private
  GetRelationShipRspArgs* result;
}

- (GetRelationShipRspArgs*) defaultInstance;

- (GetRelationShipRspArgs_Builder*) clear;
- (GetRelationShipRspArgs_Builder*) clone;

- (GetRelationShipRspArgs*) build;
- (GetRelationShipRspArgs*) buildPartial;

- (GetRelationShipRspArgs_Builder*) mergeFrom:(GetRelationShipRspArgs*) other;
- (GetRelationShipRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GetRelationShipRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasRetCode;
- (int32_t) retCode;
- (GetRelationShipRspArgs_Builder*) setRetCode:(int32_t) value;
- (GetRelationShipRspArgs_Builder*) clearRetCode;

- (BOOL) hasRetDesc;
- (NSString*) retDesc;
- (GetRelationShipRspArgs_Builder*) setRetDesc:(NSString*) value;
- (GetRelationShipRspArgs_Builder*) clearRetDesc;

- (BOOL) hasExtentNo;
- (int32_t) extentNo;
- (GetRelationShipRspArgs_Builder*) setExtentNo:(int32_t) value;
- (GetRelationShipRspArgs_Builder*) clearExtentNo;

- (BOOL) hasTargetUserId;
- (NSString*) targetUserId;
- (GetRelationShipRspArgs_Builder*) setTargetUserId:(NSString*) value;
- (GetRelationShipRspArgs_Builder*) clearTargetUserId;

- (BOOL) hasIsEnd;
- (BOOL) isEnd;
- (GetRelationShipRspArgs_Builder*) setIsEnd:(BOOL) value;
- (GetRelationShipRspArgs_Builder*) clearIsEnd;

- (BOOL) hasNextUserId;
- (NSString*) nextUserId;
- (GetRelationShipRspArgs_Builder*) setNextUserId:(NSString*) value;
- (GetRelationShipRspArgs_Builder*) clearNextUserId;

- (PBAppendableArray *)relations;
- (GetRelationShipRspArgs_AddressListRelationsEntity*)relationsAtIndex:(NSUInteger)index;
- (GetRelationShipRspArgs_Builder *)addRelations:(GetRelationShipRspArgs_AddressListRelationsEntity*)value;
- (GetRelationShipRspArgs_Builder *)setRelationsArray:(NSArray *)array;
- (GetRelationShipRspArgs_Builder *)setRelationsValues:(const GetRelationShipRspArgs_AddressListRelationsEntity* *)values count:(NSUInteger)count;
- (GetRelationShipRspArgs_Builder *)clearRelations;
@end

