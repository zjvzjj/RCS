//
//  RYContentView.m
//  Video Change MP4
//
//  Created by  易庆萍on 16/1/16.
//  Copyright © 2016年 易庆萍. All rights reserved.
//

#import "RYContentView.h"

@implementation RYContentView

+(instancetype)contentView
{
    RYContentView*view = [[[NSBundle mainBundle]loadNibNamed:@"RYContentView"owner:nil options:nil] lastObject];
    return view;
}

-(void)awakeFromNib
{
    self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
    [self.recorderBtn setImage:[UIImage imageNamed:@"sns_publish_video_btn_record_normal"] forState:UIControlStateNormal];
    [self.recorderBtn setImage:[UIImage imageNamed:@"sns_publish_video_btn_record_press"] forState:UIControlStateHighlighted];
    self.recorderBtn.layer.cornerRadius = 100 / 2;
    [self.recorderBtn addTarget:self action:@selector(recordStart) forControlEvents:UIControlEventTouchDown];
    [self.recorderBtn addTarget:self action:@selector(recordEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.recorderBtn addTarget:self action:@selector(recordEnd) forControlEvents:UIControlEventTouchUpOutside];
    
    self.deleteVideoBtn.enabled = NO;
    self.checkVideoBtn.enabled = NO;
}

//开始录制
-(void)recordStart
{
    if (self.delegate) {
        [self.delegate contentViewRecordStart:self andLabel:self.timeLabel];
    }
}
//结束录制
-(void)recordEnd
{
    if (self.delegate) {
        [self.delegate contentViewRecordEnd:self andLabel:self.timeLabel];
    }
}

//删除视频
- (IBAction)deleteVideoClick:(id)sender {
    
    if (self.delegate) {
        [self.delegate contentViewVideoDelete:self andBtn:sender];
    }
}

//选择视频
- (IBAction)chechVideoBtnClick:(id)sender {
    if (self.delegate) {
        [self.delegate contentViewVideoCheck:self andBtn:sender];
    }
}




@end
