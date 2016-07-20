// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "GroupListChangedArgs.pb.h"
// @@protoc_insertion_point(imports)

@implementation GroupListChangedArgsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [GroupListChangedArgsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = registry;
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface GroupListChangedArgs ()
@property (strong) NSString* groupId;
@property (strong) NSString* groupName;
@property (strong) NSString* actionType;
@property SInt32 groupType;
@end

@implementation GroupListChangedArgs

- (BOOL) hasGroupId {
  return !!hasGroupId_;
}
- (void) setHasGroupId:(BOOL) _value_ {
  hasGroupId_ = !!_value_;
}
@synthesize groupId;
- (BOOL) hasGroupName {
  return !!hasGroupName_;
}
- (void) setHasGroupName:(BOOL) _value_ {
  hasGroupName_ = !!_value_;
}
@synthesize groupName;
- (BOOL) hasActionType {
  return !!hasActionType_;
}
- (void) setHasActionType:(BOOL) _value_ {
  hasActionType_ = !!_value_;
}
@synthesize actionType;
- (BOOL) hasGroupType {
  return !!hasGroupType_;
}
- (void) setHasGroupType:(BOOL) _value_ {
  hasGroupType_ = !!_value_;
}
@synthesize groupType;
- (instancetype) init {
  if ((self = [super init])) {
    self.groupId = @"";
    self.groupName = @"";
    self.actionType = @"";
    self.groupType = 0;
  }
  return self;
}
static GroupListChangedArgs* defaultGroupListChangedArgsInstance = nil;
+ (void) initialize {
  if (self == [GroupListChangedArgs class]) {
    defaultGroupListChangedArgsInstance = [[GroupListChangedArgs alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultGroupListChangedArgsInstance;
}
- (instancetype) defaultInstance {
  return defaultGroupListChangedArgsInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasGroupId) {
    [output writeString:1 value:self.groupId];
  }
  if (self.hasGroupName) {
    [output writeString:2 value:self.groupName];
  }
  if (self.hasActionType) {
    [output writeString:3 value:self.actionType];
  }
  if (self.hasGroupType) {
    [output writeInt32:4 value:self.groupType];
  }
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
  if (self.hasGroupName) {
    size_ += computeStringSize(2, self.groupName);
  }
  if (self.hasActionType) {
    size_ += computeStringSize(3, self.actionType);
  }
  if (self.hasGroupType) {
    size_ += computeInt32Size(4, self.groupType);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (GroupListChangedArgs*) parseFromData:(NSData*) data {
  return (GroupListChangedArgs*)[[[GroupListChangedArgs builder] mergeFromData:data] build];
}
+ (GroupListChangedArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GroupListChangedArgs*)[[[GroupListChangedArgs builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (GroupListChangedArgs*) parseFromInputStream:(NSInputStream*) input {
  return (GroupListChangedArgs*)[[[GroupListChangedArgs builder] mergeFromInputStream:input] build];
}
+ (GroupListChangedArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GroupListChangedArgs*)[[[GroupListChangedArgs builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GroupListChangedArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (GroupListChangedArgs*)[[[GroupListChangedArgs builder] mergeFromCodedInputStream:input] build];
}
+ (GroupListChangedArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GroupListChangedArgs*)[[[GroupListChangedArgs builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GroupListChangedArgs_Builder*) builder {
  return [[GroupListChangedArgs_Builder alloc] init];
}
+ (GroupListChangedArgs_Builder*) builderWithPrototype:(GroupListChangedArgs*) prototype {
  return [[GroupListChangedArgs builder] mergeFrom:prototype];
}
- (GroupListChangedArgs_Builder*) builder {
  return [GroupListChangedArgs builder];
}
- (GroupListChangedArgs_Builder*) toBuilder {
  return [GroupListChangedArgs builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasGroupId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"groupId", self.groupId];
  }
  if (self.hasGroupName) {
    [output appendFormat:@"%@%@: %@\n", indent, @"groupName", self.groupName];
  }
  if (self.hasActionType) {
    [output appendFormat:@"%@%@: %@\n", indent, @"actionType", self.actionType];
  }
  if (self.hasGroupType) {
    [output appendFormat:@"%@%@: %@\n", indent, @"groupType", [NSNumber numberWithInteger:self.groupType]];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[GroupListChangedArgs class]]) {
    return NO;
  }
  GroupListChangedArgs *otherMessage = other;
  return
      self.hasGroupId == otherMessage.hasGroupId &&
      (!self.hasGroupId || [self.groupId isEqual:otherMessage.groupId]) &&
      self.hasGroupName == otherMessage.hasGroupName &&
      (!self.hasGroupName || [self.groupName isEqual:otherMessage.groupName]) &&
      self.hasActionType == otherMessage.hasActionType &&
      (!self.hasActionType || [self.actionType isEqual:otherMessage.actionType]) &&
      self.hasGroupType == otherMessage.hasGroupType &&
      (!self.hasGroupType || self.groupType == otherMessage.groupType) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasGroupId) {
    hashCode = hashCode * 31 + [self.groupId hash];
  }
  if (self.hasGroupName) {
    hashCode = hashCode * 31 + [self.groupName hash];
  }
  if (self.hasActionType) {
    hashCode = hashCode * 31 + [self.actionType hash];
  }
  if (self.hasGroupType) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInteger:self.groupType] hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface GroupListChangedArgs_Builder()
@property (strong) GroupListChangedArgs* resultGroupListChangedArgs;
@end

@implementation GroupListChangedArgs_Builder
@synthesize resultGroupListChangedArgs;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultGroupListChangedArgs = [[GroupListChangedArgs alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultGroupListChangedArgs;
}
- (GroupListChangedArgs_Builder*) clear {
  self.resultGroupListChangedArgs = [[GroupListChangedArgs alloc] init];
  return self;
}
- (GroupListChangedArgs_Builder*) clone {
  return [GroupListChangedArgs builderWithPrototype:resultGroupListChangedArgs];
}
- (GroupListChangedArgs*) defaultInstance {
  return [GroupListChangedArgs defaultInstance];
}
- (GroupListChangedArgs*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (GroupListChangedArgs*) buildPartial {
  GroupListChangedArgs* returnMe = resultGroupListChangedArgs;
  self.resultGroupListChangedArgs = nil;
  return returnMe;
}
- (GroupListChangedArgs_Builder*) mergeFrom:(GroupListChangedArgs*) other {
  if (other == [GroupListChangedArgs defaultInstance]) {
    return self;
  }
  if (other.hasGroupId) {
    [self setGroupId:other.groupId];
  }
  if (other.hasGroupName) {
    [self setGroupName:other.groupName];
  }
  if (other.hasActionType) {
    [self setActionType:other.actionType];
  }
  if (other.hasGroupType) {
    [self setGroupType:other.groupType];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (GroupListChangedArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (GroupListChangedArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setGroupName:[input readString]];
        break;
      }
      case 26: {
        [self setActionType:[input readString]];
        break;
      }
      case 32: {
        [self setGroupType:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasGroupId {
  return resultGroupListChangedArgs.hasGroupId;
}
- (NSString*) groupId {
  return resultGroupListChangedArgs.groupId;
}
- (GroupListChangedArgs_Builder*) setGroupId:(NSString*) value {
  resultGroupListChangedArgs.hasGroupId = YES;
  resultGroupListChangedArgs.groupId = value;
  return self;
}
- (GroupListChangedArgs_Builder*) clearGroupId {
  resultGroupListChangedArgs.hasGroupId = NO;
  resultGroupListChangedArgs.groupId = @"";
  return self;
}
- (BOOL) hasGroupName {
  return resultGroupListChangedArgs.hasGroupName;
}
- (NSString*) groupName {
  return resultGroupListChangedArgs.groupName;
}
- (GroupListChangedArgs_Builder*) setGroupName:(NSString*) value {
  resultGroupListChangedArgs.hasGroupName = YES;
  resultGroupListChangedArgs.groupName = value;
  return self;
}
- (GroupListChangedArgs_Builder*) clearGroupName {
  resultGroupListChangedArgs.hasGroupName = NO;
  resultGroupListChangedArgs.groupName = @"";
  return self;
}
- (BOOL) hasActionType {
  return resultGroupListChangedArgs.hasActionType;
}
- (NSString*) actionType {
  return resultGroupListChangedArgs.actionType;
}
- (GroupListChangedArgs_Builder*) setActionType:(NSString*) value {
  resultGroupListChangedArgs.hasActionType = YES;
  resultGroupListChangedArgs.actionType = value;
  return self;
}
- (GroupListChangedArgs_Builder*) clearActionType {
  resultGroupListChangedArgs.hasActionType = NO;
  resultGroupListChangedArgs.actionType = @"";
  return self;
}
- (BOOL) hasGroupType {
  return resultGroupListChangedArgs.hasGroupType;
}
- (SInt32) groupType {
  return resultGroupListChangedArgs.groupType;
}
- (GroupListChangedArgs_Builder*) setGroupType:(SInt32) value {
  resultGroupListChangedArgs.hasGroupType = YES;
  resultGroupListChangedArgs.groupType = value;
  return self;
}
- (GroupListChangedArgs_Builder*) clearGroupType {
  resultGroupListChangedArgs.hasGroupType = NO;
  resultGroupListChangedArgs.groupType = 0;
  return self;
}
@end


// @@protoc_insertion_point(global_scope)