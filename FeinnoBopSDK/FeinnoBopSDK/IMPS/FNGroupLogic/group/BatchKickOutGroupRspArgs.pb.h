// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

// @@protoc_insertion_point(imports)

@class BatchKickOutGroupRspArgs;
@class BatchKickOutGroupRspArgs_Builder;
@class BatchKickOutGroupRspArgs_MemberResult;
@class BatchKickOutGroupRspArgs_MemberResult_Builder;



@interface BatchKickOutGroupRspArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define BatchKickOutGroupRspArgs_statusCode @"statusCode"
#define BatchKickOutGroupRspArgs_resultList @"resultList"
@interface BatchKickOutGroupRspArgs : PBGeneratedMessage {
@private
  BOOL hasStatusCode_:1;
  SInt32 statusCode;
  NSMutableArray * resultListArray;
}
- (BOOL) hasStatusCode;
@property (readonly) SInt32 statusCode;
@property (readonly, strong) NSArray * resultList;
- (BatchKickOutGroupRspArgs_MemberResult*)resultListAtIndex:(NSUInteger)index;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (BatchKickOutGroupRspArgs_Builder*) builder;
+ (BatchKickOutGroupRspArgs_Builder*) builder;
+ (BatchKickOutGroupRspArgs_Builder*) builderWithPrototype:(BatchKickOutGroupRspArgs*) prototype;
- (BatchKickOutGroupRspArgs_Builder*) toBuilder;

+ (BatchKickOutGroupRspArgs*) parseFromData:(NSData*) data;
+ (BatchKickOutGroupRspArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (BatchKickOutGroupRspArgs*) parseFromInputStream:(NSInputStream*) input;
+ (BatchKickOutGroupRspArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (BatchKickOutGroupRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (BatchKickOutGroupRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

#define Result_userId @"userId"
#define Result_statusCode @"statusCode"
@interface BatchKickOutGroupRspArgs_MemberResult : PBGeneratedMessage {
@private
  BOOL hasStatusCode_:1;
  BOOL hasUserId_:1;
  SInt32 statusCode;
  NSString* userId;
}
- (BOOL) hasUserId;
- (BOOL) hasStatusCode;
@property (readonly, strong) NSString* userId;
@property (readonly) SInt32 statusCode;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (BatchKickOutGroupRspArgs_MemberResult_Builder*) builder;
+ (BatchKickOutGroupRspArgs_MemberResult_Builder*) builder;
+ (BatchKickOutGroupRspArgs_MemberResult_Builder*) builderWithPrototype:(BatchKickOutGroupRspArgs_MemberResult*) prototype;
- (BatchKickOutGroupRspArgs_MemberResult_Builder*) toBuilder;

+ (BatchKickOutGroupRspArgs_MemberResult*) parseFromData:(NSData*) data;
+ (BatchKickOutGroupRspArgs_MemberResult*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (BatchKickOutGroupRspArgs_MemberResult*) parseFromInputStream:(NSInputStream*) input;
+ (BatchKickOutGroupRspArgs_MemberResult*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (BatchKickOutGroupRspArgs_MemberResult*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (BatchKickOutGroupRspArgs_MemberResult*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface BatchKickOutGroupRspArgs_MemberResult_Builder : PBGeneratedMessage_Builder {
@private
  BatchKickOutGroupRspArgs_MemberResult* resultResult;
}

- (BatchKickOutGroupRspArgs_MemberResult*) defaultInstance;

- (BatchKickOutGroupRspArgs_MemberResult_Builder*) clear;
- (BatchKickOutGroupRspArgs_MemberResult_Builder*) clone;

- (BatchKickOutGroupRspArgs_MemberResult*) build;
- (BatchKickOutGroupRspArgs_MemberResult*) buildPartial;

- (BatchKickOutGroupRspArgs_MemberResult_Builder*) mergeFrom:(BatchKickOutGroupRspArgs_MemberResult*) other;
- (BatchKickOutGroupRspArgs_MemberResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (BatchKickOutGroupRspArgs_MemberResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserId;
- (NSString*) userId;
- (BatchKickOutGroupRspArgs_MemberResult_Builder*) setUserId:(NSString*) value;
- (BatchKickOutGroupRspArgs_MemberResult_Builder*) clearUserId;

- (BOOL) hasStatusCode;
- (SInt32) statusCode;
- (BatchKickOutGroupRspArgs_MemberResult_Builder*) setStatusCode:(SInt32) value;
- (BatchKickOutGroupRspArgs_MemberResult_Builder*) clearStatusCode;
@end

@interface BatchKickOutGroupRspArgs_Builder : PBGeneratedMessage_Builder {
@private
  BatchKickOutGroupRspArgs* resultBatchKickOutGroupRspArgs;
}

- (BatchKickOutGroupRspArgs*) defaultInstance;

- (BatchKickOutGroupRspArgs_Builder*) clear;
- (BatchKickOutGroupRspArgs_Builder*) clone;

- (BatchKickOutGroupRspArgs*) build;
- (BatchKickOutGroupRspArgs*) buildPartial;

- (BatchKickOutGroupRspArgs_Builder*) mergeFrom:(BatchKickOutGroupRspArgs*) other;
- (BatchKickOutGroupRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (BatchKickOutGroupRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasStatusCode;
- (SInt32) statusCode;
- (BatchKickOutGroupRspArgs_Builder*) setStatusCode:(SInt32) value;
- (BatchKickOutGroupRspArgs_Builder*) clearStatusCode;

- (NSMutableArray *)resultList;
- (BatchKickOutGroupRspArgs_MemberResult*)resultListAtIndex:(NSUInteger)index;
- (BatchKickOutGroupRspArgs_Builder *)addResultList:(BatchKickOutGroupRspArgs_MemberResult*)value;
- (BatchKickOutGroupRspArgs_Builder *)setResultListArray:(NSArray *)array;
- (BatchKickOutGroupRspArgs_Builder *)clearResultList;
@end


// @@protoc_insertion_point(global_scope)
