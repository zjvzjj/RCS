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

#import "FNMediaItem.h"

#import "FNMessagesMediaPlaceholderView.h"
#import "FNMessagesMediaViewBubbleImageMasker.h"


@interface FNMediaItem ()

@property (strong, nonatomic) UIView *cachedPlaceholderView;

@end


@implementation FNMediaItem

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithMaskAsOutgoing:YES];
}

- (instancetype)initWithMaskAsOutgoing:(BOOL)maskAsOutgoing
{
    self = [super init];
    if (self) {
        _appliesMediaViewMaskAsOutgoing = maskAsOutgoing;
        _cachedPlaceholderView = nil;
    }
    return self;
}

- (void)dealloc
{
    _cachedPlaceholderView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    _appliesMediaViewMaskAsOutgoing = appliesMediaViewMaskAsOutgoing;
    _cachedPlaceholderView = nil;
}

#pragma mark - FNMessageMediaData protocol

- (UIView *)mediaView
{
    NSAssert(NO, @"Error! required method not implemented in subclass. Need to implement %s", __PRETTY_FUNCTION__);
    return nil;
}

- (CGSize)mediaViewDisplaySize
{
    return CGSizeMake(200, 200);
}

// 站位图
- (UIView *)mediaPlaceholderView
{
    if (self.cachedPlaceholderView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        //默认是指示器类型的占位视图
        UIView *view = [FNMessagesMediaPlaceholderView viewWithAttachmentIcon];
        view.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        //将占位视图切为圆角
        [FNMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:view isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedPlaceholderView = view;
    }
    
    return self.cachedPlaceholderView;
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
    
    FNMediaItem *item = (FNMediaItem *)object;
    
    return self.appliesMediaViewMaskAsOutgoing == item.appliesMediaViewMaskAsOutgoing;
}

- (NSUInteger)hash
{
    return [NSNumber numberWithBool:self.appliesMediaViewMaskAsOutgoing].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: appliesMediaViewMaskAsOutgoing=%@>",
            [self class], @(self.appliesMediaViewMaskAsOutgoing)];
}

- (id)debugQuickLookObject
{
    return [self mediaView] ?: [self mediaPlaceholderView];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _appliesMediaViewMaskAsOutgoing = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(appliesMediaViewMaskAsOutgoing))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:self.appliesMediaViewMaskAsOutgoing forKey:NSStringFromSelector(@selector(appliesMediaViewMaskAsOutgoing))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithMaskAsOutgoing:self.appliesMediaViewMaskAsOutgoing];
}

@end
