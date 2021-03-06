// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "RtcInviteRspArgs.pb.h"

@implementation RtcInviteRspArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [RtcInviteRspArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface RtcInviteRspArgs ()
@property int32_t retCode;
@end

@implementation RtcInviteRspArgs

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
static RtcInviteRspArgs* defaultRtcInviteRspArgsInstance = nil;
+ (void) initialize {
  if (self == [RtcInviteRspArgs class]) {
    defaultRtcInviteRspArgsInstance = [[RtcInviteRspArgs alloc] init];
  }
}
+ (RtcInviteRspArgs*) defaultInstance {
  return defaultRtcInviteRspArgsInstance;
}
- (RtcInviteRspArgs*) defaultInstance {
  return defaultRtcInviteRspArgsInstance;
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
+ (RtcInviteRspArgs*) parseFromData:(NSData*) data {
  return (RtcInviteRspArgs*)[[[RtcInviteRspArgs builder] mergeFromData:data] build];
}
+ (RtcInviteRspArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcInviteRspArgs*)[[[RtcInviteRspArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (RtcInviteRspArgs*) parseFromInputStream:(NSInputStream*) input {
  return (RtcInviteRspArgs*)[[[RtcInviteRspArgs builder] mergeFromInputStream:input] build];
}
+ (RtcInviteRspArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcInviteRspArgs*)[[[RtcInviteRspArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (RtcInviteRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (RtcInviteRspArgs*)[[[RtcInviteRspArgs builder] mergeFromCodedInputStream:input] build];
}
+ (RtcInviteRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcInviteRspArgs*)[[[RtcInviteRspArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (RtcInviteRspArgs_Builder*) builder {
  return [[[RtcInviteRspArgs_Builder alloc] init] autorelease];
}
+ (RtcInviteRspArgs_Builder*) builderWithPrototype:(RtcInviteRspArgs*) prototype {
  return [[RtcInviteRspArgs builder] mergeFrom:prototype];
}
- (RtcInviteRspArgs_Builder*) builder {
  return [RtcInviteRspArgs builder];
}
- (RtcInviteRspArgs_Builder*) toBuilder {
  return [RtcInviteRspArgs builderWithPrototype:self];
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
  if (![other isKindOfClass:[RtcInviteRspArgs class]]) {
    return NO;
  }
  RtcInviteRspArgs *otherMessage = other;
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

@interface RtcInviteRspArgs_Builder()
@property (retain) RtcInviteRspArgs* result;
@end

@implementation RtcInviteRspArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[RtcInviteRspArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (RtcInviteRspArgs_Builder*) clear {
  self.result = [[[RtcInviteRspArgs alloc] init] autorelease];
  return self;
}
- (RtcInviteRspArgs_Builder*) clone {
  return [RtcInviteRspArgs builderWithPrototype:result];
}
- (RtcInviteRspArgs*) defaultInstance {
  return [RtcInviteRspArgs defaultInstance];
}
- (RtcInviteRspArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (RtcInviteRspArgs*) buildPartial {
  RtcInviteRspArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (RtcInviteRspArgs_Builder*) mergeFrom:(RtcInviteRspArgs*) other {
  if (other == [RtcInviteRspArgs defaultInstance]) {
    return self;
  }
  if (other.hasRetCode) {
    [self setRetCode:other.retCode];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (RtcInviteRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (RtcInviteRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
- (RtcInviteRspArgs_Builder*) setRetCode:(int32_t) value {
  result.hasRetCode = YES;
  result.retCode = value;
  return self;
}
- (RtcInviteRspArgs_Builder*) clearRetCode {
  result.hasRetCode = NO;
  result.retCode = 0;
  return self;
}
@end

