// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "IsRegisterReqArgs.pb.h"

@implementation IsRegisterReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [IsRegisterReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface IsRegisterReqArgs ()
@property (retain) PBAppendableArray * destIdsArray;
@end

@implementation IsRegisterReqArgs

@synthesize destIdsArray;
@dynamic destIds;
- (void) dealloc {
  self.destIdsArray = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
  }
  return self;
}
static IsRegisterReqArgs* defaultIsRegisterReqArgsInstance = nil;
+ (void) initialize {
  if (self == [IsRegisterReqArgs class]) {
    defaultIsRegisterReqArgsInstance = [[IsRegisterReqArgs alloc] init];
  }
}
+ (IsRegisterReqArgs*) defaultInstance {
  return defaultIsRegisterReqArgsInstance;
}
- (IsRegisterReqArgs*) defaultInstance {
  return defaultIsRegisterReqArgsInstance;
}
- (PBArray *)destIds {
  return destIdsArray;
}
- (NSString*)destIdsAtIndex:(NSUInteger)index {
  return [destIdsArray objectAtIndex:index];
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  const NSUInteger destIdsArrayCount = self.destIdsArray.count;
  if (destIdsArrayCount > 0) {
    const NSString* *values = (const NSString* *)self.destIdsArray.data;
    for (NSUInteger i = 0; i < destIdsArrayCount; ++i) {
      [output writeString:1 value:values[i]];
    }
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  {
    int32_t dataSize = 0;
    const NSUInteger count = self.destIdsArray.count;
    const NSString* *values = (const NSString* *)self.destIdsArray.data;
    for (NSUInteger i = 0; i < count; ++i) {
      dataSize += computeStringSizeNoTag(values[i]);
    }
    size_ += dataSize;
    size_ += 1 * count;
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (IsRegisterReqArgs*) parseFromData:(NSData*) data {
  return (IsRegisterReqArgs*)[[[IsRegisterReqArgs builder] mergeFromData:data] build];
}
+ (IsRegisterReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (IsRegisterReqArgs*)[[[IsRegisterReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (IsRegisterReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (IsRegisterReqArgs*)[[[IsRegisterReqArgs builder] mergeFromInputStream:input] build];
}
+ (IsRegisterReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (IsRegisterReqArgs*)[[[IsRegisterReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (IsRegisterReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (IsRegisterReqArgs*)[[[IsRegisterReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (IsRegisterReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (IsRegisterReqArgs*)[[[IsRegisterReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (IsRegisterReqArgs_Builder*) builder {
  return [[[IsRegisterReqArgs_Builder alloc] init] autorelease];
}
+ (IsRegisterReqArgs_Builder*) builderWithPrototype:(IsRegisterReqArgs*) prototype {
  return [[IsRegisterReqArgs builder] mergeFrom:prototype];
}
- (IsRegisterReqArgs_Builder*) builder {
  return [IsRegisterReqArgs builder];
}
- (IsRegisterReqArgs_Builder*) toBuilder {
  return [IsRegisterReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  for (NSString* element in self.destIdsArray) {
    [output appendFormat:@"%@%@: %@\n", indent, @"destIds", element];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[IsRegisterReqArgs class]]) {
    return NO;
  }
  IsRegisterReqArgs *otherMessage = other;
  return
      [self.destIdsArray isEqualToArray:otherMessage.destIdsArray] &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  for (NSString* element in self.destIdsArray) {
    hashCode = hashCode * 31 + [element hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface IsRegisterReqArgs_Builder()
@property (retain) IsRegisterReqArgs* result;
@end

@implementation IsRegisterReqArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[IsRegisterReqArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (IsRegisterReqArgs_Builder*) clear {
  self.result = [[[IsRegisterReqArgs alloc] init] autorelease];
  return self;
}
- (IsRegisterReqArgs_Builder*) clone {
  return [IsRegisterReqArgs builderWithPrototype:result];
}
- (IsRegisterReqArgs*) defaultInstance {
  return [IsRegisterReqArgs defaultInstance];
}
- (IsRegisterReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (IsRegisterReqArgs*) buildPartial {
  IsRegisterReqArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (IsRegisterReqArgs_Builder*) mergeFrom:(IsRegisterReqArgs*) other {
  if (other == [IsRegisterReqArgs defaultInstance]) {
    return self;
  }
  if (other.destIdsArray.count > 0) {
    if (result.destIdsArray == nil) {
      result.destIdsArray = [[other.destIdsArray copyWithZone:[other.destIdsArray zone]] autorelease];
    } else {
      [result.destIdsArray appendArray:other.destIdsArray];
    }
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (IsRegisterReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (IsRegisterReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self addDestIds:[input readString]];
        break;
      }
    }
  }
}
- (PBAppendableArray *)destIds {
  return result.destIdsArray;
}
- (NSString*)destIdsAtIndex:(NSUInteger)index {
  return [result destIdsAtIndex:index];
}
- (IsRegisterReqArgs_Builder *)addDestIds:(NSString*)value {
  if (result.destIdsArray == nil) {
    result.destIdsArray = [PBAppendableArray arrayWithValueType:PBArrayValueTypeObject];
  }
  [result.destIdsArray addObject:value];
  return self;
}
- (IsRegisterReqArgs_Builder *)setDestIdsArray:(NSArray *)array {
  result.destIdsArray = [PBAppendableArray arrayWithArray:array valueType:PBArrayValueTypeObject];
  return self;
}
- (IsRegisterReqArgs_Builder *)setDestIdsValues:(const NSString* *)values count:(NSUInteger)count {
  result.destIdsArray = [PBAppendableArray arrayWithValues:values count:count valueType:PBArrayValueTypeObject];
  return self;
}
- (IsRegisterReqArgs_Builder *)clearDestIds {
  result.destIdsArray = nil;
  return self;
}
@end

