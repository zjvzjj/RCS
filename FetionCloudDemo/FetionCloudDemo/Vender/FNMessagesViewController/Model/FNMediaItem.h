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

#import "FNMessageMediaData.h"

/**
 *  The `FNMediaItem` class is an abstract base class for media item model objects that represents一个抽象的多媒体model基类,提供默认的多媒体视图大小，占位视图，按照那种方式显示
 *  a single media attachment for a user message. It provides some default behavior for media items,
 *  including a default mediaViewDisplaySize, a default mediaPlaceholderView, and view masking as
 *  specified by appliesMediaViewMaskAsOutgoing. 
 *
 *  @warning This class is intended to be subclassed. You should not use it directly.
 *
 *  @see FNLocationMediaItem.
 *  @see FNPhotoMediaItem.
 *  @see FNVideoMediaItem.
 */
@interface FNMediaItem : NSObject <FNMessageMediaData, NSCoding, NSCopying>

/**
 *  A boolean value indicating whether this media item should apply
 *  an outgoing or incoming bubble image mask to its media views.
 *  Specify `YES` for an outgoing mask, and `NO` for an incoming mask.
 *  The default value is `YES`.
 */
@property (assign, nonatomic) BOOL appliesMediaViewMaskAsOutgoing;

/**
 *  Initializes and returns a media item with the specified value for maskAsOutgoing.
 *
 *  @param maskAsOutgoing A boolean value indicating whether this media item should apply指定是去按照那种气泡图片剪裁，yes按照发出，no按照收到 yes默认
 *  an outgoing or incoming bubble image mask to its media views.
 *
 *  @return An initialized `FNMediaItem` object if successful, `nil` otherwise.
 */
- (instancetype)initWithMaskAsOutgoing:(BOOL)maskAsOutgoing;

@end
