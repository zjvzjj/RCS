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

#import "FNMessagesAvatarImageFactory.h"

#import "UIColor+FNMessages.h"


@interface FNMessagesAvatarImageFactory ()

+ (UIImage *)fn_circularImage:(UIImage *)image
                   withDiamter:(NSUInteger)diameter
              highlightedColor:(UIColor *)highlightedColor;

+ (UIImage *)fn_imageWitInitials:(NSString *)initials
                  backgroundColor:(UIColor *)backgroundColor
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                         diameter:(NSUInteger)diameter;

@end



@implementation FNMessagesAvatarImageFactory

#pragma mark - Public

+ (FNMessagesAvatarImage *)avatarImageWithPlaceholder:(UIImage *)placeholderImage diameter:(NSUInteger)diameter
{
    UIImage *circlePlaceholderImage = [FNMessagesAvatarImageFactory fn_circularImage:placeholderImage
                                                                           withDiamter:diameter
                                                                      highlightedColor:nil];
    //工厂的产品是根据model的产出来定的
    return [FNMessagesAvatarImage avatarImageWithPlaceholder:circlePlaceholderImage];
}

+ (FNMessagesAvatarImage *)avatarImageWithImage:(UIImage *)image diameter:(NSUInteger)diameter
{
    UIImage *avatar = [FNMessagesAvatarImageFactory circularAvatarImage:image withDiameter:diameter];
    UIImage *highlightedAvatar = [FNMessagesAvatarImageFactory circularAvatarHighlightedImage:image withDiameter:diameter];
    
    return [[FNMessagesAvatarImage alloc] initWithAvatarImage:avatar
                                              highlightedImage:highlightedAvatar
                                              placeholderImage:avatar];
}

+ (UIImage *)circularAvatarImage:(UIImage *)image withDiameter:(NSUInteger)diameter
{
    return [FNMessagesAvatarImageFactory fn_circularImage:image
                                                withDiamter:diameter
                                           highlightedColor:nil];
}

+ (UIImage *)circularAvatarHighlightedImage:(UIImage *)image withDiameter:(NSUInteger)diameter
{
    return [FNMessagesAvatarImageFactory fn_circularImage:image
                                                withDiamter:diameter
                                           highlightedColor:[UIColor colorWithWhite:0.1f alpha:0.3f]];
}

+ (FNMessagesAvatarImage *)avatarImageWithUserInitials:(NSString *)userInitials
                                        backgroundColor:(UIColor *)backgroundColor
                                              textColor:(UIColor *)textColor
                                                   font:(UIFont *)font
                                               diameter:(NSUInteger)diameter
{
    UIImage *avatarImage = [FNMessagesAvatarImageFactory fn_imageWitInitials:userInitials
                                                               backgroundColor:backgroundColor
                                                                     textColor:textColor
                                                                          font:font
                                                                      diameter:diameter];
    
    UIImage *avatarHighlightedImage = [FNMessagesAvatarImageFactory fn_circularImage:avatarImage
                                                                           withDiamter:diameter
                                                                      highlightedColor:[UIColor colorWithWhite:0.1f alpha:0.3f]];
    
    return [[FNMessagesAvatarImage alloc] initWithAvatarImage:avatarImage
                                              highlightedImage:avatarHighlightedImage
                                              placeholderImage:avatarImage];
}

#pragma mark - Private

+ (UIImage *)fn_imageWitInitials:(NSString *)initials
                  backgroundColor:(UIColor *)backgroundColor
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                         diameter:(NSUInteger)diameter
{
    NSParameterAssert(initials != nil);
    NSParameterAssert(backgroundColor != nil);
    NSParameterAssert(textColor != nil);
    NSParameterAssert(font != nil);
    NSParameterAssert(diameter > 0);
    
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    
    NSString *text = [initials uppercaseStringWithLocale:[NSLocale currentLocale]];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font,
                                  NSForegroundColorAttributeName : textColor };
    
    CGRect textFrame = [text boundingRectWithSize:frame.size
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:attributes
                                          context:nil];
    
    CGPoint frameMidPoint = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGPoint textFrameMidPoint = CGPointMake(CGRectGetMidX(textFrame), CGRectGetMidY(textFrame));
    
    CGFloat dx = frameMidPoint.x - textFrameMidPoint.x;
    CGFloat dy = frameMidPoint.y - textFrameMidPoint.y;
    CGPoint drawPoint = CGPointMake(dx, dy);
    UIImage *image = nil;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, frame);
        [text drawAtPoint:drawPoint withAttributes:attributes];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        CGContextRestoreGState(context);
    }
    UIGraphicsEndImageContext();
    
    return [FNMessagesAvatarImageFactory fn_circularImage:image withDiamter:diameter highlightedColor:nil];
}

+ (UIImage *)fn_circularImage:(UIImage *)image withDiamter:(NSUInteger)diameter highlightedColor:(UIColor *)highlightedColor
{
    NSParameterAssert(image != nil);
    NSParameterAssert(diameter > 0);
    
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:diameter];
        [imgPath addClip];
        [image drawInRect:frame];
        
        if (highlightedColor != nil)
        {
            CGContextSetFillColorWithColor(context, highlightedColor.CGColor);
            CGContextFillEllipseInRect(context, frame);
        }
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        CGContextRestoreGState(context);
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
