// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "IsRegisterRspArgs.pb.h"

@implementation IsRegisterRspArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [IsRegisterRspArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface IsRegisterRspArgs ()
@property int32_t retCode;
@property (retain) NSString* retDesc;
@property (retain) PBAppendableArray * regiserStatusArray;
@end

@implementation IsRegisterRspArgs

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
@synthesize regiserStatusArray;
@dynamic regiserStatus;
- (void) dealloc {
  self.retDesc = nil;
  self.regiserStatusArray = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.retCode = 0;
    self.retDesc = @"";
  }
  return self;
}
static IsRegisterRspArgs* defaultIsRegisterRspArgsInstance = nil;
+ (void) initialize {
  if (self == [IsRegisterRspArgs class]) {
    defaultIsRegisterRspArgsInstance = [[IsRegisterRspArgs alloc] init];
  }
}
+ (IsRegisterRspArgs*) defaultInstance {
  return defaultIsRegisterRspArgsInstance;
}
- (IsRegisterRspArgs*) defaultInstance {
  return defaultIsRegisterRspArgsInstance;
}
- (PBArray *)regiserStatus {
  return regiserStatusArray;
}
- (IsRegisterRspArgs_RegisterStatusCombo*)regiserStatusAtIndex:(NSUInteger)index {
  return [regiserStatusArray objectAtIndex:index];
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
  for (IsRegisterRspArgs_RegisterStatusCombo *element in self.regiserStatusArray) {
    [output writeMessage:3 value:element];
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
  for (IsRegisterRspArgs_RegisterStatusCombo *element in self.regiserStatusArray) {
    size_ += computeMessageSize(3, element);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (IsRegisterRspArgs*) parseFromData:(NSData*) data {
  return (IsRegisterRspArgs*)[[[IsRegisterRspArgs builder] mergeFromData:data] build];
}
+ (IsRegisterRspArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (IsRegisterRspArgs*)[[[IsRegisterRspArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (IsRegisterRspArgs*) parseFromInputStream:(NSInputStream*) input {
  return (IsRegisterRspArgs*)[[[IsRegisterRspArgs builder] mergeFromInputStream:input] build];
}
+ (IsRegisterRspArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (IsRegisterRspArgs*)[[[IsRegisterRspArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (IsRegisterRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (IsRegisterRspArgs*)[[[IsRegisterRspArgs builder] mergeFromCodedInputStream:input] build];
}
+ (IsRegisterRspArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (IsRegisterRspArgs*)[[[IsRegisterRspArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (IsRegisterRspArgs_Builder*) builder {
  return [[[IsRegisterRspArgs_Builder alloc] init] autorelease];
}
+ (IsRegisterRspArgs_Builder*) builderWithPrototype:(IsRegisterRspArgs*) prototype {
  return [[IsRegisterRspArgs builder] mergeFrom:prototype];
}
- (IsRegisterRspArgs_Builder*) builder {
  return [IsRegisterRspArgs builder];
}
- (IsRegisterRspArgs_Builder*) toBuilder {
  return [IsRegisterRspArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasRetCode) {
    [output appendFormat:@"%@%@: %@\n", indent, @"retCode", [NSNumber numberWithInt:self.retCode]];
  }
  if (self.hasRetDesc) {
    [output appendFormat:@"%@%@: %@\n", indent, @"retDesc", self.retDesc];
  }
  for (IsRegisterRspArgs_RegisterStatusCombo* element in self.regiserStatusArray) {
    [output appendFormat:@"%@%@ {\n", indent, @"regiserStatus"];
    [element writeDescriptionTo:output
                     withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[IsRegisterRspArgs class]]) {
    return NO;
  }
  IsRegisterRspArgs *otherMessage = other;
  return
      self.hasRetCode == otherMessage.hasRetCode &&
      (!self.hasRetCode || self.retCode == otherMessage.retCode) &&
      self.hasRetDesc == otherMessage.hasRetDesc &&
      (!self.hasRetDesc || [self.retDesc isEqual:otherMessage.retDesc]) &&
      [self.regiserStatusArray isEqualToArray:otherMessage.regiserStatusArray] &&
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
  for (IsRegisterRspArgs_RegisterStatusCombo* element in self.regiserStatusArray) {
    hashCode = hashCode * 31 + [element hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface IsRegisterRspArgs_RegisterStatusCombo ()
@property (retain) NSString* userId;
@property int32_t registerStatus;
@end

@implementation IsRegisterRspArgs_RegisterStatusCombo

- (BOOL) hasUserId {
  return !!hasUserId_;
}
- (void) setHasUserId:(BOOL) value_ {
  hasUserId_ = !!value_;
}
@synthesize userId;
- (BOOL) hasRegisterStatus {
  return !!hasRegisterStatus_;
}
- (void) setHasRegisterStatus:(BOOL) value_ {
  hasRegisterStatus_ = !!value_;
}
@synthesize registerStatus;
- (void) dealloc {
  self.userId = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.userId = @"";
    self.registerStatus = 0;
  }
  return self;
}
static IsRegisterRspArgs_RegisterStatusCombo* defaultIsRegisterRspArgs_RegisterStatusComboInstance = nil;
+ (void) initialize {
  if (self == [IsRegisterRspArgs_RegisterStatusCombo class]) {
    defaultIsRegisterRspArgs_RegisterStatusComboInstance = [[IsRegisterRspArgs_RegisterStatusCombo alloc] init];
  }
}
+ (IsRegisterRspArgs_RegisterStatusCombo*) defaultInstance {
  return defaultIsRegisterRspArgs_RegisterStatusComboInstance;
}
- (IsRegisterRspArgs_RegisterStatusCombo*) defaultInstance {
  return defaultIsRegisterRspArgs_RegisterStatusComboInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasUserId) {
    [output writeString:1 value:self.userId];
  }
  if (self.hasRegisterStatus) {
    [output writeInt32:2 value:self.registerStatus];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasUserId) {
    size_ += computeStringSize(1, self.userId);
  }
  if (self.hasRegisterStatus) {
    size_ += computeInt32Size(2, self.registerStatus);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromData:(NSData*) data {
  return (IsRegisterRspArgs_RegisterStatusCombo*)[[[IsRegisterRspArgs_RegisterStatusCombo builder] mergeFromData:data] build];
}
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (IsRegisterRspArgs_RegisterStatusCombo*)[[[IsRegisterRspArgs_RegisterStatusCombo builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromInputStream:(NSInputStream*) input {
  return (IsRegisterRspArgs_RegisterStatusCombo*)[[[IsRegisterRspArgs_RegisterStatusCombo builder] mergeFromInputStream:input] build];
}
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (IsRegisterRspArgs_RegisterStatusCombo*)[[[IsRegisterRspArgs_RegisterStatusCombo builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (IsRegisterRspArgs_RegisterStatusCombo*)[[[IsRegisterRspArgs_RegisterStatusCombo builder] mergeFromCodedInputStream:input] build];
}
+ (IsRegisterRspArgs_RegisterStatusCombo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (IsRegisterRspArgs_RegisterStatusCombo*)[[[IsRegisterRspArgs_RegisterStatusCombo builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (IsRegisterRspArgs_RegisterStatusCombo_Builder*) builder {
  return [[[IsRegisterRspArgs_RegisterStatusCombo_Builder alloc] init] autorelease];
}
+ (IsRegisterRspArgs_RegisterStatusCombo_Builder*) builderWithPrototype:(IsRegisterRspArgs_RegisterStatusCombo*) prototype {
  return [[IsRegisterRspArgs_RegisterStatusCombo builder] mergeFrom:prototype];
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) builder {
  return [IsRegisterRspArgs_RegisterStatusCombo builder];
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) toBuilder {
  return [IsRegisterRspArgs_RegisterStatusCombo builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasUserId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"userId", self.userId];
  }
  if (self.hasRegisterStatus) {
    [output appendFormat:@"%@%@: %@\n", indent, @"registerStatus", [NSNumber numberWithInt:self.registerStatus]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[IsRegisterRspArgs_RegisterStatusCombo class]]) {
    return NO;
  }
  IsRegisterRspArgs_RegisterStatusCombo *otherMessage = other;
  return
      self.hasUserId == otherMessage.hasUserId &&
      (!self.hasUserId || [self.userId isEqual:otherMessage.userId]) &&
      self.hasRegisterStatus == otherMessage.hasRegisterStatus &&
      (!self.hasRegisterStatus || self.registerStatus == otherMessage.registerStatus) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasUserId) {
    hashCode = hashCode * 31 + [self.userId hash];
  }
  if (self.hasRegisterStatus) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.registerStatus] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface IsRegisterRspArgs_RegisterStatusCombo_Builder()
@property (retain) IsRegisterRspArgs_RegisterStatusCombo* result;
@end

@implementation IsRegisterRspArgs_RegisterStatusCombo_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[IsRegisterRspArgs_RegisterStatusCombo alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) clear {
  self.result = [[[IsRegisterRspArgs_RegisterStatusCombo alloc] init] autorelease];
  return self;
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) clone {
  return [IsRegisterRspArgs_RegisterStatusCombo builderWithPrototype:result];
}
- (IsRegisterRspArgs_RegisterStatusCombo*) defaultInstance {
  return [IsRegisterRspArgs_RegisterStatusCombo defaultInstance];
}
- (IsRegisterRspArgs_RegisterStatusCombo*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (IsRegisterRspArgs_RegisterStatusCombo*) buildPartial {
  IsRegisterRspArgs_RegisterStatusCombo* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) mergeFrom:(IsRegisterRspArgs_RegisterStatusCombo*) other {
  if (other == [IsRegisterRspArgs_RegisterStatusCombo defaultInstance]) {
    return self;
  }
  if (other.hasUserId) {
    [self setUserId:other.userId];
  }
  if (other.hasRegisterStatus) {
    [self setRegisterStatus:other.registerStatus];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setUserId:[input readString]];
        break;
      }
      case 16: {
        [self setRegisterStatus:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasUserId {
  return result.hasUserId;
}
- (NSString*) userId {
  return result.userId;
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) setUserId:(NSString*) value {
  result.hasUserId = YES;
  result.userId = value;
  return self;
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) clearUserId {
  result.hasUserId = NO;
  result.userId = @"";
  return self;
}
- (BOOL) hasRegisterStatus {
  return result.hasRegisterStatus;
}
- (int32_t) registerStatus {
  return result.registerStatus;
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) setRegisterStatus:(int32_t) value {
  result.hasRegisterStatus = YES;
  result.registerStatus = value;
  return self;
}
- (IsRegisterRspArgs_RegisterStatusCombo_Builder*) clearRegisterStatus {
  result.hasRegisterStatus = NO;
  result.registerStatus = 0;
  return self;
}
@end

@interface IsRegisterRspArgs_Builder()
@property (retain) IsRegisterRspArgs* result;
@end

@implementation IsRegisterRspArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[IsRegisterRspArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (IsRegisterRspArgs_Builder*) clear {
  self.result = [[[IsRegisterRspArgs alloc] init] autorelease];
  return self;
}
- (IsRegisterRspArgs_Builder*) clone {
  return [IsRegisterRspArgs builderWithPrototype:result];
}
- (IsRegisterRspArgs*) defaultInstance {
  return [IsRegisterRspArgs defaultInstance];
}
- (IsRegisterRspArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (IsRegisterRspArgs*) buildPartial {
  IsRegisterRspArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (IsRegisterRspArgs_Builder*) mergeFrom:(IsRegisterRspArgs*) other {
  if (other == [IsRegisterRspArgs defaultInstance]) {
    return self;
  }
  if (other.hasRetCode) {
    [self setRetCode:other.retCode];
  }
  if (other.hasRetDesc) {
    [self setRetDesc:other.retDesc];
  }
  if (other.regiserStatusArray.count > 0) {
    if (result.regiserStatusArray == nil) {
      result.regiserStatusArray = [[other.regiserStatusArray copyWithZone:[other.regiserStatusArray zone]] autorelease];
    } else {
      [result.regiserStatusArray appendArray:other.regiserStatusArray];
    }
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (IsRegisterRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (IsRegisterRspArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
      case 26: {
        IsRegisterRspArgs_RegisterStatusCombo_Builder* subBuilder = [IsRegisterRspArgs_RegisterStatusCombo builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addRegiserStatus:[subBuilder buildPartial]];
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
- (IsRegisterRspArgs_Builder*) setRetCode:(int32_t) value {
  result.hasRetCode = YES;
  result.retCode = value;
  return self;
}
- (IsRegisterRspArgs_Builder*) clearRetCode {
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
- (IsRegisterRspArgs_Builder*) setRetDesc:(NSString*) value {
  result.hasRetDesc = YES;
  result.retDesc = value;
  return self;
}
- (IsRegisterRspArgs_Builder*) clearRetDesc {
  result.hasRetDesc = NO;
  result.retDesc = @"";
  return self;
}
- (PBAppendableArray *)regiserStatus {
  return result.regiserStatusArray;
}
- (IsRegisterRspArgs_RegisterStatusCombo*)regiserStatusAtIndex:(NSUInteger)index {
  return [result regiserStatusAtIndex:index];
}
- (IsRegisterRspArgs_Builder *)addRegiserStatus:(IsRegisterRspArgs_RegisterStatusCombo*)value {
  if (result.regiserStatusArray == nil) {
    result.regiserStatusArray = [PBAppendableArray arrayWithValueType:PBArrayValueTypeObject];
  }
  [result.regiserStatusArray addObject:value];
  return self;
}
- (IsRegisterRspArgs_Builder *)setRegiserStatusArray:(NSArray *)array {
  result.regiserStatusArray = [PBAppendableArray arrayWithArray:array valueType:PBArrayValueTypeObject];
  return self;
}
- (IsRegisterRspArgs_Builder *)setRegiserStatusValues:(const IsRegisterRspArgs_RegisterStatusCombo* *)values count:(NSUInteger)count {
  result.regiserStatusArray = [PBAppendableArray arrayWithValues:values count:count valueType:PBArrayValueTypeObject];
  return self;
}
- (IsRegisterRspArgs_Builder *)clearRegiserStatus {
  result.regiserStatusArray = nil;
  return self;
}
@end
