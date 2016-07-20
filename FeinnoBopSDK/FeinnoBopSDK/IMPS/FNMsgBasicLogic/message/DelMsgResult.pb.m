// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "DelMsgResult.pb.h"

@implementation DelMsgResultRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [DelMsgResultRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface DelMsgResult ()
@property int32_t statusCode;
@end

@implementation DelMsgResult

- (BOOL) hasStatusCode {
  return !!hasStatusCode_;
}
- (void) setHasStatusCode:(BOOL) value_ {
  hasStatusCode_ = !!value_;
}
@synthesize statusCode;
- (void) dealloc {
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.statusCode = 0;
  }
  return self;
}
static DelMsgResult* defaultDelMsgResultInstance = nil;
+ (void) initialize {
  if (self == [DelMsgResult class]) {
    defaultDelMsgResultInstance = [[DelMsgResult alloc] init];
  }
}
+ (DelMsgResult*) defaultInstance {
  return defaultDelMsgResultInstance;
}
- (DelMsgResult*) defaultInstance {
  return defaultDelMsgResultInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasStatusCode) {
    [output writeInt32:1 value:self.statusCode];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasStatusCode) {
    size_ += computeInt32Size(1, self.statusCode);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (DelMsgResult*) parseFromData:(NSData*) data {
  return (DelMsgResult*)[[[DelMsgResult builder] mergeFromData:data] build];
}
+ (DelMsgResult*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (DelMsgResult*)[[[DelMsgResult builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (DelMsgResult*) parseFromInputStream:(NSInputStream*) input {
  return (DelMsgResult*)[[[DelMsgResult builder] mergeFromInputStream:input] build];
}
+ (DelMsgResult*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (DelMsgResult*)[[[DelMsgResult builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (DelMsgResult*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (DelMsgResult*)[[[DelMsgResult builder] mergeFromCodedInputStream:input] build];
}
+ (DelMsgResult*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (DelMsgResult*)[[[DelMsgResult builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (DelMsgResult_Builder*) builder {
  return [[[DelMsgResult_Builder alloc] init] autorelease];
}
+ (DelMsgResult_Builder*) builderWithPrototype:(DelMsgResult*) prototype {
  return [[DelMsgResult builder] mergeFrom:prototype];
}
- (DelMsgResult_Builder*) builder {
  return [DelMsgResult builder];
}
- (DelMsgResult_Builder*) toBuilder {
  return [DelMsgResult builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasStatusCode) {
    [output appendFormat:@"%@%@: %@\n", indent, @"statusCode", [NSNumber numberWithInt:self.statusCode]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[DelMsgResult class]]) {
    return NO;
  }
  DelMsgResult *otherMessage = other;
  return
      self.hasStatusCode == otherMessage.hasStatusCode &&
      (!self.hasStatusCode || self.statusCode == otherMessage.statusCode) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasStatusCode) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.statusCode] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface DelMsgResult_Builder()
@property (retain) DelMsgResult* result;
@end

@implementation DelMsgResult_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[DelMsgResult alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (DelMsgResult_Builder*) clear {
  self.result = [[[DelMsgResult alloc] init] autorelease];
  return self;
}
- (DelMsgResult_Builder*) clone {
  return [DelMsgResult builderWithPrototype:result];
}
- (DelMsgResult*) defaultInstance {
  return [DelMsgResult defaultInstance];
}
- (DelMsgResult*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (DelMsgResult*) buildPartial {
  DelMsgResult* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (DelMsgResult_Builder*) mergeFrom:(DelMsgResult*) other {
  if (other == [DelMsgResult defaultInstance]) {
    return self;
  }
  if (other.hasStatusCode) {
    [self setStatusCode:other.statusCode];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (DelMsgResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (DelMsgResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setStatusCode:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasStatusCode {
  return result.hasStatusCode;
}
- (int32_t) statusCode {
  return result.statusCode;
}
- (DelMsgResult_Builder*) setStatusCode:(int32_t) value {
  result.hasStatusCode = YES;
  result.statusCode = value;
  return self;
}
- (DelMsgResult_Builder*) clearStatusCode {
  result.hasStatusCode = NO;
  result.statusCode = 0;
  return self;
}
@end
