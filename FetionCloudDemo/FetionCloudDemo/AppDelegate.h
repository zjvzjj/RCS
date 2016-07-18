//
//  AppDelegate.h
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RcsApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign) int buddyInviterId;
@property (nonatomic,assign) int buddyRemoteId;
@property (nonatomic) NSString* localNum;

@property (nonatomic) NSMutableArray *buddyIDArray;


extern RcsApi *globalRcsApi;
extern rcs_state* R;

@end

