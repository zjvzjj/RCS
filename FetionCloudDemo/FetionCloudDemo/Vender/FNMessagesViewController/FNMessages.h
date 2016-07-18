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

#ifndef FNMessages_FNMessages_h
#define FNMessages_FNMessages_h

#import "FNMessagesViewController.h"

//  Views
#import "FNMessagesCollectionView.h"
#import "FNMessagesCollectionViewCellIncoming.h"
#import "FNMessagesCollectionViewCellOutgoing.h"
#import "FNMessagesTypingIndicatorFooterView.h"
#import "FNMessagesLoadEarlierHeaderView.h"

//  Layout
#import "FNMessagesCollectionViewFlowLayout.h"
#import "FNMessagesCollectionViewLayoutAttributes.h"

//  Model
#import "FNMessage.h"

#import "FNMediaItem.h"
#import "FNPhotoMediaItem.h"
#import "FNLocationMediaItem.h"
#import "FNVideoMediaItem.h"
#import "FNAudioMediaItem.h"

#import "FNMessagesBubbleImage.h"
#import "FNMessagesAvatarImage.h"
#import "FNMessagesCancleImage.h"

//  Protocols
#import "FNMessageData.h"
#import "FNMessageMediaData.h"
#import "FNMessageAvatarImageDataSource.h"
#import "FNMessageBubbleImageDataSource.h"
#import "FNMessageCancleImageDataSource.h"
#import "FNMessagesCollectionViewDataSource.h"
#import "FNMessagesCollectionViewDelegateFlowLayout.h"

//  Factories
#import "FNMessagesAvatarImageFactory.h"
#import "FNMessagesBubbleImageFactory.h"
#import "FNMessagesMediaViewBubbleImageMasker.h"
#import "FNMessagesTimestampFormatter.h"

//  Categories
#import "FNSystemSoundPlayer+FNMessages.h"
#import "NSString+FNMessages.h"
#import "UIColor+FNMessages.h"
#import "UIImage+FNMessages.h"
#import "UIView+FNMessages.h"
#import "UIImage+FNRound.h"

#endif
