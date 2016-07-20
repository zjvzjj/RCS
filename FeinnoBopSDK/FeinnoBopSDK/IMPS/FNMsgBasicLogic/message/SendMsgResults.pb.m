// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "SendMsgResults.pb.h"

@implementation SendMsgResultsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [SendMsgResultsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface SendMsgResults ()
@property int32_t statusCode;
@property (retain) NSString* reason;
@property (retain) NSString* msgId;
@property (retain) NSString* sendTime;
@property int64_t syncId;
@end

@implementation SendMsgResults

- (BOOL) hasStatusCode {
  return !!hasStatusCode_;
}
- (void) setHasStatusCode:(BOOL) value_ {
  hasStatusCode_ = !!value_;
}
@synthesize statusCode;
- (BOOL) hasReason {
  return !!hasReason_;
}
- (void) setHasReason:(BOOL) value_ {
  hasReason_ = !!value_;
}
@synthesize reason;
- (BOOL) hasMsgId {
  return !!hasMsgId_;
}
- (void) setHasMsgId:(BOOL) value_ {
  hasMsgId_ = !!value_;
}
@synthesize msgId;
- (BOOL) hasSendTime {
  return !!hasSendTime_;
}
- (void) setHasSendTime:(BOOL) value_ {
  hasSendTime_ = !!value_;
}
@synthesize sendTime;
- (BOOL) hasSyncId {
  return !!hasSyncId_;
}
- (void) setHasSyncId:(BOOL) value_ {
  hasSyncId_ = !!value_;
}
@synthesize syncId;
- (void) dealloc {
  self.reason = nil;
  self.msgId = nil;
  self.sendTime = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.statusCode = 0;
    self.reason = @"";
    self.msgId = @"";
    self.sendTime = @"";
    self.syncId = 0L;
  }
  return self;
}
static SendMsgResults* defaultSendMsgResultsInstance = nil;
+ (void) initialize {
  if (self == [SendMsgResults class]) {
    defaultSendMsgResultsInstance = [[SendMsgResults alloc] init];
  }
}
+ (SendMsgResults*) defaultInstance {
  return defaultSendMsgResultsInstance;
}
- (SendMsgResults*) defaultInstance {
  return defaultSendMsgResultsInstance;
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
  if (self.hasReason) {
    [output writeString:2 value:self.reason];
  }
  if (self.hasMsgId) {
    [output writeString:3 value:self.msgId];
  }
  if (self.hasSendTime) {
    [output writeString:4 value:self.sendTime];
  }
  if (self.hasSyncId) {
    [output writeInt64:5 value:self.syncId];
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
  if (self.hasReason) {
    size_ += computeStringSize(2, self.reason);
  }
  if (self.hasMsgId) {
    size_ += computeStringSize(3, self.msgId);
  }
  if (self.hasSendTime) {
    size_ += computeStringSize(4, self.sendTime);
  }
  if (self.hasSyncId) {
    size_ += computeInt64Size(5, self.syncId);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (SendMsgResults*) parseFromData:(NSData*) data {
  return (SendMsgResults*)[[[SendMsgResults builder] mergeFromData:data] build];
}
+ (SendMsgResults*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMsgResults*)[[[SendMsgResults builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (SendMsgResults*) parseFromInputStream:(NSInputStream*) input {
  return (SendMsgResults*)[[[SendMsgResults builder] mergeFromInputStream:input] build];
}
+ (SendMsgResults*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMsgResults*)[[[SendMsgResults builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendMsgResults*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (SendMsgResults*)[[[SendMsgResults builder] mergeFromCodedInputStream:input] build];
}
+ (SendMsgResults*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMsgResults*)[[[SendMsgResults builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendMsgResults_Builder*) builder {
  return [[[SendMsgResults_Builder alloc] init] autorelease];
}
+ (SendMsgResults_Builder*) builderWithPrototype:(SendMsgResults*) prototype {
  return [[SendMsgResults builder] mergeFrom:prototype];
}
- (SendMsgResults_Builder*) builder {
  return [SendMsgResults builder];
}
- (SendMsgResults_Builder*) toBuilder {
  return [SendMsgResults builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasStatusCode) {
    [output appendFormat:@"%@%@: %@\n", indent, @"statusCode", [NSNumber numberWithInt:self.statusCode]];
  }
  if (self.hasReason) {
    [output appendFormat:@"%@%@: %@\n", indent, @"reason", self.reason];
  }
  if (self.hasMsgId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"msgId", self.msgId];
  }
  if (self.hasSendTime) {
    [output appendFormat:@"%@%@: %@\n", indent, @"sendTime", self.sendTime];
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
  if (![other isKindOfClass:[SendMsgResults class]]) {
    return NO;
  }
  SendMsgResults *otherMessage = other;
  return
      self.hasStatusCode == otherMessage.hasStatusCode &&
      (!self.hasStatusCode || self.statusCode == otherMessage.statusCode) &&
      self.hasReason == otherMessage.hasReason &&
      (!self.hasReason || [self.reason isEqual:otherMessage.reason]) &&
      self.hasMsgId == otherMessage.hasMsgId &&
      (!self.hasMsgId || [self.msgId isEqual:otherMessage.msgId]) &&
      self.hasSendTime == otherMessage.hasSendTime &&
      (!self.hasSendTime || [self.sendTime isEqual:otherMessage.sendTime]) &&
      self.hasSyncId == otherMessage.hasSyncId &&
      (!self.hasSyncId || self.syncId == otherMessage.syncId) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasStatusCode) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.statusCode] hash];
  }
  if (self.hasReason) {
    hashCode = hashCode * 31 + [self.reason hash];
  }
  if (self.hasMsgId) {
    hashCode = hashCode * 31 + [self.msgId hash];
  }
  if (self.hasSendTime) {
    hashCode = hashCode * 31 + [self.sendTime hash];
  }
  if (self.hasSyncId) {
    hashCode = hashCode * 31 + [[NSNumber numberWithLongLong:self.syncId] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface SendMsgResults_Builder()
@property (retain) SendMsgResults* result;
@end

@implementation SendMsgResults_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[SendMsgResults alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (SendMsgResults_Builder*) clear {
  self.result = [[[SendMsgResults alloc] init] autorelease];
  return self;
}
- (SendMsgResults_Builder*) clone {
  return [SendMsgResults builderWithPrototype:result];
}
- (SendMsgResults*) defaultInstance {
  return [SendMsgResults defaultInstance];
}
- (SendMsgResults*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (SendMsgResults*) buildPartial {
  SendMsgResults* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (SendMsgResults_Builder*) mergeFrom:(SendMsgResults*) other {
  if (other == [SendMsgResults defaultInstance]) {
    return self;
  }
  if (other.hasStatusCode) {
    [self setStatusCode:other.statusCode];
  }
  if (other.hasReason) {
    [self setReason:other.reason];
  }
  if (other.hasMsgId) {
    [self setMsgId:other.msgId];
  }
  if (other.hasSendTime) {
    [self setSendTime:other.sendTime];
  }
  if (other.hasSyncId) {
    [self setSyncId:other.syncId];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (SendMsgResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (SendMsgResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
      case 18: {
        [self setReason:[input readString]];
        break;
      }
      case 26: {
        [self setMsgId:[input readString]];
        break;
      }
      case 34: {
        [self setSendTime:[input readString]];
        break;
      }
      case 40: {
        [self setSyncId:[input readInt64]];
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
- (SendMsgResults_Builder*) setStatusCode:(int32_t) value {
  result.hasStatusCode = YES;
  result.statusCode = value;
  return self;
}
- (SendMsgResults_Builder*) clearStatusCode {
  result.hasStatusCode = NO;
  result.statusCode = 0;
  return self;
}
- (BOOL) hasReason {
  return result.hasReason;
}
- (NSString*) reason {
  return result.reason;
}
- (SendMsgResults_Builder*) setReason:(NSString*) value {
  result.hasReason = YES;
  result.reason = value;
  return self;
}
- (SendMsgResults_Builder*) clearReason {
  result.hasReason = NO;
  result.reason = @"";
  return self;
}
- (BOOL) hasMsgId {
  return result.hasMsgId;
}
- (NSString*) msgId {
  return result.msgId;
}
- (SendMsgResults_Builder*) setMsgId:(NSString*) value {
  result.hasMsgId = YES;
  result.msgId = value;
  return self;
}
- (SendMsgResults_Builder*) clearMsgId {
  result.hasMsgId = NO;
  result.msgId = @"";
  return self;
}
- (BOOL) hasSendTime {
  return result.hasSendTime;
}
- (NSString*) sendTime {
  return result.sendTime;
}
- (SendMsgResults_Builder*) setSendTime:(NSString*) value {
  result.hasSendTime = YES;
  result.sendTime = value;
  return self;
}
- (SendMsgResults_Builder*) clearSendTime {
  result.hasSendTime = NO;
  result.sendTime = @"";
  return self;
}
- (BOOL) hasSyncId {
  return result.hasSyncId;
}
- (int64_t) syncId {
  return result.syncId;
}
- (SendMsgResults_Builder*) setSyncId:(int64_t) value {
  result.hasSyncId = YES;
  result.syncId = value;
  return self;
}
- (SendMsgResults_Builder*) clearSyncId {
  result.hasSyncId = NO;
  result.syncId = 0L;
  return self;
}
@end
