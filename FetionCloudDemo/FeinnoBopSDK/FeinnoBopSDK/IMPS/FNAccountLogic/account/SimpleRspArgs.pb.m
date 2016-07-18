// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "SimpleRspArgs.pb.h"

@implementation SimpleRspArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [SimpleRspArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface SimpleRspArgs ()
@property int32_t retCode;
@property (retain) NSString* retDesc;
@end

@implementation SimpleRspArgs

- (BOOL) hasRetCode {
  return !!hasRetCode_;
}
- (void) setHasRetCode:(BOOL) value_ {
  hasRetCode_ = !!value_;
}
@synthesize retCode;
- (BOOL) hasRetDesc {
  return !!hasRetDesc_;
}
- (void) setHasRetDesc:(BOOL) value_ {
  hasRetDesc_ = !!value_;
}
@synthesize retDesc;
- (void) dealloc {
  self.retDesc = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.retCode = 0;
    self.retDesc = @"";
  }
  return self;
}
static SimpleRspArgs* defaultSimpleRspArgsInstance = nil;
+ (void) initialize {
  if (self == [SimpleRspArgs class]) {
    defaultSimpleRspArgsInstance = [[SimpleRspArgs alloc] init];
  }
}
+ (SimpleRspArgs*) defaultInstance {
  return defaultSimpleRspArgsInstance;
}
- (SimpleRspArgs*) defaultInstance {
  return defaultSimpleRspArgsInstance;
}
- (BOOL) isInitialized {
  if (!self.hasRetCode) {
    return NO;
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasRetCode) {
    [output writeInt32:1 value:self.retCode];
  }
  if (self.hasRetDesc) {
    [output writeString:2 value:self.retDesc];
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
  if (self.hasRetDesc) {
    size_ += computeStringSize(2, self.retDesc);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (SimpleRspArgs*) parseFromData:(NSData*) data {
  return (SimpleRspArgs*)[[[SimpleRspArgs builder] mergeFromData:data] build];
}
+ (SimpleRspArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SimpleRspArgs*)[[[SimpleRspArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (SimpleRspArgs*) parseFromInputStream:(NSInputStream*) input {
  return (SimpleRspArgs*)[[[SimpleRspArgs builder] mergeFromInputStream:input] build];
}
+ (SimpleRspArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SimpleRspArgs*)[[[SimpleRspArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SimpleRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (SimpleRspArgs*)[[[SimpleRspArgs builder] mergeFromCodedInputStream:input] build];
}
+ (SimpleRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SimpleRspArgs*)[[[SimpleRspArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SimpleRspArgs_Builder*) builder {
  return [[[SimpleRspArgs_Builder alloc] init] autorelease];
}
+ (SimpleRspArgs_Builder*) builderWithPrototype:(SimpleRspArgs*) prototype {
  return [[SimpleRspArgs builder] mergeFrom:prototype];
}
- (SimpleRspArgs_Builder*) builder {
  return [SimpleRspArgs builder];
}
- (SimpleRspArgs_Builder*) toBuilder {
  return [SimpleRspArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasRetCode) {
    [output appendFormat:@"%@%@: %@\n", indent, @"retCode", [NSNumber numberWithInt:self.retCode]];
  }
  if (self.hasRetDesc) {
    [output appendFormat:@"%@%@: %@\n", indent, @"retDesc", self.retDesc];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[SimpleRspArgs class]]) {
    return NO;
  }
  SimpleRspArgs *otherMessage = other;
  return
      self.hasRetCode == otherMessage.hasRetCode &&
      (!self.hasRetCode || self.retCode == otherMessage.retCode) &&
      self.hasRetDesc == otherMessage.hasRetDesc &&
      (!self.hasRetDesc || [self.retDesc isEqual:otherMessage.retDesc]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasRetCode) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.retCode] hash];
  }
  if (self.hasRetDesc) {
    hashCode = hashCode * 31 + [self.retDesc hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface SimpleRspArgs_Builder()
@property (retain) SimpleRspArgs* result;
@end

@implementation SimpleRspArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[SimpleRspArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (SimpleRspArgs_Builder*) clear {
  self.result = [[[SimpleRspArgs alloc] init] autorelease];
  return self;
}
- (SimpleRspArgs_Builder*) clone {
  return [SimpleRspArgs builderWithPrototype:result];
}
- (SimpleRspArgs*) defaultInstance {
  return [SimpleRspArgs defaultInstance];
}
- (SimpleRspArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (SimpleRspArgs*) buildPartial {
  SimpleRspArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (SimpleRspArgs_Builder*) mergeFrom:(SimpleRspArgs*) other {
  if (other == [SimpleRspArgs defaultInstance]) {
    return self;
  }
  if (other.hasRetCode) {
    [self setRetCode:other.retCode];
  }
  if (other.hasRetDesc) {
    [self setRetDesc:other.retDesc];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (SimpleRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (SimpleRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
      case 18: {
        [self setRetDesc:[input readString]];
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
- (SimpleRspArgs_Builder*) setRetCode:(int32_t) value {
  result.hasRetCode = YES;
  result.retCode = value;
  return self;
}
- (SimpleRspArgs_Builder*) clearRetCode {
  result.hasRetCode = NO;
  result.retCode = 0;
  return self;
}
- (BOOL) hasRetDesc {
  return result.hasRetDesc;
}
- (NSString*) retDesc {
  return result.retDesc;
}
- (SimpleRspArgs_Builder*) setRetDesc:(NSString*) value {
  result.hasRetDesc = YES;
  result.retDesc = value;
  return self;
}
- (SimpleRspArgs_Builder*) clearRetDesc {
  result.hasRetDesc = NO;
  result.retDesc = @"";
  return self;
}
@end

