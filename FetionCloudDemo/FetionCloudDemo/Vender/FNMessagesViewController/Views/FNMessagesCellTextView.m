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

#import "FNMessagesCellTextView.h"

#import <CoreText/CoreText.h>

@implementation CTRunDeRef

@synthesize x;

@synthesize y;

@synthesize width;

@synthesize height;

@synthesize name;

@end

static void deallocer(void *ref)
{
    CTRunDeRef *r = (CTRunDeRef *) CFBridgingRelease(ref);
}

static CGFloat ascenter(void *ref)
{
    CTRunDeRef *r = (__bridge CTRunDeRef *) (ref);
    
    return r.height;
}

static CGFloat descenter(void *ref)
{
    CTRunDeRef *r = (__bridge CTRunDeRef *) (ref);
    
    return r.y;
}

static CGFloat widther(void *ref)
{
    CTRunDeRef *r = (__bridge CTRunDeRef *) (ref);
    
    return r.width;
}

static CTRunDelegateCallbacks cb =
{
    kCTRunDelegateCurrentVersion,
    
    deallocer,
    ascenter,
    descenter,
    widther,
};

@interface FNMessagesCellTextView ()
{
    NSMutableArray *links;
    
    NSRange touched;
    
    NSMutableAttributedString *content;
    
    CTFramesetterRef framesetter;
    
    CTFrameRef frame;
    
    CGFloat _height;
}

+ (NSMutableAttributedString *) resolveMarkups:(NSString *)string;

@end

@implementation FNMessagesCellTextView

@synthesize delegate;

@synthesize edge;

@synthesize text;

- (id) initWithFrame:(CGRect)aframe
{
    self = [super initWithFrame:aframe];
    
    if (self)
    {
        
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.userInteractionEnabled = YES;
}

- (void) setText:(NSString *)aText
{
    text = aText;
    
    if (framesetter)
    {
        CFRelease(framesetter);
    }
    
    if (frame)
    {
        CFRelease(frame);
    }
    
    if (text)
    {
        links = [NSMutableArray array];
        
        content = [FNMessagesCellTextView resolveMarkups:aText];
        
        touched = NSMakeRange(- 1, 0);
        
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber error:nil];
        
        NSArray *matches = [detector matchesInString:content.string options:0 range:NSMakeRange(0, content.length)];
        
        self.isHaveLink = NO;
        
        for (NSTextCheckingResult *match in matches)
        {
            self.isHaveLink = YES;
            
            NSRange range = match.range;
            
            UIColor *color = [UIColor blueColor];
            
            [content addAttribute:NSForegroundColorAttributeName value:color range:range];
            
            [content addAttribute:NSUnderlineStyleAttributeName value:@(1) range:range];
            
            [links addObject:match];
        }
        
        UIFont *font = [UIFont systemFontOfSize:16.0f];
        
        [content addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, content.length)];
        
        NSMutableParagraphStyle *stly = [[NSMutableParagraphStyle alloc] init];
        
        stly.lineSpacing = 3.0f;
        
        [content addAttribute:NSParagraphStyleAttributeName value:stly range:NSMakeRange(0, content.length)];
        
        framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) content);
        
        CFRange empty = CFRangeMake(0, content.length);
        
        CGRect bounds = CGRectMake(0.0f, 0.0f, self.bounds.size.width - edge.left - edge.right, self.bounds.size.height - edge.top - edge.bottom);
        
        CGPathRef path = CGPathCreateWithRect(bounds, NULL);
        
        frame = CTFramesetterCreateFrame(framesetter, empty, path, NULL);
        
//        CFArrayRef lines = CTFrameGetLines(frame);
        
        CGPathRelease(path);
    }
    else
    {
        content = nil;
        
        framesetter = nil;
        
        frame = nil;
    }
    
    [self setNeedsDisplay];
}

- (void) setFrame:(CGRect)aframe
{
    if (frame)
    {
        CFRelease(frame);
    }
    
    if (framesetter)
    {
        CFRange empty = CFRangeMake(0, content.length);
        
        CGRect bounds = CGRectMake(0.0f, 0.0f, aframe.size.width - edge.left - edge.right, aframe.size.height - edge.top - edge.bottom);
        
        CGPathRef path = CGPathCreateWithRect(bounds, NULL);
        
        frame = CTFramesetterCreateFrame(framesetter, empty, path, NULL);
        
//        CFArrayRef lines = CTFrameGetLines(frame);
        
        CGPathRelease(path);
    }
    else
    {
        frame = nil;
    }
    
    [super setFrame:aframe];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if (frame)
    {
        CFRelease(frame);
    }
    
    if (framesetter)
    {
        CFRange empty = CFRangeMake(0, content.length);
        
        CGRect bounds = CGRectMake(0.0f, 0.0f, self.frame.size.width - edge.left - edge.right, self.frame.size.height - edge.top - edge.bottom);
        
        CGPathRef path = CGPathCreateWithRect(bounds, NULL);
        
        frame = CTFramesetterCreateFrame(framesetter, empty, path, NULL);
        
//        CFArrayRef lines = CTFrameGetLines(frame);
        
        CGPathRelease(path);
    }
    else
    {
        frame = nil;
    }
}

