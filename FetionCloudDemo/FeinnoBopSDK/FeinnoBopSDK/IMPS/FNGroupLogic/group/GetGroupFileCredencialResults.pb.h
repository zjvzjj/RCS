// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class GetGroupFileCredencialResults;
@class GetGroupFileCredencialResults_Builder;
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


@interface GetGroupFileCredencialResultsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface GetGroupFileCredencialResults : PBGeneratedMessage {
@private
  BOOL hasStatusCode_:1;
  BOOL hasCredential_:1;
  int32_t statusCode;
  NSString* credential;
}
- (BOOL) hasStatusCode;
- (BOOL) hasCredential;
@property (readonly) int32_t statusCode;
@property (readonly, retain) NSString* credential;

+ (GetGroupFileCredencialResults*) defaultInstance;
- (GetGroupFileCredencialResults*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GetGroupFileCredencialResults_Builder*) builder;
+ (GetGroupFileCredencialResults_Builder*) builder;
+ (GetGroupFileCredencialResults_Builder*) builderWithPrototype:(GetGroupFileCredencialResults*) prototype;
- (GetGroupFileCredencialResults_Builder*) toBuilder;

+ (GetGroupFileCredencialResults*) parseFromData:(NSData*) data;
+ (GetGroupFileCredencialResults*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetGroupFileCredencialResults*) parseFromInputStream:(NSInputStream*) input;
+ (GetGroupFileCredencialResults*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetGroupFileCredencialResults*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GetGroupFileCredencialResults*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface GetGroupFileCredencialResults_Builder : PBGeneratedMessage_Builder {
@private
  GetGroupFileCredencialResults* result;
}

- (GetGroupFileCredencialResults*) defaultInstance;

- (GetGroupFileCredencialResults_Builder*) clear;
- (GetGroupFileCredencialResults_Builder*) clone;

- (GetGroupFileCredencialResults*) build;
- (GetGroupFileCredencialResults*) buildPartial;

- (GetGroupFileCredencialResults_Builder*) mergeFrom:(GetGroupFileCredencialResults*) other;
- (GetGroupFileCredencialResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GetGroupFileCredencialResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasStatusCode;
- (int32_t) statusCode;
- (GetGroupFileCredencialResults_Builder*) setStatusCode:(int32_t) value;
- (GetGroupFileCredencialResults_Builder*) clearStatusCode;

- (BOOL) hasCredential;
- (NSString*) credential;
- (GetGroupFileCredencialResults_Builder*) setCredential:(NSString*) value;
- (GetGroupFileCredencialResults_Builder*) clearCredential;
@end

