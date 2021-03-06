// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "SendWelcomeLanguageReqArgs.pb.h"
// @@protoc_insertion_point(imports)

@implementation SendWelcomeLanguageReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [SendWelcomeLanguageReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = registry;
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface SendWelcomeLanguageReqArgs ()
@property SInt32 isFirstLogin;
@end

@implementation SendWelcomeLanguageReqArgs

- (BOOL) hasIsFirstLogin {
  return !!hasIsFirstLogin_;
}
- (void) setHasIsFirstLogin:(BOOL) _value_ {
  hasIsFirstLogin_ = !!_value_;
}
@synthesize isFirstLogin;
- (instancetype) init {
  if ((self = [super init])) {
    self.isFirstLogin = 0;
  }
  return self;
}
static SendWelcomeLanguageReqArgs* defaultSendWelcomeLanguageReqArgsInstance = nil;
+ (void) initialize {
  if (self == [SendWelcomeLanguageReqArgs class]) {
    defaultSendWelcomeLanguageReqArgsInstance = [[SendWelcomeLanguageReqArgs alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultSendWelcomeLanguageReqArgsInstance;
}
- (instancetype) defaultInstance {
  return defaultSendWelcomeLanguageReqArgsInstance;
}
- (BOOL) isInitialized {
  if (!self.hasIsFirstLogin) {
    return NO;
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasIsFirstLogin) {
    [output writeInt32:1 value:self.isFirstLogin];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (SInt32) serializedSize {
  __block SInt32 size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasIsFirstLogin) {
    size_ += computeInt32Size(1, self.isFirstLogin);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (SendWelcomeLanguageReqArgs*) parseFromData:(NSData*) data {
  return (SendWelcomeLanguageReqArgs*)[[[SendWelcomeLanguageReqArgs builder] mergeFromData:data] build];
}
+ (SendWelcomeLanguageReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendWelcomeLanguageReqArgs*)[[[SendWelcomeLanguageReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (SendWelcomeLanguageReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (SendWelcomeLanguageReqArgs*)[[[SendWelcomeLanguageReqArgs builder] mergeFromInputStream:input] build];
}
+ (SendWelcomeLanguageReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendWelcomeLanguageReqArgs*)[[[SendWelcomeLanguageReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendWelcomeLanguageReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (SendWelcomeLanguageReqArgs*)[[[SendWelcomeLanguageReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (SendWelcomeLanguageReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (SendWelcomeLanguageReqArgs*)[[[SendWelcomeLanguageReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (SendWelcomeLanguageReqArgs_Builder*) builder {
  return [[SendWelcomeLanguageReqArgs_Builder alloc] init];
}
+ (SendWelcomeLanguageReqArgs_Builder*) builderWithPrototype:(SendWelcomeLanguageReqArgs*) prototype {
  return [[SendWelcomeLanguageReqArgs builder] mergeFrom:prototype];
}
- (SendWelcomeLanguageReqArgs_Builder*) builder {
  return [SendWelcomeLanguageReqArgs builder];
}
- (SendWelcomeLanguageReqArgs_Builder*) toBuilder {
  return [SendWelcomeLanguageReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasIsFirstLogin) {
    [output appendFormat:@"%@%@: %@\n", indent, @"isFirstLogin", [NSNumber numberWithInteger:self.isFirstLogin]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}

- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[SendWelcomeLanguageReqArgs class]]) {
    return NO;
  }
  SendWelcomeLanguageReqArgs *otherMessage = other;
  return
      self.hasIsFirstLogin == otherMessage.hasIsFirstLogin &&
      (!self.hasIsFirstLogin || self.isFirstLogin == otherMessage.isFirstLogin) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasIsFirstLogin) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInteger:self.isFirstLogin] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface SendWelcomeLanguageReqArgs_Builder()
@property (strong) SendWelcomeLanguageReqArgs* resultSendWelcomeLanguageReqArgs;
@end

@implementation SendWelcomeLanguageReqArgs_Builder
@synthesize resultSendWelcomeLanguageReqArgs;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultSendWelcomeLanguageReqArgs = [[SendWelcomeLanguageReqArgs alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultSendWelcomeLanguageReqArgs;
}
- (SendWelcomeLanguageReqArgs_Builder*) clear {
  self.resultSendWelcomeLanguageReqArgs = [[SendWelcomeLanguageReqArgs alloc] init];
  return self;
}
- (SendWelcomeLanguageReqArgs_Builder*) clone {
  return [SendWelcomeLanguageReqArgs builderWithPrototype:resultSendWelcomeLanguageReqArgs];
}
- (SendWelcomeLanguageReqArgs*) defaultInstance {
  return [SendWelcomeLanguageReqArgs defaultInstance];
}
- (SendWelcomeLanguageReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (SendWelcomeLanguageReqArgs*) buildPartial {
  SendWelcomeLanguageReqArgs* returnMe = resultSendWelcomeLanguageReqArgs;
  self.resultSendWelcomeLanguageReqArgs = nil;
  return returnMe;
}
- (SendWelcomeLanguageReqArgs_Builder*) mergeFrom:(SendWelcomeLanguageReqArgs*) other {
  if (other == [SendWelcomeLanguageReqArgs defaultInstance]) {
    return self;
  }
  if (other.hasIsFirstLogin) {
    [self setIsFirstLogin:other.isFirstLogin];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (SendWelcomeLanguageReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (SendWelcomeLanguageReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
      case 8: {
        [self setIsFirstLogin:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasIsFirstLogin {
  return resultSendWelcomeLanguageReqArgs.hasIsFirstLogin;
}
- (SInt32) isFirstLogin {
  return resultSendWelcomeLanguageReqArgs.isFirstLogin;
}
- (SendWelcomeLanguageReqArgs_Builder*) setIsFirstLogin:(SInt32) value {
  resultSendWelcomeLanguageReqArgs.hasIsFirstLogin = YES;
  resultSendWelcomeLanguageReqArgs.isFirstLogin = value;
  return self;
}
- (SendWelcomeLanguageReqArgs_Builder*) clearIsFirstLogin {
  resultSendWelcomeLanguageReqArgs.hasIsFirstLogin = NO;
  resultSendWelcomeLanguageReqArgs.isFirstLogin = 0;
  return self;
}
@end


// @@protoc_insertion_point(global_scope)
