// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

// @@protoc_insertion_point(imports)

@class UserExitGroupNtfArgs;
@class UserExitGroupNtfArgs_Builder;



@interface UserExitGroupNtfArgsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define UserExitGroupNtfArgs_groupId @"groupId"
#define UserExitGroupNtfArgs_exitType @"exitType"
#define UserExitGroupNtfArgs_exitUserId @"exitUserId"
#define UserExitGroupNtfArgs_exitUserNickname @"exitUserNickname"
#define UserExitGroupNtfArgs_sourceUserId @"sourceUserId"
#define UserExitGroupNtfArgs_sourceUserNickname @"sourceUserNickname"
#define UserExitGroupNtfArgs_groupName @"groupName"
@interface UserExitGroupNtfArgs : PBGeneratedMessage {
@private
  BOOL hasExitType_:1;
  BOOL hasGroupId_:1;
  BOOL hasExitUserId_:1;
  BOOL hasExitUserNickname_:1;
  BOOL hasSourceUserId_:1;
  BOOL hasSourceUserNickname_:1;
  BOOL hasGroupName_:1;
  SInt32 exitType;
  NSString* groupId;
  NSString* exitUserId;
  NSString* exitUserNickname;
  NSString* sourceUserId;
  NSString* sourceUserNickname;
  NSString* groupName;
}
- (BOOL) hasGroupId;
- (BOOL) hasExitType;
- (BOOL) hasExitUserId;
- (BOOL) hasExitUserNickname;
- (BOOL) hasSourceUserId;
- (BOOL) hasSourceUserNickname;
- (BOOL) hasGroupName;
@property (readonly, strong) NSString* groupId;
@property (readonly) SInt32 exitType;
@property (readonly, strong) NSString* exitUserId;
@property (readonly, strong) NSString* exitUserNickname;
@property (readonly, strong) NSString* sourceUserId;
@property (readonly, strong) NSString* sourceUserNickname;
@property (readonly, strong) NSString* groupName;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (UserExitGroupNtfArgs_Builder*) builder;
+ (UserExitGroupNtfArgs_Builder*) builder;
+ (UserExitGroupNtfArgs_Builder*) builderWithPrototype:(UserExitGroupNtfArgs*) prototype;
- (UserExitGroupNtfArgs_Builder*) toBuilder;

+ (UserExitGroupNtfArgs*) parseFromData:(NSData*) data;
+ (UserExitGroupNtfArgs*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (UserExitGroupNtfArgs*) parseFromInputStream:(NSInputStream*) input;
+ (UserExitGroupNtfArgs*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (UserExitGroupNtfArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (UserExitGroupNtfArgs*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface UserExitGroupNtfArgs_Builder : PBGeneratedMessage_Builder {
@private
  UserExitGroupNtfArgs* resultUserExitGroupNtfArgs;
}

- (UserExitGroupNtfArgs*) defaultInstance;

- (UserExitGroupNtfArgs_Builder*) clear;
- (UserExitGroupNtfArgs_Builder*) clone;

- (UserExitGroupNtfArgs*) build;
- (UserExitGroupNtfArgs*) buildPartial;

- (UserExitGroupNtfArgs_Builder*) mergeFrom:(UserExitGroupNtfArgs*) other;
- (UserExitGroupNtfArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (UserExitGroupNtfArgs_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasGroupId;
- (NSString*) groupId;
- (UserExitGroupNtfArgs_Builder*) setGroupId:(NSString*) value;
- (UserExitGroupNtfArgs_Builder*) clearGroupId;

- (BOOL) hasExitType;
- (SInt32) exitType;
- (UserExitGroupNtfArgs_Builder*) setExitType:(SInt32) value;
- (UserExitGroupNtfArgs_Builder*) clearExitType;

- (BOOL) hasExitUserId;
- (NSString*) exitUserId;
- (UserExitGroupNtfArgs_Builder*) setExitUserId:(NSString*) value;
- (UserExitGroupNtfArgs_Builder*) clearExitUserId;

- (BOOL) hasExitUserNickname;
- (NSString*) exitUserNickname;
- (UserExitGroupNtfArgs_Builder*) setExitUserNickname:(NSString*) value;
- (UserExitGroupNtfArgs_Builder*) clearExitUserNickname;

- (BOOL) hasSourceUserId;
- (NSString*) sourceUserId;
- (UserExitGroupNtfArgs_Builder*) setSourceUserId:(NSString*) value;
- (UserExitGroupNtfArgs_Builder*) clearSourceUserId;

- (BOOL) hasSourceUserNickname;
- (NSString*) sourceUserNickname;
- (UserExitGroupNtfArgs_Builder*) setSourceUserNickname:(NSString*) value;
- (UserExitGroupNtfArgs_Builder*) clearSourceUserNickname;

- (BOOL) hasGroupName;
- (NSString*) groupName;
- (UserExitGroupNtfArgs_Builder*) setGroupName:(NSString*) value;
- (UserExitGroupNtfArgs_Builder*) clearGroupName;
@end


// @@protoc_insertion_point(global_scope)