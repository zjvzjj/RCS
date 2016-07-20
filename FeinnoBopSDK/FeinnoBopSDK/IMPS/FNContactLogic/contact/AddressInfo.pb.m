// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "AddressInfo.pb.h"

@implementation AddressInfoRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [AddressInfoRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface AddressInfo ()
@property (retain) NSString* name;
@property (retain) NSString* mobile;
@property (retain) NSString* email;
@end

@implementation AddressInfo

- (BOOL) hasName {
  return !!hasName_;
}
- (void) setHasName:(BOOL) value_ {
  hasName_ = !!value_;
}
@synthesize name;
- (BOOL) hasMobile {
  return !!hasMobile_;
}
- (void) setHasMobile:(BOOL) value_ {
  hasMobile_ = !!value_;
}
@synthesize mobile;
- (BOOL) hasEmail {
  return !!hasEmail_;
}
- (void) setHasEmail:(BOOL) value_ {
  hasEmail_ = !!value_;
}
@synthesize email;
- (void) dealloc {
  self.name = nil;
  self.mobile = nil;
  self.email = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.name = @"";
    self.mobile = @"";
    self.email = @"";
  }
  return self;
}
static AddressInfo* defaultAddressInfoInstance = nil;
+ (void) initialize {
  if (self == [AddressInfo class]) {
    defaultAddressInfoInstance = [[AddressInfo alloc] init];
  }
}
+ (AddressInfo*) defaultInstance {
  return defaultAddressInfoInstance;
}
- (AddressInfo*) defaultInstance {
  return defaultAddressInfoInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasName) {
    [output writeString:1 value:self.name];
  }
  if (self.hasMobile) {
    [output writeString:2 value:self.mobile];
  }
  if (self.hasEmail) {
    [output writeString:3 value:self.email];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasName) {
    size_ += computeStringSize(1, self.name);
  }
  if (self.hasMobile) {
    size_ += computeStringSize(2, self.mobile);
  }
  if (self.hasEmail) {
    size_ += computeStringSize(3, self.email);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (AddressInfo*) parseFromData:(NSData*) data {
  return (AddressInfo*)[[[AddressInfo builder] mergeFromData:data] build];
}
+ (AddressInfo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (AddressInfo*)[[[AddressInfo builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (AddressInfo*) parseFromInputStream:(NSInputStream*) input {
  return (AddressInfo*)[[[AddressInfo builder] mergeFromInputStream:input] build];
}
+ (AddressInfo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (AddressInfo*)[[[AddressInfo builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (AddressInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (AddressInfo*)[[[AddressInfo builder] mergeFromCodedInputStream:input] build];
}
+ (AddressInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (AddressInfo*)[[[AddressInfo builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (AddressInfo_Builder*) builder {
  return [[[AddressInfo_Builder alloc] init] autorelease];
}
+ (AddressInfo_Builder*) builderWithPrototype:(AddressInfo*) prototype {
  return [[AddressInfo builder] mergeFrom:prototype];
}
- (AddressInfo_Builder*) builder {
  return [AddressInfo builder];
}
- (AddressInfo_Builder*) toBuilder {
  return [AddressInfo builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasName) {
    [output appendFormat:@"%@%@: %@\n", indent, @"name", self.name];
  }
  if (self.hasMobile) {
    [output appendFormat:@"%@%@: %@\n", indent, @"mobile", self.mobile];
  }
  if (self.hasEmail) {
    [output appendFormat:@"%@%@: %@\n", indent, @"email", self.email];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[AddressInfo class]]) {
    return NO;
  }
  AddressInfo *otherMessage = other;
  return
      self.hasName == otherMessage.hasName &&
      (!self.hasName || [self.name isEqual:otherMessage.name]) &&
      self.hasMobile == otherMessage.hasMobile &&
      (!self.hasMobile || [self.mobile isEqual:otherMessage.mobile]) &&
      self.hasEmail == otherMessage.hasEmail &&
      (!self.hasEmail || [self.email isEqual:otherMessage.email]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  if (self.hasName) {
    hashCode = hashCode * 31 + [self.name hash];
  }
  if (self.hasMobile) {
    hashCode = hashCode * 31 + [self.mobile hash];
  }
  if (self.hasEmail) {
    hashCode = hashCode * 31 + [self.email hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface AddressInfo_Builder()
@property (retain) AddressInfo* result;
@end

@implementation AddressInfo_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[AddressInfo alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (AddressInfo_Builder*) clear {
  self.result = [[[AddressInfo alloc] init] autorelease];
  return self;
}
- (AddressInfo_Builder*) clone {
  return [AddressInfo builderWithPrototype:result];
}
- (AddressInfo*) defaultInstance {
  return [AddressInfo defaultInstance];
}
- (AddressInfo*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (AddressInfo*) buildPartial {
  AddressInfo* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (AddressInfo_Builder*) mergeFrom:(AddressInfo*) other {
  if (other == [AddressInfo defaultInstance]) {
    return self;
  }
  if (other.hasName) {
    [self setName:other.name];
  }
  if (other.hasMobile) {
    [self setMobile:other.mobile];
  }
  if (other.hasEmail) {
    [self setEmail:other.email];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (AddressInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (AddressInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setName:[input readString]];
        break;
      }
      case 18: {
        [self setMobile:[input readString]];
        break;
      }
      case 26: {
        [self setEmail:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasName {
  return result.hasName;
}
- (NSString*) name {
  return result.name;
}
- (AddressInfo_Builder*) setName:(NSString*) value {
  result.hasName = YES;
  result.name = value;
  return self;
}
- (AddressInfo_Builder*) clearName {
  result.hasName = NO;
  result.name = @"";
  return self;
}
- (BOOL) hasMobile {
  return result.hasMobile;
}
- (NSString*) mobile {
  return result.mobile;
}
- (AddressInfo_Builder*) setMobile:(NSString*) value {
  result.hasMobile = YES;
  result.mobile = value;
  return self;
}
- (AddressInfo_Builder*) clearMobile {
  result.hasMobile = NO;
  result.mobile = @"";
  return self;
}
- (BOOL) hasEmail {
  return result.hasEmail;
}
- (NSString*) email {
  return result.email;
}
- (AddressInfo_Builder*) setEmail:(NSString*) value {
  result.hasEmail = YES;
  result.email = value;
  return self;
}
- (AddressInfo_Builder*) clearEmail {
  result.hasEmail = NO;
  result.email = @"";
  return self;
}
@end
