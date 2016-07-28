
//
//  MessageController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "MessageController.h"
#import "NSDate+Extension.h"

#import "FNMsgTable.h"
#import "FNGroupMsgTable.h"
#import "FNRecentConversationTable.h"
#import "FNGroupTable.h"
#import "FNContactTable.h"
#import "FNGroupMsgNotify.h"
#import "FNMsgNotify.h"
#import "FNMsgArgs.h"
#import "FNMsgLogic.h"
#import "FNGroupMsgLogic.h"
#import "FNGroupLogic.h"
#import "ConversationController.h"
#import "BOPAFNetworking.h"
#import "ContactDataTable.h"
#import "Utility.h"
#import "MessageTableModel.h"
#import "MessageTableCell.h"
#import "FNUserConfig.h"
#import "CurrentUserTable.h"
#import "FNGroupNotify.h"

#import "FNUserInfo.h"
#import "AppDelegate.h"

@interface MessageController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *messageDataArray;//消息数据源
@property (nonatomic, strong) NSMutableArray *tempArray; //临时变量,存储所有的cell的indexPath

@property(nonatomic,strong) NSMutableArray * msgDataSource;
@end

@implementation MessageController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.tempArray = [NSMutableArray array];

    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self pullMessage];
    //获取群列表（存入db中）
    [self getGroupLists:PGGroup];
    [self getGroupLists:DGGroup];
    [self registerObserver:YES];
  //  [self receiveMessageNTF:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddBuddy:) name:@"addbuddy" object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self receiveMessageNTF:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)notifyGroupListChanged
{
    [self receiveMessageNTF:nil];
}

- (void)pullMessage
{
    FNPullMsgRequest *request = [[FNPullMsgRequest alloc] init];
    [FNMsgLogic getMsg:request callback:^(NSArray *msgList) {
        [self receiveMessageNTF:nil];
    }];
    [FNGroupMsgLogic getMsg:request callback:^(NSArray *msgList) {
        [self receiveMessageNTF:nil];
    }];
}

- (void)getGroupLists:(int32_t)groupType {
    FNGetGroupListRequest *gpListReq = [[FNGetGroupListRequest alloc] init];
    gpListReq.groupType = groupType;
    
    [FNGroupLogic getGroupList:gpListReq callback:^(FNGetGroupListResponse *rspArgs) {
        int32_t rc = rspArgs.statusCode;
        NSLog(@"get group list %d",rc);
    }];
}

- (void)registerObserver:(BOOL)isRegister
{
    
    if (isRegister)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageNTF:) name:NOTIFY_HAS_NEW_MSG object:nil];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recemessage:) name:@"test" object:nil];
        
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageNTF:) name:NOTIFY_HAS_NEW_GROUP_MSG object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifyGroupListChanged)
                                                     name:NOTIFY_GROUP_LIST_CHANGED
                                                   object:nil];

        

    }
    else
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_HAS_NEW_MSG object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_HAS_NEW_GROUP_MSG object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_GROUP_LIST_CHANGED object:nil];

    }
    
}


- (void)AddBuddy:(NSNotification *)notify{
    
    NSLog(@"%@",notify.object);
    
    
    

    [globalRcsApi buddyhandle:R userId:872967 accept:1 reason:@"I'm JACK" callback:^(rcs_state* R, BuddyResult *s) {
        if (s->error_code == 200) {
            
            NSLog(@"============");
            
        }
        else{
            
            NSLog(@"============");
            
        }
    }];

}









