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

#import "FNMessage.h"


@interface FNMessage ()

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                         isMedia:(BOOL)isMedia
                           msgId:(NSString *)msgId;

@end

@implementation FNMessage

@synthesize sendingFlag;

#pragma mark - Initialization

+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                               text:(NSString *)text
                              msgId:(NSString *)msgId
{
    return [[FNMessage alloc] initWithSenderId:senderId
                              senderDisplayName:displayName
                                           date:[NSDate date]
                                           text:text
                                         msgId:msgId];
}

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                            text:(NSString *)text
                           msgId:(NSString *)msgId
{
    if (text == nil || [text length] == 0)
    {
        text = @"";
    }
    NSParameterAssert(text != nil);
    
    self = [self initWithSenderId:senderId senderDisplayName:senderDisplayName date:date isMedia:NO msgId:msgId];
    if (self) {
        _text = [text copy];
    }
    return self;
}


+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                              media:(id<FNMessageMediaData>)media
                              msgId:(NSString *)msgId
{
    return [[FNMessage alloc] initWithSenderId:senderId
                              senderDisplayName:displayName
                                           date:[NSDate date]
                                          media:media
                                         msgId:msgId];
}

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                           media:(id<FNMessageMediaData>)media
                           msgId:(NSString *)msgId
{
    NSParameterAssert(media != nil);
    
    self = [self initWithSenderId:senderId senderDisplayName:senderDisplayName date:date isMedia:YES msgId:msgId];
    if (self) {
        _media = media;
    }
    return self;
}

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                         isMedia:(BOOL)isMedia
                           msgId:(NSString *)msgId
{
    NSParameterAssert(senderId != nil);
    NSParameterAssert(senderDisplayName != nil);
    NSParameterAssert(date != nil);
    NSParameterAssert(msgId != nil);

    self = [super init];
    if (self) {
        _senderId = [senderId copy];
        _senderDisplayName = [senderDisplayName copy];
        _date = [date copy];
        _isMediaMessage = isMedia;
        _msgId = [msgId copy];
    }
    return self;
}

- (id)init
{
    NSAssert(NO, @"%s is not a valid initializer for %@.", __PRETTY_FUNCTION__, [self class]);
    return nil;
}

- (void)dealloc
{
    _senderId = nil;
    _senderDisplayName = nil;
    _date = nil;
    _text = nil;
    _media = nil;
    _msgId = nil;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    FNMessage *aMessage = (FNMessage *)object;
    
    if (self.isMediaMessage != aMessage.isMediaMessage) {
        return NO;
    }
    
    BOOL hasEqualContent = self.isMediaMessage ? [self.media isEqual:aMessage.media] : [self.text isEqualToString:aMessage.text];
    
    return [self.senderId isEqualToString:aMessage.senderId]
            && [self.senderDisplayName isEqualToString:aMessage.senderDisplayName]
            && ([self.date compare:aMessage.date] == NSOrderedSame)
            && hasEqualContent;
}

- (NSUInteger)hash
{
    NSUInteger contentHash = self.isMediaMessage ? self.media.hash : self.text.hash;
    
    return self.senderId.hash ^ self.date.hash ^ contentHash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: senderId=%@, senderDisplayName=%@, date=%@, isMediaMessage=%@, text=%@, media=%@>",
            [self class], self.senderId, self.senderDisplayName, self.date, @(self.isMediaMessage), self.text, self.media];
}

- (id)debugQuickLookObject
{
    return [self.media mediaView] ?: [self.media mediaPlaceholderView];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _senderId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderId))];
        _senderDisplayName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderDisplayName))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
        _isMediaMessage = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isMediaMessage))];
        _text = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(text))];
        _media = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(media))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.senderId forKey:NSStringFromSelector(@selector(senderId))];
    [aCoder encodeObject:self.senderDisplayName forKey:NSStringFromSelector(@selector(senderDisplayName))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
    [aCoder encodeBool:self.isMediaMessage forKey:NSStringFromSelector(@selector(isMediaMessage))];
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    
    if ([self.media conformsToProtocol:@protocol(NSCoding)]) {
        [aCoder encodeObject:self.media forKey:NSStringFromSelector(@selector(media))];
    }
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    if (self.isMediaMessage) {
        return [[[self class] allocWithZone:zone] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:self.date
                                                             media:self.media
                                                             msgId:self.msgId];
    }
    
    return [[[self class] allocWithZone:zone] initWithSenderId:self.senderId
                                             senderDisplayName:self.senderDisplayName
                                                          date:self.date
                                                          text:self.text
                                                         msgId:self.msgId];
}

@end
