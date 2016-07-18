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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *   模型和view之间的数据交换
 *  The `FNMessageMediaData` protocol defines the common interface through which
 *  a `FNMessagesViewController` and `FNMessagesCollectionView` interact with media message model objects.
 *  它声明一个类必须实现该类的实例的必需和可选的方法
 *  It declares the required and optional methods that a class must implement so that instances of that class
 *  can be displayed properly within a `FNMessagesCollectionViewCell`.
 *
 *  This library provides a few concrete classes that conform to this protocol. You may use them as-is,
 *  but they will likely require some modifications or extensions to conform to your particular data models.
 *  These concrete media items are: `FNPhotoMediaItem`, `FNLocationMediaItem`, `FNVideoMediaItem`.
 *
 *  @see FNPhotoMediaItem.
 *  @see FNLocationMediaItem.
 *  @see FNVideoMediaItem.
 */
@protocol FNMessageMediaData <NSObject>

@required

/**
 *  @return An initialized `UIView` object that represents the data for this media object.
 *
 *  @discussion You may return `nil` from this method while the media data is being downloaded.
 */
- (UIView *)mediaView;

/**
 *  @return The frame size for the mediaView when displayed in a `FNMessagesCollectionViewCell`. 
 *
 *  @discussion You should return an appropriate size value to be set for the mediaView's frame
 *  based on the contents of the view, and the frame and layout of the `FNMessagesCollectionViewCell`
 *  in which mediaView will be displayed.
 *
 *  @warning You must return a size with non-zero, positive width and height values.
 */
- (CGSize)mediaViewDisplaySize;

/**
 *  @return A placeholder media view to be displayed if mediaView is not yet available, or `nil`.
 *  For example, if mediaView will be constructed based on media data that must be downloaded,
 *  this placeholder view will be used until mediaView is not `nil`.
 *
 *  @discussion If you do not need support for a placeholder view, then you may simply return the
 *  same value here as mediaView. Otherwise, consider using `FNMessagesMediaPlaceholderView`.
 *
 *  @warning You must not return `nil` from this method.
 *
 *  @see FNMessagesMediaPlaceholderView.
 */
- (UIView *)mediaPlaceholderView;

@end
