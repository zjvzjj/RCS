// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "GetAddressListReqArgs.pb.h"

@implementation GetAddressListReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [GetAddressListReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface GetAddressListReqArgs ()
@property BOOL isDetail;
@property (retain) PBAppendableArray * addresslistIdsArray;
@property (retain) NSString* startAddresslistId;
@property int32_t countNum;
@end

@implementation GetAddressListReqArgs

- (BOOL) hasIsDetail {
  return !!hasIsDetail_;
}
- (void) setHasIsDetail:(BOOL) value_ {
  hasIsDetail_ = !!value_;
}
- (BOOL) isDetail {
  return !!isDetail_;
}
- (void) setIsDetail:(BOOL) value_ {
  isDetail_ = !!value_;
}
@synthesize addresslistIdsArray;
@dynamic addresslistIds;
- (BOOL) hasStartAddresslistId {
  return !!hasStartAddresslistId_;
}
- (void) setHasStartAddresslistId:(BOOL) value_ {
  hasStartAddresslistId_ = !!value_;
}
@synthesize startAddresslistId;
- (BOOL) hasCountNum {
  return !!hasCountNum_;
}
- (void) setHasCountNum:(BOOL) value_ {
  hasCountNum_ = !!value_;
}
@synthesize countNum;
- (void) dealloc {
  self.addresslistIdsArray = nil;
  self.startAddresslistId = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.isDetail = NO;
    self.startAddresslistId = @"";
    self.countNum = 0;
  }
  return self;
}
static GetAddressListReqArgs* defaultGetAddressListReqArgsInstance = nil;
+ (void) initialize {
  if (self == [GetAddressListReqArgs class]) {
    defaultGetAddressListReqArgsInstance = [[GetAddressListReqArgs alloc] init];
  }
}
+ (GetAddressListReqArgs*) defaultInstance {
  return defaultGetAddressListReqArgsInstance;
}
- (GetAddressListReqArgs*) defaultInstance {
  return defaultGetAddressListReqArgsInstance;
}
- (PBArray *)addresslistIds {
  return addresslistIdsArray;
}
- (NSString*)addresslistIdsAtIndex:(NSUInteger)index {
  return [addresslistIdsArray objectAtIndex:index];
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasIsDetail) {
    [output writeBool:1 value:self.isDetail];
  }
  const NSUInteger addresslistIdsArrayCount = self.addresslistIdsArray.count;
  if (addresslistIdsArrayCount > 0) {
    const NSString* *values = (const NSString* *)self.addresslistIdsArray.data;
    for (NSUInteger i = 0; i < addresslistIdsArrayCount; ++i) {
      [output writeString:2 value:values[i]];
    }
  }
  if (self.hasStartAddresslistId) {
    [output writeString:3 value:self.startAddresslistId];
  }
  if (self.hasCountNum) {
    [output writeInt32:4 value:self.countNum];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasIsDetail) {
    size_ += computeBoolSize(1, self.isDetail);
  }
  {
    int32_t dataSize = 0;
    const NSUInteger count = self.addresslistIdsArray.count;
    const NSString* *values = (const NSString* *)self.addresslistIdsArray.data;
    for (NSUInteger i = 0; i < count; ++i) {
      dataSize += computeStringSizeNoTag(values[i]);
    }
    size_ += dataSize;
    size_ += 1 * count;
  }
  if (self.hasStartAddresslistId) {
    size_ += computeStringSize(3, self.startAddresslistId);
  }
  if (self.hasCountNum) {
    size_ += computeInt32Size(4, self.countNum);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (GetAddressListReqArgs*) parseFromData:(NSData*) data {
  return (GetAddressListReqArgs*)[[[GetAddressListReqArgs builder] mergeFromData:data] build];
}
+ (GetAddressListReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetAddressListReqArgs*)[[[GetAddressListReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (GetAddressListReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (GetAddressListReqArgs*)[[[GetAddressListReqArgs builder] mergeFromInputStream:input] build];
}
+ (GetAddressListReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetAddressListReqArgs*)[[[GetAddressListReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GetAddressListReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (GetAddressListReqArgs*)[[[GetAddressListReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (GetAddressListReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetAddressListReqArgs*)[[[GetAddressListReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GetAddressListReqArgs_Builder*) builder {
  return [[[GetAddressListReqArgs_Builder alloc] init] autorelease];
}
+ (GetAddressListReqArgs_Builder*) builderWithPrototype:(GetAddressListReqArgs*) prototype {
  return [[GetAddressListReqArgs builder] mergeFrom:prototype];
}
- (GetAddressListReqArgs_Builder*) builder {
  return [GetAddressListReqArgs builder];
}
- (GetAddressListReqArgs_Builder*) toBuilder {
  return [GetAddressListReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasIsDetail) {
    [output appendFormat:@"%@%@: %@\n", indent, @"isDetail", [NSNumber numberWithBool:self.isDetail]];
  }
  for (NSString* element in self.addresslistIdsArray) {
    [output appendFormat:@"%@%@: %@\n", indent, @"addresslistIds", element];
  }
  if (self.hasStartAddresslistId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"startAddresslistId", self.startAddresslistId];
  }
  if (self.hasCountNum) {
    [output appendFormat:@"%@%@: %@\n", indent, @"countNum", [NSNumber numberWithInt:self.countNum]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[GetAddressListReqArgs class]]) {
    return NO;
  }
  GetAddressListReqArgs *otherMessage = other;
  return
      self.hasIsDetail == otherMessage.hasIsDetail &&
      (!self.hasIsDetail || self.isDetail == otherMessage.isDetail) &&
      [self.addresslistIdsArray isEqualToArray:otherMessage.addresslistIdsArray] &&
      self.hasStartAddresslistId == otherMessage.hasStartAddresslistId &&
      (!self.hasStartAddresslistId || [self.startAddresslistId isEqual:otherMessage.startAddresslistId]) &&
      self.hasCountNum == otherMessage.hasCountNum &&
      (!self.hasCountNum || self.countNum == otherMessage.countNum) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasIsDetail) {
    hashCode = hashCode * 31 + [[NSNumber numberWithBool:self.isDetail] hash];
  }
  for (NSString* element in self.addresslistIdsArray) {
    hashCode = hashCode * 31 + [element hash];
  }
  if (self.hasStartAddresslistId) {
    hashCode = hashCode * 31 + [self.startAddresslistId hash];
  }
  if (self.hasCountNum) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.countNum] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface GetAddressListReqArgs_Builder()
@property (retain) GetAddressListReqArgs* result;
@end

@implementation GetAddressListReqArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[GetAddressListReqArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (GetAddressListReqArgs_Builder*) clear {
  self.result = [[[GetAddressListReqArgs alloc] init] autorelease];
  return self;
}
- (GetAddressListReqArgs_Builder*) clone {
  return [GetAddressListReqArgs builderWithPrototype:result];
}
- (GetAddressListReqArgs*) defaultInstance {
  return [GetAddressListReqArgs defaultInstance];
}
- (GetAddressListReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (GetAddressListReqArgs*) buildPartial {
  GetAddressListReqArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (GetAddressListReqArgs_Builder*) mergeFrom:(GetAddressListReqArgs*) other {
  if (other == [GetAddressListReqArgs defaultInstance]) {
    return self;
  }
  if (other.hasIsDetail) {
    [self setIsDetail:other.isDetail];
  }
  if (other.addresslistIdsArray.count > 0) {
    if (result.addresslistIdsArray == nil) {
      result.addresslistIdsArray = [[other.addresslistIdsArray copyWithZone:[other.addresslistIdsArray zone]] autorelease];
    } else {
      [result.addresslistIdsArray appendArray:other.addresslistIdsArray];
    }
  }
  if (other.hasStartAddresslistId) {
    [self setStartAddresslistId:other.startAddresslistId];
  }
  if (other.hasCountNum) {
    [self setCountNum:other.countNum];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (GetAddressListReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (GetAddressListReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setIsDetail:[input readBool]];
        break;
      }
      case 18: {
        [self addAddresslistIds:[input readString]];
        break;
      }
      case 26: {
        [self setStartAddresslistId:[input readString]];
        break;
      }
      case 32: {
        [self setCountNum:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasIsDetail {
  return result.hasIsDetail;
}
- (BOOL) isDetail {
  return result.isDetail;
}
- (GetAddressListReqArgs_Builder*) setIsDetail:(BOOL) value {
  result.hasIsDetail = YES;
  result.isDetail = value;
  return self;
}
- (GetAddressListReqArgs_Builder*) clearIsDetail {
  result.hasIsDetail = NO;
  result.isDetail = NO;
  return self;
}
- (PBAppendableArray *)addresslistIds {
  return result.addresslistIdsArray;
}
- (NSString*)addresslistIdsAtIndex:(NSUInteger)index {
  return [result addresslistIdsAtIndex:index];
}
- (GetAddressListReqArgs_Builder *)addAddresslistIds:(NSString*)value {
  if (result.addresslistIdsArray == nil) {
    result.addresslistIdsArray = [PBAppendableArray arrayWithValueType:PBArrayValueTypeObject];
  }
  [result.addresslistIdsArray addObject:value];
  return self;
}
- (GetAddressListReqArgs_Builder *)setAddresslistIdsArray:(NSArray *)array {
  result.addresslistIdsArray = [PBAppendableArray arrayWithArray:array valueType:PBArrayValueTypeObject];
  return self;
}
- (GetAddressListReqArgs_Builder *)setAddresslistIdsValues:(const NSString* *)values count:(NSUInteger)count {
  result.addresslistIdsArray = [PBAppendableArray arrayWithValues:values count:count valueType:PBArrayValueTypeObject];
  return self;
}
- (GetAddressListReqArgs_Builder *)clearAddresslistIds {
  result.addresslistIdsArray = nil;
  return self;
}
- (BOOL) hasStartAddresslistId {
  return result.hasStartAddresslistId;
}
- (NSString*) startAddresslistId {
  return result.startAddresslistId;
}
- (GetAddressListReqArgs_Builder*) setStartAddresslistId:(NSString*) value {
  result.hasStartAddresslistId = YES;
  result.startAddresslistId = value;
  return self;
}
- (GetAddressListReqArgs_Builder*) clearStartAddresslistId {
  result.hasStartAddresslistId = NO;
  result.startAddresslistId = @"";
  return self;
}
- (BOOL) hasCountNum {
  return result.hasCountNum;
}
- (int32_t) countNum {
  return result.countNum;
}
- (GetAddressListReqArgs_Builder*) setCountNum:(int32_t) value {
  result.hasCountNum = YES;
  result.countNum = value;
  return self;
}
- (GetAddressListReqArgs_Builder*) clearCountNum {
  result.hasCountNum = NO;
  result.countNum = 0;
  return self;
}
@end
