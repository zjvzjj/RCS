// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "UpdateDeviceInfoReqArgs.pb.h"
// @@protoc_insertion_point(imports)

@implementation UpdateDeviceInfoReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [UpdateDeviceInfoReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = registry;
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface UpdateDeviceInfoReqArgs ()
@property (strong) NSString* userId;
@property (strong) NSString* clientType;
@property (strong) NSString* clientVersion;
@property (strong) NSString* token;
@end

@implementation UpdateDeviceInfoReqArgs

- (BOOL) hasUserId {
  return !!hasUserId_;
}
- (void) setHasUserId:(BOOL) _value_ {
  hasUserId_ = !!_value_;
}
@synthesize userId;
- (BOOL) hasClientType {
  return !!hasClientType_;
}
- (void) setHasClientType:(BOOL) _value_ {
  hasClientType_ = !!_value_;
}
@synthesize clientType;
- (BOOL) hasClientVersion {
  return !!hasClientVersion_;
}
- (void) setHasClientVersion:(BOOL) _value_ {
  hasClientVersion_ = !!_value_;
}
@synthesize clientVersion;
- (BOOL) hasToken {
  return !!hasToken_;
}
- (void) setHasToken:(BOOL) _value_ {
  hasToken_ = !!_value_;
}
@synthesize token;
- (instancetype) init {
  if ((self = [super init])) {
    self.userId = @"";
    self.clientType = @"";
    self.clientVersion = @"";
    self.token = @"";
  }
  return self;
}
static UpdateDeviceInfoReqArgs* defaultUpdateDeviceInfoReqArgsInstance = nil;
+ (void) initialize {
  if (self == [UpdateDeviceInfoReqArgs class]) {
    defaultUpdateDeviceInfoReqArgsInstance = [[UpdateDeviceInfoReqArgs alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultUpdateDeviceInfoReqArgsInstance;
}
- (instancetype) defaultInstance {
  return defaultUpdateDeviceInfoReqArgsInstance;
}
- (BOOL) isInitialized {
  if (!self.hasUserId) {
    return NO;
  }
  if (!self.hasClientType) {
    return NO;
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasUserId) {
    [output writeString:1 value:self.userId];
  }
  if (self.hasClientType) {
    [output writeString:2 value:self.clientType];
  }
  if (self.hasClientVersion) {
    [output writeString:3 value:self.clientVersion];
  }
  if (self.hasToken) {
    [output writeString:4 value:self.token];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  __block int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasUserId) {
    size_ += computeStringSize(1, self.userId);
  }
  if (self.hasClientType) {
    size_ += computeStringSize(2, self.clientType);
  }
  if (self.hasClientVersion) {
    size_ += computeStringSize(3, self.clientVersion);
  }
  if (self.hasToken) {
    size_ += computeStringSize(4, self.token);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (UpdateDeviceInfoReqArgs*) parseFromData:(NSData*) data {
  return (UpdateDeviceInfoReqArgs*)[[[UpdateDeviceInfoReqArgs builder] mergeFromData:data] build];
}
+ (UpdateDeviceInfoReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (UpdateDeviceInfoReqArgs*)[[[UpdateDeviceInfoReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (UpdateDeviceInfoReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (UpdateDeviceInfoReqArgs*)[[[UpdateDeviceInfoReqArgs builder] mergeFromInputStream:input] build];
}
+ (UpdateDeviceInfoReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (UpdateDeviceInfoReqArgs*)[[[UpdateDeviceInfoReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (UpdateDeviceInfoReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (UpdateDeviceInfoReqArgs*)[[[UpdateDeviceInfoReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (UpdateDeviceInfoReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (UpdateDeviceInfoReqArgs*)[[[UpdateDeviceInfoReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (UpdateDeviceInfoReqArgs_Builder*) builder {
  return [[UpdateDeviceInfoReqArgs_Builder alloc] init];
}
+ (UpdateDeviceInfoReqArgs_Builder*) builderWithPrototype:(UpdateDeviceInfoReqArgs*) prototype {
  return [[UpdateDeviceInfoReqArgs builder] mergeFrom:prototype];
}
- (UpdateDeviceInfoReqArgs_Builder*) builder {
  return [UpdateDeviceInfoReqArgs builder];
}
- (UpdateDeviceInfoReqArgs_Builder*) toBuilder {
  return [UpdateDeviceInfoReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasUserId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"userId", self.userId];
  }
  if (self.hasClientType) {
    [output appendFormat:@"%@%@: %@\n", indent, @"clientType", self.clientType];
  }
  if (self.hasClientVersion) {
    [output appendFormat:@"%@%@: %@\n", indent, @"clientVersion", self.clientVersion];
  }
  if (self.hasToken) {
    [output appendFormat:@"%@%@: %@\n", indent, @"token", self.token];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[UpdateDeviceInfoReqArgs class]]) {
    return NO;
  }
  UpdateDeviceInfoReqArgs *otherMessage = other;
  return
      self.hasUserId == otherMessage.hasUserId &&
      (!self.hasUserId || [self.userId isEqual:otherMessage.userId]) &&
      self.hasClientType == otherMessage.hasClientType &&
      (!self.hasClientType || [self.clientType isEqual:otherMessage.clientType]) &&
      self.hasClientVersion == otherMessage.hasClientVersion &&
      (!self.hasClientVersion || [self.clientVersion isEqual:otherMessage.clientVersion]) &&
      self.hasToken == otherMessage.hasToken &&
      (!self.hasToken || [self.token isEqual:otherMessage.token]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasUserId) {
    hashCode = hashCode * 31 + [self.userId hash];
  }
  if (self.hasClientType) {
    hashCode = hashCode * 31 + [self.clientType hash];
  }
  if (self.hasClientVersion) {
    hashCode = hashCode * 31 + [self.clientVersion hash];
  }
  if (self.hasToken) {
    hashCode = hashCode * 31 + [self.token hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface UpdateDeviceInfoReqArgs_Builder()
@property (strong) UpdateDeviceInfoReqArgs* resultUpdateDeviceInfoReqArgs;
@end

@implementation UpdateDeviceInfoReqArgs_Builder
@synthesize resultUpdateDeviceInfoReqArgs;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultUpdateDeviceInfoReqArgs = [[UpdateDeviceInfoReqArgs alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultUpdateDeviceInfoReqArgs;
}
- (UpdateDeviceInfoReqArgs_Builder*) clear {
  self.resultUpdateDeviceInfoReqArgs = [[UpdateDeviceInfoReqArgs alloc] init];
  return self;
}
- (UpdateDeviceInfoReqArgs_Builder*) clone {
  return [UpdateDeviceInfoReqArgs builderWithPrototype:resultUpdateDeviceInfoReqArgs];
}
- (UpdateDeviceInfoReqArgs*) defaultInstance {
  return [UpdateDeviceInfoReqArgs defaultInstance];
}
- (UpdateDeviceInfoReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (UpdateDeviceInfoReqArgs*) buildPartial {
  UpdateDeviceInfoReqArgs* returnMe = resultUpdateDeviceInfoReqArgs;
  self.resultUpdateDeviceInfoReqArgs = nil;
  return returnMe;
}
- (UpdateDeviceInfoReqArgs_Builder*) mergeFrom:(UpdateDeviceInfoReqArgs*) other {
  if (other == [UpdateDeviceInfoReqArgs defaultInstance]) {
    return self;
  }
  if (other.hasUserId) {
    [self setUserId:other.userId];
  }
  if (other.hasClientType) {
    [self setClientType:other.clientType];
  }
  if (other.hasClientVersion) {
    [self setClientVersion:other.clientVersion];
  }
  if (other.hasToken) {
    [self setToken:other.token];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (UpdateDeviceInfoReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (UpdateDeviceInfoReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setUserId:[input readString]];
        break;
      }
      case 18: {
        [self setClientType:[input readString]];
        break;
      }
      case 26: {
        [self setClientVersion:[input readString]];
        break;
      }
      case 34: {
        [self setToken:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasUserId {
  return resultUpdateDeviceInfoReqArgs.hasUserId;
}
- (NSString*) userId {
  return resultUpdateDeviceInfoReqArgs.userId;
}
- (UpdateDeviceInfoReqArgs_Builder*) setUserId:(NSString*) value {
  resultUpdateDeviceInfoReqArgs.hasUserId = YES;
  resultUpdateDeviceInfoReqArgs.userId = value;
  return self;
}
- (UpdateDeviceInfoReqArgs_Builder*) clearUserId {
  resultUpdateDeviceInfoReqArgs.hasUserId = NO;
  resultUpdateDeviceInfoReqArgs.userId = @"";
  return self;
}
- (BOOL) hasClientType {
  return resultUpdateDeviceInfoReqArgs.hasClientType;
}
- (NSString*) clientType {
  return resultUpdateDeviceInfoReqArgs.clientType;
}
- (UpdateDeviceInfoReqArgs_Builder*) setClientType:(NSString*) value {
  resultUpdateDeviceInfoReqArgs.hasClientType = YES;
  resultUpdateDeviceInfoReqArgs.clientType = value;
  return self;
}
- (UpdateDeviceInfoReqArgs_Builder*) clearClientType {
  resultUpdateDeviceInfoReqArgs.hasClientType = NO;
  resultUpdateDeviceInfoReqArgs.clientType = @"";
  return self;
}
- (BOOL) hasClientVersion {
  return resultUpdateDeviceInfoReqArgs.hasClientVersion;
}
- (NSString*) clientVersion {
  return resultUpdateDeviceInfoReqArgs.clientVersion;
}
- (UpdateDeviceInfoReqArgs_Builder*) setClientVersion:(NSString*) value {
  resultUpdateDeviceInfoReqArgs.hasClientVersion = YES;
  resultUpdateDeviceInfoReqArgs.clientVersion = value;
  return self;
}
- (UpdateDeviceInfoReqArgs_Builder*) clearClientVersion {
  resultUpdateDeviceInfoReqArgs.hasClientVersion = NO;
  resultUpdateDeviceInfoReqArgs.clientVersion = @"";
  return self;
}
- (BOOL) hasToken {
  return resultUpdateDeviceInfoReqArgs.hasToken;
}
- (NSString*) token {
  return resultUpdateDeviceInfoReqArgs.token;
}
- (UpdateDeviceInfoReqArgs_Builder*) setToken:(NSString*) value {
  resultUpdateDeviceInfoReqArgs.hasToken = YES;
  resultUpdateDeviceInfoReqArgs.token = value;
  return self;
}
- (UpdateDeviceInfoReqArgs_Builder*) clearToken {
  resultUpdateDeviceInfoReqArgs.hasToken = NO;
  resultUpdateDeviceInfoReqArgs.token = @"";
  return self;
}
@end


// @@protoc_insertion_point(global_scope)
