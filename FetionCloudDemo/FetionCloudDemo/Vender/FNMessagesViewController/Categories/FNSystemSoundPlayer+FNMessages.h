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

#import "FNSystemSoundPlayer.h"

@interface FNSystemSoundPlayer (FNMessages)

/**
 *  Plays the default sound for received messages.
 */
+ (void)fn_playMessageReceivedSound;

/**
 *  Plays the default sound for received messages *as an alert*, invoking device vibration if available.
 */
+ (void)fn_playMessageReceivedAlert;

/**
 *  Plays the default sound for sent messages.
 */
+ (void)fn_playMessageSentSound;

/**
 *  Plays the default sound for sent messages *as an alert*, invoking device vibration if available.
 */
+ (void)fn_playMessageSentAlert;

@end
