// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "GetRelationShipReqArgs.pb.h"

@implementation GetRelationShipReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [GetRelationShipReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface GetRelationShipReqArgs ()
@property int32_t extentNo;
@property (retain) NSString* targetUserId;
@property (retain) NSString* startUserId;
@end

@implementation GetRelationShipReqArgs

- (BOOL) hasExtentNo {
  return !!hasExtentNo_;
}
- (void) setHasExtentNo:(BOOL) value_ {
  hasExtentNo_ = !!value_;
}
@synthesize extentNo;
- (BOOL) hasTargetUserId {
  return !!hasTargetUserId_;
}
- (void) setHasTargetUserId:(BOOL) value_ {
  hasTargetUserId_ = !!value_;
}
@synthesize targetUserId;
- (BOOL) hasStartUserId {
  return !!hasStartUserId_;
}
- (void) setHasStartUserId:(BOOL) value_ {
  hasStartUserId_ = !!value_;
}
@synthesize startUserId;
- (void) dealloc {
  self.targetUserId = nil;
  self.startUserId = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.extentNo = 0;
    self.targetUserId = @"";
    self.startUserId = @"";
  }
  return self;
}
static GetRelationShipReqArgs* defaultGetRelationShipReqArgsInstance = nil;
+ (void) initialize {
  if (self == [GetRelationShipReqArgs class]) {
    defaultGetRelationShipReqArgsInstance = [[GetRelationShipReqArgs alloc] init];
  }
}
+ (GetRelationShipReqArgs*) defaultInstance {
  return defaultGetRelationShipReqArgsInstance;
}
- (GetRelationShipReqArgs*) defaultInstance {
  return defaultGetRelationShipReqArgsInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasExtentNo) {
    [output writeInt32:1 value:self.extentNo];
  }
  if (self.hasTargetUserId) {
    [output writeString:2 value:self.targetUserId];
  }
  if (self.hasStartUserId) {
    [output writeString:3 value:self.startUserId];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasExtentNo) {
    size_ += computeInt32Size(1, self.extentNo);
  }
  if (self.hasTargetUserId) {
    size_ += computeStringSize(2, self.targetUserId);
  }
  if (self.hasStartUserId) {
    size_ += computeStringSize(3, self.startUserId);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (GetRelationShipReqArgs*) parseFromData:(NSData*) data {
  return (GetRelationShipReqArgs*)[[[GetRelationShipReqArgs builder] mergeFromData:data] build];
}
+ (GetRelationShipReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetRelationShipReqArgs*)[[[GetRelationShipReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (GetRelationShipReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (GetRelationShipReqArgs*)[[[GetRelationShipReqArgs builder] mergeFromInputStream:input] build];
}
+ (GetRelationShipReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetRelationShipReqArgs*)[[[GetRelationShipReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GetRelationShipReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (GetRelationShipReqArgs*)[[[GetRelationShipReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (GetRelationShipReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetRelationShipReqArgs*)[[[GetRelationShipReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GetRelationShipReqArgs_Builder*) builder {
  return [[[GetRelationShipReqArgs_Builder alloc] init] autorelease];
}
+ (GetRelationShipReqArgs_Builder*) builderWithPrototype:(GetRelationShipReqArgs*) prototype {
  return [[GetRelationShipReqArgs builder] mergeFrom:prototype];
}
- (GetRelationShipReqArgs_Builder*) builder {
  return [GetRelationShipReqArgs builder];
}
- (GetRelationShipReqArgs_Builder*) toBuilder {
  return [GetRelationShipReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasExtentNo) {
    [output appendFormat:@"%@%@: %@\n", indent, @"extentNo", [NSNumber numberWithInt:self.extentNo]];
  }
  if (self.hasTargetUserId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"targetUserId", self.targetUserId];
  }
  if (self.hasStartUserId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"startUserId", self.startUserId];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[GetRelationShipReqArgs class]]) {
    return NO;
  }
  GetRelationShipReqArgs *otherMessage = other;
  return
      self.hasExtentNo == otherMessage.hasExtentNo &&
      (!self.hasExtentNo || self.extentNo == otherMessage.extentNo) &&
      self.hasTargetUserId == otherMessage.hasTargetUserId &&
      (!self.hasTargetUserId || [self.targetUserId isEqual:otherMessage.targetUserId]) &&
      self.hasStartUserId == otherMessage.hasStartUserId &&
      (!self.hasStartUserId || [self.startUserId isEqual:otherMessage.startUserId]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasExtentNo) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInt:self.extentNo] hash];
  }
  if (self.hasTargetUserId) {
    hashCode = hashCode * 31 + [self.targetUserId hash];
  }
  if (self.hasStartUserId) {
    hashCode = hashCode * 31 + [self.startUserId hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface GetRelationShipReqArgs_Builder()
@property (retain) GetRelationShipReqArgs* result;
@end

@implementation GetRelationShipReqArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[GetRelationShipReqArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (GetRelationShipReqArgs_Builder*) clear {
  self.result = [[[GetRelationShipReqArgs alloc] init] autorelease];
  return self;
}
- (GetRelationShipReqArgs_Builder*) clone {
  return [GetRelationShipReqArgs builderWithPrototype:result];
}
- (GetRelationShipReqArgs*) defaultInstance {
  return [GetRelationShipReqArgs defaultInstance];
}
- (GetRelationShipReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (GetRelationShipReqArgs*) buildPartial {
  GetRelationShipReqArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (GetRelationShipReqArgs_Builder*) mergeFrom:(GetRelationShipReqArgs*) other {
  if (other == [GetRelationShipReqArgs defaultInstance]) {
    return self;
  }
  if (other.hasExtentNo) {
    [self setExtentNo:other.extentNo];
  }
  if (other.hasTargetUserId) {
    [self setTargetUserId:other.targetUserId];
  }
  if (other.hasStartUserId) {
    [self setStartUserId:other.startUserId];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (GetRelationShipReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (GetRelationShipReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setExtentNo:[input readInt32]];
        break;
      }
      case 18: {
        [self setTargetUserId:[input readString]];
        break;
      }
      case 26: {
        [self setStartUserId:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasExtentNo {
  return result.hasExtentNo;
}
- (int32_t) extentNo {
  return result.extentNo;
}
- (GetRelationShipReqArgs_Builder*) setExtentNo:(int32_t) value {
  result.hasExtentNo = YES;
  result.extentNo = value;
  return self;
}
- (GetRelationShipReqArgs_Builder*) clearExtentNo {
  result.hasExtentNo = NO;
  result.extentNo = 0;
  return self;
}
- (BOOL) hasTargetUserId {
  return result.hasTargetUserId;
}
- (NSString*) targetUserId {
  return result.targetUserId;
}
- (GetRelationShipReqArgs_Builder*) setTargetUserId:(NSString*) value {
  result.hasTargetUserId = YES;
  result.targetUserId = value;
  return self;
}
- (GetRelationShipReqArgs_Builder*) clearTargetUserId {
  result.hasTargetUserId = NO;
  result.targetUserId = @"";
  return self;
}
- (BOOL) hasStartUserId {
  return result.hasStartUserId;
}
- (NSString*) startUserId {
  return result.startUserId;
}
- (GetRelationShipReqArgs_Builder*) setStartUserId:(NSString*) value {
  result.hasStartUserId = YES;
  result.startUserId = value;
  return self;
}
- (GetRelationShipReqArgs_Builder*) clearStartUserId {
  result.hasStartUserId = NO;
  result.startUserId = @"";
  return self;
}
@end
