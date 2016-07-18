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

#import "FNSystemSoundPlayer+FNMessages.h"

@implementation FNSystemSoundPlayer (FNMessages)

+ (void)fn_playMessageReceivedSound
{
    [[FNSystemSoundPlayer sharedPlayer] playSoundWithFilename:@"message_received"
                                                 fileExtension:kFNSystemSoundTypeAIFF];
}

+ (void)fn_playMessageReceivedAlert
{
    [[FNSystemSoundPlayer sharedPlayer] playAlertSoundWithFilename:@"message_received" fileExtension:kFNSystemSoundTypeAIFF];
}

+ (void)fn_playMessageSentSound
{
    [[FNSystemSoundPlayer sharedPlayer] playSoundWithFilename:@"message_sent"
                                                 fileExtension:kFNSystemSoundTypeAIFF];
}

+ (void)fn_playMessageSentAlert
{
    [[FNSystemSoundPlayer sharedPlayer] playAlertSoundWithFilename:@"message_sent" fileExtension:kFNSystemSoundTypeAIFF];
}

@end
