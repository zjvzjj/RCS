//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/FNMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/FNMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>

#import "FNMessageData.h"

typedef enum : NSUInteger {
    FNMessageTypePlainText,
    FNMessageTypePicture,
    FNMessageTypeAudio,
    FNMessageTypeVideo,
} FNMessageType;

/**
 *  The `FNMessage` class is a concrete class for message model objects that represents a single user message.
 *  The message can be a text message or media message, depending on how it is initialized.
 *  It implements the `FNMessageData` protocol and it contains the senderId, senderDisplayName,
 *  and the date that the message was sent. If initialized as a media message it also contains a media attachment,
 *  otherwise it contains the message text.主要作用是将消息规范一边并存储
 */
@interface FNMessage : NSObject <FNMessageData, NSCoding, NSCopying>
//时长
@property (nonatomic,assign)long timeLong;

// 文件大小
@property (nonatomic,copy) NSString *fileSize;

// 进度字段
@property(nonatomic, assign)CGFloat progress;

/**
 *  Returns the string identifier that uniquely identifies the user who sent the message. 发送方id
 */
@property (copy, nonatomic, readonly) NSString *senderId;


@property (copy, nonatomic) NSString *msgId;//消息id

/**
 *  Returns the display name for the user who sent the message. This value does not have to be unique.
 */
@property (copy, nonatomic) NSString *senderDisplayName;//发送方名字

/**
 *  Returns the date that the message was sent.日期
 */
@property (copy, nonatomic, readonly) NSDate *date;

/**
 *  Returns a boolean value specifying whether or not the message contains media.
 *  If `NO`, the message contains text. If `YES`, the message contains media.
 *  The value of this property depends on how the object was initialized. 是否为多媒体消息
 */
@property (assign, nonatomic, readonly) BOOL isMediaMessage;

//消息类型
@property (assign, nonatomic) FNMessageType messageType;

/**
 *  Returns the body text of the message, or `nil` if the message is a media message.
 *  That is, if `isMediaMessage` is equal to `YES` then this value will be `nil`.文本内容
 */
@property (copy, nonatomic) NSString *text;
//@property (copy, nonatomic, readonly) NSString *text;

/**
 *  Returns the media item attachment of the message, or `nil` if the message is not a media message.
 *  That is, if `isMediaMessage` is equal to `NO` then this value will be `nil`.多媒体内容
 */
@property (copy, nonatomic, readonly) id<FNMessageMediaData> media;

/**
 * custom variables to draw msg send failure img flag发送失败标志
 */
@property (assign, nonatomic) BOOL sendFailureFlag;

/**
 * custom flag, should always be evaluated before failure or success
 */
@property (assign, nonatomic) BOOL sendingFlag;//正在发送标志

/* is rev or send msgs
 * no is recvied msg, yes is send msg
 */
 
@property (assign, nonatomic) BOOL isOutgoing;//是否发出

/*
 * is re sent msg
 */
@property (assign, nonatomic) BOOL isReSent;//是否重发

/*
 * is translated.
 */
@property (assign, nonatomic) BOOL isTranslated;//是否已翻译


#pragma mark - Initialization

/**
 *  Initializes and returns a message object having the given senderId, displayName, text,
 *  and current system date.
 *
 *  @param senderId    The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param displayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param text        The body text of the message. This value must not be `nil`.
 *
 *  @discussion Initializing a `FNMessage` with this method will set `isMediaMessage` to `NO`.
 *
 *  @return An initialized `FNMessage` object if successful, `nil` otherwise.
 */
+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                               text:(NSString *)text
                              msgId:(NSString *)msgId;

/**
 *  Initializes and returns a message object having the given senderId, senderDisplayName, date, and text.
 *
 *  @param senderId          The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param senderDisplayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param date              The date that the message was sent. This value must not be `nil`.
 *  @param text              The body text of the message. This value must not be `nil`.
 *
 *  @discussion Initializing a `FNMessage` with this method will set `isMediaMessage` to `NO`.
 *
 *  @return An initialized `FNMessage` object if successful, `nil` otherwise.
 */
- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                            text:(NSString *)text
                           msgId:(NSString *)msgId;
/**
 *  Initializes and returns a message object having the given senderId, displayName, media,
 *  and current system date.
 *
 *  @param senderId    The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param displayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param media       The media data for the message. This value must not be `nil`.
 *
 *  @discussion Initializing a `FNMessage` with this method will set `isMediaMessage` to `YES`.
 *
 *  @return An initialized `FNMessage` object if successful, `nil` otherwise.
 */
+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                              media:(id<FNMessageMediaData>)media
                              msgId:(NSString *)msgId;

/**
 *  Initializes and returns a message object having the given senderId, displayName, date, and media.
 *
 *  @param senderId          The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param senderDisplayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param date              The date that the message was sent. This value must not be `nil`.
 *  @param media             The media data for the message. This value must not be `nil`.
 *
 *  @discussion Initializing a `FNMessage` with this method will set `isMediaMessage` to `YES`.
 *
 *  @return An initialized `FNMessage` object if successful, `nil` otherwise.
 */
- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                           media:(id<FNMessageMediaData>)media
                           msgId:(NSString *)msgId;

@end
