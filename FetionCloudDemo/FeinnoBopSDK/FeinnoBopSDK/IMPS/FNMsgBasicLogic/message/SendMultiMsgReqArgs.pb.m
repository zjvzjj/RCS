// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "SendMultiMsgReqArgs.pb.h"
// @@protoc_insertion_point(imports)

@implementation SendMultiMsgReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [SendMultiMsgReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = registry;
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface SendMultiMsgReqArgs ()
@property (strong) NSString* fromBopId;
@property (strong) NSMutableArray * toBopIdArray;
@property (strong) MsgEntitys* msg;
@property (strong) NSString* sendDate;
@end

@implementation SendMultiMsgReqArgs

- (BOOL) hasFromBopId {
  return !!hasFromBopId_;
}
- (void) setHasFromBopId:(BOOL) _value_ {
  hasFromBopId_ = !!_value_;
}
@synthesize fromBopId;
@synthesize toBopIdArray;
@dynamic toBopId;
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
- (instancetype) init {
  if ((self = [super init])) {
    self.fromBopId = @"";
    self.msg = [MsgEntitys defaultInstance];
    self.sendDate = @"";
  }
  return self;
}
static SendMultiMsgReqArgs* defaultSendMultiMsgReqArgsInstance = nil;
+ (void) initialize {
  if (self == [SendMultiMsgReqArgs class]) {
    defaultSendMultiMsgReqArgsInstance = [[SendMultiMsgReqArgs alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultSendMultiMsgReqArgsInstance;
}
- (instancetype) defaultInstance {
  return defaultSendMultiMsgReqArgsInstance;
}
- (NSArray *)toBopId {
  return toBopIdArray;
}
- (NSString*)toBopIdAtIndex:(NSUInteger)index {
  return [toBopIdArray objectAtIndex:index];
}
- (BOOL) isInitialized {
  if (!self.hasFromBopId) {
    return NO;
  }
  if (!self.hasMsg) {
    return NO;
  }
  if (!self.msg.isInitialized) {
    return NO;
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasFromBopId) {
    [output writeString:1 value:self.fromBopId];
  }
  [self.toBopIdArray enumerateObjectsUsingBlock:^(NSString *element, NSUInteger idx, BOOL *stop) {
    [output writeString:2 value:element];
  }];
  if (self.hasMsg) {
    [output writeMessage:3 value:self.msg];
  }
  if (self.hasSendDate) {
    [output writeString:4 value:self.sendDate];
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
  {
    __block SInt32 dataSize = 0;
    const NSUInteger count = self.toBopIdArray.count;
    [self.toBopIdArray enumerateObjectsUsingBlock:^(NSString *element, NSUInteger idx, BOOL *stop) {
      dataSize += computeStringSizeNoTag(element);
    }];
    size_ += dataSize;
    size_ += (SInt32)(1 * count);
  }
  if (self.hasMsg) {
    size_ += computeMessageSize(3, self.msg);
  }
  if (self.hasSendDate) {
    size_ += computeStringSize(4, self.sendDate);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (SendMultiMsgReqArgs*) parseFromData:(NSData*) data {
  return (SendMultiMsgReqArgs*)[[[SendMultiMsgReqArgs builder] mergeFromData:data] build];
}
+ (SendMultiMsgReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMultiMsgReqArgs*)[[[SendMultiMsgReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (SendMultiMsgReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (SendMultiMsgReqArgs*)[[[SendMultiMsgReqArgs builder] mergeFromInputStream:input] build];
}
+ (SendMultiMsgReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMultiMsgReqArgs*)[[[SendMultiMsgReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendMultiMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (SendMultiMsgReqArgs*)[[[SendMultiMsgReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (SendMultiMsgReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendMultiMsgReqArgs*)[[[SendMultiMsgReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendMultiMsgReqArgs_Builder*) builder {
  return [[SendMultiMsgReqArgs_Builder alloc] init];
}
+ (SendMultiMsgReqArgs_Builder*) builderWithPrototype:(SendMultiMsgReqArgs*) prototype {
  return [[SendMultiMsgReqArgs builder] mergeFrom:prototype];
}
- (SendMultiMsgReqArgs_Builder*) builder {
  return [SendMultiMsgReqArgs builder];
}
- (SendMultiMsgReqArgs_Builder*) toBuilder {
  return [SendMultiMsgReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasFromBopId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"fromBopId", self.fromBopId];
  }
  [self.toBopIdArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [output appendFormat:@"%@%@: %@\n", indent, @"toBopId", obj];
  }];
  if (self.hasMsg) {
    [output appendFormat:@"%@%@ {\n", indent, @"msg"];
    [self.msg writeDescriptionTo:output
                         withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
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
  if (![other isKindOfClass:[SendMultiMsgReqArgs class]]) {
    return NO;
  }
  SendMultiMsgReqArgs *otherMessage = other;
  return
      self.hasFromBopId == otherMessage.hasFromBopId &&
      (!self.hasFromBopId || [self.fromBopId isEqual:otherMessage.fromBopId]) &&
      [self.toBopIdArray isEqualToArray:otherMessage.toBopIdArray] &&
      self.hasMsg == otherMessage.hasMsg &&
      (!self.hasMsg || [self.msg isEqual:otherMessage.msg]) &&
      self.hasSendDate == otherMessage.hasSendDate &&
      (!self.hasSendDate || [self.sendDate isEqual:otherMessage.sendDate]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasFromBopId) {
    hashCode = hashCode * 31 + [self.fromBopId hash];
  }
  [self.toBopIdArray enumerateObjectsUsingBlock:^(NSString *element, NSUInteger idx, BOOL *stop) {
    hashCode = hashCode * 31 + [element hash];
  }];
  if (self.hasMsg) {
    hashCode = hashCode * 31 + [self.msg hash];
  }
  if (self.hasSendDate) {
    hashCode = hashCode * 31 + [self.sendDate hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface SendMultiMsgReqArgs_Builder()
@property (strong) SendMultiMsgReqArgs* resultSendMultiMsgReqArgs;
@end

@implementation SendMultiMsgReqArgs_Builder
@synthesize resultSendMultiMsgReqArgs;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultSendMultiMsgReqArgs = [[SendMultiMsgReqArgs alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultSendMultiMsgReqArgs;
}
- (SendMultiMsgReqArgs_Builder*) clear {
  self.resultSendMultiMsgReqArgs = [[SendMultiMsgReqArgs alloc] init];
  return self;
}
- (SendMultiMsgReqArgs_Builder*) clone {
  return [SendMultiMsgReqArgs builderWithPrototype:resultSendMultiMsgReqArgs];
}
- (SendMultiMsgReqArgs*) defaultInstance {
  return [SendMultiMsgReqArgs defaultInstance];
}
- (SendMultiMsgReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (SendMultiMsgReqArgs*) buildPartial {
  SendMultiMsgReqArgs* returnMe = resultSendMultiMsgReqArgs;
  self.resultSendMultiMsgReqArgs = nil;
  return returnMe;
}
- (SendMultiMsgReqArgs_Builder*) mergeFrom:(SendMultiMsgReqArgs*) other {
  if (other == [SendMultiMsgReqArgs defaultInstance]) {
    return self;
  }
  if (other.hasFromBopId) {
    [self setFromBopId:other.fromBopId];
  }
  if (other.toBopIdArray.count > 0) {
    if (resultSendMultiMsgReqArgs.toBopIdArray == nil) {
      resultSendMultiMsgReqArgs.toBopIdArray = [[NSMutableArray alloc] initWithArray:other.toBopIdArray];
    } else {
      [resultSendMultiMsgReqArgs.toBopIdArray addObjectsFromArray:other.toBopIdArray];
    }
  }
  if (other.hasMsg) {
    [self mergeMsg:other.msg];
  }
  if (other.hasSendDate) {
    [self setSendDate:other.sendDate];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (SendMultiMsgReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (SendMultiMsgReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self addToBopId:[input readString]];
        break;
      }
      case 26: {
        MsgEntitysBuilder* subBuilder = [MsgEntitys builder];
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
    }
  }
}
- (BOOL) hasFromBopId {
  return resultSendMultiMsgReqArgs.hasFromBopId;
}
- (NSString*) fromBopId {
  return resultSendMultiMsgReqArgs.fromBopId;
}
- (SendMultiMsgReqArgs_Builder*) setFromBopId:(NSString*) value {
  resultSendMultiMsgReqArgs.hasFromBopId = YES;
  resultSendMultiMsgReqArgs.fromBopId = value;
  return self;
}
- (SendMultiMsgReqArgs_Builder*) clearFromBopId {
  resultSendMultiMsgReqArgs.hasFromBopId = NO;
  resultSendMultiMsgReqArgs.fromBopId = @"";
  return self;
}
- (NSMutableArray *)toBopId {
  return resultSendMultiMsgReqArgs.toBopIdArray;
}
- (NSString*)toBopIdAtIndex:(NSUInteger)index {
  return [resultSendMultiMsgReqArgs toBopIdAtIndex:index];
}
- (SendMultiMsgReqArgs_Builder *)addToBopId:(NSString*)value {
  if (resultSendMultiMsgReqArgs.toBopIdArray == nil) {
    resultSendMultiMsgReqArgs.toBopIdArray = [[NSMutableArray alloc]init];
  }
  [resultSendMultiMsgReqArgs.toBopIdArray addObject:value];
  return self;
}
- (SendMultiMsgReqArgs_Builder *)setToBopIdArray:(NSArray *)array {
  resultSendMultiMsgReqArgs.toBopIdArray = [[NSMutableArray alloc] initWithArray:array];
  return self;
}
- (SendMultiMsgReqArgs_Builder *)clearToBopId {
  resultSendMultiMsgReqArgs.toBopIdArray = nil;
  return self;
}
- (BOOL) hasMsg {
  return resultSendMultiMsgReqArgs.hasMsg;
}
- (MsgEntitys*) msg {
  return resultSendMultiMsgReqArgs.msg;
}
- (SendMultiMsgReqArgs_Builder*) setMsg:(MsgEntitys*) value {
  resultSendMultiMsgReqArgs.hasMsg = YES;
  resultSendMultiMsgReqArgs.msg = value;
  return self;
}
- (SendMultiMsgReqArgs_Builder*) setMsgBuilder:(MsgEntitysBuilder*) builderForValue {
  return [self setMsg:[builderForValue build]];
}
- (SendMultiMsgReqArgs_Builder*) mergeMsg:(MsgEntitys*) value {
  if (resultSendMultiMsgReqArgs.hasMsg &&
      resultSendMultiMsgReqArgs.msg != [MsgEntitys defaultInstance]) {
    resultSendMultiMsgReqArgs.msg =
      [[[MsgEntitys builderWithPrototype:resultSendMultiMsgReqArgs.msg] mergeFrom:value] buildPartial];
  } else {
    resultSendMultiMsgReqArgs.msg = value;
  }
  resultSendMultiMsgReqArgs.hasMsg = YES;
  return self;
}
- (SendMultiMsgReqArgs_Builder*) clearMsg {
  resultSendMultiMsgReqArgs.hasMsg = NO;
  resultSendMultiMsgReqArgs.msg = [MsgEntitys defaultInstance];
  return self;
}
- (BOOL) hasSendDate {
  return resultSendMultiMsgReqArgs.hasSendDate;
}
- (NSString*) sendDate {
  return resultSendMultiMsgReqArgs.sendDate;
}
- (SendMultiMsgReqArgs_Builder*) setSendDate:(NSString*) value {
  resultSendMultiMsgReqArgs.hasSendDate = YES;
  resultSendMultiMsgReqArgs.sendDate = value;
  return self;
}
- (SendMultiMsgReqArgs_Builder*) clearSendDate {
  resultSendMultiMsgReqArgs.hasSendDate = NO;
  resultSendMultiMsgReqArgs.sendDate = @"";
  return self;
}
@end

@interface MsgEntitys ()
@property (strong) NSString* msgId;
@property SInt64 syncId;
@property (strong) NSString* msgType;
@property (strong) NSString* msgAttribute;
@property (strong) NSString* msgContent;
@property (strong) NSString* senderNickName;
@property (strong) NSString* senderId;
@property (strong) NSMutableArray * extendArray;
@end

@implementation MsgEntitys

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
- (BOOL) hasSenderNickName {
  return !!hasSenderNickName_;
}
- (void) setHasSenderNickName:(BOOL) _value_ {
  hasSenderNickName_ = !!_value_;
}
@synthesize senderNickName;
- (BOOL) hasSenderId {
  return !!hasSenderId_;
}
- (void) setHasSenderId:(BOOL) _value_ {
  hasSenderId_ = !!_value_;
}
@synthesize senderId;
@synthesize extendArray;
@dynamic extend;
- (instancetype) init {
  if ((self = [super init])) {
    self.msgId = @"";
    self.syncId = 0L;
    self.msgType = @"";
    self.msgAttribute = @"";
    self.msgContent = @"";
    self.senderNickName = @"";
    self.senderId = @"";
  }
  return self;
}
static MsgEntitys* defaultMsgEntitysInstance = nil;
+ (void) initialize {
  if (self == [MsgEntitys class]) {
    defaultMsgEntitysInstance = [[MsgEntitys alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultMsgEntitysInstance;
}
- (instancetype) defaultInstance {
  return defaultMsgEntitysInstance;
}
- (NSArray *)extend {
  return extendArray;
}
- (NSData*)extendAtIndex:(NSUInteger)index {
  return [extendArray objectAtIndex:index];
}
- (BOOL) isInitialized {
  if (!self.hasMsgId) {
    return NO;
  }
  if (!self.hasMsgType) {
    return NO;
  }
  if (!self.hasMsgContent) {
    return NO;
  }
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
  if (self.hasSenderNickName) {
    [output writeString:6 value:self.senderNickName];
  }
  if (self.hasSenderId) {
    [output writeString:7 value:self.senderId];
  }
  [self.extendArray enumerateObjectsUsingBlock:^(NSData *element, NSUInteger idx, BOOL *stop) {
    [output writeData:8 value:element];
  }];
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
  if (self.hasSenderNickName) {
    size_ += computeStringSize(6, self.senderNickName);
  }
  if (self.hasSenderId) {
    size_ += computeStringSize(7, self.senderId);
  }
  {
    __block SInt32 dataSize = 0;
    const NSUInteger count = self.extendArray.count;
    [self.extendArray enumerateObjectsUsingBlock:^(NSData *element, NSUInteger idx, BOOL *stop) {
      dataSize += computeDataSizeNoTag(element);
    }];
    size_ += dataSize;
    size_ += (SInt32)(1 * count);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (MsgEntitys*) parseFromData:(NSData*) data {
  return (MsgEntitys*)[[[MsgEntitys builder] mergeFromData:data] build];
}
+ (MsgEntitys*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MsgEntitys*)[[[MsgEntitys builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (MsgEntitys*) parseFromInputStream:(NSInputStream*) input {
  return (MsgEntitys*)[[[MsgEntitys builder] mergeFromInputStream:input] build];
}
+ (MsgEntitys*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MsgEntitys*)[[[MsgEntitys builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MsgEntitys*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (MsgEntitys*)[[[MsgEntitys builder] mergeFromCodedInputStream:input] build];
}
+ (MsgEntitys*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (MsgEntitys*)[[[MsgEntitys builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (MsgEntitysBuilder*) builder {
  return [[MsgEntitysBuilder alloc] init];
}
+ (MsgEntitysBuilder*) builderWithPrototype:(MsgEntitys*) prototype {
  return [[MsgEntitys builder] mergeFrom:prototype];
}
- (MsgEntitysBuilder*) builder {
  return [MsgEntitys builder];
}
- (MsgEntitysBuilder*) toBuilder {
  return [MsgEntitys builderWithPrototype:self];
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
  if (self.hasSenderNickName) {
    [output appendFormat:@"%@%@: %@\n", indent, @"senderNickName", self.senderNickName];
  }
  if (self.hasSenderId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"senderId", self.senderId];
  }
  [self.extendArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [output appendFormat:@"%@%@: %@\n", indent, @"extend", obj];
  }];
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[MsgEntitys class]]) {
    return NO;
  }
  MsgEntitys *otherMessage = other;
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
      self.hasSenderNickName == otherMessage.hasSenderNickName &&
      (!self.hasSenderNickName || [self.senderNickName isEqual:otherMessage.senderNickName]) &&
      self.hasSenderId == otherMessage.hasSenderId &&
      (!self.hasSenderId || [self.senderId isEqual:otherMessage.senderId]) &&
      [self.extendArray isEqualToArray:otherMessage.extendArray] &&
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
  if (self.hasSenderNickName) {
    hashCode = hashCode * 31 + [self.senderNickName hash];
  }
  if (self.hasSenderId) {
    hashCode = hashCode * 31 + [self.senderId hash];
  }
  [self.extendArray enumerateObjectsUsingBlock:^(NSData *element, NSUInteger idx, BOOL *stop) {
    hashCode = hashCode * 31 + [element hash];
  }];
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface MsgEntitysBuilder()
@property (strong) MsgEntitys* resultMsgEntitys;
@end

@implementation MsgEntitysBuilder
@synthesize resultMsgEntitys;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultMsgEntitys = [[MsgEntitys alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultMsgEntitys;
}
- (MsgEntitysBuilder*) clear {
  self.resultMsgEntitys = [[MsgEntitys alloc] init];
  return self;
}
- (MsgEntitysBuilder*) clone {
  return [MsgEntitys builderWithPrototype:resultMsgEntitys];
}
- (MsgEntitys*) defaultInstance {
  return [MsgEntitys defaultInstance];
}
- (MsgEntitys*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (MsgEntitys*) buildPartial {
  MsgEntitys* returnMe = resultMsgEntitys;
  self.resultMsgEntitys = nil;
  return returnMe;
}
- (MsgEntitysBuilder*) mergeFrom:(MsgEntitys*) other {
  if (other == [MsgEntitys defaultInstance]) {
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
  if (other.hasSenderNickName) {
    [self setSenderNickName:other.senderNickName];
  }
  if (other.hasSenderId) {
    [self setSenderId:other.senderId];
  }
  if (other.extendArray.count > 0) {
    if (resultMsgEntitys.extendArray == nil) {
      resultMsgEntitys.extendArray = [[NSMutableArray alloc] initWithArray:other.extendArray];
    } else {
      [resultMsgEntitys.extendArray addObjectsFromArray:other.extendArray];
    }
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (MsgEntitysBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (MsgEntitysBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setSenderNickName:[input readString]];
        break;
      }
      case 58: {
        [self setSenderId:[input readString]];
        break;
      }
      case 66: {
        [self addExtend:[input readData]];
        break;
      }
    }
  }
}
- (BOOL) hasMsgId {
  return resultMsgEntitys.hasMsgId;
}
- (NSString*) msgId {
  return resultMsgEntitys.msgId;
}
- (MsgEntitysBuilder*) setMsgId:(NSString*) value {
  resultMsgEntitys.hasMsgId = YES;
  resultMsgEntitys.msgId = value;
  return self;
}
- (MsgEntitysBuilder*) clearMsgId {
  resultMsgEntitys.hasMsgId = NO;
  resultMsgEntitys.msgId = @"";
  return self;
}
- (BOOL) hasSyncId {
  return resultMsgEntitys.hasSyncId;
}
- (SInt64) syncId {
  return resultMsgEntitys.syncId;
}
- (MsgEntitysBuilder*) setSyncId:(SInt64) value {
  resultMsgEntitys.hasSyncId = YES;
  resultMsgEntitys.syncId = value;
  return self;
}
- (MsgEntitysBuilder*) clearSyncId {
  resultMsgEntitys.hasSyncId = NO;
  resultMsgEntitys.syncId = 0L;
  return self;
}
- (BOOL) hasMsgType {
  return resultMsgEntitys.hasMsgType;
}
- (NSString*) msgType {
  return resultMsgEntitys.msgType;
}
- (MsgEntitysBuilder*) setMsgType:(NSString*) value {
  resultMsgEntitys.hasMsgType = YES;
  resultMsgEntitys.msgType = value;
  return self;
}
- (MsgEntitysBuilder*) clearMsgType {
  resultMsgEntitys.hasMsgType = NO;
  resultMsgEntitys.msgType = @"";
  return self;
}
- (BOOL) hasMsgAttribute {
  return resultMsgEntitys.hasMsgAttribute;
}
- (NSString*) msgAttribute {
  return resultMsgEntitys.msgAttribute;
}
- (MsgEntitysBuilder*) setMsgAttribute:(NSString*) value {
  resultMsgEntitys.hasMsgAttribute = YES;
  resultMsgEntitys.msgAttribute = value;
  return self;
}
- (MsgEntitysBuilder*) clearMsgAttribute {
  resultMsgEntitys.hasMsgAttribute = NO;
  resultMsgEntitys.msgAttribute = @"";
  return self;
}
- (BOOL) hasMsgContent {
  return resultMsgEntitys.hasMsgContent;
}
- (NSString*) msgContent {
  return resultMsgEntitys.msgContent;
}
- (MsgEntitysBuilder*) setMsgContent:(NSString*) value {
  resultMsgEntitys.hasMsgContent = YES;
  resultMsgEntitys.msgContent = value;
  return self;
}
- (MsgEntitysBuilder*) clearMsgContent {
  resultMsgEntitys.hasMsgContent = NO;
  resultMsgEntitys.msgContent = @"";
  return self;
}
- (BOOL) hasSenderNickName {
  return resultMsgEntitys.hasSenderNickName;
}
- (NSString*) senderNickName {
  return resultMsgEntitys.senderNickName;
}
- (MsgEntitysBuilder*) setSenderNickName:(NSString*) value {
  resultMsgEntitys.hasSenderNickName = YES;
  resultMsgEntitys.senderNickName = value;
  return self;
}
- (MsgEntitysBuilder*) clearSenderNickName {
  resultMsgEntitys.hasSenderNickName = NO;
  resultMsgEntitys.senderNickName = @"";
  return self;
}
- (BOOL) hasSenderId {
  return resultMsgEntitys.hasSenderId;
}
- (NSString*) senderId {
  return resultMsgEntitys.senderId;
}
- (MsgEntitysBuilder*) setSenderId:(NSString*) value {
  resultMsgEntitys.hasSenderId = YES;
  resultMsgEntitys.senderId = value;
  return self;
}
- (MsgEntitysBuilder*) clearSenderId {
  resultMsgEntitys.hasSenderId = NO;
  resultMsgEntitys.senderId = @"";
  return self;
}
- (NSMutableArray *)extend {
  return resultMsgEntitys.extendArray;
}
- (NSData*)extendAtIndex:(NSUInteger)index {
  return [resultMsgEntitys extendAtIndex:index];
}
- (MsgEntitysBuilder *)addExtend:(NSData*)value {
  if (resultMsgEntitys.extendArray == nil) {
    resultMsgEntitys.extendArray = [[NSMutableArray alloc]init];
  }
  [resultMsgEntitys.extendArray addObject:value];
  return self;
}
- (MsgEntitysBuilder *)setExtendArray:(NSArray *)array {
  resultMsgEntitys.extendArray = [[NSMutableArray alloc] initWithArray:array];
  return self;
}
- (MsgEntitysBuilder *)clearExtend {
  resultMsgEntitys.extendArray = nil;
  return self;
}
@end


// @@protoc_insertion_point(global_scope)
