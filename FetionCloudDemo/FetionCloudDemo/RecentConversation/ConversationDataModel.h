
#import <Foundation/Foundation.h>
#import "FNMessages.h"
@class ConversationDataModel;
@class FNMsgTable;
@class FNGroupMsgTable;

@protocol ConversationDataModelSource <NSObject>

- (void)conversationDataModel:(ConversationDataModel *)model message:(FNMsgTable *)message;

- (void)conversationDataModel:(ConversationDataModel *)model groupMessage:(FNGroupMsgTable *)message;

@end

@interface ConversationDataModel : NSObject

@property (nonatomic, assign) id<ConversationDataModelSource> dataSource;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *toUserId;
@property (nonatomic, strong) NSMutableArray *messages;
@property (strong, nonatomic) NSMutableDictionary *avatars;
@property (strong, nonatomic) FNMessagesBubbleImage *outgoingBubbleImageData;
@property (strong, nonatomic) FNMessagesBubbleImage *incomingBubbleImageData;

@property (nonatomic, assign) BOOL isFinish;

- (instancetype)initWithSourceAndId:(NSString *)source
                           targetId:(NSString *)target
                   historyMsgsCount:(int)count
                          firstLoad:(BOOL)firstLoad;

- (NSMutableArray *)makeTargetFNMsg:(id)messageData
                          mediaData:(NSData *)mediaData;

- (FNMessage *)makePhotoMediaMessage:(UIImage *)image
                              sender:(NSString *)userid
                                name:(NSString *)username
                               msgId:(NSString *)msgId
                           imagePath:(NSString *)imgPath;

- (FNMessage *)makeAudioMediaMessage:(NSURL *)fileURL
                            duration:(NSInteger)duration
                             bitrate:(NSString *)bitrate
                              sender:(NSString *)userid
                                name:(NSString *)username
                               msgID:(NSString *)msgId;

- (FNMessage *)makeVideoMediaMessage:(NSURL *)fileURL
                            duration:(NSInteger)duration
                              sender:(NSString *)userid
                                name:(NSString *)username
                               msgID:(NSString *)msgId;

- (void)setAvatarWithDefaultSenderID:(NSString *)senderID;

- (void)setAvatar:(NSString *)avatar senderID:(NSString *)senderID;

@end
