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

#import "FNVideoMediaItem.h"

#import "FNMessagesMediaPlaceholderView.h"
#import "FNMessagesMediaViewBubbleImageMasker.h"

#import "UIImage+FNMessages.h"
#import "ShapedImageView.h"
#import "UIView+ZLExtension.h"
@interface FNVideoMediaItem ()
{
    AVPlayerLayer *_layer;
}

@property (strong, nonatomic) UIImageView *cachedVideoImageView;

@end


@implementation FNVideoMediaItem

@synthesize thumbPath = _thumbPath;

#pragma mark - Initialization

- (instancetype)initWithFileURL:(NSURL *)fileURL isReadyToPlay:(BOOL)isReadyToPlay
{
    self = [super init];
    if (self) {
        _fileURL = [fileURL copy];
        _isReadyToPlay = isReadyToPlay;
        _cachedVideoImageView = nil;
    }
    return self;
}

- (void)dealloc
{
    _fileURL = nil;
    _cachedVideoImageView = nil;
    _thumbPath = nil;
}

#pragma mark - Setters

- (void)setFileURL:(NSURL *)fileURL
{
    _fileURL = [fileURL copy];
    _cachedVideoImageView = nil;
}

- (void)setIsReadyToPlay:(BOOL)isReadyToPlay
{
    _isReadyToPlay = isReadyToPlay;
    _cachedVideoImageView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedVideoImageView = nil;
}

