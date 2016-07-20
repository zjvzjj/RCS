// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ChangeGroupOwnerResults.pb.h"

@implementation ChangeGroupOwnerResultsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [ChangeGroupOwnerResultsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface ChangeGroupOwnerResults ()
@property int32_t statusCode;
@end

@implementation ChangeGroupOwnerResults

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
static ChangeGroupOwnerResults* defaultChangeGroupOwnerResultsInstance = nil;
+ (void) initialize {
  if (self == [ChangeGroupOwnerResults class]) {
    defaultChangeGroupOwnerResultsInstance = [[ChangeGroupOwnerResults alloc] init];
  }
}
+ (ChangeGroupOwnerResults*) defaultInstance {
  return defaultChangeGroupOwnerResultsInstance;
}
- (ChangeGroupOwnerResults*) defaultInstance {
  return defaultChangeGroupOwnerResultsInstance;
}
- (BOOL) isInitialized {
  if (!self.hasStatusCode) {
    return NO;
  }
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
+ (ChangeGroupOwnerResults*) parseFromData:(NSData*) data {
  return (ChangeGroupOwnerResults*)[[[ChangeGroupOwnerResults builder] mergeFromData:data] build];
}
+ (ChangeGroupOwnerResults*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (ChangeGroupOwnerResults*)[[[ChangeGroupOwnerResults builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (ChangeGroupOwnerResults*) parseFromInputStream:(NSInputStream*) input {
  return (ChangeGroupOwnerResults*)[[[ChangeGroupOwnerResults builder] mergeFromInputStream:input] build];
}
+ (ChangeGroupOwnerResults*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (ChangeGroupOwnerResults*)[[[ChangeGroupOwnerResults builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (ChangeGroupOwnerResults*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (ChangeGroupOwnerResults*)[[[ChangeGroupOwnerResults builder] mergeFromCodedInputStream:input] build];
}
+ (ChangeGroupOwnerResults*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (ChangeGroupOwnerResults*)[[[ChangeGroupOwnerResults builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (ChangeGroupOwnerResults_Builder*) builder {
  return [[[ChangeGroupOwnerResults_Builder alloc] init] autorelease];
}
+ (ChangeGroupOwnerResults_Builder*) builderWithPrototype:(ChangeGroupOwnerResults*) prototype {
  return [[ChangeGroupOwnerResults builder] mergeFrom:prototype];
}
- (ChangeGroupOwnerResults_Builder*) builder {
  return [ChangeGroupOwnerResults builder];
}
- (ChangeGroupOwnerResults_Builder*) toBuilder {
  return [ChangeGroupOwnerResults builderWithPrototype:self];
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
  if (![other isKindOfClass:[ChangeGroupOwnerResults class]]) {
    return NO;
  }
  ChangeGroupOwnerResults *otherMessage = other;
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

@interface ChangeGroupOwnerResults_Builder()
@property (retain) ChangeGroupOwnerResults* result;
@end

@implementation ChangeGroupOwnerResults_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[ChangeGroupOwnerResults alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (ChangeGroupOwnerResults_Builder*) clear {
  self.result = [[[ChangeGroupOwnerResults alloc] init] autorelease];
  return self;
}
- (ChangeGroupOwnerResults_Builder*) clone {
  return [ChangeGroupOwnerResults builderWithPrototype:result];
}
- (ChangeGroupOwnerResults*) defaultInstance {
  return [ChangeGroupOwnerResults defaultInstance];
}
- (ChangeGroupOwnerResults*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (ChangeGroupOwnerResults*) buildPartial {
  ChangeGroupOwnerResults* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (ChangeGroupOwnerResults_Builder*) mergeFrom:(ChangeGroupOwnerResults*) other {
  if (other == [ChangeGroupOwnerResults defaultInstance]) {
    return self;
  }
  if (other.hasStatusCode) {
    [self setStatusCode:other.statusCode];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (ChangeGroupOwnerResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (ChangeGroupOwnerResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
- (ChangeGroupOwnerResults_Builder*) setStatusCode:(int32_t) value {
  result.hasStatusCode = YES;
  result.statusCode = value;
  return self;
}
- (ChangeGroupOwnerResults_Builder*) clearStatusCode {
  result.hasStatusCode = NO;
  result.statusCode = 0;
  return self;
}
@end
