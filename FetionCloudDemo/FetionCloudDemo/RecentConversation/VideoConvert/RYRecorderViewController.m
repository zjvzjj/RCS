//
//  RYRecorderViewController.m
//  Video Change MP4
//
//  Created by  易庆萍 on 16/1/16.
//  Copyright © 2016年 易庆萍. All rights reserved.
//

#import "RYRecorderViewController.h"
#import "SNSVideoRecorder.h"
#import "RYContentView.h"
#import <AVFoundation/AVFoundation.h>
#define LIMIT_TIME 6000 //最大录制时间
#define progressH 10

@interface RYRecorderViewController ()<RYContentViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)SNSVideoRecorder *videoRecorder ;
@property(nonatomic,weak)RYContentView *contentView;
@property(nonatomic,weak)UIView *progressView;//进度条视图
@property(nonatomic,weak)UIView *progresPoint;//闪动效果



@property(nonatomic,assign)NSInteger recordTime;//当前视频录制时间
@property(nonatomic,assign)NSInteger videoTime;//当前视频最终时间
@property(nonatomic,strong)NSTimer *videoTimer ;//定时器
@property(nonatomic,copy)NSString *imagePath ;//视频截图位置
@property(nonatomic,copy)NSString *videoPath ;//视频位置


@property(nonatomic,assign)BOOL isBack ;//是否点击导航控制器的返回按钮

@property (nonatomic,assign) BOOL isFrontCamere; // 前后摄像头选择按钮
@end

@implementation RYRecorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    
    //初始化视频录制视图
    [self MakeOperationBtn];
    //初始化视频控制视图
    [self MakeRecorder];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(showAlertViewAndBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(changeCamera:)];
    self.isFrontCamere = NO;
    
}
#pragma mark 初始化视频录制视图
-(void)MakeOperationBtn
{
    RYContentView *contentView=[RYContentView contentView];
    contentView.frame=CGRectMake(0, kScreen_height-kContentView_height, kScreen_width, kContentView_height);
    contentView.delegate=self;
    
    UIView *pView=[[UIView alloc]init];
    pView.frame=CGRectMake(0, 20, kScreen_width, progressH);
    pView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.7];
    
    UIView *progressView=[[UIView alloc]init];
    progressView.backgroundColor=[UIColor colorWithRed:0 green:163 blue:255 alpha:1];
    //progressView.frame=CGRectMake(20, 0, 50, 10);
    [pView addSubview:progressView];
    self.progressView=progressView;
    
    UIView *pointView=[[UIView alloc]init];
    pointView.backgroundColor=[UIColor whiteColor];
    pointView.frame=CGRectMake(0, 0, 3, progressH);
    [pView addSubview:pointView];
    self.progresPoint=pointView;
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=[UIColor whiteColor];
    line.frame=CGRectMake(kScreen_width*2/3,0 , 1, progressH);
    [pView addSubview:line];
    self.progresPoint=line;
    
    
    [contentView addSubview:pView];
    [self.view addSubview:contentView];
    self.contentView=contentView;
    self.contentView.timeLabel.text = [NSString stringWithFormat:@"剩余%ld秒", (LIMIT_TIME - self.recordTime) / 1000];
    
}
#pragma mark 初始化视频控制视图
-(void)MakeRecorder
{
    NSString *fileSavePath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"needMp4.mp4"];
    SNSVideoRecorder *recorder=[[SNSVideoRecorder alloc]initWithFrame:self.view.bounds videoPath:fileSavePath];
    [self.view insertSubview:recorder belowSubview:self.contentView];
    self.videoRecorder=recorder;    
}




#pragma mark 代理事件， 录制 暂停
//开始录制
-(void)contentViewRecordStart:(RYContentView*)contentView andLabel:(UILabel*)timeLabel
{
    [self recordStart];
    self.navigationItem.leftBarButtonItem.enabled = NO;
}
//结束录制
-(void)contentViewRecordEnd:(RYContentView*)contentView andLabel:(UILabel*)timeLabel
{
    [self recordEnd];
    self.navigationItem.leftBarButtonItem.enabled = YES;

    
}
//删除视频
-(void)contentViewVideoDelete:(RYContentView*)contentView andBtn:(UIButton*)btn
{
    [self showAlertView];
}

//选择视频
-(void)contentViewVideoCheck:(RYContentView*)contentView andBtn:(UIButton*)btn
{
    
    if (self.sendDataWithVideoPathAndImagePath) {
        self.sendDataWithVideoPathAndImagePath(self.videoPath,self.imagePath);
    };
}

