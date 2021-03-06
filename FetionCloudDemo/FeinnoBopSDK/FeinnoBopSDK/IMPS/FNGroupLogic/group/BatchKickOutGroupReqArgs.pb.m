// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "BatchKickOutGroupReqArgs.pb.h"
// @@protoc_insertion_point(imports)

@implementation BatchKickOutGroupReqArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [BatchKickOutGroupReqArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = registry;
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface BatchKickOutGroupReqArgs ()
@property (strong) NSString* groupId;
@property (strong) NSMutableArray * userIdListArray;
@end

@implementation BatchKickOutGroupReqArgs

- (BOOL) hasGroupId {
  return !!hasGroupId_;
}
- (void) setHasGroupId:(BOOL) _value_ {
  hasGroupId_ = !!_value_;
}
@synthesize groupId;
@synthesize userIdListArray;
@dynamic userIdList;
- (instancetype) init {
  if ((self = [super init])) {
    self.groupId = @"";
  }
  return self;
}
static BatchKickOutGroupReqArgs* defaultBatchKickOutGroupReqArgsInstance = nil;
+ (void) initialize {
  if (self == [BatchKickOutGroupReqArgs class]) {
    defaultBatchKickOutGroupReqArgsInstance = [[BatchKickOutGroupReqArgs alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultBatchKickOutGroupReqArgsInstance;
}
- (instancetype) defaultInstance {
  return defaultBatchKickOutGroupReqArgsInstance;
}
- (NSArray *)userIdList {
  return userIdListArray;
}
- (NSString*)userIdListAtIndex:(NSUInteger)index {
  return [userIdListArray objectAtIndex:index];
}
- (BOOL) isInitialized {
  if (!self.hasGroupId) {
    return NO;
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasGroupId) {
    [output writeString:1 value:self.groupId];
  }
  [self.userIdListArray enumerateObjectsUsingBlock:^(NSString *element, NSUInteger idx, BOOL *stop) {
    [output writeString:2 value:element];
  }];
  [self.unknownFields writeToCodedOutputStream:output];
}
- (SInt32) serializedSize {
  __block SInt32 size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasGroupId) {
    size_ += computeStringSize(1, self.groupId);
  }
  {
    __block SInt32 dataSize = 0;
    const NSUInteger count = self.userIdListArray.count;
    [self.userIdListArray enumerateObjectsUsingBlock:^(NSString *element, NSUInteger idx, BOOL *stop) {
      dataSize += computeStringSizeNoTag(element);
    }];
    size_ += dataSize;
    size_ += (SInt32)(1 * count);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (BatchKickOutGroupReqArgs*) parseFromData:(NSData*) data {
  return (BatchKickOutGroupReqArgs*)[[[BatchKickOutGroupReqArgs builder] mergeFromData:data] build];
}
+ (BatchKickOutGroupReqArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (BatchKickOutGroupReqArgs*)[[[BatchKickOutGroupReqArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (BatchKickOutGroupReqArgs*) parseFromInputStream:(NSInputStream*) input {
  return (BatchKickOutGroupReqArgs*)[[[BatchKickOutGroupReqArgs builder] mergeFromInputStream:input] build];
}
+ (BatchKickOutGroupReqArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (BatchKickOutGroupReqArgs*)[[[BatchKickOutGroupReqArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (BatchKickOutGroupReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (BatchKickOutGroupReqArgs*)[[[BatchKickOutGroupReqArgs builder] mergeFromCodedInputStream:input] build];
}
+ (BatchKickOutGroupReqArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (BatchKickOutGroupReqArgs*)[[[BatchKickOutGroupReqArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (BatchKickOutGroupReqArgs_Builder*) builder {
  return [[BatchKickOutGroupReqArgs_Builder alloc] init];
}
+ (BatchKickOutGroupReqArgs_Builder*) builderWithPrototype:(BatchKickOutGroupReqArgs*) prototype {
  return [[BatchKickOutGroupReqArgs builder] mergeFrom:prototype];
}
- (BatchKickOutGroupReqArgs_Builder*) builder {
  return [BatchKickOutGroupReqArgs builder];
}
- (BatchKickOutGroupReqArgs_Builder*) toBuilder {
  return [BatchKickOutGroupReqArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasGroupId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"groupId", self.groupId];
  }
  [self.userIdListArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [output appendFormat:@"%@%@: %@\n", indent, @"userIdList", obj];
  }];
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[BatchKickOutGroupReqArgs class]]) {
    return NO;
  }
  BatchKickOutGroupReqArgs *otherMessage = other;
  return
      self.hasGroupId == otherMessage.hasGroupId &&
      (!self.hasGroupId || [self.groupId isEqual:otherMessage.groupId]) &&
      [self.userIdListArray isEqualToArray:otherMessage.userIdListArray] &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasGroupId) {
    hashCode = hashCode * 31 + [self.groupId hash];
  }
  [self.userIdListArray enumerateObjectsUsingBlock:^(NSString *element, NSUInteger idx, BOOL *stop) {
    hashCode = hashCode * 31 + [element hash];
  }];
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface BatchKickOutGroupReqArgs_Builder()
@property (strong) BatchKickOutGroupReqArgs* resultBatchKickOutGroupReqArgs;
@end

@implementation BatchKickOutGroupReqArgs_Builder
@synthesize resultBatchKickOutGroupReqArgs;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultBatchKickOutGroupReqArgs = [[BatchKickOutGroupReqArgs alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultBatchKickOutGroupReqArgs;
}
- (BatchKickOutGroupReqArgs_Builder*) clear {
  self.resultBatchKickOutGroupReqArgs = [[BatchKickOutGroupReqArgs alloc] init];
  return self;
}
- (BatchKickOutGroupReqArgs_Builder*) clone {
  return [BatchKickOutGroupReqArgs builderWithPrototype:resultBatchKickOutGroupReqArgs];
}
- (BatchKickOutGroupReqArgs*) defaultInstance {
  return [BatchKickOutGroupReqArgs defaultInstance];
}
- (BatchKickOutGroupReqArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (BatchKickOutGroupReqArgs*) buildPartial {
  BatchKickOutGroupReqArgs* returnMe = resultBatchKickOutGroupReqArgs;
  self.resultBatchKickOutGroupReqArgs = nil;
  return returnMe;
}
- (BatchKickOutGroupReqArgs_Builder*) mergeFrom:(BatchKickOutGroupReqArgs*) other {
  if (other == [BatchKickOutGroupReqArgs defaultInstance]) {
    return self;
  }
  if (other.hasGroupId) {
    [self setGroupId:other.groupId];
  }
  if (other.userIdListArray.count > 0) {
    if (resultBatchKickOutGroupReqArgs.userIdListArray == nil) {
      resultBatchKickOutGroupReqArgs.userIdListArray = [[NSMutableArray alloc] initWithArray:other.userIdListArray];
    } else {
      [resultBatchKickOutGroupReqArgs.userIdListArray addObjectsFromArray:other.userIdListArray];
    }
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (BatchKickOutGroupReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (BatchKickOutGroupReqArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setGroupId:[input readString]];
        break;
      }
      case 18: {
        [self addUserIdList:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasGroupId {
  return resultBatchKickOutGroupReqArgs.hasGroupId;
}
- (NSString*) groupId {
  return resultBatchKickOutGroupReqArgs.groupId;
}
- (BatchKickOutGroupReqArgs_Builder*) setGroupId:(NSString*) value {
  resultBatchKickOutGroupReqArgs.hasGroupId = YES;
  resultBatchKickOutGroupReqArgs.groupId = value;
  return self;
}
- (BatchKickOutGroupReqArgs_Builder*) clearGroupId {
  resultBatchKickOutGroupReqArgs.hasGroupId = NO;
  resultBatchKickOutGroupReqArgs.groupId = @"";
  return self;
}
- (NSMutableArray *)userIdList {
  return resultBatchKickOutGroupReqArgs.userIdListArray;
}
- (NSString*)userIdListAtIndex:(NSUInteger)index {
  return [resultBatchKickOutGroupReqArgs userIdListAtIndex:index];
}
- (BatchKickOutGroupReqArgs_Builder *)addUserIdList:(NSString*)value {
  if (resultBatchKickOutGroupReqArgs.userIdListArray == nil) {
    resultBatchKickOutGroupReqArgs.userIdListArray = [[NSMutableArray alloc]init];
  }
  [resultBatchKickOutGroupReqArgs.userIdListArray addObject:value];
  return self;
}
- (BatchKickOutGroupReqArgs_Builder *)setUserIdListArray:(NSArray *)array {
  resultBatchKickOutGroupReqArgs.userIdListArray = [[NSMutableArray alloc] initWithArray:array];
  return self;
}
- (BatchKickOutGroupReqArgs_Builder *)clearUserIdList {
  resultBatchKickOutGroupReqArgs.userIdListArray = nil;
  return self;
}
@end


// @@protoc_insertion_point(global_scope)
