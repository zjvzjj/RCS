//
//  RYContentView.h
//  Video Change MP4
//
//  Created by  易庆萍on 16/1/16.
//  Copyright © 2016年 易庆萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height
#define kContentView_height kScreen_width*0.7

@class RYContentView;
@protocol RYContentViewDelegate <NSObject>

//开始录制
-(void)contentViewRecordStart:(RYContentView*)contentView andLabel:(UILabel*)timeLabel;
//结束录制
-(void)contentViewRecordEnd:(RYContentView*)contentView andLabel:(UILabel*)timeLabel;


//删除视频
-(void)contentViewVideoDelete:(RYContentView*)contentView andBtn:(UIButton*)btn;

//选择视频
-(void)contentViewVideoCheck:(RYContentView*)contentView andBtn:(UIButton*)btn;


@end

@interface RYContentView : UIView
@property (weak, nonatomic) IBOutlet UIButton *recorderBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property(nonatomic,weak)id<RYContentViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *deleteVideoBtn;

@property (weak, nonatomic) IBOutlet UIButton *checkVideoBtn;


+(instancetype)contentView;

@end
