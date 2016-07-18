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
    
    _buddyListArray = [[NSMutableArray alloc]init];
    
    _buddyPortraitPath = [[NSMutableArray alloc]init];
    
    _buddyIDArray = [[NSMutableArray alloc]init];
    
    _buddyIDArray = [FNUserInfo ShareStaticConst].buddyIDArray;

    
    [self getUserinfo];
    
}

//获取好友概要信息

- (void) getUserinfo{
    
    for (int i=0; i<[_buddyIDArray count]; i++) {
        
        NSNumber *number = [_buddyIDArray objectAtIndex:i];
        
        NSString * ids = [NSString stringWithFormat:@"%@",number];
        
        
        [globalRcsApi usergetinfo:R ids:ids callback:^(rcs_state* R, UserInfoResult *s) {
            if(s->error_code == 200)
            {
                //[self AddLogC:"user get info ok"];
                NSLog(@"ids============%@",ids);
                
                int  j = 0;
                while (1 && s->user_infos) {
                    
                    UserInfo* u = s->user_infos[j++];
                    if (u == NULL) {
                        break;
                    }
                    NSLog(@"username = %s",u->username);
                    NSLog(@"nickname = %s",u->nickname);
                    NSLog(@"user_id = %d",u->user_id);
                    
                    ContactDataTable *infos = [ContactDataTable new];
                    infos.userId = [NSString stringWithFormat:@"%d",u->user_id];
                    infos.nickName = [NSString stringWithUTF8String:u->nickname];
                    
                    
                    //获取用户头像
                    [ globalRcsApi usergetportrait:R userId:[ids intValue] isSmall:YES callback:^(rcs_state* R, UserPortraitResult *s) {
                        if(s->error_code == 200)
                        {
                            
                            NSLog(@"%s",s->file_path);
                            
                            infos.portraitPath = [NSString stringWithFormat:@"%s",s->file_path];

                            [_buddyListArray addObject:infos];
                            
                            
//                            [globalRcsApi msgfetchfile:R number:ids
//                                             messageId:[NSString stringWithFormat:@"%d",s->sid]
//                                              chatType:1
//                                              filePath:infos.portraitPath
//                                           contentType:2
//                                              fileName:@""
//                                            transferId:@""
//                                                 start:0
//                                              fileSize:10
//                                                  hash:@""
//                                                isBurn:NO
//                                              callback:^(rcs_state* R, MessageResult *s) {
//                                                  if (s->error_code == 200) {
//                                                      
//                                                      NSLog(@"succeed");
//                                                      
//                                                  }
//                                                  else
//                                                  {
//                                                      NSLog(@"failed");
//                                                      
//                                                  }
//                                              }];
        
            
                            
                            dispatch_async(dispatch_get_main_queue(),^{
                                
                                [self.tableView reloadData];
                            });
                            
                            NSLog(@"user get portrait ok");
                            
                        }else
                        {
                            
                            infos.portraitPath = @"";
                            
                            [_buddyListArray addObject:infos];
                            
                            dispatch_async(dispatch_get_main_queue(),^{
                                
                                [self.tableView reloadData];
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

//获取用户头像
//- (void) getUserPortrait{
//
//    for (int i=0; i<[_buddyIDArray count]; i++) {
//        
//        NSNumber *number = [_buddyIDArray objectAtIndex:i];
//                
//        [globalRcsApi usergetportrait:R userId:[number intValue] isSmall:YES callback:^(rcs_state* R, UserPortraitResult *s) {
//            if(s->error_code == 200)
//            {
//                
//                NSLog(@"%s",s->file_path);
//                [_buddyPortraitPath addObject:[NSString stringWithFormat:@"%s",s->file_path]];
//                
//                dispatch_async(dispatch_get_main_queue(),^{
//                    
//                    [self.tableView reloadData];
//                });
//                
//                NSLog(@"user get portrait ok");
//                
//            }else
//            {
//                
//                NSLog(@"user get portrait failed");
//                
//            }
//        }];
//    }
//}









- (void)viewWillAppear:(BOOL)animated
{
    
    _buddyIDArray = [FNUserInfo ShareStaticConst].buddyIDArray;
    
    //取消cell的选中状态
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    //[self readData];
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
    
    return [_buddyListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactListCell" forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contactListCell"];
    }
    
    ContactDataTable *infos = _buddyListArray[indexPath.row];
    cell.textLabel.text = infos.nickName;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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

//    if (indexPath.row == 0)
//    {
//        [self performSegueWithIdentifier:@"group" sender:nil];
//    }
//    else if (indexPath.row == 1)
//    {
//        [self performSegueWithIdentifier:@"discussionGroup" sender:nil];
//    }
//    else
//    {
//        [self performSegueWithIdentifier:@"contactConversation" sender:indexPath];
//    }
    
     [self performSegueWithIdentifier:@"contactConversation" sender:indexPath];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1)
    {
        return NO;
    }

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
        [isDelete show];
    }
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        ContactDataTable *info = _tokenizers[self.selectIndexPath.row];
        [ContactDataTable del:info.userId];
        [FNRecentConversationTable delete:info.userId];
        [FNMsgTable deleteByUserId:info.userId];
        
        [self readData];
    }
    else
    {
        [self.tableView setEditing:NO animated:YES];
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
        
//        NSIndexPath *index = (NSIndexPath *)sender;
//        ContactDataTable *infos = _tokenizers[index.row];
//        ConversationController *conversationVC = segue.destinationViewController;
//        conversationVC.toDisplayName = infos.nickName;
//        
//        conversationVC.toUserid = [Utility userIdWithoutAppKey:infos.userId];
//       
//        conversationVC.source = @"private";

        
    }
    
}

@end































