//
//  FNMessagesCancleImage.m
//  Fetion
//
//  Created by Dominate on 15/9/14.
//  Copyright (c) 2015年 xinrui.com. All rights reserved.
//

#import "FNMessagesCancleImage.h"

@implementation FNMessagesCancleImage

#pragma mark - Initialization

- (instancetype)initWithMessageCancleImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    NSParameterAssert(image != nil);
    NSParameterAssert(highlightedImage != nil);
    
    self = [super init];
    if (self) {
        _messageCancleImage = image;
        _messageCancleHighlightedImage = highlightedImage;
    }
    return self;
}

-(void)dealloc
{
    _messageCancleImage = nil;
    _messageCancleHighlightedImage = nil;
}

- (id)init
{
    NSAssert(NO, @"%s is not a valid initializer for %@. Use %@ instead.",
             __PRETTY_FUNCTION__, [self class], NSStringFromSelector(@selector(initWithMessageCancleImage:highlightedImage:)));
    return nil;
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: messageCancleImage=%@, messageCancleHighlightedImage=%@>",
            [self class], self.messageCancleImage, self.messageCancleHighlightedImage];
}

- (id)debugQuickLookObject
{
    return [[UIImageView alloc] initWithImage:self.messageCancleImage highlightedImage:self.messageCancleHighlightedImage];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithMessageCancleImage:[UIImage imageWithCGImage:self.messageCancleImage.CGImage]
                                                        highlightedImage:[UIImage imageWithCGImage:self.messageCancleHighlightedImage.CGImage]];
}


@end
