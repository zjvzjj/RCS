//
//  SNSVideoRecorder.m
//  Circles
//
//  Created by ouyangyifeng on 14/10/30.
//  Copyright (c) 2014年 FeinnoCommunicationTech. All rights reserved.
//

#import "SNSVideoRecorder.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef enum RecordStatus
{
    RecordStatus_Waiting = 0x10,
    RecordStatus_begin = 0x20,
    RecordStatus_continue = 0x30,
    RecordStatus_pause = 0x40,
    RecordStatus_end = 0x50,
}RecordStatus;


@interface SNSVideoRecorder()
<
AVCaptureVideoDataOutputSampleBufferDelegate,
AVCaptureAudioDataOutputSampleBufferDelegate
>

@property (nonatomic, retain) AVCaptureSession *session;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, retain) AVCaptureDeviceInput *videoInput;
@property (nonatomic, retain) AVCaptureVideoDataOutput *videoOutput;

@property (nonatomic, retain) AVAssetWriter *videoWriter;
@property (nonatomic, retain) AVAssetWriterInput *videoWriterInput;
@property (nonatomic, retain) AVAssetWriterInput *audioWriterInput;

@property (nonatomic, assign) dispatch_queue_t queue;

@end

@implementation SNSVideoRecorder

- (id)initWithFrame:(CGRect)frame videoPath:(NSString*)videoPath
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (![videoPath rangeOfString:@".mp4"].length)
            videoPath = [videoPath stringByAppendingString:@".mp4"];
        self.imagePath = [[videoPath substringToIndex:videoPath.length - 4] stringByAppendingString:@".jpg"];
        self.videoPath = videoPath;
        
        self.queue = dispatch_queue_create("record.queue", NULL);
        
        self.session = [[[AVCaptureSession alloc] init] autorelease];
        self.session.sessionPreset = AVCaptureSessionPresetHigh;

        [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(changeCamera:) userInfo:nil repeats:NO];

        AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio] error:nil];
        [self.session addInput:audioInput];
        AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
        [audioOutput setSampleBufferDelegate:self queue:self.queue];
        [self.session addOutput:audioOutput];
        [audioOutput release];
        
        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        CGFloat height = frame.size.width * [UIScreen mainScreen].scale;
        previewLayer.frame = CGRectMake(0, -(height - frame.size.height) / 2, frame.size.width, height);
        [self.layer addSublayer:previewLayer];
        [previewLayer release];
        
        [self start];
    }
    
    return self;
}

- (void)dealloc
{
    [self cleanUpMemory];
    [super dealloc];
}

- (void)cleanUpMemory
{
    dispatch_release(self.queue);
    self.session = nil;
    self.previewLayer = nil;
    self.videoInput = nil;
    self.videoOutput = nil;
    self.videoWriter = nil;
    self.videoWriterInput = nil;
    self.audioWriterInput = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)changeCamera:(SNSVideoDevicePosition)position
{
    if (position != SNSVideoDevicePositionFront)
        position = SNSVideoDevicePositionBack;
    
    AVCaptureDeviceInput *videoInput = nil;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == (position == AVCaptureDevicePositionFront ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack))
        {
            videoInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            break;
        }
    }

    AVCaptureVideoDataOutput* videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoOutput setAlwaysDiscardsLateVideoFrames:YES];
    [videoOutput setSampleBufferDelegate:self queue:self.queue];
    NSDictionary* videoOutputSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:kCVPixelFormatType_32BGRA], kCVPixelBufferPixelFormatTypeKey,
                                        kCVPixelBufferExtendedPixelsLeftKey, kCVPixelBufferExtendedPixelsLeftKey,
                                        nil];
    videoOutput.videoSettings = videoOutputSetting;
    
    [self.session beginConfiguration];
    
    if (self.videoInput)
        [self.session removeInput:self.videoInput];
    [self.session addInput:videoInput];
    self.videoInput = videoInput;
    
    if (self.videoOutput)
        [self.session removeOutput:self.videoOutput];
    [self.session addOutput:videoOutput];
    [videoOutput release];
    self.videoOutput = videoOutput;
    
    for (AVCaptureConnection *connection in videoOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if (![port.mediaType isEqual:AVMediaTypeVideo])
                continue;
            if ([connection isVideoOrientationSupported])
                [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
        }
    }
    
    [self.session commitConfiguration];
}

