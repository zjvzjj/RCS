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

/**
 *  The `FNPhotoMediaItem` class is a concrete `FNMediaItem` subclass that implements the `FNMessageMediaData` protocol
 *  and represents a photo media message. An initialized `FNPhotoMediaItem` object can be passed 
 *  to a `FNMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `FNPhotoMediaItem` to provide additional functionality or behavior.
 */
@interface FNPhotoMediaItem : FNMediaItem <FNMessageMediaData, NSCoding, NSCopying>

/**
 *  The image for the photo media item. The default value is `nil`.
 */

@property (copy, nonatomic) UIImage *image;

/**
 *  初始化并返回具有给定的图像照片的媒体项目对象。
 *  Initializes and returns a photo media item object having the given image.
 *
 *  @param image The image for the photo media item. This value may be `nil`.
 *
 *  @return An initialized `FNPhotoMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the image must be dowloaded from the network, 
 *  you may initialize a `FNPhotoMediaItem` object with a `nil` image. 
 *  Once the image has been retrieved, you can then set the image property.
 */
- (instancetype)initWithImage:(UIImage *)image;

- (void)removeUploadFromSuperView;

- (void)addUploadViewToSuperView;

@property (nonatomic, retain) NSString *imagePath;

@end
