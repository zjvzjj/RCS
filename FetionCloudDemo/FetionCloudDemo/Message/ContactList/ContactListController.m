//
//  ContactListController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "ContactListController.h"
#import "ConversationController.h"

#import "FNSystemConfig.h"
#import "FNUserConfig.h"
#import "FNContactLogic.h"
#import "FNContactTable.h"
#import "FNAccountLogic.h"
#import "FNMsgNotify.h"
#import "FNGroupMsgNotify.h"
#import "FNGroupNotify.h"
#import "FNAccountArgs.h"
#import "NSString+Extension.h"
#import "FNRecentConversationTable.h"
#import "FNMsgTable.h"
#import "Utility.h"

#import "ContactDataTable.h"
#import "AppDelegate.h"
#import "FNUserInfo.h"

#import "ContactDataTable.h"
#import "ContactRequestTable.h"

#import "DBManager.h"
@interface ContactListController ()
{
    NSMutableArray *_tokenizers;
    NSMutableArray *_buddyListArray;
    
}

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation ContactListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    _tokenizers = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addBuddy:)
                                                 name:@"addbuddy"
                                               object:nil];
    
}

//获取好友概要信息

- (void) getUserinfo{
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    
    if (name)
    {
        [DBManager initDBWithUserId:name];
    }
   
    _buddyIDArray = [[NSMutableArray alloc]init];
    
    _buddyListArray = [[NSMutableArray alloc]init];
    
    [self.tableView reloadData];
    
    [DBManager initDBWithUserId:[FNUserInfo ShareStaticConst].localNum];
    
    _buddyIDArray = [NSMutableArray arrayWithArray:[ContactDataTable getAll]];
    
    for (int i=0; i<[_buddyIDArray count]; i++) {
        
        ContactDataTable *user = _buddyIDArray[i];
        
        [globalRcsApi usergetinfo:R ids:user.userId callback:^(rcs_state* R, UserInfoResult *s) {
            if(s->error_code == 200)
            {
                
                int  j = 0;
                while (1 && s->user_infos) {
                    
                    UserInfo* u = s->user_infos[j++];
                    if (u == NULL) {
                        break;
                    }
                    NSLog(@"username = %s",u->username);
                    NSLog(@"nickname = %s",u->nickname);
                    NSLog(@"user_id = %d",u->user_id);
                    
                    ContactDataTable *table = [ContactDataTable getWithUserId:user.userId];
                    table.userId = [NSString stringWithFormat:@"%d",u->user_id];
                    table.nickName = [NSString stringWithUTF8String:u->nickname];
                    table.username = [NSString stringWithUTF8String:u->username];
                    
                    [ContactDataTable update:table];
                    
                    [_buddyListArray addObject:table];
                    
                    dispatch_async(dispatch_get_main_queue(),^{
                        if (_buddyListArray.count > 0) {
                            [self.tableView reloadData];
                        }
                    });
                    
                    //获取用户头像
                    [ globalRcsApi usergetportrait:R userId:[user.userId intValue] isSmall:YES callback:^(rcs_state* R, UserPortraitResult *s) {
                        if(s->error_code == 200)
                        {
                            
                            NSLog(@"%s",s->file_path);
                            table.portrait = [NSString stringWithUTF8String:s->file_path];
                            [ContactDataTable update:table];
                            
                            dispatch_async(dispatch_get_main_queue(),^{
                                if (_buddyListArray.count > 0) {
                                    [self.tableView reloadData];
                                }
                            });
                            
                            NSLog(@"user get portrait ok");
                            
                        }else{
                            
                            table.portrait = @"";
                            [ContactDataTable update:table];
                            
                            dispatch_async(dispatch_get_main_queue(),^{
                                if (_buddyListArray.count > 0) {
                                    [self.tableView reloadData];
                                }
                            });
                            
                            NSLog(@"user get portrait failed");
                            
                        }
                    }];
                    
                }
                
            }else{
                
                NSLog(@"user get info failed");
                
            }
        }];
    }
    
}

//添加好友通知
- (void)addBuddy:(NSNotification *)notify{
    
    NSLog(@"%@",notify.object);
    
    if (!_addBuddyArray) {
        _addBuddyArray = [[NSMutableArray alloc]init];
    }
    
    ContactRequestTable *t = notify.object;
    [_addBuddyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![((ContactRequestTable *)obj).userId isEqualToString:t.userId])  {
            [_addBuddyArray addObject:t];
            [ContactRequestTable insert:t];
        }
    }];
    dispatch_async(dispatch_get_main_queue(),^{
        
        [self.tableView reloadData];
    });

}


