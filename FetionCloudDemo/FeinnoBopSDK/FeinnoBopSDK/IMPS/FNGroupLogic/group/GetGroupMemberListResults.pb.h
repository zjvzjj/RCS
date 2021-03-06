// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

// @@protoc_insertion_point(imports)

@class GetGroupMemberListResults;
@class GetGroupMemberListResultsBuilder;
@class GetGroupMemberListResultsGroupMemberInfo;
@class GetGroupMemberListResultsGroupMemberInfoBuilder;



@interface GetGroupMemberListResultsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define GetGroupMemberListResults_reCode @"reCode"
#define GetGroupMemberListResults_groupMembers @"groupMembers"
@interface GetGroupMemberListResults : PBGeneratedMessage {
@private
  BOOL hasReCode_:1;
  SInt32 reCode;
  NSMutableArray * groupMembersArray;
}
- (BOOL) hasReCode;
@property (readonly) SInt32 reCode;
@property (readonly, strong) NSArray * groupMembers;
- (GetGroupMemberListResultsGroupMemberInfo*)groupMembersAtIndex:(NSUInteger)index;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GetGroupMemberListResultsBuilder*) builder;
+ (GetGroupMemberListResultsBuilder*) builder;
+ (GetGroupMemberListResultsBuilder*) builderWithPrototype:(GetGroupMemberListResults*) prototype;
- (GetGroupMemberListResultsBuilder*) toBuilder;

+ (GetGroupMemberListResults*) parseFromData:(NSData*) data;
+ (GetGroupMemberListResults*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetGroupMemberListResults*) parseFromInputStream:(NSInputStream*) input;
+ (GetGroupMemberListResults*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetGroupMemberListResults*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GetGroupMemberListResults*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

#define GroupMemberInfo_userId @"userId"
#define GroupMemberInfo_groupNickName @"groupNickName"
#define GroupMemberInfo_identity @"identity"
#define GroupMemberInfo_userConfig @"userConfig"
#define GroupMemberInfo_groupMemberPortraitUrl @"groupMemberPortraitUrl"
@interface GetGroupMemberListResultsGroupMemberInfo : PBGeneratedMessage {
@private
  BOOL hasIdentity_:1;
  BOOL hasUserConfig_:1;
  BOOL hasUserId_:1;
  BOOL hasGroupNickName_:1;
  BOOL hasGroupMemberPortraitUrl_:1;
  SInt32 identity;
  SInt32 userConfig;
  NSString* userId;
  NSString* groupNickName;
  NSString* groupMemberPortraitUrl;
}
- (BOOL) hasUserId;
- (BOOL) hasGroupNickName;
- (BOOL) hasIdentity;
- (BOOL) hasUserConfig;
- (BOOL) hasGroupMemberPortraitUrl;
@property (readonly, strong) NSString* userId;
@property (readonly, strong) NSString* groupNickName;
@property (readonly) SInt32 identity;
@property (readonly) SInt32 userConfig;
@property (readonly, strong) NSString* groupMemberPortraitUrl;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) builder;
+ (GetGroupMemberListResultsGroupMemberInfoBuilder*) builder;
+ (GetGroupMemberListResultsGroupMemberInfoBuilder*) builderWithPrototype:(GetGroupMemberListResultsGroupMemberInfo*) prototype;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) toBuilder;

+ (GetGroupMemberListResultsGroupMemberInfo*) parseFromData:(NSData*) data;
+ (GetGroupMemberListResultsGroupMemberInfo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetGroupMemberListResultsGroupMemberInfo*) parseFromInputStream:(NSInputStream*) input;
+ (GetGroupMemberListResultsGroupMemberInfo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetGroupMemberListResultsGroupMemberInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GetGroupMemberListResultsGroupMemberInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface GetGroupMemberListResultsGroupMemberInfoBuilder : PBGeneratedMessage_Builder {
@private
  GetGroupMemberListResultsGroupMemberInfo* resultGroupMemberInfo;
}

- (GetGroupMemberListResultsGroupMemberInfo*) defaultInstance;

- (GetGroupMemberListResultsGroupMemberInfoBuilder*) clear;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) clone;

- (GetGroupMemberListResultsGroupMemberInfo*) build;
- (GetGroupMemberListResultsGroupMemberInfo*) buildPartial;

- (GetGroupMemberListResultsGroupMemberInfoBuilder*) mergeFrom:(GetGroupMemberListResultsGroupMemberInfo*) other;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserId;
- (NSString*) userId;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) setUserId:(NSString*) value;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) clearUserId;

- (BOOL) hasGroupNickName;
- (NSString*) groupNickName;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) setGroupNickName:(NSString*) value;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) clearGroupNickName;

- (BOOL) hasIdentity;
- (SInt32) identity;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) setIdentity:(SInt32) value;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) clearIdentity;

- (BOOL) hasUserConfig;
- (SInt32) userConfig;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) setUserConfig:(SInt32) value;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) clearUserConfig;

- (BOOL) hasGroupMemberPortraitUrl;
- (NSString*) groupMemberPortraitUrl;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) setGroupMemberPortraitUrl:(NSString*) value;
- (GetGroupMemberListResultsGroupMemberInfoBuilder*) clearGroupMemberPortraitUrl;
@end

@interface GetGroupMemberListResultsBuilder : PBGeneratedMessage_Builder {
@private
  GetGroupMemberListResults* resultGetGroupMemberListResults;
}

- (GetGroupMemberListResults*) defaultInstance;

- (GetGroupMemberListResultsBuilder*) clear;
- (GetGroupMemberListResultsBuilder*) clone;

- (GetGroupMemberListResults*) build;
- (GetGroupMemberListResults*) buildPartial;

- (GetGroupMemberListResultsBuilder*) mergeFrom:(GetGroupMemberListResults*) other;
- (GetGroupMemberListResultsBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GetGroupMemberListResultsBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasReCode;
- (SInt32) reCode;
- (GetGroupMemberListResultsBuilder*) setReCode:(SInt32) value;
- (GetGroupMemberListResultsBuilder*) clearReCode;

- (NSMutableArray *)groupMembers;
- (GetGroupMemberListResultsGroupMemberInfo*)groupMembersAtIndex:(NSUInteger)index;
- (GetGroupMemberListResultsBuilder *)addGroupMembers:(GetGroupMemberListResultsGroupMemberInfo*)value;
- (GetGroupMemberListResultsBuilder *)setGroupMembersArray:(NSArray *)array;
- (GetGroupMemberListResultsBuilder *)clearGroupMembers;
@end


// @@protoc_insertion_point(global_scope)