- (void)recemessage:(NSNotification *)notify{
    
    
    NSLog(@"hahahah");
    
    
    NSLog(@"notify:%@",notify.object);
    int32_t msgNum = (int32_t)((NSArray *)notify.object).count;
    NSLog(@"recent received msg number:%d", msgNum);
   // [self.messageDataArray addObject:notify];

    
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (FNRecentConversationTable *msgTable in self.messageDataArray)
    {
        CurrentUserTable *userTable = [CurrentUserTable getLastUser];
        NSString *str = [Utility userIdWithoutAppKey:userTable.userId];
//        if([msgTable.targetId isEqualToString:str])
//        {
//            continue;
//        }
        MessageTableModel *model = [[MessageTableModel alloc]init];
        model.eventType = msgTable.eventType;
        NSDate *date = [self dateWithString:msgTable.lastActiveDate];
        NSString *times = [self dateHourMinute:date];
        model.tid = msgTable.targetId;
        //model.tid = @"720309";
        model.lastActiveDate = times;
        NSString *contentDetail = msgTable.content ;
        model.unreadCount = msgTable.unreadMsgCount;
        
        
        if(msgTable.eventType == 1)
        {
            ContactDataTable *contact = [ContactDataTable getWithUserId:[Utility userIdWithAppKey:msgTable.targetId]];
            
            if (contact.nickName)
            {
                model.sendNickName = contact.nickName;
            }else
            {
                model.sendNickName = contact.account;
                
                if(!model.sendNickName)
                {
                    model.sendNickName = [Utility userIdWithoutAppKey:msgTable.targetId];
                }
            }//昵称
            
            model.content = contentDetail;
        }
        if(msgTable.eventType == 2)
        {
            FNGroupTable *groupTable = [[FNGroupTable get:msgTable.targetId] lastObject];
            model.sendNickName = groupTable.groupName;
            
            if(!groupTable.groupName )
            {
                model.sendNickName = msgTable.targetId;
            }
            FNGroupMsgTable *groupMsgTable =[[FNGroupMsgTable getHistoryMsgForGroupId:msgTable.targetId num:1] lastObject];
            NSString *sendId = groupMsgTable.senderId;
            ContactDataTable *contact = [ContactDataTable getWithUserId:[Utility userIdWithAppKey:sendId]];
            if (contact.nickName)
            {
                model.lastNickName = contact.nickName;
            }else
            {
                model.lastNickName = msgTable.senderNickname;
            }
            if ([model.lastNickName isEqualToString:[CurrentUserTable getLastUser].nickName]) {
                model.content = contentDetail;
                
            }else{
                model.content = [NSString stringWithFormat:@"%@:%@",model.lastNickName,contentDetail];
            }
            
        }
        
        [arrM addObject:model];
        
    }
    self.msgDataSource = arrM;
    [self.tableView reloadData];
    
}



