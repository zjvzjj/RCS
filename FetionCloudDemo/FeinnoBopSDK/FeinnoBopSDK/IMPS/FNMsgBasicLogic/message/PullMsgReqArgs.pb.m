// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "PullMsgReqArgs.pb.h"

@implementation PullMsgReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [PullMsgReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface PullMsgReqArgs ()
@property int32_t count;
@property int64_t syncId;
@end

@implementation PullMsgReqArgs

- (BOOL) hasCount {
  return !!hasCount_;
}
- (void) setHasCount:(BOOL) value_ {
  hasCount_ = !!value_;
}
@synthesize count;
- (BOOL) hasSyncId {
  return !!hasSyncId_;
}
- (void) setHasSyncId:(BOOL) value_ {
  hasSyncId_ = !!value_;
}
@synthesize syncId;
- (void) dealloc {
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.count = 0;
    self.syncId = 0L;
  }
  return self;
}
static PullMsgReqArgs* defaultPullMsgReqArgsInstance = nil;
+ (void) initialize {
  if (self == [PullMsgReqArgs class]) {
    defaultPullMsgReqArgsInstance = [[PullMsgReqArgs alloc] init];
  }
}
+ (PullMsgReqArgs*) defaultInstance {
  return defaultPullMsgReqArgsInstance;
}
- (PullMsgReqArgs*) defaultInstance {
  return defaultPullMsgReqArgsInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasCount) {
    [output writeInt32:1 value:self.count];
  }
  if (self.hasSyncId) {
    [output writeInt64:2 value:self.syncId];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasCount) {
    size_ += computeInt32Size(1, self.count);
  }
  if (self.hasSyncId) {
    size_ += computeInt64Size(2, self.syncId);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (PullMsgReqArgs*) parseFromData:(NSData*) data {
  return (PullMsgReqArgs*)[[[PullMsgReqArgs builder] mergeFromData:data] build];
}
+ (PullMsgReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PullMsgReqArgs*)[[[PullMsgReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (PullMsgReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (PullMsgReqArgs*)[[[PullMsgReqArgs builder] mergeFromInputStream:input] build];
}
+ (PullMsgReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PullMsgReqArgs*)[[[PullMsgReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PullMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (PullMsgReqArgs*)[[[PullMsgReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (PullMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PullMsgReqArgs*)[[[PullMsgReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PullMsgReqArgs_Builder*) builder {
  return [[[PullMsgReqArgs_Builder alloc] init] autorelease];
}
+ (PullMsgReqArgs_Builder*) builderWithPrototype:(PullMsgReqArgs*) prototype {
  return [[PullMsgReqArgs builder] mergeFrom:prototype];
}
- (PullMsgReqArgs_Builder*) builder {
  return [PullMsgReqArgs builder];
}
- (PullMsgReqArgs_Builder*) toBuilder {
  return [PullMsgReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasCount) {
    [output appendFormat:@"%@%@: %@\n", indent, @"count", [NSNumber numberWithInt:self.count]];
  }
  if (self.hasSyncId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"syncId", [NSNumber numberWithLongLong:self.syncId]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[PullMsgReqArgs class]]) {
    return NO;
  }
  PullMsgReqArgs *otherMessage = other;
  return
      self.hasCount == otherMessage.hasCount &&
      (!self.hasCount || self.count == otherMessage.count) &&
      self.hasSyncId == otherMessage.hasSyncId &&
      (!self.hasSyncId || self.syncId == otherMessage.syncId) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasCount) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.count] hash];
  }
  if (self.hasSyncId) {
    hashCode = hashCode * 31 + [[NSNumber numberWithLongLong:self.syncId] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface PullMsgReqArgs_Builder()
@property (retain) PullMsgReqArgs* result;
@end

@implementation PullMsgReqArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[PullMsgReqArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (PullMsgReqArgs_Builder*) clear {
  self.result = [[[PullMsgReqArgs alloc] init] autorelease];
  return self;
}
- (PullMsgReqArgs_Builder*) clone {
  return [PullMsgReqArgs builderWithPrototype:result];
}
- (PullMsgReqArgs*) defaultInstance {
  return [PullMsgReqArgs defaultInstance];
}
- (PullMsgReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (PullMsgReqArgs*) buildPartial {
  PullMsgReqArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (PullMsgReqArgs_Builder*) mergeFrom:(PullMsgReqArgs*) other {
  if (other == [PullMsgReqArgs defaultInstance]) {
    return self;
  }
  if (other.hasCount) {
    [self setCount:other.count];
  }
  if (other.hasSyncId) {
    [self setSyncId:other.syncId];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (PullMsgReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (PullMsgReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setCount:[input readInt32]];
        break;
      }
      case 16: {
        [self setSyncId:[input readInt64]];
        break;
      }
    }
  }
}
- (BOOL) hasCount {
  return result.hasCount;
}
- (int32_t) count {
  return result.count;
}
- (PullMsgReqArgs_Builder*) setCount:(int32_t) value {
  result.hasCount = YES;
  result.count = value;
  return self;
}
- (PullMsgReqArgs_Builder*) clearCount {
  result.hasCount = NO;
  result.count = 0;
  return self;
}
- (BOOL) hasSyncId {
  return result.hasSyncId;
}
- (int64_t) syncId {
  return result.syncId;
}
- (PullMsgReqArgs_Builder*) setSyncId:(int64_t) value {
  result.hasSyncId = YES;
  result.syncId = value;
  return self;
}
- (PullMsgReqArgs_Builder*) clearSyncId {
  result.hasSyncId = NO;
  result.syncId = 0L;
  return self;
}
@end

