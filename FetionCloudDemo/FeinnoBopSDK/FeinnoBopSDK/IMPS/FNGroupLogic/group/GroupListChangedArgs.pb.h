// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

// @@protoc_insertion_point(imports)

@class GroupListChangedArgs;
@class GroupListChangedArgs_Builder;



@interface GroupListChangedArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define GroupListChangedArgs_groupId @"groupId"
#define GroupListChangedArgs_groupName @"groupName"
#define GroupListChangedArgs_actionType @"actionType"
#define GroupListChangedArgs_groupType @"groupType"
@interface GroupListChangedArgs : PBGeneratedMessage {
@private
  BOOL hasGroupType_:1;
  BOOL hasGroupId_:1;
  BOOL hasGroupName_:1;
  BOOL hasActionType_:1;
  SInt32 groupType;
  NSString* groupId;
  NSString* groupName;
  NSString* actionType;
}
- (BOOL) hasGroupId;
- (BOOL) hasGroupName;
- (BOOL) hasActionType;
- (BOOL) hasGroupType;
@property (readonly, strong) NSString* groupId;
@property (readonly, strong) NSString* groupName;
@property (readonly, strong) NSString* actionType;
@property (readonly) SInt32 groupType;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GroupListChangedArgs_Builder*) builder;
+ (GroupListChangedArgs_Builder*) builder;
+ (GroupListChangedArgs_Builder*) builderWithPrototype:(GroupListChangedArgs*) prototype;
- (GroupListChangedArgs_Builder*) toBuilder;

+ (GroupListChangedArgs*) parseFromData:(NSData*) data;
+ (GroupListChangedArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GroupListChangedArgs*) parseFromInputStream:(NSInputStream*) input;
+ (GroupListChangedArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GroupListChangedArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GroupListChangedArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface GroupListChangedArgs_Builder : PBGeneratedMessage_Builder {
@private
  GroupListChangedArgs* resultGroupListChangedArgs;
}

- (GroupListChangedArgs*) defaultInstance;

- (GroupListChangedArgs_Builder*) clear;
- (GroupListChangedArgs_Builder*) clone;

- (GroupListChangedArgs*) build;
- (GroupListChangedArgs*) buildPartial;

- (GroupListChangedArgs_Builder*) mergeFrom:(GroupListChangedArgs*) other;
- (GroupListChangedArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GroupListChangedArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasGroupId;
- (NSString*) groupId;
- (GroupListChangedArgs_Builder*) setGroupId:(NSString*) value;
- (GroupListChangedArgs_Builder*) clearGroupId;

- (BOOL) hasGroupName;
- (NSString*) groupName;
- (GroupListChangedArgs_Builder*) setGroupName:(NSString*) value;
- (GroupListChangedArgs_Builder*) clearGroupName;

- (BOOL) hasActionType;
- (NSString*) actionType;
- (GroupListChangedArgs_Builder*) setActionType:(NSString*) value;
- (GroupListChangedArgs_Builder*) clearActionType;

- (BOOL) hasGroupType;
- (SInt32) groupType;
- (GroupListChangedArgs_Builder*) setGroupType:(SInt32) value;
- (GroupListChangedArgs_Builder*) clearGroupType;
@end


// @@protoc_insertion_point(global_scope)