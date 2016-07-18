//
//  FNMsgContent.h
//  FeinnoBopSDK
//
//  Created by doujinkun on 15/3/26.
//  Copyright (c) 2015年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNEnum.h"

/**
 *  消息内容的类族
 */
@interface FNMsgContent : NSObject

/**
 *  得到某种消息内容类的工厂方法,请调用此方法得到实例对象，不建议使用init方法
 *
 *  @param type 消息内容的参数，可能的取值为枚举类型MsgContentType：TextMsg ImageMsg VideoMsg AudioMsg FileMsg
 *
 *  @return 返回的实例变量
 */
+ (instancetype)msgContentWithType:(MsgContentType)type;

/**
 *  将字符串转化为类的实例对象，由SDK调用
 *
 *  @param str     要转化的字符串
 *  @param msgType 消息内容的类型 FNMsgTypePlain FNMsgTypePic FNMsgTypeAudio FNMsgTypeFile FNMsgTypeVideo
 *
 *  @return 返回的实例对象
 */
+ (instancetype)toObjectFromStr:(NSString *)str withMsgType:(NSString *)msgType;

/**
 *  将实例对象转化成字符串
 *
 *  @return 返回的字符串,当为FNMsgContent类实例或者参数错误时，返回nil
 */
- (NSString *)toJString;

/**
 *  消息内容的类型
 *
 *  @return 返回的消息内容的类型
 */
- (NSString *)contentType;

/**
 *  消息的内容
 *
 *  @return 返回的消息内容
 */
- (NSString *)content;

/**
 *  富文本文件的ID
 *
 *  @return 返回的文件ID，当为文本类或者参数错误时，返回nil
 */
- (NSString *)fileId;

/**
 *  富文本文件名
 *
 *  @return 返回的文件名，当为文本类或者参数错误时，返回nil
 */
- (NSString *)fileName;

/**
 *  富文本消息内容类内的文件路径属性
 *
 *  @return 文件路径,当为文本类或者参数错误时，返回nil
 */
- (NSString *)filePath;

/**
 *  富文本消息内容类内的图片数据
 *
 *  @return 富文本的多媒体数据
 */
- (NSData *)fileData;

/**
 *  富文本消息的文件缩略图路径
 *
 *  @return 缩略图路径,当为文本类或者参数错误时，返回nil
 */
- (NSString *)fileThumbPath;

/**
 *  富文本消息的下载路径
 *
 *  @return 文件下载路径,当为文本类或者参数错误时，返回nil
 */
- (NSString *)fileDownloadUrl;

/**
 *  富文本文件的大小
 *
 *  @return 富文本文件大小，当为文本类或者参数错误时，返回0
 */
- (long)fileSize;

/**
 *  文件宽度
 *
 *  @return 富文本文件宽度，当为文本类或者参数错误时，返回0
 */
- (long)fileWidth;

/**
 *  文件高度
 *
 *  @return 富文本文件高度，当为文本类或者参数错误时，返回0
 */
- (long)fileHeight;

/**
 *  音视频文件的播放时间
 *
 *  @return 返回音视频文件的播放时间，当为文本类或者参数错误时，返回0
 */
- (long)duration;

/**
 *  音视频文件的比特率
 *
 *  @return 返回音视频文件的比特率，当为文本类或者参数错误时，返回0
 */
- (long)bitrate;

/**
 *  设置消息的内容类型
 *
 *  @param contentType 消息的内容类型参数
 */
- (void)setContentType:(NSString *)contentType;

/**
 *  设置消息的文本内容
 *
 *  @param content 消息文本内容参数
 */
- (void)setContent:(NSString *)content;

/**
 *  设置文件ID
 *
 *  @param fileId 文件ID参数
 */
- (void)setFileId:(NSString *)fileId;

/**
 *  设置文件名
 *
 *  @param fileName 文件名参数
 */
- (void)setFileName:(NSString *)fileName;

/**
 *  设置文件路径
 *
 *  @param filePath 文件路径参数
 */
- (void)setFilePath:(NSString *)filePath;
/**
 *  设置文件数据
 *
 *  @param fileData 文件数据
 */
- (void)setFileData:(NSData *)fileData;

