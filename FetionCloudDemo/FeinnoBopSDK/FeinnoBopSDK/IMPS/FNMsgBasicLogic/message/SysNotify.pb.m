// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "SysNotify.pb.h"

@implementation SysNotifyRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [SysNotifyRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface SysNotify ()
@property int64_t msgId;
@property int32_t msgType;
@property (retain) NSString* msgBody;
@property (retain) NSString* title;
@property (retain) NSString* sendDate;
@end

@implementation SysNotify

- (BOOL) hasMsgId {
  return !!hasMsgId_;
}
- (void) setHasMsgId:(BOOL) value_ {
  hasMsgId_ = !!value_;
}
@synthesize msgId;
- (BOOL) hasMsgType {
  return !!hasMsgType_;
}
- (void) setHasMsgType:(BOOL) value_ {
  hasMsgType_ = !!value_;
}
@synthesize msgType;
- (BOOL) hasMsgBody {
  return !!hasMsgBody_;
}
- (void) setHasMsgBody:(BOOL) value_ {
  hasMsgBody_ = !!value_;
}
@synthesize msgBody;
- (BOOL) hasTitle {
  return !!hasTitle_;
}
- (void) setHasTitle:(BOOL) value_ {
  hasTitle_ = !!value_;
}
@synthesize title;
- (BOOL) hasSendDate {
  return !!hasSendDate_;
}
- (void) setHasSendDate:(BOOL) value_ {
  hasSendDate_ = !!value_;
}
@synthesize sendDate;
- (void) dealloc {
  self.msgBody = nil;
  self.title = nil;
  self.sendDate = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.msgId = 0L;
    self.msgType = 0;
    self.msgBody = @"";
    self.title = @"";
    self.sendDate = @"";
  }
  return self;
}
static SysNotify* defaultSysNotifyInstance = nil;
+ (void) initialize {
  if (self == [SysNotify class]) {
    defaultSysNotifyInstance = [[SysNotify alloc] init];
  }
}
+ (SysNotify*) defaultInstance {
  return defaultSysNotifyInstance;
}
- (SysNotify*) defaultInstance {
  return defaultSysNotifyInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasMsgId) {
    [output writeInt64:1 value:self.msgId];
  }
  if (self.hasMsgType) {
    [output writeInt32:2 value:self.msgType];
  }
  if (self.hasMsgBody) {
    [output writeString:3 value:self.msgBody];
  }
  if (self.hasTitle) {
    [output writeString:4 value:self.title];
  }
  if (self.hasSendDate) {
    [output writeString:5 value:self.sendDate];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasMsgId) {
    size_ += computeInt64Size(1, self.msgId);
  }
  if (self.hasMsgType) {
    size_ += computeInt32Size(2, self.msgType);
  }
  if (self.hasMsgBody) {
    size_ += computeStringSize(3, self.msgBody);
  }
  if (self.hasTitle) {
    size_ += computeStringSize(4, self.title);
  }
  if (self.hasSendDate) {
    size_ += computeStringSize(5, self.sendDate);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (SysNotify*) parseFromData:(NSData*) data {
  return (SysNotify*)[[[SysNotify builder] mergeFromData:data] build];
}
+ (SysNotify*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SysNotify*)[[[SysNotify builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (SysNotify*) parseFromInputStream:(NSInputStream*) input {
  return (SysNotify*)[[[SysNotify builder] mergeFromInputStream:input] build];
}
+ (SysNotify*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SysNotify*)[[[SysNotify builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SysNotify*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (SysNotify*)[[[SysNotify builder] mergeFromCodedInputStream:input] build];
}
+ (SysNotify*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SysNotify*)[[[SysNotify builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SysNotify_Builder*) builder {
  return [[[SysNotify_Builder alloc] init] autorelease];
}
+ (SysNotify_Builder*) builderWithPrototype:(SysNotify*) prototype {
  return [[SysNotify builder] mergeFrom:prototype];
}
- (SysNotify_Builder*) builder {
  return [SysNotify builder];
}
- (SysNotify_Builder*) toBuilder {
  return [SysNotify builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasMsgId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"msgId", [NSNumber numberWithLongLong:self.msgId]];
  }
  if (self.hasMsgType) {
    [output appendFormat:@"%@%@: %@\n", indent, @"msgType", [NSNumber numberWithInt:self.msgType]];
  }
  if (self.hasMsgBody) {
    [output appendFormat:@"%@%@: %@\n", indent, @"msgBody", self.msgBody];
  }
  if (self.hasTitle) {
    [output appendFormat:@"%@%@: %@\n", indent, @"title", self.title];
  }
  if (self.hasSendDate) {
    [output appendFormat:@"%@%@: %@\n", indent, @"sendDate", self.sendDate];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[SysNotify class]]) {
    return NO;
  }
  SysNotify *otherMessage = other;
  return
      self.hasMsgId == otherMessage.hasMsgId &&
      (!self.hasMsgId || self.msgId == otherMessage.msgId) &&
      self.hasMsgType == otherMessage.hasMsgType &&
      (!self.hasMsgType || self.msgType == otherMessage.msgType) &&
      self.hasMsgBody == otherMessage.hasMsgBody &&
      (!self.hasMsgBody || [self.msgBody isEqual:otherMessage.msgBody]) &&
      self.hasTitle == otherMessage.hasTitle &&
      (!self.hasTitle || [self.title isEqual:otherMessage.title]) &&
      self.hasSendDate == otherMessage.hasSendDate &&
      (!self.hasSendDate || [self.sendDate isEqual:otherMessage.sendDate]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasMsgId) {
    hashCode = hashCode * 31 + [[NSNumber numberWithLongLong:self.msgId] hash];
  }
  if (self.hasMsgType) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.msgType] hash];
  }
  if (self.hasMsgBody) {
    hashCode = hashCode * 31 + [self.msgBody hash];
  }
  if (self.hasTitle) {
    hashCode = hashCode * 31 + [self.title hash];
  }
  if (self.hasSendDate) {
    hashCode = hashCode * 31 + [self.sendDate hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface SysNotify_Builder()
@property (retain) SysNotify* result;
@end

@implementation SysNotify_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[SysNotify alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (SysNotify_Builder*) clear {
  self.result = [[[SysNotify alloc] init] autorelease];
  return self;
}
- (SysNotify_Builder*) clone {
  return [SysNotify builderWithPrototype:result];
}
- (SysNotify*) defaultInstance {
  return [SysNotify defaultInstance];
}
- (SysNotify*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (SysNotify*) buildPartial {
  SysNotify* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (SysNotify_Builder*) mergeFrom:(SysNotify*) other {
  if (other == [SysNotify defaultInstance]) {
    return self;
  }
  if (other.hasMsgId) {
    [self setMsgId:other.msgId];
  }
  if (other.hasMsgType) {
    [self setMsgType:other.msgType];
  }
  if (other.hasMsgBody) {
    [self setMsgBody:other.msgBody];
  }
  if (other.hasTitle) {
    [self setTitle:other.title];
  }
  if (other.hasSendDate) {
    [self setSendDate:other.sendDate];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (SysNotify_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (SysNotify_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setMsgId:[input readInt64]];
        break;
      }
      case 16: {
        [self setMsgType:[input readInt32]];
        break;
      }
      case 26: {
        [self setMsgBody:[input readString]];
        break;
      }
      case 34: {
        [self setTitle:[input readString]];
        break;
      }
      case 42: {
        [self setSendDate:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasMsgId {
  return result.hasMsgId;
}
- (int64_t) msgId {
  return result.msgId;
}
- (SysNotify_Builder*) setMsgId:(int64_t) value {
  result.hasMsgId = YES;
  result.msgId = value;
  return self;
}
- (SysNotify_Builder*) clearMsgId {
  result.hasMsgId = NO;
  result.msgId = 0L;
  return self;
}
- (BOOL) hasMsgType {
  return result.hasMsgType;
}
- (int32_t) msgType {
  return result.msgType;
}
- (SysNotify_Builder*) setMsgType:(int32_t) value {
  result.hasMsgType = YES;
  result.msgType = value;
  return self;
}
- (SysNotify_Builder*) clearMsgType {
  result.hasMsgType = NO;
  result.msgType = 0;
  return self;
}
- (BOOL) hasMsgBody {
  return result.hasMsgBody;
}
- (NSString*) msgBody {
  return result.msgBody;
}
- (SysNotify_Builder*) setMsgBody:(NSString*) value {
  result.hasMsgBody = YES;
  result.msgBody = value;
  return self;
}
- (SysNotify_Builder*) clearMsgBody {
  result.hasMsgBody = NO;
  result.msgBody = @"";
  return self;
}
- (BOOL) hasTitle {
  return result.hasTitle;
}
- (NSString*) title {
  return result.title;
}
- (SysNotify_Builder*) setTitle:(NSString*) value {
  result.hasTitle = YES;
  result.title = value;
  return self;
}
- (SysNotify_Builder*) clearTitle {
  result.hasTitle = NO;
  result.title = @"";
  return self;
}
- (BOOL) hasSendDate {
  return result.hasSendDate;
}
- (NSString*) sendDate {
  return result.sendDate;
}
- (SysNotify_Builder*) setSendDate:(NSString*) value {
  result.hasSendDate = YES;
  result.sendDate = value;
  return self;
}
- (SysNotify_Builder*) clearSendDate {
  result.hasSendDate = NO;
  result.sendDate = @"";
  return self;
}
@end