// 处理收听到的广播
- (void)receiveMessageNTF:(NSNotification *)notify
{
    NSLog(@"notify:%@",notify.object);
    int32_t msgNum = (int32_t)((NSArray *)notify.object).count;
    NSLog(@"recent received msg number:%d", msgNum);
    self.messageDataArray = [FNRecentConversationTable get];
    
    
//    NSMutableArray *msgarray = [FNUserInfo ShareStaticConst].messageArray;
//    int32_t msgNum1 =(int32_t) msgarray.count;
//    
//    NSArray *fnTables = [FNUserInfo ShareStaticConst].messageArray;
    
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (FNRecentConversationTable *msgTable in self.messageDataArray)
    {
        CurrentUserTable *userTable = [CurrentUserTable getLastUser];
        NSString *str = [Utility userIdWithoutAppKey:userTable.userId];
       if([msgTable.targetId isEqualToString:str])
       {
           continue;
       }
        MessageTableModel *model = [[MessageTableModel alloc]init];
        model.eventType = msgTable.eventType;
        NSDate *date = [self dateWithString:msgTable.lastActiveDate];
        NSString *times = [self dateHourMinute:date];
        model.tid = msgTable.targetId;
        model.lastActiveDate = times;
        NSString *contentDetail = msgTable.content ;
        model.unreadCount = msgTable.unreadMsgCount;
    
        
        if(msgTable.eventType == 1)
        {
           ContactDataTable *contact = [ContactDataTable getWithUserId:[Utility userIdWithAppKey:msgTable.targetId]];

            if (contact.nickName)
            {
                model.sendNickName = contact.nickName;
            }else
            {
                model.sendNickName = contact.account;
                
                if(!model.sendNickName)
                {
                    model.sendNickName = [Utility userIdWithoutAppKey:msgTable.targetName];
                }
            }//昵称
            
            model.content = contentDetail;
        }
        if(msgTable.eventType == 2)
        {
            FNGroupTable *groupTable = [[FNGroupTable get:msgTable.targetId] lastObject];
            model.sendNickName = groupTable.groupName;
            
            if(!groupTable.groupName )
            {
                model.sendNickName = msgTable.targetId;
            }
           FNGroupMsgTable *groupMsgTable =[[FNGroupMsgTable getHistoryMsgForGroupId:msgTable.targetId num:1] lastObject];
            NSString *sendId = groupMsgTable.senderId;
            ContactDataTable *contact = [ContactDataTable getWithUserId:[Utility userIdWithAppKey:sendId]];
            if (contact.nickName)
            {
                model.lastNickName = contact.nickName;
            }else
            {
                model.lastNickName = msgTable.senderNickname;
            }
            if ([model.lastNickName isEqualToString:[CurrentUserTable getLastUser].nickName]) {
                model.content = contentDetail;

            }else{
                model.content = [NSString stringWithFormat:@"%@:%@",model.lastNickName,contentDetail];
            }
            
        }
        
        [arrM addObject:model];
        
    }
    self.msgDataSource = arrM;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (void)dealloc
{
    [self registerObserver:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableCell *cell =[MessageTableCell messageListCellWithTableView:tableView];
    
    cell.dataModel = self.msgDataSource [indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        FNRecentConversationTable *infos = (FNRecentConversationTable *)[self.messageDataArray objectAtIndex:indexPath.row];
        
        NSString *targetId = infos.targetId;
        NSLog(@"targetId : %@",targetId);
        [FNRecentConversationTable delete:targetId];

//        if (infos.eventType == 1)
//        {
//            [FNMsgTable deleteByUserId:targetId];
//        }
//        else
//        {
//            [FNGroupMsgTable deleteByGroupId:targetId];
//        }
        [self.messageDataArray removeObjectAtIndex:indexPath.row];
        [self.msgDataSource removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
    }
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
            formatter.dateFormat = @"HH:mm";
            return [formatter stringFromDate:date];
            
        }else{
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:date];
        }
    }else{
        
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:date];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"conversation" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *index = (NSIndexPath *)sender;
    MessageTableModel *infos = self.msgDataSource[index.row];
    ConversationController *conversationVC = segue.destinationViewController;
    conversationVC.toDisplayName = infos.sendNickName;
    //conversationVC.toUserid = [Utility userIdWithAppKey:infos.userId];
    conversationVC.toUserid = infos.tid;
    conversationVC.source = @"private";
    
//    if ([segue.identifier isEqualToString:@"conversation"])
//    {
//        NSIndexPath *index = sender;
//        
//        ConversationController *conversationController = segue.destinationViewController;
//        MessageTableModel *messageTableModel = (MessageTableModel *)self.msgDataSource[index.row];
//        
//        if(messageTableModel.eventType == 1)
//        {
//            conversationController.source = @"private";
//            conversationController.toUserid = messageTableModel.tid;
//            ContactDataTable *contact = [ContactDataTable getWithUserId:[Utility userIdWithAppKey: messageTableModel.tid]];
//            if (contact.nickName)
//            {
//                conversationController.toDisplayName = contact.nickName;
//            }
//            else
//            {
//                conversationController.toDisplayName = contact.account;
//                if(! conversationController.toDisplayName)
//                {
//                     conversationController.toDisplayName = [Utility userIdWithoutAppKey:messageTableModel.tid];
//                }
//            }
//            
//        }else if (messageTableModel.eventType == 2)
//        {
//            conversationController.source = @"group";
//            NSMutableArray *groups = [FNGroupTable get:messageTableModel.tid];
//            if (groups.count != 0)
//            {
//                FNGroupTable *group = (FNGroupTable *)groups[0];
//                conversationController.toDisplayName = group.groupName;
//                
//            }
//            if(!conversationController.toDisplayName )
//            {
//                conversationController.toDisplayName = messageTableModel.tid;
//            }
//            conversationController.toUserid = messageTableModel.tid;
//        }
//        [FNRecentConversationTable updateUnReadCount:messageTableModel.tid];
//    }
}



@end
