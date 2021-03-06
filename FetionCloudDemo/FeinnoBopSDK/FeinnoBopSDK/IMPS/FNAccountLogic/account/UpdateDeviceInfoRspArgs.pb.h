// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

// @@protoc_insertion_point(imports)

@class UpdateDeviceInfoRspArgs;
@class UpdateDeviceInfoRspArgs_Builder;



@interface UpdateDeviceInfoRspArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define UpdateDeviceInfoRspArgs_statusCode @"statusCode"
@interface UpdateDeviceInfoRspArgs : PBGeneratedMessage {
@private
  BOOL hasStatusCode_:1;
  SInt32 statusCode;
}
- (BOOL) hasStatusCode;
@property (readonly) SInt32 statusCode;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (UpdateDeviceInfoRspArgs_Builder*) builder;
+ (UpdateDeviceInfoRspArgs_Builder*) builder;
+ (UpdateDeviceInfoRspArgs_Builder*) builderWithPrototype:(UpdateDeviceInfoRspArgs*) prototype;
- (UpdateDeviceInfoRspArgs_Builder*) toBuilder;

+ (UpdateDeviceInfoRspArgs*) parseFromData:(NSData*) data;
+ (UpdateDeviceInfoRspArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (UpdateDeviceInfoRspArgs*) parseFromInputStream:(NSInputStream*) input;
+ (UpdateDeviceInfoRspArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (UpdateDeviceInfoRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (UpdateDeviceInfoRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface UpdateDeviceInfoRspArgs_Builder : PBGeneratedMessage_Builder {
@private
  UpdateDeviceInfoRspArgs* resultUpdateDeviceInfoRspArgs;
}

- (UpdateDeviceInfoRspArgs*) defaultInstance;

- (UpdateDeviceInfoRspArgs_Builder*) clear;
- (UpdateDeviceInfoRspArgs_Builder*) clone;

- (UpdateDeviceInfoRspArgs*) build;
- (UpdateDeviceInfoRspArgs*) buildPartial;

- (UpdateDeviceInfoRspArgs_Builder*) mergeFrom:(UpdateDeviceInfoRspArgs*) other;
- (UpdateDeviceInfoRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (UpdateDeviceInfoRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasStatusCode;
- (SInt32) statusCode;
- (UpdateDeviceInfoRspArgs_Builder*) setStatusCode:(SInt32) value;
- (UpdateDeviceInfoRspArgs_Builder*) clearStatusCode;
@end


// @@protoc_insertion_point(global_scope)