/**
 *  文件缩略图路径
 *
 *  @param fileThumbPath 文件缩略图路径参数
 */
- (void)setFileThumbPath:(NSString *)fileThumbPath;

/**
 *  文件下载地址
 *
 *  @param fileDownloadUrl 文件下载地址参数
 */
- (void)setFileDownloadUrl:(NSString *)fileDownloadUrl;

/**
 *  文件大小
 *
 *  @param fileSize 文件大小参数
 */
- (void)setFileSize:(long)fileSize;

/**
 *  文件宽度
 *
 *  @param fileWidth 文件宽度参数
 */
- (void)setFileWidth:(long)fileWidth;

/**
 *  文件高度
 *
 *  @param fileHeight 文件高度参数
 */
- (void)setFileHeight:(long)fileHeight;

/**
 *  音视频文件的比特率
 *
 *  @param bitrate 音视频文件的比特率参数
 */
- (void)setBitrate:(long)bitrate;

/**
 *  音视频文件的时长
 *
 *  @param duration 音视频文件的时长
 */
- (void)setDuration:(long)duration;

@end

/**
 *  文本消息的内容类
 */
@interface FNTextMsgContent : FNMsgContent

// 消息内容的类型
@property (nonatomic) NSString *contentType;

// 文本消息内容字符串
@property (nonatomic) NSString *content;

/**
 *  将该类转化为字符串
 *
 *  @return 返回的字符串
 */
- (NSString *)toJString;

/**
 *  从字符串中解析处该类
 *
 *  @param str 待处理的字符串
 *
 *  @return 返回的实例对象
 */
+ (instancetype)toObjectFromStr:(NSString *)str;

@end

/**
 *  图片消息的内容类
 */
@interface FNImageMsgContent : FNTextMsgContent

// 文件的ID
@property (nonatomic) NSString *fileId;

// 文件名
@property (nonatomic) NSString *fileName;

// 文件的本地路径
@property (nonatomic) NSString *filePath;

//文件的数据
@property (nonatomic) NSData *fileData;

// 文件的缩略图路径
@property (nonatomic) NSString *fileThumbPath;

// 文件的下载地址
@property (nonatomic) NSString *fileDownloadUrl;

// 文件大小
@property (nonatomic) long fileSize;

// 文件宽度
@property (nonatomic) long fileWidth;

// 文件高度
@property (nonatomic) long fileHeight;

/**
 *  将该类转化为字符串
 *
 *  @return 返回的字符串
 */
- (NSString *)toJString;

/**
 *  从字符串中解析处该类
 *
 *  @param str 待处理的字符串
 *
 *  @return 返回的实例对象
 */
+ (instancetype)toObjectFromStr:(NSString *)str;

@end

/**
 *  视频消息的内容类
 */
@interface FNVideoMsgContent : FNImageMsgContent

// 文件的比特率
@property (nonatomic) long bitrate;

// 文件的时长
@property (nonatomic) long duration;

/**
 *  将该类转化为字符串
 *
 *  @return 返回的字符串
 */
- (NSString *)toJString;

/**
 *  从字符串中解析处该类
 *
 *  @param str 待处理的字符串
 *
 *  @return 返回的实例对象
 */
+ (instancetype)toObjectFromStr:(NSString *)str;

@end

/**
 *  音频消息的内容类
 */
@interface FNAudioMsgContent : FNVideoMsgContent

/**
 *  将该类转化为字符串
 *
 *  @return 返回的字符串
 */
- (NSString *)toJString;

/**
 *  从字符串中解析处该类
 *
 *  @param str 待处理的字符串
 *
 *  @return 返回的实例对象
 */
+ (instancetype)toObjectFromStr:(NSString *)str;

@end

/**
 *  文件消息的内容类
 */
@interface FNFileMsgContent : FNImageMsgContent

/**
 *  将该类转化为字符串
 *
 *  @return 返回的字符串
 */
- (NSString *)toJString;

/**
 *  从字符串中解析处该类
 *
 *  @param str 待处理的字符串
 *
 *  @return 返回的实例对象
 */
+ (instancetype)toObjectFromStr:(NSString *)str;

@end
