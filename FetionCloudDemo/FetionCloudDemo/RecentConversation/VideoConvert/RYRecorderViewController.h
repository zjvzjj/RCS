//
//  RYRecorderViewController.h
//  Video Change MP4
//
//  Created by  易庆萍 on 16/1/16.
//  Copyright © 2016年 易庆萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYRecorderViewController : UIViewController


@property(nonatomic,copy)void(^sendDataWithVideoPathAndImagePath)(NSString*VideoPath,NSString*Image) ;


@end
