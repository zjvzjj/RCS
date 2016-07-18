// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class ChangeGroupOwnerResults;
@class ChangeGroupOwnerResults_Builder;
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


@interface ChangeGroupOwnerResultsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface ChangeGroupOwnerResults : PBGeneratedMessage {
@private
  BOOL hasStatusCode_:1;
  int32_t statusCode;
}
- (BOOL) hasStatusCode;
@property (readonly) int32_t statusCode;

+ (ChangeGroupOwnerResults*) defaultInstance;
- (ChangeGroupOwnerResults*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ChangeGroupOwnerResults_Builder*) builder;
+ (ChangeGroupOwnerResults_Builder*) builder;
+ (ChangeGroupOwnerResults_Builder*) builderWithPrototype:(ChangeGroupOwnerResults*) prototype;
- (ChangeGroupOwnerResults_Builder*) toBuilder;

+ (ChangeGroupOwnerResults*) parseFromData:(NSData*) data;
+ (ChangeGroupOwnerResults*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ChangeGroupOwnerResults*) parseFromInputStream:(NSInputStream*) input;
+ (ChangeGroupOwnerResults*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ChangeGroupOwnerResults*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ChangeGroupOwnerResults*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ChangeGroupOwnerResults_Builder : PBGeneratedMessage_Builder {
@private
  ChangeGroupOwnerResults* result;
}

- (ChangeGroupOwnerResults*) defaultInstance;

- (ChangeGroupOwnerResults_Builder*) clear;
- (ChangeGroupOwnerResults_Builder*) clone;

- (ChangeGroupOwnerResults*) build;
- (ChangeGroupOwnerResults*) buildPartial;

- (ChangeGroupOwnerResults_Builder*) mergeFrom:(ChangeGroupOwnerResults*) other;
- (ChangeGroupOwnerResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ChangeGroupOwnerResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasStatusCode;
- (int32_t) statusCode;
- (ChangeGroupOwnerResults_Builder*) setStatusCode:(int32_t) value;
- (ChangeGroupOwnerResults_Builder*) clearStatusCode;
@end