- (void)initWriter
{
    self.videoWriter = [[[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:self.videoPath] fileType:AVFileTypeMPEG4 error:nil] autorelease];
    
    CGFloat width = 240;
    CGFloat height = 320;
    double bitRate = [UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].bounds.size.width;
    
    NSDictionary *videoCompressionProps = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [NSNumber numberWithDouble:bitRate], AVVideoAverageBitRateKey,
                                           nil];
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:height],AVVideoHeightKey,
                                   AVVideoScalingModeResizeAspectFill ,AVVideoScalingModeKey,
                                   videoCompressionProps, AVVideoCompressionPropertiesKey,
                                   nil];
    self.videoWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    self.videoWriterInput.expectsMediaDataInRealTime = YES;
    if ([self.videoWriter canAddInput:self.videoWriterInput])
        [self.videoWriter addInput:self.videoWriterInput];
    
    AudioChannelLayout acl;
    bzero(&acl, sizeof(acl));
    acl.mChannelLayoutTag = kAudioChannelLayoutTag_Mono;
    NSDictionary* audioSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt: kAudioFormatMPEG4AAC ], AVFormatIDKey,
                                   [NSNumber numberWithInt:64000], AVEncoderBitRateKey,
                                   [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                   [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                   [NSData dataWithBytes:&acl length:sizeof(acl)], AVChannelLayoutKey,
                                   nil];
    self.audioWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:audioSettings];
    self.audioWriterInput.expectsMediaDataInRealTime = YES;
    if ([self.videoWriter canAddInput:self.audioWriterInput])
        [self.videoWriter addInput:self.audioWriterInput];
}

- (void)setTorch:(BOOL)torch
{
    AVCaptureDevice *videoDevice = self.videoInput.device;
    if (![videoDevice hasTorch])
        return;
    
    [videoDevice lockForConfiguration:nil];
    if (torch)
        [videoDevice setTorchMode:AVCaptureTorchModeOn];
    else
        [videoDevice setTorchMode:AVCaptureTorchModeOff];
    [videoDevice unlockForConfiguration];
}

- (void)start
{
    [self.session startRunning];
}

- (void)record
{
    if (self.isRecord)
        return;
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    [fileMgr removeItemAtPath:self.imagePath error:nil];
    [fileMgr removeItemAtPath:self.videoPath error:nil];
    
    [self initWriter];
    
    self.isRecord = YES;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (!self.isRecord || (self.videoWriter.status != AVAssetWriterStatusWriting && self.videoWriter.status == AVAssetWriterStatusFailed))
        return;
    
    if (!CMSampleBufferDataIsReady(sampleBuffer))
        return;
    
    CMTime time = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
    
    if (self.videoWriter.status == AVAssetWriterStatusUnknown)
    {
        [self.videoWriter startWriting];
        [self.videoWriter startSessionAtSourceTime:time];
    }
    
    if ([captureOutput isKindOfClass:AVCaptureVideoDataOutput.class])
    {
        if ([self.videoWriterInput isReadyForMoreMediaData])
            [self.videoWriterInput appendSampleBuffer:sampleBuffer];
    }
    else if ([captureOutput isKindOfClass:AVCaptureAudioDataOutput.class])
    {
        if ([self.audioWriterInput isReadyForMoreMediaData])
            [self.audioWriterInput appendSampleBuffer:sampleBuffer];
    }
}

- (void)endRecord
{
    dispatch_async(self.queue, ^
                   {
                       if (self.videoWriter.status == AVAssetWriterStatusWriting || self.videoWriter.status == AVAssetWriterStatusFailed)
                       {
                           [self.videoWriter finishWriting];
                           [self writeThumb];
                           self.isRecord = NO;
                           return;
                       }
                       [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(endRecord) userInfo:nil repeats:NO];
                   });
}

- (void)stop
{
    [self endRecord];
    [self.session stopRunning];
}

- (void)writeThumb
{
    NSDictionary *settings = self.videoWriterInput.outputSettings;
    float width = [[settings objectForKey:AVVideoWidthKey] floatValue];
    float height = [[settings objectForKey:AVVideoHeightKey] floatValue];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:self.videoPath] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    [asset release];
    gen.appliesPreferredTrackTransform = YES;
    
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:CMTimeMakeWithSeconds(0.5,60) actualTime:&actualTime error:&error];
    [gen release];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    [thumb drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [thumb release];
    
    NSData *data = UIImageJPEGRepresentation(scaledImage, 0.7);
    [data writeToFile:self.imagePath atomically:YES];
}

- (double)size
{
    return 0;
}

- (void)clear
{
    [self stop];
}

@end