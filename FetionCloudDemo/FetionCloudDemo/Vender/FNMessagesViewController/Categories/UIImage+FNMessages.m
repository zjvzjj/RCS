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

#import "UIImage+FNMessages.h"
#import "FNImage.h"

@implementation UIImage (FNMessages)

- (UIImage *)fn_imageMaskedWithColor:(UIColor *)maskColor
{
    NSParameterAssert(maskColor != nil);
    
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGContextFillRect(context, imageRect);
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)fn_incomingImageMaskedWithColor:(UIColor *)maskColor
{
    NSParameterAssert(maskColor != nil);
    
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGContextFillRect(context, imageRect);
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [maskColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
    
    return newImage;
}

+ (UIImage *)fn_bubbleImageFromBundleWithName:(NSString *)name
{
    return [FNImage imageWithName:name];
}

+ (UIImage *)fn_bubbleRegularImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"bubble_regular"];
}

+ (UIImage *)fn_bubbleRegularTaillessImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"bubble_tailless"];
}

+ (UIImage *)fn_bubbleRegularStrokedImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"bubble_stroked"];
}

+ (UIImage *)fn_bubbleRegularStrokedTaillessImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"bubble_stroked_tailless"];
}

+ (UIImage *)fn_OutgoingbubbleCompactImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"outgoingbubble_min"];
}

+ (UIImage *)fn_IncomingbubbleCompactImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"incomingbubble_min"];
}

+ (UIImage *)fn_bubbleCompactTaillessImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"bubble_min_tailless"];
}

+ (UIImage *)fn_defaultAccessoryImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"clip"];
}

+ (UIImage *)fn_defaultTypingIndicatorImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"typing"];
}

+ (UIImage *)fn_defaultPlayImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"play"];
}

+ (UIImage *)fn_outgoingCancleImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"refresh"];
}

+ (UIImage *)fn_incomingCancleImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"cancle"];
}

+ (UIImage *) fn_sendingImage
{
    return [FNImage imageWithName:@"chatroom_message_sending"];
}

+ (UIImage *)fn_audioNoPlayImage
{
    return [UIImage fn_bubbleImageFromBundleWithName:@"notPlay"];
}

@end