#pragma mark -

- (void) drawRect:(CGRect)rect
{
    @autoreleasepool
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(context);
        
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        
        CGContextFillRect(context, rect);
        
        if (framesetter && frame)
        {
            CFArrayRef lines = CTFrameGetLines(frame);
            
            CFIndex count = CFArrayGetCount(lines);
            
            CGPoint origins[count];
            
            CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
            
            for (CFIndex i = 0; i < count; i ++)
            {
                CTLineRef line = CFArrayGetValueAtIndex(lines, i);
                
                CGContextSaveGState(context);
                
                CGAffineTransform matrix = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, - 1.0f);
                
                CGContextSetTextMatrix(context, matrix);
                
                CGAffineTransform transform = CGAffineTransformMakeTranslation(edge.left + origins[i].x, rect.size.height - origins[i].y - edge.bottom);
                
                CGContextConcatCTM(context, transform);
                
                CFArrayRef runs = CTLineGetGlyphRuns(line);
                
                for (CFIndex j = 0; j < CFArrayGetCount(runs); j ++)
                {
                    CTRunRef run = CFArrayGetValueAtIndex(runs, j);
                    
                    CFDictionaryRef runDic = CTRunGetAttributes(run);
                    
                    CTRunDelegateRef rund = CFDictionaryGetValue(runDic, kCTRunDelegateAttributeName);
                    
                    if (rund)
                    {
                        CTRunDeRef *ref = CTRunDelegateGetRefCon(rund);
                        
                        const CGPoint *points = CTRunGetPositionsPtr(run);
                        
                        CGRect imageBounds = CGRectMake(points[0].x, 0.0f, ref.width, ref.height);
                        
                        CGContextSaveGState(context);
                        
                        CGAffineTransform scale = CGAffineTransformMakeScale(1.0f, - 1.0f);
                        
                        CGContextConcatCTM(context, scale);
                        
                        UIImage *image = [FNImage emojWithName:ref.name];
                        
                        CGContextDrawImage(context, imageBounds, image.CGImage);
                        
                        CGContextRestoreGState(context);
                    }
                }
                
                
//                CGFloat ascent;
//                
//                CGFloat descent;
//                
//                CGFloat leading;
//                
//                CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
//                
//                _height += (ascent + descent + leading);

                
                CTLineDraw(line, context);
                
                CGContextRestoreGState(context);
            }
        }
        
        if (touched.location != - 1)
        {
            CGRect rect = [self region:touched];
            
            CGContextSaveGState(context);
            
            const CGFloat cmark[4] = {189.0f / 255.0f, 207.0f / 255.0f, 244.0f / 255.0f, 0.5f};
            
            CGContextSetFillColor(context, cmark);
            
            CGContextFillRect(context, rect);
            
            CGContextRestoreGState(context);
        }
        
        CGContextRestoreGState(context);
        
        
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        
//        CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithWhite:0 alpha:1 ].CGColor);
//        CGContextSetLineWidth(ctx, 2.0f);
//        
//        CGPoint leftPoint = CGPointMake(0,_height);
//        CGPoint rightPoint = CGPointMake(self.frame.size.width, _height);
//        CGContextMoveToPoint(ctx, leftPoint.x, leftPoint.y);
//        CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
//        CGContextStrokePath(ctx);
    }
}

#pragma mark -

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    touched = NSMakeRange(- 1, 0);
    
    for (UITouch *touch in touches)
    {
        CGPoint p = [touch locationInView:self];
        
        CFIndex index = [self position:p];
        
        for (NSTextCheckingResult *match in links)
        {
            touched = match.range;

            if (touched.location <= index && touched.location + touched.length >= index)
            {
            }
            else
            {
                touched = NSMakeRange(- 1, 0);
            }
        }
    }
    
    [self setNeedsDisplay];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    touched = NSMakeRange(- 1, 0);
    
    for (UITouch *touch in touches)
    {
        CGPoint p = [touch locationInView:self];
        
        CFIndex index = [self position:p];
                
        for (NSTextCheckingResult *match in links)
        {
            touched = match.range;
            
            if (touched.location <= index && touched.location + touched.length >= index)
            {
                
            }
            else
            {
                touched = NSMakeRange(- 1, 0);
            }
        }
    }
    
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    touched = NSMakeRange(- 1, 0);
    
    for (UITouch *touch in touches)
    {
        CGPoint p = [touch locationInView:self];
        
        CFIndex index = [self position:p];
        
        for (NSTextCheckingResult *match in links)
        {
            NSRange range = match.range;
            
            if (range.location <= index && range.location + range.length >= index)
            {
                NSString *string = [content.string substringWithRange:range];
                
                touched = NSMakeRange(- 1, 0);
                
                [self.delegate goToLink:string ofType:match.resultType];
            }
        }
    }
    
    touched = NSMakeRange(- 1, 0);
    
    [self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    touched = NSMakeRange(- 1, 0);
    
    [self setNeedsDisplay];
}

