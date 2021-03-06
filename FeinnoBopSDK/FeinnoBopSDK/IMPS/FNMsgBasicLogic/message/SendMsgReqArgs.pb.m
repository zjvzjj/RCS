// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "SendMsgReqArgs.pb.h"
// @@protoc_insertion_point(imports)

@implementation SendMsgReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [SendMsgReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = registry;
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface SendMsgReqArgs ()
@property (strong) NSString* fromBopId;
@property (strong) NSString* toUserId;
@property (strong) SendMsgReqArgsMsgEntity* msg;
@property (strong) NSString* sendDate;
@property SInt32 sendClientType;
@property (strong) NSString* sendClientPortraitUrl;
@end

@implementation SendMsgReqArgs

- (BOOL) hasFromBopId {
  return !!hasFromBopId_;
}
- (void) setHasFromBopId:(BOOL) _value_ {
  hasFromBopId_ = !!_value_;
}
@synthesize fromBopId;
- (BOOL) hasToUserId {
  return !!hasToUserId_;
}
- (void) setHasToUserId:(BOOL) _value_ {
  hasToUserId_ = !!_value_;
}
@synthesize toUserId;
- (BOOL) hasMsg {
  return !!hasMsg_;
}
- (void) setHasMsg:(BOOL) _value_ {
  hasMsg_ = !!_value_;
}
@synthesize msg;
- (BOOL) hasSendDate {
  return !!hasSendDate_;
}
- (void) setHasSendDate:(BOOL) _value_ {
  hasSendDate_ = !!_value_;
}
@synthesize sendDate;
- (BOOL) hasSendClientType {
  return !!hasSendClientType_;
}
- (void) setHasSendClientType:(BOOL) _value_ {
  hasSendClientType_ = !!_value_;
}
@synthesize sendClientType;
- (BOOL) hasSendClientPortraitUrl {
  return !!hasSendClientPortraitUrl_;
}
- (void) setHasSendClientPortraitUrl:(BOOL) _value_ {
  hasSendClientPortraitUrl_ = !!_value_;
}
@synthesize sendClientPortraitUrl;
- (instancetype) init {
  if ((self = [super init])) {
    self.fromBopId = @"";
    self.toUserId = @"";
    self.msg = [SendMsgReqArgsMsgEntity defaultInstance];
    self.sendDate = @"";
    self.sendClientType = 0;
    self.sendClientPortraitUrl = @"";
  }
  return self;
}
static SendMsgReqArgs* defaultSendMsgReqArgsInstance = nil;
+ (void) initialize {
  if (self == [SendMsgReqArgs class]) {
    defaultSendMsgReqArgsInstance = [[SendMsgReqArgs alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultSendMsgReqArgsInstance;
}
- (instancetype) defaultInstance {
  return defaultSendMsgReqArgsInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasFromBopId) {
    [output writeString:1 value:self.fromBopId];
  }
  if (self.hasToUserId) {
    [output writeString:2 value:self.toUserId];
  }
  if (self.hasMsg) {
    [output writeMessage:3 value:self.msg];
  }
  if (self.hasSendDate) {
    [output writeString:4 value:self.sendDate];
  }
  if (self.hasSendClientType) {
    [output writeInt32:5 value:self.sendClientType];
  }
  if (self.hasSendClientPortraitUrl) {
    [output writeString:6 value:self.sendClientPortraitUrl];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (SInt32) serializedSize {
  __block SInt32 size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasFromBopId) {
    size_ += computeStringSize(1, self.fromBopId);
  }
  if (self.hasToUserId) {
    size_ += computeStringSize(2, self.toUserId);
  }
  if (self.hasMsg) {
    size_ += computeMessageSize(3, self.msg);
  }
  if (self.hasSendDate) {
    size_ += computeStringSize(4, self.sendDate);
  }
  if (self.hasSendClientType) {
    size_ += computeInt32Size(5, self.sendClientType);
  }
  if (self.hasSendClientPortraitUrl) {
    size_ += computeStringSize(6, self.sendClientPortraitUrl);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (SendMsgReqArgs*) parseFromData:(NSData*) data {
  return (SendMsgReqArgs*)[[[SendMsgReqArgs builder] mergeFromData:data] build];
}
+ (SendMsgReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMsgReqArgs*)[[[SendMsgReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (SendMsgReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (SendMsgReqArgs*)[[[SendMsgReqArgs builder] mergeFromInputStream:input] build];
}
+ (SendMsgReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMsgReqArgs*)[[[SendMsgReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (SendMsgReqArgs*)[[[SendMsgReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (SendMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMsgReqArgs*)[[[SendMsgReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendMsgReqArgsBuilder*) builder {
  return [[SendMsgReqArgsBuilder alloc] init];
}
+ (SendMsgReqArgsBuilder*) builderWithPrototype:(SendMsgReqArgs*) prototype {
  return [[SendMsgReqArgs builder] mergeFrom:prototype];
}
- (SendMsgReqArgsBuilder*) builder {
  return [SendMsgReqArgs builder];
}
- (SendMsgReqArgsBuilder*) toBuilder {
  return [SendMsgReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasFromBopId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"fromBopId", self.fromBopId];
  }
  if (self.hasToUserId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"toUserId", self.toUserId];
  }
  if (self.hasMsg) {
    [output appendFormat:@"%@%@ {\n", indent, @"msg"];
    [self.msg writeDescriptionTo:output
                         withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
  }
  if (self.hasSendDate) {
    [output appendFormat:@"%@%@: %@\n", indent, @"sendDate", self.sendDate];
  }
  if (self.hasSendClientType) {
    [output appendFormat:@"%@%@: %@\n", indent, @"sendClientType", [NSNumber numberWithInteger:self.sendClientType]];
  }
  if (self.hasSendClientPortraitUrl) {
    [output appendFormat:@"%@%@: %@\n", indent, @"sendClientPortraitUrl", self.sendClientPortraitUrl];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[SendMsgReqArgs class]]) {
    return NO;
  }
  SendMsgReqArgs *otherMessage = other;
  return
      self.hasFromBopId == otherMessage.hasFromBopId &&
      (!self.hasFromBopId || [self.fromBopId isEqual:otherMessage.fromBopId]) &&
      self.hasToUserId == otherMessage.hasToUserId &&
      (!self.hasToUserId || [self.toUserId isEqual:otherMessage.toUserId]) &&
      self.hasMsg == otherMessage.hasMsg &&
      (!self.hasMsg || [self.msg isEqual:otherMessage.msg]) &&
      self.hasSendDate == otherMessage.hasSendDate &&
      (!self.hasSendDate || [self.sendDate isEqual:otherMessage.sendDate]) &&
      self.hasSendClientType == otherMessage.hasSendClientType &&
      (!self.hasSendClientType || self.sendClientType == otherMessage.sendClientType) &&
      self.hasSendClientPortraitUrl == otherMessage.hasSendClientPortraitUrl &&
      (!self.hasSendClientPortraitUrl || [self.sendClientPortraitUrl isEqual:otherMessage.sendClientPortraitUrl]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasFromBopId) {
    hashCode = hashCode * 31 + [self.fromBopId hash];
  }
  if (self.hasToUserId) {
    hashCode = hashCode * 31 + [self.toUserId hash];
  }
  if (self.hasMsg) {
    hashCode = hashCode * 31 + [self.msg hash];
  }
  if (self.hasSendDate) {
    hashCode = hashCode * 31 + [self.sendDate hash];
  }
  if (self.hasSendClientType) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInteger:self.sendClientType] hash];
  }
  if (self.hasSendClientPortraitUrl) {
    hashCode = hashCode * 31 + [self.sendClientPortraitUrl hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface SendMsgReqArgsMsgEntity ()
@property (strong) NSString* msgId;
@property SInt64 syncId;
@property (strong) NSString* msgType;
@property (strong) NSString* msgAttribute;
@property (strong) NSString* msgContent;
@property (strong) NSString* senderNickname;
@property (strong) NSString* senderId;
@property (strong) NSData* extend;
@property (strong) NSString* pushDesc;
@end

@implementation SendMsgReqArgsMsgEntity

- (BOOL) hasMsgId {
  return !!hasMsgId_;
}
- (void) setHasMsgId:(BOOL) _value_ {
  hasMsgId_ = !!_value_;
}
@synthesize msgId;
- (BOOL) hasSyncId {
  return !!hasSyncId_;
}
- (void) setHasSyncId:(BOOL) _value_ {
  hasSyncId_ = !!_value_;
}
@synthesize syncId;
- (BOOL) hasMsgType {
  return !!hasMsgType_;
}
- (void) setHasMsgType:(BOOL) _value_ {
  hasMsgType_ = !!_value_;
}
@synthesize msgType;
- (BOOL) hasMsgAttribute {
  return !!hasMsgAttribute_;
}
- (void) setHasMsgAttribute:(BOOL) _value_ {
  hasMsgAttribute_ = !!_value_;
}
@synthesize msgAttribute;
- (BOOL) hasMsgContent {
  return !!hasMsgContent_;
}
- (void) setHasMsgContent:(BOOL) _value_ {
  hasMsgContent_ = !!_value_;
}
@synthesize msgContent;
- (BOOL) hasSenderNickname {
  return !!hasSenderNickname_;
}
- (void) setHasSenderNickname:(BOOL) _value_ {
  hasSenderNickname_ = !!_value_;
}
@synthesize senderNickname;
- (BOOL) hasSenderId {
  return !!hasSenderId_;
}
- (void) setHasSenderId:(BOOL) _value_ {
  hasSenderId_ = !!_value_;
}
@synthesize senderId;
- (BOOL) hasExtend {
  return !!hasExtend_;
}
- (void) setHasExtend:(BOOL) _value_ {
  hasExtend_ = !!_value_;
}
@synthesize extend;
- (BOOL) hasPushDesc {
  return !!hasPushDesc_;
}
- (void) setHasPushDesc:(BOOL) _value_ {
  hasPushDesc_ = !!_value_;
}
@synthesize pushDesc;
- (instancetype) init {
  if ((self = [super init])) {
    self.msgId = @"";
    self.syncId = 0L;
    self.msgType = @"";
    self.msgAttribute = @"";
    self.msgContent = @"";
    self.senderNickname = @"";
    self.senderId = @"";
    self.extend = [NSData data];
    self.pushDesc = @"";
  }
  return self;
}
static SendMsgReqArgsMsgEntity* defaultSendMsgReqArgsMsgEntityInstance = nil;
+ (void) initialize {
  if (self == [SendMsgReqArgsMsgEntity class]) {
    defaultSendMsgReqArgsMsgEntityInstance = [[SendMsgReqArgsMsgEntity alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultSendMsgReqArgsMsgEntityInstance;
}
- (instancetype) defaultInstance {
  return defaultSendMsgReqArgsMsgEntityInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasMsgId) {
    [output writeString:1 value:self.msgId];
  }
  if (self.hasSyncId) {
    [output writeInt64:2 value:self.syncId];
  }
  if (self.hasMsgType) {
    [output writeString:3 value:self.msgType];
  }
  if (self.hasMsgAttribute) {
    [output writeString:4 value:self.msgAttribute];
  }
  if (self.hasMsgContent) {
    [output writeString:5 value:self.msgContent];
  }
  if (self.hasSenderNickname) {
    [output writeString:6 value:self.senderNickname];
  }
  if (self.hasSenderId) {
    [output writeString:7 value:self.senderId];
  }
  if (self.hasExtend) {
    [output writeData:8 value:self.extend];
  }
  if (self.hasPushDesc) {
    [output writeString:9 value:self.pushDesc];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (SInt32) serializedSize {
  __block SInt32 size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasMsgId) {
    size_ += computeStringSize(1, self.msgId);
  }
  if (self.hasSyncId) {
    size_ += computeInt64Size(2, self.syncId);
  }
  if (self.hasMsgType) {
    size_ += computeStringSize(3, self.msgType);
  }
  if (self.hasMsgAttribute) {
    size_ += computeStringSize(4, self.msgAttribute);
  }
  if (self.hasMsgContent) {
    size_ += computeStringSize(5, self.msgContent);
  }
  if (self.hasSenderNickname) {
    size_ += computeStringSize(6, self.senderNickname);
  }
  if (self.hasSenderId) {
    size_ += computeStringSize(7, self.senderId);
  }
  if (self.hasExtend) {
    size_ += computeDataSize(8, self.extend);
  }
  if (self.hasPushDesc) {
    size_ += computeStringSize(9, self.pushDesc);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (SendMsgReqArgsMsgEntity*) parseFromData:(NSData*) data {
  return (SendMsgReqArgsMsgEntity*)[[[SendMsgReqArgsMsgEntity builder] mergeFromData:data] build];
}
+ (SendMsgReqArgsMsgEntity*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMsgReqArgsMsgEntity*)[[[SendMsgReqArgsMsgEntity builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (SendMsgReqArgsMsgEntity*) parseFromInputStream:(NSInputStream*) input {
  return (SendMsgReqArgsMsgEntity*)[[[SendMsgReqArgsMsgEntity builder] mergeFromInputStream:input] build];
}
+ (SendMsgReqArgsMsgEntity*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMsgReqArgsMsgEntity*)[[[SendMsgReqArgsMsgEntity builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendMsgReqArgsMsgEntity*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (SendMsgReqArgsMsgEntity*)[[[SendMsgReqArgsMsgEntity builder] mergeFromCodedInputStream:input] build];
}
+ (SendMsgReqArgsMsgEntity*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMsgReqArgsMsgEntity*)[[[SendMsgReqArgsMsgEntity builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendMsgReqArgsMsgEntityBuilder*) builder {
  return [[SendMsgReqArgsMsgEntityBuilder alloc] init];
}
+ (SendMsgReqArgsMsgEntityBuilder*) builderWithPrototype:(SendMsgReqArgsMsgEntity*) prototype {
  return [[SendMsgReqArgsMsgEntity builder] mergeFrom:prototype];
}
- (SendMsgReqArgsMsgEntityBuilder*) builder {
  return [SendMsgReqArgsMsgEntity builder];
}
- (SendMsgReqArgsMsgEntityBuilder*) toBuilder {
  return [SendMsgReqArgsMsgEntity builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasMsgId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"msgId", self.msgId];
  }
  if (self.hasSyncId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"syncId", [NSNumber numberWithLongLong:self.syncId]];
  }
  if (self.hasMsgType) {
    [output appendFormat:@"%@%@: %@\n", indent, @"msgType", self.msgType];
  }
  if (self.hasMsgAttribute) {
    [output appendFormat:@"%@%@: %@\n", indent, @"msgAttribute", self.msgAttribute];
  }
  if (self.hasMsgContent) {
    [output appendFormat:@"%@%@: %@\n", indent, @"msgContent", self.msgContent];
  }
  if (self.hasSenderNickname) {
    [output appendFormat:@"%@%@: %@\n", indent, @"senderNickname", self.senderNickname];
  }
  if (self.hasSenderId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"senderId", self.senderId];
  }
  if (self.hasExtend) {
    [output appendFormat:@"%@%@: %@\n", indent, @"extend", self.extend];
  }
  if (self.hasPushDesc) {
    [output appendFormat:@"%@%@: %@\n", indent, @"pushDesc", self.pushDesc];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[SendMsgReqArgsMsgEntity class]]) {
    return NO;
  }
  SendMsgReqArgsMsgEntity *otherMessage = other;
  return
      self.hasMsgId == otherMessage.hasMsgId &&
      (!self.hasMsgId || [self.msgId isEqual:otherMessage.msgId]) &&
      self.hasSyncId == otherMessage.hasSyncId &&
      (!self.hasSyncId || self.syncId == otherMessage.syncId) &&
      self.hasMsgType == otherMessage.hasMsgType &&
      (!self.hasMsgType || [self.msgType isEqual:otherMessage.msgType]) &&
      self.hasMsgAttribute == otherMessage.hasMsgAttribute &&
      (!self.hasMsgAttribute || [self.msgAttribute isEqual:otherMessage.msgAttribute]) &&
      self.hasMsgContent == otherMessage.hasMsgContent &&
      (!self.hasMsgContent || [self.msgContent isEqual:otherMessage.msgContent]) &&
      self.hasSenderNickname == otherMessage.hasSenderNickname &&
      (!self.hasSenderNickname || [self.senderNickname isEqual:otherMessage.senderNickname]) &&
      self.hasSenderId == otherMessage.hasSenderId &&
      (!self.hasSenderId || [self.senderId isEqual:otherMessage.senderId]) &&
      self.hasExtend == otherMessage.hasExtend &&
      (!self.hasExtend || [self.extend isEqual:otherMessage.extend]) &&
      self.hasPushDesc == otherMessage.hasPushDesc &&
      (!self.hasPushDesc || [self.pushDesc isEqual:otherMessage.pushDesc]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasMsgId) {
    hashCode = hashCode * 31 + [self.msgId hash];
  }
  if (self.hasSyncId) {
    hashCode = hashCode * 31 + [[NSNumber numberWithLongLong:self.syncId] hash];
  }
  if (self.hasMsgType) {
    hashCode = hashCode * 31 + [self.msgType hash];
  }
  if (self.hasMsgAttribute) {
    hashCode = hashCode * 31 + [self.msgAttribute hash];
  }
  if (self.hasMsgContent) {
    hashCode = hashCode * 31 + [self.msgContent hash];
  }
  if (self.hasSenderNickname) {
    hashCode = hashCode * 31 + [self.senderNickname hash];
  }
  if (self.hasSenderId) {
    hashCode = hashCode * 31 + [self.senderId hash];
  }
  if (self.hasExtend) {
    hashCode = hashCode * 31 + [self.extend hash];
  }
  if (self.hasPushDesc) {
    hashCode = hashCode * 31 + [self.pushDesc hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface SendMsgReqArgsMsgEntityBuilder()
@property (strong) SendMsgReqArgsMsgEntity* resultMsgEntity;
@end

@implementation SendMsgReqArgsMsgEntityBuilder
@synthesize resultMsgEntity;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultMsgEntity = [[SendMsgReqArgsMsgEntity alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultMsgEntity;
}
- (SendMsgReqArgsMsgEntityBuilder*) clear {
  self.resultMsgEntity = [[SendMsgReqArgsMsgEntity alloc] init];
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clone {
  return [SendMsgReqArgsMsgEntity builderWithPrototype:resultMsgEntity];
}
- (SendMsgReqArgsMsgEntity*) defaultInstance {
  return [SendMsgReqArgsMsgEntity defaultInstance];
}
- (SendMsgReqArgsMsgEntity*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (SendMsgReqArgsMsgEntity*) buildPartial {
  SendMsgReqArgsMsgEntity* returnMe = resultMsgEntity;
  self.resultMsgEntity = nil;
  return returnMe;
}
- (SendMsgReqArgsMsgEntityBuilder*) mergeFrom:(SendMsgReqArgsMsgEntity*) other {
  if (other == [SendMsgReqArgsMsgEntity defaultInstance]) {
    return self;
  }
  if (other.hasMsgId) {
    [self setMsgId:other.msgId];
  }
  if (other.hasSyncId) {
    [self setSyncId:other.syncId];
  }
  if (other.hasMsgType) {
    [self setMsgType:other.msgType];
  }
  if (other.hasMsgAttribute) {
    [self setMsgAttribute:other.msgAttribute];
  }
  if (other.hasMsgContent) {
    [self setMsgContent:other.msgContent];
  }
  if (other.hasSenderNickname) {
    [self setSenderNickname:other.senderNickname];
  }
  if (other.hasSenderId) {
    [self setSenderId:other.senderId];
  }
  if (other.hasExtend) {
    [self setExtend:other.extend];
  }
  if (other.hasPushDesc) {
    [self setPushDesc:other.pushDesc];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (SendMsgReqArgsMsgEntityBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    SInt32 tag = [input readTag];
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
        [self setMsgId:[input readString]];
        break;
      }
      case 16: {
        [self setSyncId:[input readInt64]];
        break;
      }
      case 26: {
        [self setMsgType:[input readString]];
        break;
      }
      case 34: {
        [self setMsgAttribute:[input readString]];
        break;
      }
      case 42: {
        [self setMsgContent:[input readString]];
        break;
      }
      case 50: {
        [self setSenderNickname:[input readString]];
        break;
      }
      case 58: {
        [self setSenderId:[input readString]];
        break;
      }
      case 66: {
        [self setExtend:[input readData]];
        break;
      }
      case 74: {
        [self setPushDesc:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasMsgId {
  return resultMsgEntity.hasMsgId;
}
- (NSString*) msgId {
  return resultMsgEntity.msgId;
}
- (SendMsgReqArgsMsgEntityBuilder*) setMsgId:(NSString*) value {
  resultMsgEntity.hasMsgId = YES;
  resultMsgEntity.msgId = value;
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clearMsgId {
  resultMsgEntity.hasMsgId = NO;
  resultMsgEntity.msgId = @"";
  return self;
}
- (BOOL) hasSyncId {
  return resultMsgEntity.hasSyncId;
}
- (SInt64) syncId {
  return resultMsgEntity.syncId;
}
- (SendMsgReqArgsMsgEntityBuilder*) setSyncId:(SInt64) value {
  resultMsgEntity.hasSyncId = YES;
  resultMsgEntity.syncId = value;
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clearSyncId {
  resultMsgEntity.hasSyncId = NO;
  resultMsgEntity.syncId = 0L;
  return self;
}
- (BOOL) hasMsgType {
  return resultMsgEntity.hasMsgType;
}
- (NSString*) msgType {
  return resultMsgEntity.msgType;
}
- (SendMsgReqArgsMsgEntityBuilder*) setMsgType:(NSString*) value {
  resultMsgEntity.hasMsgType = YES;
  resultMsgEntity.msgType = value;
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clearMsgType {
  resultMsgEntity.hasMsgType = NO;
  resultMsgEntity.msgType = @"";
  return self;
}
- (BOOL) hasMsgAttribute {
  return resultMsgEntity.hasMsgAttribute;
}
- (NSString*) msgAttribute {
  return resultMsgEntity.msgAttribute;
}
- (SendMsgReqArgsMsgEntityBuilder*) setMsgAttribute:(NSString*) value {
  resultMsgEntity.hasMsgAttribute = YES;
  resultMsgEntity.msgAttribute = value;
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clearMsgAttribute {
  resultMsgEntity.hasMsgAttribute = NO;
  resultMsgEntity.msgAttribute = @"";
  return self;
}
- (BOOL) hasMsgContent {
  return resultMsgEntity.hasMsgContent;
}
- (NSString*) msgContent {
  return resultMsgEntity.msgContent;
}
- (SendMsgReqArgsMsgEntityBuilder*) setMsgContent:(NSString*) value {
  resultMsgEntity.hasMsgContent = YES;
  resultMsgEntity.msgContent = value;
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clearMsgContent {
  resultMsgEntity.hasMsgContent = NO;
  resultMsgEntity.msgContent = @"";
  return self;
}
- (BOOL) hasSenderNickname {
  return resultMsgEntity.hasSenderNickname;
}
- (NSString*) senderNickname {
  return resultMsgEntity.senderNickname;
}
- (SendMsgReqArgsMsgEntityBuilder*) setSenderNickname:(NSString*) value {
  resultMsgEntity.hasSenderNickname = YES;
  resultMsgEntity.senderNickname = value;
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clearSenderNickname {
  resultMsgEntity.hasSenderNickname = NO;
  resultMsgEntity.senderNickname = @"";
  return self;
}
- (BOOL) hasSenderId {
  return resultMsgEntity.hasSenderId;
}
- (NSString*) senderId {
  return resultMsgEntity.senderId;
}
- (SendMsgReqArgsMsgEntityBuilder*) setSenderId:(NSString*) value {
  resultMsgEntity.hasSenderId = YES;
  resultMsgEntity.senderId = value;
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clearSenderId {
  resultMsgEntity.hasSenderId = NO;
  resultMsgEntity.senderId = @"";
  return self;
}
- (BOOL) hasExtend {
  return resultMsgEntity.hasExtend;
}
- (NSData*) extend {
  return resultMsgEntity.extend;
}
- (SendMsgReqArgsMsgEntityBuilder*) setExtend:(NSData*) value {
  resultMsgEntity.hasExtend = YES;
  resultMsgEntity.extend = value;
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clearExtend {
  resultMsgEntity.hasExtend = NO;
  resultMsgEntity.extend = [NSData data];
  return self;
}
- (BOOL) hasPushDesc {
  return resultMsgEntity.hasPushDesc;
}
- (NSString*) pushDesc {
  return resultMsgEntity.pushDesc;
}
- (SendMsgReqArgsMsgEntityBuilder*) setPushDesc:(NSString*) value {
  resultMsgEntity.hasPushDesc = YES;
  resultMsgEntity.pushDesc = value;
  return self;
}
- (SendMsgReqArgsMsgEntityBuilder*) clearPushDesc {
  resultMsgEntity.hasPushDesc = NO;
  resultMsgEntity.pushDesc = @"";
  return self;
}
@end

@interface SendMsgReqArgsBuilder()
@property (strong) SendMsgReqArgs* resultSendMsgReqArgs;
@end

@implementation SendMsgReqArgsBuilder
@synthesize resultSendMsgReqArgs;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultSendMsgReqArgs = [[SendMsgReqArgs alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultSendMsgReqArgs;
}
- (SendMsgReqArgsBuilder*) clear {
  self.resultSendMsgReqArgs = [[SendMsgReqArgs alloc] init];
  return self;
}
- (SendMsgReqArgsBuilder*) clone {
  return [SendMsgReqArgs builderWithPrototype:resultSendMsgReqArgs];
}
- (SendMsgReqArgs*) defaultInstance {
  return [SendMsgReqArgs defaultInstance];
}
- (SendMsgReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (SendMsgReqArgs*) buildPartial {
  SendMsgReqArgs* returnMe = resultSendMsgReqArgs;
  self.resultSendMsgReqArgs = nil;
  return returnMe;
}
- (SendMsgReqArgsBuilder*) mergeFrom:(SendMsgReqArgs*) other {
  if (other == [SendMsgReqArgs defaultInstance]) {
    return self;
  }
  if (other.hasFromBopId) {
    [self setFromBopId:other.fromBopId];
  }
  if (other.hasToUserId) {
    [self setToUserId:other.toUserId];
  }
  if (other.hasMsg) {
    [self mergeMsg:other.msg];
  }
  if (other.hasSendDate) {
    [self setSendDate:other.sendDate];
  }
  if (other.hasSendClientType) {
    [self setSendClientType:other.sendClientType];
  }
  if (other.hasSendClientPortraitUrl) {
    [self setSendClientPortraitUrl:other.sendClientPortraitUrl];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (SendMsgReqArgsBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (SendMsgReqArgsBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    SInt32 tag = [input readTag];
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
        [self setFromBopId:[input readString]];
        break;
      }
      case 18: {
        [self setToUserId:[input readString]];
        break;
      }
      case 26: {
        SendMsgReqArgsMsgEntityBuilder* subBuilder = [SendMsgReqArgsMsgEntity builder];
        if (self.hasMsg) {
          [subBuilder mergeFrom:self.msg];
        }
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self setMsg:[subBuilder buildPartial]];
        break;
      }
      case 34: {
        [self setSendDate:[input readString]];
        break;
      }
      case 40: {
        [self setSendClientType:[input readInt32]];
        break;
      }
      case 50: {
        [self setSendClientPortraitUrl:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasFromBopId {
  return resultSendMsgReqArgs.hasFromBopId;
}
- (NSString*) fromBopId {
  return resultSendMsgReqArgs.fromBopId;
}
- (SendMsgReqArgsBuilder*) setFromBopId:(NSString*) value {
  resultSendMsgReqArgs.hasFromBopId = YES;
  resultSendMsgReqArgs.fromBopId = value;
  return self;
}
- (SendMsgReqArgsBuilder*) clearFromBopId {
  resultSendMsgReqArgs.hasFromBopId = NO;
  resultSendMsgReqArgs.fromBopId = @"";
  return self;
}
- (BOOL) hasToUserId {
  return resultSendMsgReqArgs.hasToUserId;
}
- (NSString*) toUserId {
  return resultSendMsgReqArgs.toUserId;
}
- (SendMsgReqArgsBuilder*) setToUserId:(NSString*) value {
  resultSendMsgReqArgs.hasToUserId = YES;
  resultSendMsgReqArgs.toUserId = value;
  return self;
}
- (SendMsgReqArgsBuilder*) clearToUserId {
  resultSendMsgReqArgs.hasToUserId = NO;
  resultSendMsgReqArgs.toUserId = @"";
  return self;
}
- (BOOL) hasMsg {
  return resultSendMsgReqArgs.hasMsg;
}
- (SendMsgReqArgsMsgEntity*) msg {
  return resultSendMsgReqArgs.msg;
}
- (SendMsgReqArgsBuilder*) setMsg:(SendMsgReqArgsMsgEntity*) value {
  resultSendMsgReqArgs.hasMsg = YES;
  resultSendMsgReqArgs.msg = value;
  return self;
}
- (SendMsgReqArgsBuilder*) setMsgBuilder:(SendMsgReqArgsMsgEntityBuilder*) builderForValue {
  return [self setMsg:[builderForValue build]];
}
- (SendMsgReqArgsBuilder*) mergeMsg:(SendMsgReqArgsMsgEntity*) value {
  if (resultSendMsgReqArgs.hasMsg &&
      resultSendMsgReqArgs.msg != [SendMsgReqArgsMsgEntity defaultInstance]) {
    resultSendMsgReqArgs.msg =
      [[[SendMsgReqArgsMsgEntity builderWithPrototype:resultSendMsgReqArgs.msg] mergeFrom:value] buildPartial];
  } else {
    resultSendMsgReqArgs.msg = value;
  }
  resultSendMsgReqArgs.hasMsg = YES;
  return self;
}
- (SendMsgReqArgsBuilder*) clearMsg {
  resultSendMsgReqArgs.hasMsg = NO;
  resultSendMsgReqArgs.msg = [SendMsgReqArgsMsgEntity defaultInstance];
  return self;
}
- (BOOL) hasSendDate {
  return resultSendMsgReqArgs.hasSendDate;
}
- (NSString*) sendDate {
  return resultSendMsgReqArgs.sendDate;
}
- (SendMsgReqArgsBuilder*) setSendDate:(NSString*) value {
  resultSendMsgReqArgs.hasSendDate = YES;
  resultSendMsgReqArgs.sendDate = value;
  return self;
}
- (SendMsgReqArgsBuilder*) clearSendDate {
  resultSendMsgReqArgs.hasSendDate = NO;
  resultSendMsgReqArgs.sendDate = @"";
  return self;
}
- (BOOL) hasSendClientType {
  return resultSendMsgReqArgs.hasSendClientType;
}
- (SInt32) sendClientType {
  return resultSendMsgReqArgs.sendClientType;
}
- (SendMsgReqArgsBuilder*) setSendClientType:(SInt32) value {
  resultSendMsgReqArgs.hasSendClientType = YES;
  resultSendMsgReqArgs.sendClientType = value;
  return self;
}
- (SendMsgReqArgsBuilder*) clearSendClientType {
  resultSendMsgReqArgs.hasSendClientType = NO;
  resultSendMsgReqArgs.sendClientType = 0;
  return self;
}
- (BOOL) hasSendClientPortraitUrl {
  return resultSendMsgReqArgs.hasSendClientPortraitUrl;
}
- (NSString*) sendClientPortraitUrl {
  return resultSendMsgReqArgs.sendClientPortraitUrl;
}
- (SendMsgReqArgsBuilder*) setSendClientPortraitUrl:(NSString*) value {
  resultSendMsgReqArgs.hasSendClientPortraitUrl = YES;
  resultSendMsgReqArgs.sendClientPortraitUrl = value;
  return self;
}
- (SendMsgReqArgsBuilder*) clearSendClientPortraitUrl {
  resultSendMsgReqArgs.hasSendClientPortraitUrl = NO;
  resultSendMsgReqArgs.sendClientPortraitUrl = @"";
  return self;
}
@end


// @@protoc_insertion_point(global_scope)
