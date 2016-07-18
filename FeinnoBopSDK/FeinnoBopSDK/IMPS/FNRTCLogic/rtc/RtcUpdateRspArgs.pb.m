// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "RtcUpdateRspArgs.pb.h"

@implementation RtcUpdateRspArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [RtcUpdateRspArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface RtcUpdateRspArgs ()
@property int32_t retCode;
@end

@implementation RtcUpdateRspArgs

- (BOOL) hasRetCode {
  return !!hasRetCode_;
}
- (void) setHasRetCode:(BOOL) value_ {
  hasRetCode_ = !!value_;
}
@synthesize retCode;
- (void) dealloc {
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.retCode = 0;
  }
  return self;
}
static RtcUpdateRspArgs* defaultRtcUpdateRspArgsInstance = nil;
+ (void) initialize {
  if (self == [RtcUpdateRspArgs class]) {
    defaultRtcUpdateRspArgsInstance = [[RtcUpdateRspArgs alloc] init];
  }
}
+ (RtcUpdateRspArgs*) defaultInstance {
  return defaultRtcUpdateRspArgsInstance;
}
- (RtcUpdateRspArgs*) defaultInstance {
  return defaultRtcUpdateRspArgsInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasRetCode) {
    [output writeInt32:1 value:self.retCode];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasRetCode) {
    size_ += computeInt32Size(1, self.retCode);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (RtcUpdateRspArgs*) parseFromData:(NSData*) data {
  return (RtcUpdateRspArgs*)[[[RtcUpdateRspArgs builder] mergeFromData:data] build];
}
+ (RtcUpdateRspArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcUpdateRspArgs*)[[[RtcUpdateRspArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (RtcUpdateRspArgs*) parseFromInputStream:(NSInputStream*) input {
  return (RtcUpdateRspArgs*)[[[RtcUpdateRspArgs builder] mergeFromInputStream:input] build];
}
+ (RtcUpdateRspArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcUpdateRspArgs*)[[[RtcUpdateRspArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (RtcUpdateRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (RtcUpdateRspArgs*)[[[RtcUpdateRspArgs builder] mergeFromCodedInputStream:input] build];
}
+ (RtcUpdateRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcUpdateRspArgs*)[[[RtcUpdateRspArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (RtcUpdateRspArgs_Builder*) builder {
  return [[[RtcUpdateRspArgs_Builder alloc] init] autorelease];
}
+ (RtcUpdateRspArgs_Builder*) builderWithPrototype:(RtcUpdateRspArgs*) prototype {
  return [[RtcUpdateRspArgs builder] mergeFrom:prototype];
}
- (RtcUpdateRspArgs_Builder*) builder {
  return [RtcUpdateRspArgs builder];
}
- (RtcUpdateRspArgs_Builder*) toBuilder {
  return [RtcUpdateRspArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasRetCode) {
    [output appendFormat:@"%@%@: %@\n", indent, @"retCode", [NSNumber numberWithInt:self.retCode]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[RtcUpdateRspArgs class]]) {
    return NO;
  }
  RtcUpdateRspArgs *otherMessage = other;
  return
      self.hasRetCode == otherMessage.hasRetCode &&
      (!self.hasRetCode || self.retCode == otherMessage.retCode) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasRetCode) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.retCode] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface RtcUpdateRspArgs_Builder()
@property (retain) RtcUpdateRspArgs* result;
@end

@implementation RtcUpdateRspArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[RtcUpdateRspArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (RtcUpdateRspArgs_Builder*) clear {
  self.result = [[[RtcUpdateRspArgs alloc] init] autorelease];
  return self;
}
- (RtcUpdateRspArgs_Builder*) clone {
  return [RtcUpdateRspArgs builderWithPrototype:result];
}
- (RtcUpdateRspArgs*) defaultInstance {
  return [RtcUpdateRspArgs defaultInstance];
}
- (RtcUpdateRspArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (RtcUpdateRspArgs*) buildPartial {
  RtcUpdateRspArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (RtcUpdateRspArgs_Builder*) mergeFrom:(RtcUpdateRspArgs*) other {
  if (other == [RtcUpdateRspArgs defaultInstance]) {
    return self;
  }
  if (other.hasRetCode) {
    [self setRetCode:other.retCode];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (RtcUpdateRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (RtcUpdateRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    int32_t tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 8: {
        [self setRetCode:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasRetCode {
  return result.hasRetCode;
}
- (int32_t) retCode {
  return result.retCode;
}
- (RtcUpdateRspArgs_Builder*) setRetCode:(int32_t) value {
  result.hasRetCode = YES;
  result.retCode = value;
  return self;
}
- (RtcUpdateRspArgs_Builder*) clearRetCode {
  result.hasRetCode = NO;
  result.retCode = 0;
  return self;
}
@end

