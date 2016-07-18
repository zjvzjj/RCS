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

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

/**
 *  A completion handler block for a `FNLocationMediaItem`. See `setLocation: withCompletionHandler:`.
 */
typedef void (^FNLocationMediaItemCompletionBlock)(void);


#import "FNMediaItem.h"
#import "FNMessagesAvatarImageFactory.h"

/**
 *  The `FNLocationMediaItem` class is a concrete `FNMediaItem` subclass that implements the `FNMessageMediaData` protocol
 *  and represents a location media message. An initialized `FNLocationMediaItem` object can be passed
 *  to a `FNMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `FNLocationMediaItem` to provide additional functionality or behavior.
 */
@interface FNLocationMediaItem : FNMediaItem <FNMessageMediaData, MKAnnotation, NSCoding, NSCopying>

/**
 *  The location for the media item. The default value is `nil`.
 */
@property (copy, nonatomic) CLLocation *location;

/**
 *  The coordinate of the location property.
 */
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;

/**
 *  Initializes and returns a location media item object having the given location.
 *
 *  @param location The location for the media item. This value may be `nil`.
 *
 *  @return An initialized `FNLocationMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the location data must be dowloaded from the network,
 *  you may initialize a `FNLocationMediaItem` object with a `nil` location.
 *  Once the location data has been retrieved, you can then set the location property
 *  using `setLocation: withCompletionHandler:`
 */
- (instancetype)initWithLocation:(CLLocation *)location;

/**
 *  Sets the specified location for the location media item and immediately begins creating
 *  a map view snapshot image on a background thread. The map view zooms to a default region whose center point 
 *  is the location coordinate and whose span is 500 meters for both the latitudinal and longitudinal meters.
 *
 *  The specified block is executed upon completion of creating the snapshot image and is executed on the app’s main thread.
 *
 *  @param location   The location for the media item.
 *  @param completion The block to call after the map view snapshot for the given location has been created.
 */
- (void)setLocation:(CLLocation *)location withCompletionHandler:(FNLocationMediaItemCompletionBlock)completion;

/**
 *  Sets the specified location for the location media item and immediately begins creating
 *  a map view snapshot image on a background thread.
 *
 *  The specified block is executed upon completion of creating the snapshot image and is executed on the app’s main thread.
 *
 *  @param location   The location for the media item.
 *  @param region     The map region that you want to capture.
 *  @param completion The block to call after the map view snapshot for the given location has been created.
 */
- (void)setLocation:(CLLocation *)location
             region:(MKCoordinateRegion)region withCompletionHandler:(FNLocationMediaItemCompletionBlock)completion;
@end
