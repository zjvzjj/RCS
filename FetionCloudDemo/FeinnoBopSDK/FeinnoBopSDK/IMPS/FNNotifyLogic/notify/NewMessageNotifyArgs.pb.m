// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "NewMessageNotifyArgs.pb.h"

@implementation NewMessageNotifyArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [NewMessageNotifyArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface NewMessageNotifyArgs ()
@property (retain) NSString* bopId;
@property (retain) NSString* event;
@property int32_t msgType;
@end

@implementation NewMessageNotifyArgs

- (BOOL) hasBopId {
  return !!hasBopId_;
}
- (void) setHasBopId:(BOOL) value_ {
  hasBopId_ = !!value_;
}
@synthesize bopId;
- (BOOL) hasEvent {
  return !!hasEvent_;
}
- (void) setHasEvent:(BOOL) value_ {
  hasEvent_ = !!value_;
}
@synthesize event;
- (BOOL) hasMsgType {
  return !!hasMsgType_;
}
- (void) setHasMsgType:(BOOL) value_ {
  hasMsgType_ = !!value_;
}
@synthesize msgType;
- (void) dealloc {
  self.bopId = nil;
  self.event = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.bopId = @"";
    self.event = @"";
    self.msgType = 0;
  }
  return self;
}
static NewMessageNotifyArgs* defaultNewMessageNotifyArgsInstance = nil;
+ (void) initialize {
  if (self == [NewMessageNotifyArgs class]) {
    defaultNewMessageNotifyArgsInstance = [[NewMessageNotifyArgs alloc] init];
  }
}
+ (NewMessageNotifyArgs*) defaultInstance {
  return defaultNewMessageNotifyArgsInstance;
}
- (NewMessageNotifyArgs*) defaultInstance {
  return defaultNewMessageNotifyArgsInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasBopId) {
    [output writeString:1 value:self.bopId];
  }
  if (self.hasEvent) {
    [output writeString:2 value:self.event];
  }
  if (self.hasMsgType) {
    [output writeInt32:3 value:self.msgType];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasBopId) {
    size_ += computeStringSize(1, self.bopId);
  }
  if (self.hasEvent) {
    size_ += computeStringSize(2, self.event);
  }
  if (self.hasMsgType) {
    size_ += computeInt32Size(3, self.msgType);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (NewMessageNotifyArgs*) parseFromData:(NSData*) data {
  return (NewMessageNotifyArgs*)[[[NewMessageNotifyArgs builder] mergeFromData:data] build];
}
+ (NewMessageNotifyArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (NewMessageNotifyArgs*)[[[NewMessageNotifyArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (NewMessageNotifyArgs*) parseFromInputStream:(NSInputStream*) input {
  return (NewMessageNotifyArgs*)[[[NewMessageNotifyArgs builder] mergeFromInputStream:input] build];
}
+ (NewMessageNotifyArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (NewMessageNotifyArgs*)[[[NewMessageNotifyArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (NewMessageNotifyArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (NewMessageNotifyArgs*)[[[NewMessageNotifyArgs builder] mergeFromCodedInputStream:input] build];
}
+ (NewMessageNotifyArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (NewMessageNotifyArgs*)[[[NewMessageNotifyArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (NewMessageNotifyArgs_Builder*) builder {
  return [[[NewMessageNotifyArgs_Builder alloc] init] autorelease];
}
+ (NewMessageNotifyArgs_Builder*) builderWithPrototype:(NewMessageNotifyArgs*) prototype {
  return [[NewMessageNotifyArgs builder] mergeFrom:prototype];
}
- (NewMessageNotifyArgs_Builder*) builder {
  return [NewMessageNotifyArgs builder];
}
- (NewMessageNotifyArgs_Builder*) toBuilder {
  return [NewMessageNotifyArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasBopId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"bopId", self.bopId];
  }
  if (self.hasEvent) {
    [output appendFormat:@"%@%@: %@\n", indent, @"event", self.event];
  }
  if (self.hasMsgType) {
    [output appendFormat:@"%@%@: %@\n", indent, @"msgType", [NSNumber numberWithInt:self.msgType]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[NewMessageNotifyArgs class]]) {
    return NO;
  }
  NewMessageNotifyArgs *otherMessage = other;
  return
      self.hasBopId == otherMessage.hasBopId &&
      (!self.hasBopId || [self.bopId isEqual:otherMessage.bopId]) &&
      self.hasEvent == otherMessage.hasEvent &&
      (!self.hasEvent || [self.event isEqual:otherMessage.event]) &&
      self.hasMsgType == otherMessage.hasMsgType &&
      (!self.hasMsgType || self.msgType == otherMessage.msgType) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasBopId) {
    hashCode = hashCode * 31 + [self.bopId hash];
  }
  if (self.hasEvent) {
    hashCode = hashCode * 31 + [self.event hash];
  }
  if (self.hasMsgType) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.msgType] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface NewMessageNotifyArgs_Builder()
@property (retain) NewMessageNotifyArgs* result;
@end

@implementation NewMessageNotifyArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[NewMessageNotifyArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (NewMessageNotifyArgs_Builder*) clear {
  self.result = [[[NewMessageNotifyArgs alloc] init] autorelease];
  return self;
}
- (NewMessageNotifyArgs_Builder*) clone {
  return [NewMessageNotifyArgs builderWithPrototype:result];
}
- (NewMessageNotifyArgs*) defaultInstance {
  return [NewMessageNotifyArgs defaultInstance];
}
- (NewMessageNotifyArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (NewMessageNotifyArgs*) buildPartial {
  NewMessageNotifyArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (NewMessageNotifyArgs_Builder*) mergeFrom:(NewMessageNotifyArgs*) other {
  if (other == [NewMessageNotifyArgs defaultInstance]) {
    return self;
  }
  if (other.hasBopId) {
    [self setBopId:other.bopId];
  }
  if (other.hasEvent) {
    [self setEvent:other.event];
  }
  if (other.hasMsgType) {
    [self setMsgType:other.msgType];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (NewMessageNotifyArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (NewMessageNotifyArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setBopId:[input readString]];
        break;
      }
      case 18: {
        [self setEvent:[input readString]];
        break;
      }
      case 24: {
        [self setMsgType:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasBopId {
  return result.hasBopId;
}
- (NSString*) bopId {
  return result.bopId;
}
- (NewMessageNotifyArgs_Builder*) setBopId:(NSString*) value {
  result.hasBopId = YES;
  result.bopId = value;
  return self;
}
- (NewMessageNotifyArgs_Builder*) clearBopId {
  result.hasBopId = NO;
  result.bopId = @"";
  return self;
}
- (BOOL) hasEvent {
  return result.hasEvent;
}
- (NSString*) event {
  return result.event;
}
- (NewMessageNotifyArgs_Builder*) setEvent:(NSString*) value {
  result.hasEvent = YES;
  result.event = value;
  return self;
}
- (NewMessageNotifyArgs_Builder*) clearEvent {
  result.hasEvent = NO;
  result.event = @"";
  return self;
}
- (BOOL) hasMsgType {
  return result.hasMsgType;
}
- (int32_t) msgType {
  return result.msgType;
}
- (NewMessageNotifyArgs_Builder*) setMsgType:(int32_t) value {
  result.hasMsgType = YES;
  result.msgType = value;
  return self;
}
- (NewMessageNotifyArgs_Builder*) clearMsgType {
  result.hasMsgType = NO;
  result.msgType = 0;
  return self;
}
@end

