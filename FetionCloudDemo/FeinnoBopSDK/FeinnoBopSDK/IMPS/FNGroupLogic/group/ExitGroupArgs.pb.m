// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ExitGroupArgs.pb.h"

@implementation ExitGroupArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [ExitGroupArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface ExitGroupArgs ()
@property (retain) NSString* groupId;
@end

@implementation ExitGroupArgs

- (BOOL) hasGroupId {
  return !!hasGroupId_;
}
- (void) setHasGroupId:(BOOL) value_ {
  hasGroupId_ = !!value_;
}
@synthesize groupId;
- (void) dealloc {
  self.groupId = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.groupId = @"";
  }
  return self;
}
static ExitGroupArgs* defaultExitGroupArgsInstance = nil;
+ (void) initialize {
  if (self == [ExitGroupArgs class]) {
    defaultExitGroupArgsInstance = [[ExitGroupArgs alloc] init];
  }
}
+ (ExitGroupArgs*) defaultInstance {
  return defaultExitGroupArgsInstance;
}
- (ExitGroupArgs*) defaultInstance {
  return defaultExitGroupArgsInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasGroupId) {
    [output writeString:1 value:self.groupId];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasGroupId) {
    size_ += computeStringSize(1, self.groupId);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (ExitGroupArgs*) parseFromData:(NSData*) data {
  return (ExitGroupArgs*)[[[ExitGroupArgs builder] mergeFromData:data] build];
}
+ (ExitGroupArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (ExitGroupArgs*)[[[ExitGroupArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (ExitGroupArgs*) parseFromInputStream:(NSInputStream*) input {
  return (ExitGroupArgs*)[[[ExitGroupArgs builder] mergeFromInputStream:input] build];
}
+ (ExitGroupArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (ExitGroupArgs*)[[[ExitGroupArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (ExitGroupArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (ExitGroupArgs*)[[[ExitGroupArgs builder] mergeFromCodedInputStream:input] build];
}
+ (ExitGroupArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (ExitGroupArgs*)[[[ExitGroupArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (ExitGroupArgs_Builder*) builder {
  return [[[ExitGroupArgs_Builder alloc] init] autorelease];
}
+ (ExitGroupArgs_Builder*) builderWithPrototype:(ExitGroupArgs*) prototype {
  return [[ExitGroupArgs builder] mergeFrom:prototype];
}
- (ExitGroupArgs_Builder*) builder {
  return [ExitGroupArgs builder];
}
- (ExitGroupArgs_Builder*) toBuilder {
  return [ExitGroupArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasGroupId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"groupId", self.groupId];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[ExitGroupArgs class]]) {
    return NO;
  }
  ExitGroupArgs *otherMessage = other;
  return
      self.hasGroupId == otherMessage.hasGroupId &&
      (!self.hasGroupId || [self.groupId isEqual:otherMessage.groupId]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasGroupId) {
    hashCode = hashCode * 31 + [self.groupId hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface ExitGroupArgs_Builder()
@property (retain) ExitGroupArgs* result;
@end

@implementation ExitGroupArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[ExitGroupArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (ExitGroupArgs_Builder*) clear {
  self.result = [[[ExitGroupArgs alloc] init] autorelease];
  return self;
}
- (ExitGroupArgs_Builder*) clone {
  return [ExitGroupArgs builderWithPrototype:result];
}
- (ExitGroupArgs*) defaultInstance {
  return [ExitGroupArgs defaultInstance];
}
- (ExitGroupArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (ExitGroupArgs*) buildPartial {
  ExitGroupArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (ExitGroupArgs_Builder*) mergeFrom:(ExitGroupArgs*) other {
  if (other == [ExitGroupArgs defaultInstance]) {
    return self;
  }
  if (other.hasGroupId) {
    [self setGroupId:other.groupId];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (ExitGroupArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (ExitGroupArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
      case 10: {
        [self setGroupId:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasGroupId {
  return result.hasGroupId;
}
- (NSString*) groupId {
  return result.groupId;
}
- (ExitGroupArgs_Builder*) setGroupId:(NSString*) value {
  result.hasGroupId = YES;
  result.groupId = value;
  return self;
}
- (ExitGroupArgs_Builder*) clearGroupId {
  result.hasGroupId = NO;
  result.groupId = @"";
  return self;
}
@end