- (void)viewWillAppear:(BOOL)animated
{
    
    if (_addBuddyArray.count == 0) {
        _addBuddyArray = [NSMutableArray arrayWithArray:[ContactRequestTable getAll]];
    }
    
    [self getUserinfo];
    
    NSLog(@"%lu",(unsigned long)_buddyIDArray.count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)more:(id)sender
{
    [self pushAddContact];
}

- (void)readData
{
    NSMutableArray *personArray = [NSMutableArray arrayWithArray:[ContactDataTable getAll]];
    
    [_tokenizers removeAllObjects];
    
    [_tokenizers addObjectsFromArray:personArray];
    
    [_tokenizers insertObject:@"群" atIndex:0];
    
    [_tokenizers insertObject:@"讨论组" atIndex:1];
    
    [self.tableView reloadData];
    
}

- (void)pushAddContact
{
    [self performSegueWithIdentifier:@"addContact" sender:nil];
}

- (void)pushDeleteContact
{
    [self performSegueWithIdentifier:@"deleteContact" sender:nil];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return _buddyListArray.count;
            break;
            
        case 1:{
            
            return _addBuddyArray.count;
            break;
        }
            
        default:
            return _buddyListArray.count;
            break;
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (_addBuddyArray.count > 0) {
        
        return 2;
    }
    
    return 1;

}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 15, 300, 30)];
    titleLabel.text = @"#new friends";
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    switch (section) {
        case 0:
            return nil;
            break;
            
        case 1:
            return titleLabel.text;
            break;
            
        default:
            return nil;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactListCell" forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contactListCell"];
    }
    
    
    if (indexPath.section == 0) {
        
        if (_buddyListArray.count > 0) {
            ContactDataTable *infos = _buddyListArray[indexPath.row];
            cell.textLabel.text = infos.nickName;
        }
        
    }else if (indexPath.section == 1){
        
        ContactDataTable *infos = _addBuddyArray[indexPath.row];
        cell.textLabel.text = infos.nickName;
            
    }
    
    
    //NSData *data = [NSData dataWithContentsOfFile:infos.portraitPath];
    //
    
    //    NSString *imagename = [infos.portraitPath lastPathComponent];
    //
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *rootCachePath = [paths firstObject];
    //
    //    NSString *imagePath = [NSString  stringWithFormat:@"%@/%@.jpg",rootCachePath,imagename];
    //
    //    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    //    cell.imageView.image = [UIImage imageWithData:data];
    
    //NSLog(@"%@",infos.portraitPath);
    //    NSString *imgPath = infos.portraitPath;
    //    NSData *data = [NSData dataWithContentsOfFile:imgPath];
    //    cell.imageView.image = [UIImage imageWithData:data];
    
    
    //    NSString *str = [FNUserInfo ShareStaticConst].imgpath;
    //    NSData *data = [NSData dataWithContentsOfFile:str];
    //    cell.imageView.image = [UIImage imageWithData:data];
    
    
    //    NSObject *sec = _tokenizers[indexPath.row];
    //
    //    if ([sec isKindOfClass:[ContactDataTable class]])
    //    {
    //        ContactDataTable *t = (ContactDataTable *)sec;
    //        cell.textLabel.text = [t nickName];
    //
    //cell.imageView.image = [FNImage avatarWithIndex:(indexPath.row-2)];
    //    }
    //    else if ([sec isKindOfClass: [NSString class]])
    //    {
    //        cell.textLabel.text = sec;
    //
    //        cell.imageView.image = [UIImage imageNamed:@"group_head_portrait"];
    //    }
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        [self performSegueWithIdentifier:@"contactConversation" sender:indexPath];
        
    }else if (indexPath.section == 1){
        
        self.selectIndexPath = indexPath;

        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"" message:@"是否添加为好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        alert.tag = 2002;
        
        [alert show];
    
    }
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        self.selectIndexPath = indexPath;
        UIAlertView *isDelete = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"是否删除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        isDelete.tag = 2003;
        [isDelete show];
    }
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 2002) {
        
        ContactDataTable *info = [_addBuddyArray objectAtIndex:self.selectIndexPath.row];
                
        if (buttonIndex == 0) {
            
            [globalRcsApi buddyhandle:R userId:[info.userId intValue] accept:1 reason:@"I'm Jack" callback:^(rcs_state* R, BuddyResult *s) {
                if (s->error_code == 200) {
                    
                    [_buddyListArray addObject:info];
                    [_addBuddyArray removeObject:info];
                    
                    [ContactRequestTable del:info.userId];
                    
                    dispatch_async(dispatch_get_main_queue(),^{
                        
                            [self.tableView reloadData];
                    });
                    
                    NSLog(@"add buddy ok");
                    
                }else{
                    
                    NSLog(@"add buddy failed");
                    
                }
            }];
            
        }else{
            
            NSLog(@"cancel");
        }
        
    }else if (alertView.tag == 2003){
    
    if (buttonIndex == 0)
    {
        
        ContactDataTable *info = [_buddyListArray objectAtIndex:self.selectIndexPath.row];
        //删除好友
        [globalRcsApi buddydel:R userId:[info.userId intValue] callback:^(rcs_state* R, BuddyResult *s) {
            if (s->error_code == 200) {
                
                [_buddyListArray removeObject:info];
                
                [ContactDataTable del:info.userId];
                
                dispatch_async(dispatch_get_main_queue(),^{
                    
                    [self.tableView reloadData];
                });
                
                NSLog(@"delete buddy ok");
                
            }else{
                
                NSLog(@"delete buddy failed");
                
            }
        }];
        
    }else{
        
        [self.tableView setEditing:NO animated:YES];
    }
        
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"contactConversation"]) {
        
        NSIndexPath *index = (NSIndexPath *)sender;
        ContactDataTable *infos = _buddyListArray[index.row];
        ConversationController *conversationVC = segue.destinationViewController;
        conversationVC.toDisplayName = infos.nickName;
        //conversationVC.toUserid = [Utility userIdWithAppKey:infos.userId];
        conversationVC.toUserid = infos.userId;
        conversationVC.source = @"private";
    }
    
}

@end