#pragma mark - FNMessageMediaData protocol
- (UIView *)mediaView
{
    ShapedImageView *imageView = nil;
    CGSize size = [self mediaViewDisplaySize];

    if (self.cachedVideoImageView == nil)
    {
        if(self.fileURL == nil || self.fileURL.absoluteString.length ==0)
        {
            if (!self.appliesMediaViewMaskAsOutgoing)
            {
                imageView = [[ShapedImageView alloc]initWithFrame:CGRectMake(0,0,size.width,size.height) withImage:@"incomingbubble_min"];
            }
            else
            {
                imageView = [[ShapedImageView alloc]initWithFrame:CGRectMake(0,0,size.width,size.height) withImage:@"outgoingbubble_min"];
            }
            
            self.cachedVideoImageView = imageView;
            UIImageView *videoSymbol = [[UIImageView alloc]initWithImage:[FNImage imageWithName:@"cancle"]];
            videoSymbol.bounds = CGRectMake(0, 0, size.width * 0.25, size.width * 0.25);
            videoSymbol.zl_centerX = size.width * 0.5;
            videoSymbol.zl_centerY = size.height * 0.5;
            [imageView addSubview:videoSymbol];
            
        }else{
        
        AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:self.fileURL options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc]initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:CMTimeMakeWithSeconds(1, 60) actualTime:&actualTime error:&error];
        UIImage *thumbImage = [[UIImage alloc]initWithCGImage:image];
    
        if (!self.appliesMediaViewMaskAsOutgoing)
        {
            imageView = [[ShapedImageView alloc]initWithFrame:CGRectMake(0,0,size.width,size.height) withImage:@"incomingbubble_min"];
        }
        else
        {
            imageView = [[ShapedImageView alloc]initWithFrame:CGRectMake(0,0,size.width,size.height) withImage:@"outgoingbubble_min"];
        }
        
        [imageView setImage:thumbImage];
        self.cachedVideoImageView = imageView;
        UIImageView *videoSymbol = [[UIImageView alloc]initWithImage:[FNImage imageWithName:@"play"]];
        videoSymbol.bounds = CGRectMake(0, 0, size.width * 0.25, size.width * 0.25);
        videoSymbol.zl_centerX = size.width * 0.5;
        videoSymbol.zl_centerY = size.height * 0.5;
        [imageView addSubview:videoSymbol];
                
        UILabel *coverLabel= [[UILabel alloc]init];
        coverLabel.backgroundColor =[UIColor whiteColor];
        coverLabel.alpha = 0.5;
        coverLabel.zl_width = size.width;
        coverLabel.zl_height = 40;
        coverLabel.zl_x = 0;
        coverLabel.zl_y = size.height -coverLabel.zl_height;
        [imageView addSubview:coverLabel];
        
        UILabel *sizeLabel = [[UILabel alloc]init];
        sizeLabel.tag = 2000;
        sizeLabel.textColor = [UIColor blackColor];
        sizeLabel.textAlignment = NSTextAlignmentLeft;
        sizeLabel.frame = CGRectMake(10, size.height -40, 100, 40);
        [imageView addSubview:sizeLabel];
        
        UILabel *timeLabel = [[UILabel alloc]init];
         timeLabel.tag = 2001;
        timeLabel.frame = CGRectMake(size.width - 60, size.height -40, 60, 40);
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [imageView addSubview:timeLabel];
        }
    }
    
    return self.cachedVideoImageView;
}
//- (UIView *)mediaView
//{
////    if (self.fileURL == nil) {
////        return nil;
////    }
//    
//    if (self.cachedVideoImageView == nil)
//    {
//        CGSize size = [self mediaViewDisplaySize];
//        
//        NSString *imageName = @"outgoingbubble_min";
//     
//        if (!self.appliesMediaViewMaskAsOutgoing)
//        {
//            imageName = @"incomingbubble_min";
//        }
//        
//        UIImage *image = [FNImage imageWithName:imageName];
//        
//        UIEdgeInsets insets = UIEdgeInsetsMake((image.size.height/2.0)-1, (image.size.width/2.0)-1, image.size.height/2.0, image.size.width/2.0);
//        
//        UIImage *bubble = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:bubble];
//        
//        imageView.backgroundColor = [UIColor clearColor];
//        
//        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
//        
//        if (_fileURL && _isReadyToPlay)
//        {
//            [imageView.layer addSublayer:[self mediaSnapshot]];
//        }
//        else if (_thumbPath)
//        {
//            UIImage *thumb = [UIImage imageWithContentsOfFile:_thumbPath];
//            imageView.image = thumb;
//        }
//        
//        self.cachedVideoImageView = imageView;
//    }
//    
//    return self.cachedVideoImageView;
//}
//
- (AVPlayerLayer *)mediaSnapshot
{
    AVPlayer *player = [AVPlayer playerWithURL:self.fileURL];
    
    if (_layer)
    {
        return _layer;
    }
    
    _layer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    _layer.backgroundColor = [[UIColor clearColor] CGColor];
    
    CGSize size = [self mediaViewDisplaySize];
    
    _layer.frame = CGRectMake(5, 5, size.width-15, size.height-10);
    
    CALayer *icon = [CALayer layer];
    
    icon.contentsGravity = @"center";
    
    icon.frame = _layer.bounds;
        
    icon.contents = (id)[FNImage imageWithName:@"failure1"].CGImage;
    
    [_layer addSublayer:icon];
    
    return _layer;
}

- (CGSize)mediaViewDisplaySize
{
    return CGSizeMake(200, 200);
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![super isEqual:object]) {
        return NO;
    }
    
    FNVideoMediaItem *videoItem = (FNVideoMediaItem *)object;
    
    return [self.fileURL isEqual:videoItem.fileURL]
            && self.isReadyToPlay == videoItem.isReadyToPlay;
}

- (NSUInteger)hash
{
    return self.fileURL.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: fileURL=%@, isReadyToPlay=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.fileURL, @(self.isReadyToPlay), @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _fileURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(fileURL))];
        _isReadyToPlay = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isReadyToPlay))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.fileURL forKey:NSStringFromSelector(@selector(fileURL))];
    [aCoder encodeBool:self.isReadyToPlay forKey:NSStringFromSelector(@selector(isReadyToPlay))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    FNVideoMediaItem *copy = [[[self class] allocWithZone:zone] initWithFileURL:self.fileURL
                                                                   isReadyToPlay:self.isReadyToPlay];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
