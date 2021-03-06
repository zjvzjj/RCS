// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class SendSimpleMsgResults;
@class SendSimpleMsgResults_Builder;
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


@interface SendSimpleMsgResultsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface SendSimpleMsgResults : PBGeneratedMessage {
@private
  BOOL hasStatusCode_:1;
  int32_t statusCode;
}
- (BOOL) hasStatusCode;
@property (readonly) int32_t statusCode;

+ (SendSimpleMsgResults*) defaultInstance;
- (SendSimpleMsgResults*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (SendSimpleMsgResults_Builder*) builder;
+ (SendSimpleMsgResults_Builder*) builder;
+ (SendSimpleMsgResults_Builder*) builderWithPrototype:(SendSimpleMsgResults*) prototype;
- (SendSimpleMsgResults_Builder*) toBuilder;

+ (SendSimpleMsgResults*) parseFromData:(NSData*) data;
+ (SendSimpleMsgResults*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SendSimpleMsgResults*) parseFromInputStream:(NSInputStream*) input;
+ (SendSimpleMsgResults*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (SendSimpleMsgResults*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (SendSimpleMsgResults*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface SendSimpleMsgResults_Builder : PBGeneratedMessage_Builder {
@private
  SendSimpleMsgResults* result;
}

- (SendSimpleMsgResults*) defaultInstance;

- (SendSimpleMsgResults_Builder*) clear;
- (SendSimpleMsgResults_Builder*) clone;

- (SendSimpleMsgResults*) build;
- (SendSimpleMsgResults*) buildPartial;

- (SendSimpleMsgResults_Builder*) mergeFrom:(SendSimpleMsgResults*) other;
- (SendSimpleMsgResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (SendSimpleMsgResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasStatusCode;
- (int32_t) statusCode;
- (SendSimpleMsgResults_Builder*) setStatusCode:(int32_t) value;
- (SendSimpleMsgResults_Builder*) clearStatusCode;
@end

