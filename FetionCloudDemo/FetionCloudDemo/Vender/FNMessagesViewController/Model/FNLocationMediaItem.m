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

#import "FNLocationMediaItem.h"

#import "FNMessagesMediaPlaceholderView.h"
#import "FNMessagesMediaViewBubbleImageMasker.h"


@interface FNLocationMediaItem ()

@property (strong, nonatomic) UIImage *cachedMapSnapshotImage;

@property (strong, nonatomic) UIImageView *cachedMapImageView;

- (void)createMapViewSnapshotForLocation:(CLLocation *)location
                        coordinateRegion:(MKCoordinateRegion)region
                   withCompletionHandler:(FNLocationMediaItemCompletionBlock)completion;

@end


@implementation FNLocationMediaItem

#pragma mark - Initialization

- (instancetype)initWithLocation:(CLLocation *)location
{
    self = [super init];
    if (self) {
        [self setLocation:location withCompletionHandler:nil];
    }
    return self;
}

- (void)dealloc
{
    _location = nil;
    _cachedMapSnapshotImage = nil;
    _cachedMapImageView = nil;
}

#pragma mark - Setters

- (void)setLocation:(CLLocation *)location
{
    [self setLocation:location withCompletionHandler:nil];
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedMapSnapshotImage = nil;
    _cachedMapImageView = nil;
}

#pragma mark - Map snapshot

- (void)setLocation:(CLLocation *)location withCompletionHandler:(FNLocationMediaItemCompletionBlock)completion
{
    [self setLocation:location region:MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0) withCompletionHandler:completion];
}

- (void)setLocation:(CLLocation *)location region:(MKCoordinateRegion)region withCompletionHandler:(FNLocationMediaItemCompletionBlock)completion
{
    _location = [location copy];
    _cachedMapSnapshotImage = nil;
    _cachedMapImageView = nil;
    
    if (_location == nil) {
        return;
    }
    
    [self createMapViewSnapshotForLocation:_location
                          coordinateRegion:region
                     withCompletionHandler:completion];
}

- (void)createMapViewSnapshotForLocation:(CLLocation *)location
                        coordinateRegion:(MKCoordinateRegion)region
                   withCompletionHandler:(FNLocationMediaItemCompletionBlock)completion
{
    NSParameterAssert(location != nil);
    
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = region;
    options.size = [self mediaViewDisplaySize];
    options.scale = [UIScreen mainScreen].scale;
    
    MKMapSnapshotter *snapShotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    
    [snapShotter startWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
              completionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
                  if (error) {
                      NSLog(@"%s Error creating map snapshot: %@", __PRETTY_FUNCTION__, error);
                      return;
                  }
                  
                  MKAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:nil];
                  CGPoint coordinatePoint = [snapshot pointForCoordinate:location.coordinate];
                  UIImage *image = snapshot.image;
                  
                  UIGraphicsBeginImageContextWithOptions(image.size, YES, image.scale);
                  {
                      [image drawAtPoint:CGPointZero];
                      [pin.image drawAtPoint:coordinatePoint];
                      self.cachedMapSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
                  }
                  UIGraphicsEndImageContext();
                  
                  if (completion) {
                      dispatch_async(dispatch_get_main_queue(), completion);
                  }
              }];
}

#pragma mark - MKAnnotation

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

#pragma mark - FNMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.location == nil) {
        return nil;
    }
    
    if (self.cachedMapImageView == nil)
    {
        CGSize size = [self mediaViewDisplaySize];
        
        NSString *imageName = @"outgoingbubble_min";
       
        if (!self.appliesMediaViewMaskAsOutgoing)
        {
            imageName = @"incomingbubble_min";
        }
        
        UIImage *image = [FNImage imageWithName:imageName];
        
        UIEdgeInsets insets = UIEdgeInsetsMake((image.size.height/2.0)-1, (image.size.width/2.0)-1, image.size.height/2.0, image.size.width/2.0);
        
        UIImage *bubble = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.image = bubble;
        
        imageView.backgroundColor = [UIColor clearColor];
        
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        
        UIImageView *locationView = [[UIImageView alloc] initWithImage:self.cachedMapSnapshotImage];
        
        locationView.backgroundColor = [UIColor redColor];
        
        locationView.frame = CGRectMake(5, 5, size.width-15, size.height-10);
        
        locationView.contentMode = UIViewContentModeScaleAspectFit;
        
        [imageView addSubview:locationView];
        
        [FNMessagesAvatarImageFactory circularAvatarImage:self.cachedMapSnapshotImage withDiameter:4];
        
        self.cachedMapImageView = imageView;

    }
    
    return self.cachedMapImageView;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![super isEqual:object]) {
        return NO;
    }
    
    FNLocationMediaItem *locationItem = (FNLocationMediaItem *)object;
    
    return [self.location isEqual:locationItem.location];
}

- (NSUInteger)hash
{
    return self.location.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: location=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.location, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        CLLocation *location = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(location))];
        [self setLocation:location withCompletionHandler:nil];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.location forKey:NSStringFromSelector(@selector(location))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    FNLocationMediaItem *copy = [[[self class] allocWithZone:zone] initWithLocation:self.location];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
