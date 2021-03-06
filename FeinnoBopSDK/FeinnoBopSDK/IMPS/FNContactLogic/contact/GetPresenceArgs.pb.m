// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "GetPresenceArgs.pb.h"

@implementation GetPresenceArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [GetPresenceArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface GetPresenceArgs ()
@property (retain) PBAppendableArray * userListArray;
@end

@implementation GetPresenceArgs

@synthesize userListArray;
@dynamic userList;
- (void) dealloc {
  self.userListArray = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
  }
  return self;
}
static GetPresenceArgs* defaultGetPresenceArgsInstance = nil;
+ (void) initialize {
  if (self == [GetPresenceArgs class]) {
    defaultGetPresenceArgsInstance = [[GetPresenceArgs alloc] init];
  }
}
+ (GetPresenceArgs*) defaultInstance {
  return defaultGetPresenceArgsInstance;
}
- (GetPresenceArgs*) defaultInstance {
  return defaultGetPresenceArgsInstance;
}
- (PBArray *)userList {
  return userListArray;
}
- (NSString*)userListAtIndex:(NSUInteger)index {
  return [userListArray objectAtIndex:index];
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  const NSUInteger userListArrayCount = self.userListArray.count;
  if (userListArrayCount > 0) {
    const NSString* *values = (const NSString* *)self.userListArray.data;
    for (NSUInteger i = 0; i < userListArrayCount; ++i) {
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
    const NSUInteger count = self.userListArray.count;
    const NSString* *values = (const NSString* *)self.userListArray.data;
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
+ (GetPresenceArgs*) parseFromData:(NSData*) data {
  return (GetPresenceArgs*)[[[GetPresenceArgs builder] mergeFromData:data] build];
}
+ (GetPresenceArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetPresenceArgs*)[[[GetPresenceArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (GetPresenceArgs*) parseFromInputStream:(NSInputStream*) input {
  return (GetPresenceArgs*)[[[GetPresenceArgs builder] mergeFromInputStream:input] build];
}
+ (GetPresenceArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetPresenceArgs*)[[[GetPresenceArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GetPresenceArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (GetPresenceArgs*)[[[GetPresenceArgs builder] mergeFromCodedInputStream:input] build];
}
+ (GetPresenceArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetPresenceArgs*)[[[GetPresenceArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GetPresenceArgs_Builder*) builder {
  return [[[GetPresenceArgs_Builder alloc] init] autorelease];
}
+ (GetPresenceArgs_Builder*) builderWithPrototype:(GetPresenceArgs*) prototype {
  return [[GetPresenceArgs builder] mergeFrom:prototype];
}
- (GetPresenceArgs_Builder*) builder {
  return [GetPresenceArgs builder];
}
- (GetPresenceArgs_Builder*) toBuilder {
  return [GetPresenceArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  for (NSString* element in self.userListArray) {
    [output appendFormat:@"%@%@: %@\n", indent, @"userList", element];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[GetPresenceArgs class]]) {
    return NO;
  }
  GetPresenceArgs *otherMessage = other;
  return
      [self.userListArray isEqualToArray:otherMessage.userListArray] &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  NSUInteger hashCode = 7;
  for (NSString* element in self.userListArray) {
    hashCode = hashCode * 31 + [element hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface GetPresenceArgs_Builder()
@property (retain) GetPresenceArgs* result;
@end

@implementation GetPresenceArgs_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[GetPresenceArgs alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (GetPresenceArgs_Builder*) clear {
  self.result = [[[GetPresenceArgs alloc] init] autorelease];
  return self;
}
- (GetPresenceArgs_Builder*) clone {
  return [GetPresenceArgs builderWithPrototype:result];
}
- (GetPresenceArgs*) defaultInstance {
  return [GetPresenceArgs defaultInstance];
}
- (GetPresenceArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (GetPresenceArgs*) buildPartial {
  GetPresenceArgs* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (GetPresenceArgs_Builder*) mergeFrom:(GetPresenceArgs*) other {
  if (other == [GetPresenceArgs defaultInstance]) {
    return self;
  }
  if (other.userListArray.count > 0) {
    if (result.userListArray == nil) {
      result.userListArray = [[other.userListArray copyWithZone:[other.userListArray zone]] autorelease];
    } else {
      [result.userListArray appendArray:other.userListArray];
    }
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (GetPresenceArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (GetPresenceArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self addUserList:[input readString]];
        break;
      }
    }
  }
}
- (PBAppendableArray *)userList {
  return result.userListArray;
}
- (NSString*)userListAtIndex:(NSUInteger)index {
  return [result userListAtIndex:index];
}
- (GetPresenceArgs_Builder *)addUserList:(NSString*)value {
  if (result.userListArray == nil) {
    result.userListArray = [PBAppendableArray arrayWithValueType:PBArrayValueTypeObject];
  }
  [result.userListArray addObject:value];
  return self;
}
- (GetPresenceArgs_Builder *)setUserListArray:(NSArray *)array {
  result.userListArray = [PBAppendableArray arrayWithArray:array valueType:PBArrayValueTypeObject];
  return self;
}
- (GetPresenceArgs_Builder *)setUserListValues:(const NSString* *)values count:(NSUInteger)count {
  result.userListArray = [PBAppendableArray arrayWithValues:values count:count valueType:PBArrayValueTypeObject];
  return self;
}
- (GetPresenceArgs_Builder *)clearUserList {
  result.userListArray = nil;
  return self;
}
@end