-(void)changeCamera:(UIButton *)btn
{
    
    if (self.isFrontCamere)
    {
        [self.videoRecorder changeCamera:SNSVideoDevicePositionBack];
        self.isFrontCamere = NO;
    }
    else
    {
        [self.videoRecorder changeCamera:SNSVideoDevicePositionFront];
        self.isFrontCamere = YES;
    }
    
}
-(void)recordStart
{
    
    NSLog(@"开始录制：%@",NSHomeDirectory());
    
    self.recordTime = 0;
    [self.videoRecorder record];
    self.videoTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(recording) userInfo:nil repeats:YES];
    
    self.imagePath = self.videoRecorder.imagePath;
    self.videoPath = self.videoRecorder.videoPath;
}
-(void)recordEnd
{
    NSLog(@"结束录制%@",self.videoPath);
    //确定录制时间
    if (!self.recordTime)
    {
        CMTime time = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:self.videoPath] options:nil].duration;
        self.recordTime = time.value * 1.0 / time.timescale * 1000;
    }
    //确定视频时间
    self.videoTime = self.recordTime / 1000.0;
    //视频小于4秒提示
    if (self.recordTime < LIMIT_TIME * 2 / 3)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"视频录制时间不能小于4秒" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [self clear];
        self.contentView.deleteVideoBtn.enabled=NO;
        self.contentView.checkVideoBtn.enabled=NO;
        return;
    }
    
    self.contentView.recorderBtn.enabled = NO;
    self.contentView.deleteVideoBtn.enabled=YES;
    self.contentView.checkVideoBtn.enabled=YES;
    [self stop];
}
#pragma mark 重制显示的控件 进度条
- (void)clear
{
    [self stop];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    [fileMgr removeItemAtPath:self.imagePath error:nil];
    [fileMgr removeItemAtPath:self.videoPath error:nil];
    
    self.imagePath = nil;
    self.videoTime = 0;
    self.videoPath = nil;
    self.contentView.timeLabel.text=[NSString stringWithFormat:@"剩余%d秒", LIMIT_TIME  / 1000];
    self.contentView.recorderBtn.enabled = YES;
    self.progressView.frame = CGRectMake(0, 0, 0, progressH);
    self.progresPoint.frame = CGRectMake(self.progressView.frame.size.width - 1.5, 0, 3, progressH);
    self.progresPoint.hidden=NO;
    
    [self MakeRecorder];
}
#pragma mark 销毁定时器 停止录制
- (void)stop
{
    [self.videoTimer invalidate];
    self.videoTimer = nil;
    [self.videoRecorder stop];
}
#pragma mark 定时器执行事件
-(void)recording
{
    if (self.recordTime > LIMIT_TIME)
    {
        [self recordEnd];
        return;
    }
    
    if (!self.videoRecorder.isRecord)
        return;
    self.recordTime += 50;
    NSInteger leftTime ;
    if(self.recordTime > LIMIT_TIME - 100 ||self.recordTime == LIMIT_TIME)
    {
        leftTime = 0;
        
    }else{
        leftTime =(LIMIT_TIME - self.recordTime) / 1000 + 1;
    }
    self.contentView.timeLabel.text = [NSString stringWithFormat:@"剩余%ld秒", leftTime];
    UIColor *relaseC=[UIColor colorWithRed:0 green:163 blue:255 alpha:1];
    UIColor *blueC=[UIColor colorWithRed:183 green:177 blue:156 alpha:1];
    
    self.progressView.backgroundColor = self.recordTime >= LIMIT_TIME * 2 / 3 ? relaseC : blueC;
    self.progressView.frame = CGRectMake(0, 0, self.view.frame.size.width * self.recordTime / LIMIT_TIME, progressH);
    self.progresPoint.frame = CGRectMake(self.progressView.frame.size.width, 0, 3, progressH);
    
    if (self.recordTime % 500 == 0)
    {
        self.progresPoint.hidden = !self.progresPoint.hidden;
    }
    
}

-(void)showAlertViewAndBack
{
    if (self.videoTime >= 4) {
        self.isBack = YES;
        [self showAlertView];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)showAlertView
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要放弃视频？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
#pragma mark alertView 代理时间
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if (self.isBack==YES) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
        [self clear];
        self.contentView.deleteVideoBtn.enabled=NO;
        self.contentView.checkVideoBtn.enabled=NO;
    }
    if (buttonIndex==0) {
        self.isBack=NO;
    }
    
}




@end
