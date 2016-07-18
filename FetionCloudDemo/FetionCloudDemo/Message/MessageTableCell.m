//
//  FZConversationOddCell.m
//  FANSZ
//
//  Created by yiqingping on 16/1/24.
//  Copyright © 2016年 FANSZ. All rights reserved.
//

#import "MessageTableCell.h"
#import "UIView+ZLExtension.h"
#import "NSString+Extension.h"
#import "NSDate+Extension.h"
#import "FNGroupLogic.h"
#import "Utility.h"
#import "ContactDataTable.h"

@interface MessageTableCell ()


@property (nonatomic, weak) UIImageView *avatarImageView;//头像

@property(nonatomic,weak) UILabel * nameLab;//姓名(群名)

@property(nonatomic,weak) UILabel * timeLab;//时间

@property(nonatomic,weak) UILabel * messLab;//具体信息

@property (nonatomic,weak) UILabel *unReadLab; // 未读消息数


@end

@implementation MessageTableCell
+ (instancetype)messageListCellWithTableView:(UITableView *)tableView
{
    NSString *reuserId =@"messageList";
    MessageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserId];
    }
    return cell;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加头像
        UIImageView *avatarImageView =[[UIImageView alloc]init];
        [self.contentView addSubview:avatarImageView];
        self.avatarImageView = avatarImageView;
        
        //添加昵称label
        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        nameLab.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:nameLab];
        self.nameLab = nameLab;
        
        // 添加时间
        UILabel *timeLab = [[UILabel alloc]init];
        timeLab.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1.0];
        timeLab.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:timeLab];
        self.timeLab = timeLab;
        
        //添加消息内容label
        UILabel *messLab = [[UILabel alloc]init];
        messLab.textColor = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
        messLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:messLab];
        self.messLab = messLab;
        
        //添加 未读条数label
        UILabel *unReadLab = [[UILabel alloc]init];
        unReadLab.textColor =[UIColor whiteColor];
        unReadLab.backgroundColor = [UIColor redColor];
        unReadLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:unReadLab];
        unReadLab.textAlignment = NSTextAlignmentCenter;
        self.unReadLab = unReadLab;
    }
    return self;
}

-(void)setDataModel:(MessageTableModel *)dataModel
{
    _dataModel = dataModel;
    
    self.avatarImageView.frame = CGRectMake(kMarginX, (kCellHeight - kImageWidth) * 0.5, kImageWidth, kImageWidth);// 头像
    
    NSString *content = nil;
    if(dataModel.eventType ==1)
    {
        NSString *tid = [NSString stringWithFormat:@"%@@%@",dataModel.tid,APP_KEY];
        ContactDataTable *ta = [ContactDataTable getWithUserId:tid];
        if(ta.portrait == nil)
        {
            self.imageView.image = [FNImage imageWithName:@"head_portrait_2"];
        }
        else
        {
            self.imageView.image = [FNImage imageWithName:ta.portrait];

        }
        content = dataModel.content;
      
    }
    if(dataModel.eventType == 2)
    {
     
        self.imageView.image = [UIImage imageNamed:@"group_head_portrait"];
        content = dataModel.content;
    }
    CGSize sizeContent = [content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];// 消息内容
    
    NSString *nameStr = dataModel.sendNickName;
    CGSize sizeName = [nameStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];// 昵称

    NSString *timeStr = dataModel.lastActiveDate;
    CGSize sizeTime = [timeStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];// 时间
    
    CGFloat nameLX = CGRectGetMaxX(self.avatarImageView.frame) + kMarginX2; //昵称位置
    CGFloat nameW = sizeName.width > (kScreen_width - kImageWidth -kMarginX *4 - sizeTime.width) ? (kScreen_width - kImageWidth -kMarginX *4 - sizeTime.width): sizeName.width;
    self.nameLab.frame = CGRectMake(nameLX, kMarginY, nameW,sizeName.height);
    
    self.timeLab.frame =CGRectMake(kScreen_width - kMarginX- sizeTime.width, kMarginY3, sizeTime.width, sizeTime.height);     // 时间位置
    
    CGFloat contentW ;
    
    if(dataModel.unreadCount > 0)
    {
        self.unReadLab.layer.cornerRadius = kUnreadW * 0.5;
        self.unReadLab.layer.masksToBounds = YES;
        self.unReadLab.frame = CGRectMake(kScreen_width - kMarginX- kUnreadW,kCellHeight- kMarginY4 -kUnreadW , kUnreadW, kUnreadW);
        self.unReadLab.hidden = NO;
        contentW = sizeContent.width > (kScreen_width - kImageWidth -kMarginX *2 - kMarginX2 *2-kUnreadW) ? (kScreen_width - kImageWidth -kMarginX *2 - kMarginX2 *2-kUnreadW): sizeContent.width;
        if(dataModel.unreadCount >99)
        {
            self.unReadLab.text = [NSString stringWithFormat:@"..."];
            
        }else
        {
            self.unReadLab.text = [NSString stringWithFormat:@"%zd",dataModel.unreadCount];

        }
        
    }else{
        self.unReadLab.hidden = YES;
        contentW = sizeContent.width > (kScreen_width - kImageWidth -kMarginX *2 - kMarginX2) ? (kScreen_width - kImageWidth -kMarginX *2 - kMarginX2): sizeContent.width;
        
    }    // 未读条数的位置
    
    CGFloat messsgeY = kCellHeight - kMarginY4 - sizeContent.height;
   
    self.messLab.frame = CGRectMake(nameLX, messsgeY, contentW, sizeContent.height); //消息内容位置
    self.messLab.text = content;
    self.timeLab.text = timeStr;
    self.nameLab.text = dataModel.sendNickName;
}

- (NSDate *)dateWithString:(NSString*)dateStr
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createDate = [formatter dateFromString:dateStr];//创建时间
    return createDate;
}


//获得日期中的时间
- (NSString *)dateHourMinute:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    if ([NSDate isThisYearWithDate:date])
    {
        if ([NSDate isTodayWithDate:date]) {
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
            NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            comps = [calendar components:unitFlags fromDate:date];
            
            NSInteger hour =[comps hour];
            if(hour < 12)
            {
                formatter.dateFormat = @"上午hh:mm";
                return [formatter stringFromDate:date];
            }else
            {
                formatter.dateFormat = @"下午hh:mm";
                return [formatter stringFromDate:date];
            }
            
        }else{
            formatter.dateFormat = @"MM月dd日";
            return [formatter stringFromDate:date];
        }
    }else{
        
        formatter.dateFormat = @"yyyy年MM月dd日";
        return [formatter stringFromDate:date];
    }
}



@end