#pragma mark - Extension

+ (CGSize) estimatedSize:(CGSize)constraints string:(NSString *)text
{
    NSMutableAttributedString *content = [FNMessagesCellTextView resolveMarkups:text];
    
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    
    [content addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, content.length)];
    
    NSMutableParagraphStyle *stly = [[NSMutableParagraphStyle alloc] init];
    
    stly.lineSpacing = 3.0f;
    
    [content addAttribute:NSParagraphStyleAttributeName value:stly range:NSMakeRange(0, content.length)];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) content);
    
    CFRange empty = CFRangeMake(0, content.length);
    
    CFRange range = CFRangeMake(0, 0);
    
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, empty, NULL, constraints, &range);
    
    CFRelease(framesetter);
    
    return size;
}

+ (NSMutableAttributedString *) resolveMarkups:(NSString *)string
{
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:@"\\[/.+?]" options:0 error:nil];
    
    NSArray *matches = [exp matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSInteger removed = 0;
    
    for (NSTextCheckingResult *match in matches)
    {
        CTRunDeRef *ref = [[CTRunDeRef alloc] init];
        
        ref.x = 0.0f;
        ref.y = 0.0f;
        
        ref.width = 24.0f;
        ref.height = 24.0f;
        
        NSRange range = NSMakeRange(match.range.location + 2, match.range.length - 3);
        
        ref.name = [string substringWithRange:range];
        
        CTRunDelegateRef rund = CTRunDelegateCreate(&cb, (void *) CFBridgingRetain(ref));
        
        NSAttributedString *attach = [[NSAttributedString alloc] initWithString:@"\uFFFC" attributes:@{(NSString *) kCTRunDelegateAttributeName : CFBridgingRelease(rund)}];
        
        range = NSMakeRange(match.range.location - removed, match.range.length);
        
        [attr replaceCharactersInRange:range withAttributedString:attach];
        
        removed += (match.range.length - 1);
    }
    
    return attr;
}

- (CFIndex) position:(CGPoint)point
{
    point.x -= edge.left;
//    point.y -= edge.top;
    
    CFIndex index = content.length;
    
    if (frame)
    {
        CFArrayRef lines = CTFrameGetLines(frame);
        
        CFIndex count = CFArrayGetCount(lines);
        
        CGPoint origins[count];
        
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
        
        for (CFIndex i = 0; i < count; i ++)
        {
            CTLineRef line = CFArrayGetValueAtIndex(lines, i);
            
            CGFloat ascent, descent, leading;
            
            double width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            
            CGFloat offset = self.frame.size.height - origins[i].y - edge.bottom;
            
            if (point.y >= offset && point.y < offset + ascent + descent)
            {
//                CFRange r = CTLineGetStringRange(line);
//                
//                NSString* substring = [content.string substringWithRange:NSMakeRange(r.location, r.length)];
//                
//                NSLog(@"%@",substring);
                
                CGPoint actual = CGPointMake(point.x - edge.left, point.y - edge.top);
                
                index = CTLineGetStringIndexForPosition(line, actual);
            }
        }
    }
    
    return index;
}

- (CGRect) region:(NSRange)range
{
    CFIndex loc = range.location;
    
    CFIndex len = range.location + range.length;
    
    if (frame)
    {
        CFArrayRef lines = CTFrameGetLines(frame);
        
        CFIndex count = CFArrayGetCount(lines);
        
        CGPoint origins[count];
        
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
        
        for (CFIndex i = 0; i < count; i ++)
        {
            CTLineRef line = CFArrayGetValueAtIndex(lines, i);
            
            CGFloat ascent, descent, leading;
            
            double width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            
            CFRange r = CTLineGetStringRange(line);
            
            if (r.location <= len && r.location + r.length > loc)
            {
                CFIndex from = MAX(loc, r.location);
                
                CFIndex to = MIN(len, r.location + r.length);
                
                CGFloat xStart = CTLineGetOffsetForStringIndex(line, from, NULL);
                
                CGFloat xEnd = CTLineGetOffsetForStringIndex(line, to, NULL);
                
                CGFloat offset = self.frame.size.height - origins[i].y - edge.bottom;
                
                return CGRectMake(edge.left + xStart, offset, xEnd - xStart, ascent + descent);
            }
        }
    }
    
    return CGRectZero;
}

@end
