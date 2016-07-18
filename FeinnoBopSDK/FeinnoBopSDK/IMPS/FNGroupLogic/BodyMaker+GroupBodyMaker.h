//
//  BodyMaker+GroupBodyMaker.h
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/2/9.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import "BodyMaker.h"

@interface BodyMaker (GroupBodyMaker)

+ (NSData *)makeCreateGroupReq:(NSString *)groupName
                   groupConfig:(int32_t)groupConfig
                     groupType:(int32_t)gpType
                      nickName:(NSString *)nickName
              groupPortraitUrl:(NSString *)groupPortraitUrl;

+ (NSData *)makeSetGroupInfo:(NSString *)groupId
                   groupName:(NSString *)gpName
                      config:(int32_t)gpConfig
            groupPortraitUrl:(NSString *)groupPortraitUrl
                 updateField:(int32_t)updateField;

+ (NSData *)makeSetGroupMemberInfoReq:(NSString *)groupId
                               userId:(NSString *)userId
                           memberName:(NSString *)memberName
                     updateFieldFlags:(NSInteger)updateFieldFlags
                    memberPortraitUrl:(NSString *)memberPortraitUrl;

+ (NSData *)makeInviteJoinGroup:(NSArray *)gpInfos;

+ (NSData *)makeHandleApproveInviteJoin:(NSString *)groupId
                               sourceId:(NSString *)sourceId
           mutableHandleApproveItemList:(NSMutableArray *)mutableHandleApproveItemList;

+ (NSData *)makeKickOutGroup:(NSString *)groupId
                kickedUserId:(NSString *)target;

+ (NSData *)makeBatchKickOutGroup:(NSString *)groupId
                     kickedUserIds:(NSArray *)target;

+ (NSData *)makeDelGroupReq:(NSString *)groupId;

+ (NSData *)makeExitGroupReq:(NSString *)groupId;

+ (NSData *)makeGetGroupList:(int32_t)groupType
            groupListVersion:(int32_t)version;

+ (NSData *)makeGetGroupMemberList:(NSString *)groupId;

+ (NSData *)makeGetGroupFileCredentialReq:(NSString *)groupId;

+ (NSData *)makeChangeGroupOwner:(NSString *)groupId userId:(NSString *)userId;

@end
