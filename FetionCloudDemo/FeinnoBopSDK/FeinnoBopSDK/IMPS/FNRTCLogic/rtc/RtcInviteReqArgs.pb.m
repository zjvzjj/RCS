// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "RtcInviteReqArgs.pb.h"

@implementation RtcInviteReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [RtcInviteReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface RtcInviteReqArgs ()
@property (retain) RtcInviteReqArgs_CallInfo* callInfo;
@property (retain) NSString* sdp;
@end

@implementation RtcInviteReqArgs

- (BOOL) hasCallInfo {
  return !!hasCallInfo_;
}
- (void) setHasCallInfo:(BOOL) value_ {
  hasCallInfo_ = !!value_;
}
@synthesize callInfo;
- (BOOL) hasSdp {
  return !!hasSdp_;
}
- (void) setHasSdp:(BOOL) value_ {
  hasSdp_ = !!value_;
}
@synthesize sdp;
- (void) dealloc {
  self.callInfo = nil;
  self.sdp = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.callInfo = [RtcInviteReqArgs_CallInfo defaultInstance];
    self.sdp = @"";
  }
  return self;
}
static RtcInviteReqArgs* defaultRtcInviteReqArgsInstance = nil;
+ (void) initialize {
  if (self == [RtcInviteReqArgs class]) {
    defaultRtcInviteReqArgsInstance = [[RtcInviteReqArgs alloc] init];
  }
}
+ (RtcInviteReqArgs*) defaultInstance {
  return defaultRtcInviteReqArgsInstance;
}
- (RtcInviteReqArgs*) defaultInstance {
  return defaultRtcInviteReqArgsInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasCallInfo) {
    [output writeMessage:1 value:self.callInfo];
  }
  if (self.hasSdp) {
    [output writeString:2 value:self.sdp];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasCallInfo) {
    size_ += computeMessageSize(1, self.callInfo);
  }
  if (self.hasSdp) {
    size_ += computeStringSize(2, self.sdp);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (RtcInviteReqArgs*) parseFromData:(NSData*) data {
  return (RtcInviteReqArgs*)[[[RtcInviteReqArgs builder] mergeFromData:data] build];
}
+ (RtcInviteReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcInviteReqArgs*)[[[RtcInviteReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (RtcInviteReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (RtcInviteReqArgs*)[[[RtcInviteReqArgs builder] mergeFromInputStream:input] build];
}
+ (RtcInviteReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcInviteReqArgs*)[[[RtcInviteReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (RtcInviteReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (RtcInviteReqArgs*)[[[RtcInviteReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (RtcInviteReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcInviteReqArgs*)[[[RtcInviteReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (RtcInviteReqArgs_Builder*) builder {
  return [[[RtcInviteReqArgs_Builder alloc] init] autorelease];
}
+ (RtcInviteReqArgs_Builder*) builderWithPrototype:(RtcInviteReqArgs*) prototype {
  return [[RtcInviteReqArgs builder] mergeFrom:prototype];
}
- (RtcInviteReqArgs_Builder*) builder {
  return [RtcInviteReqArgs builder];
}
- (RtcInviteReqArgs_Builder*) toBuilder {
  return [RtcInviteReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasCallInfo) {
    [output appendFormat:@"%@%@ {\n", indent, @"callInfo"];
    [self.callInfo writeDescriptionTo:output
                         withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
  }
  if (self.hasSdp) {
    [output appendFormat:@"%@%@: %@\n", indent, @"sdp", self.sdp];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[RtcInviteReqArgs class]]) {
    return NO;
  }
  RtcInviteReqArgs *otherMessage = other;
  return
      self.hasCallInfo == otherMessage.hasCallInfo &&
      (!self.hasCallInfo || [self.callInfo isEqual:otherMessage.callInfo]) &&
      self.hasSdp == otherMessage.hasSdp &&
      (!self.hasSdp || [self.sdp isEqual:otherMessage.sdp]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasCallInfo) {
    hashCode = hashCode * 31 + [self.callInfo hash];
  }
  if (self.hasSdp) {
    hashCode = hashCode * 31 + [self.sdp hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface RtcInviteReqArgs_CallInfo ()
@property (retain) NSString* peerUserId;
@property (retain) NSString* callId;
@end

@implementation RtcInviteReqArgs_CallInfo

- (BOOL) hasPeerUserId {
  return !!hasPeerUserId_;
}
- (void) setHasPeerUserId:(BOOL) value_ {
  hasPeerUserId_ = !!value_;
}
@synthesize peerUserId;
- (BOOL) hasCallId {
  return !!hasCallId_;
}
- (void) setHasCallId:(BOOL) value_ {
  hasCallId_ = !!value_;
}
@synthesize callId;
- (void) dealloc {
  self.peerUserId = nil;
  self.callId = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.peerUserId = @"";
    self.callId = @"";
  }
  return self;
}
static RtcInviteReqArgs_CallInfo* defaultRtcInviteReqArgs_CallInfoInstance = nil;
+ (void) initialize {
  if (self == [RtcInviteReqArgs_CallInfo class]) {
    defaultRtcInviteReqArgs_CallInfoInstance = [[RtcInviteReqArgs_CallInfo alloc] init];
  }
}
+ (RtcInviteReqArgs_CallInfo*) defaultInstance {
  return defaultRtcInviteReqArgs_CallInfoInstance;
}
- (RtcInviteReqArgs_CallInfo*) defaultInstance {
  return defaultRtcInviteReqArgs_CallInfoInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasPeerUserId) {
    [output writeString:1 value:self.peerUserId];
  }
  if (self.hasCallId) {
    [output writeString:2 value:self.callId];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasPeerUserId) {
    size_ += computeStringSize(1, self.peerUserId);
  }
  if (self.hasCallId) {
    size_ += computeStringSize(2, self.callId);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (RtcInviteReqArgs_CallInfo*) parseFromData:(NSData*) data {
  return (RtcInviteReqArgs_CallInfo*)[[[RtcInviteReqArgs_CallInfo builder] mergeFromData:data] build];
}
+ (RtcInviteReqArgs_CallInfo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcInviteReqArgs_CallInfo*)[[[RtcInviteReqArgs_CallInfo builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (RtcInviteReqArgs_CallInfo*) parseFromInputStream:(NSInputStream*) input {
  return (RtcInviteReqArgs_CallInfo*)[[[RtcInviteReqArgs_CallInfo builder] mergeFromInputStream:input] build];
}
+ (RtcInviteReqArgs_CallInfo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcInviteReqArgs_CallInfo*)[[[RtcInviteReqArgs_CallInfo builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (RtcInviteReqArgs_CallInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (RtcInviteReqArgs_CallInfo*)[[[RtcInviteReqArgs_CallInfo builder] mergeFromCodedInputStream:input] build];
}
+ (RtcInviteReqArgs_CallInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (RtcInviteReqArgs_CallInfo*)[[[RtcInviteReqArgs_CallInfo builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (RtcInviteReqArgs_CallInfo_Builder*) builder {
  return [[[RtcInviteReqArgs_CallInfo_Builder alloc] init] autorelease];
}
+ (RtcInviteReqArgs_CallInfo_Builder*) builderWithPrototype:(RtcInviteReqArgs_CallInfo*) prototype {
  return [[RtcInviteReqArgs_CallInfo builder] mergeFrom:prototype];
}
- (RtcInviteReqArgs_CallInfo_Builder*) builder {
  return [RtcInviteReqArgs_CallInfo builder];
}
- (RtcInviteReqArgs_CallInfo_Builder*) toBuilder {
  return [RtcInviteReqArgs_CallInfo builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasPeerUserId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"peerUserId", self.peerUserId];
  }
  if (self.hasCallId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"callId", self.callId];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[RtcInviteReqArgs_CallInfo class]]) {
    return NO;
  }
  RtcInviteReqArgs_CallInfo *otherMessage = other;
  return
      self.hasPeerUserId == otherMessage.hasPeerUserId &&
      (!self.hasPeerUserId || [self.peerUserId isEqual:otherMessage.peerUserId]) &&
      self.hasCallId == otherMessage.hasCallId &&
      (!self.hasCallId || [self.callId isEqual:otherMessage.callId]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasPeerUserId) {
    hashCode = hashCode * 31 + [self.peerUserId hash];
  }
  if (self.hasCallId) {
    hashCode = hashCode * 31 + [self.callId hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface RtcInviteReqArgs_CallInfo_Builder()
@property (retain) RtcInviteReqArgs_CallInfo* result;
@end

@implementation RtcInviteReqArgs_CallInfo_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[RtcInviteReqArgs_CallInfo alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (RtcInviteReqArgs_CallInfo_Builder*) clear {
  self.result = [[[RtcInviteReqArgs_CallInfo alloc] init] autorelease];
  return self;
}
- (RtcInviteReqArgs_CallInfo_Builder*) clone {
  return [RtcInviteReqArgs_CallInfo builderWithPrototype:result];
}
- (RtcInviteReqArgs_CallInfo*) defaultInstance {
  return [RtcInviteReqArgs_CallInfo defaultInstance];
}
- (RtcInviteReqArgs_CallInfo*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (RtcInviteReqArgs_CallInfo*) buildPartial {
  RtcInviteReqArgs_CallInfo* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (RtcInviteReqArgs_CallInfo_Builder*) mergeFrom:(RtcInviteReqArgs_CallInfo*) other {
  if (other == [RtcInviteReqArgs_CallInfo defaultInstance]) {
    return self;
  }
  if (other.hasPeerUserId) {
    [self setPeerUserId:other.peerUserId];
  }
  if (other.hasCallId) {
    [self setCallId:other.callId];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (RtcInviteReqArgs_CallInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (RtcInviteReqArgs_CallInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setPeerUserId:[input readString]];
        break;
      }
      case 18: {
        [self setCallId:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasPeerUserId {
  return result.hasPeerUserId;
}
- (NSString*) peerUserId {
  return result.peerUserId;
}
- (RtcInviteReqArgs_CallInfo_Builder*) setPeerUserId:(NSString*) value {
  result.hasPeerUserId = YES;
  result.peerUserId = value;
  return self;
}
- (RtcInviteReqArgs_CallInfo_Builder*) clearPeerUserId {
  result.hasPeerUserId = NO;
  result.peerUserId = @"";
  return self;
}
- (BOOL) hasCallId {
  return result.hasCallId;
}
- (NSString*) callId {
  return result.callId;
}
- (RtcInviteReqArgs_CallInfo_Builder*) setCallId:(NSString*) value {
  result.hasCallId = YES;
  result.callId = value;
  return self;
}
- (RtcInviteReqArgs_CallInfo_Builder*) clearCallId {
  result.hasCallId = NO;
  result.callId = @"";
  return self;
}
@end

@interface RtcInviteReqArgs_Builder()
@property (retain) RtcInviteReqArgs* result;
@end

@implementation RtcInviteReqArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[RtcInviteReqArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (RtcInviteReqArgs_Builder*) clear {
  self.result = [[[RtcInviteReqArgs alloc] init] autorelease];
  return self;
}
- (RtcInviteReqArgs_Builder*) clone {
  return [RtcInviteReqArgs builderWithPrototype:result];
}
- (RtcInviteReqArgs*) defaultInstance {
  return [RtcInviteReqArgs defaultInstance];
}
- (RtcInviteReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (RtcInviteReqArgs*) buildPartial {
  RtcInviteReqArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (RtcInviteReqArgs_Builder*) mergeFrom:(RtcInviteReqArgs*) other {
  if (other == [RtcInviteReqArgs defaultInstance]) {
    return self;
  }
  if (other.hasCallInfo) {
    [self mergeCallInfo:other.callInfo];
  }
  if (other.hasSdp) {
    [self setSdp:other.sdp];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (RtcInviteReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (RtcInviteReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        RtcInviteReqArgs_CallInfo_Builder* subBuilder = [RtcInviteReqArgs_CallInfo builder];
        if (self.hasCallInfo) {
          [subBuilder mergeFrom:self.callInfo];
        }
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self setCallInfo:[subBuilder buildPartial]];
        break;
      }
      case 18: {
        [self setSdp:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasCallInfo {
  return result.hasCallInfo;
}
- (RtcInviteReqArgs_CallInfo*) callInfo {
  return result.callInfo;
}
- (RtcInviteReqArgs_Builder*) setCallInfo:(RtcInviteReqArgs_CallInfo*) value {
  result.hasCallInfo = YES;
  result.callInfo = value;
  return self;
}
- (RtcInviteReqArgs_Builder*) setCallInfoBuilder:(RtcInviteReqArgs_CallInfo_Builder*) builderForValue {
  return [self setCallInfo:[builderForValue build]];
}
- (RtcInviteReqArgs_Builder*) mergeCallInfo:(RtcInviteReqArgs_CallInfo*) value {
  if (result.hasCallInfo &&
      result.callInfo != [RtcInviteReqArgs_CallInfo defaultInstance]) {
    result.callInfo =
      [[[RtcInviteReqArgs_CallInfo builderWithPrototype:result.callInfo] mergeFrom:value] buildPartial];
  } else {
    result.callInfo = value;
  }
  result.hasCallInfo = YES;
  return self;
}
- (RtcInviteReqArgs_Builder*) clearCallInfo {
  result.hasCallInfo = NO;
  result.callInfo = [RtcInviteReqArgs_CallInfo defaultInstance];
  return self;
}
- (BOOL) hasSdp {
  return result.hasSdp;
}
- (NSString*) sdp {
  return result.sdp;
}
- (RtcInviteReqArgs_Builder*) setSdp:(NSString*) value {
  result.hasSdp = YES;
  result.sdp = value;
  return self;
}
- (RtcInviteReqArgs_Builder*) clearSdp {
  result.hasSdp = NO;
  result.sdp = @"";
  return self;
}
@end

