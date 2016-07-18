//
//  ContactListController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "ABViewController.h"
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
#import "FNGroupLogic.h"
#import "ContactDataTable.h"
#import "FNGroupTable.h"
#import "CurrentUserTable.h"
#import "ABChatContactCell.h"

NSString *ABGroupAddMsg = nil;

@interface ABViewController ()
{
    NSMutableArray *_tokenizers;
    
    NSMutableSet *_selectedSet;
}
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation ABViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(finish)];
    [self.navigationItem setRightBarButtonItem:right];
    
    _tokenizers = [[NSMutableArray alloc] init];
    
    _selectedSet = [[NSMutableSet alloc] init];
    
    FNGetGroupMemberListRequest *request = [[FNGetGroupMemberListRequest alloc] init];
    
    request.groupID = self.groupId;
    
    [FNGroupLogic getGroupMemberList:request callback:^(FNGetGroupMemberListResponse *rspArgs)
     {
         int responseCode = rspArgs.statusCode;
         
         if ( 200 == responseCode )
         {
             for (FNGroupMemberInfo *info in rspArgs.memberArray)
             {
                 if ([info.userID isEqualToString:[[CurrentUserTable getLastUser] userId]] && info.identity == 0)
                 {
//                     UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(finish)];
//                     [self.navigationItem setRightBarButtonItem:right];
                     [self readData];
                     
                     break;
                 }
             }
         }
     }];
    
    ABGroupAddMsg = nil;
    
    [self.tableView registerClass:[ABChatContactCell class] forCellReuseIdentifier:@"ABChatContactCell"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.tableView.allowsMultipleSelection = YES;

}

- (void)finish
{
    
    if (self.isDisGroup)
    {
        if (![_selectedSet count])
        {
            return;
        }
        
        __weak __typeof(self) weakSelf = self;
        
        NSMutableString *name = [NSMutableString string];
        
        for (ContactDataTable *user in [_selectedSet allObjects])
        {
            [name appendFormat:@"%@、",user.nickName];
        }
        
        if (name.length>1)
        {
            [name deleteCharactersInRange:NSMakeRange(name.length-1, 1)];
        }
        
        if (!self.isNewGroup)
        {
            FNInviteJoinGroupRequest *request = [[FNInviteJoinGroupRequest alloc] init];
            
            request.groupInfoArray = [NSMutableArray array];
            
            NSMutableString *text = [NSMutableString stringWithString:@"我邀请了"];
            
            NSMutableString *groupName = [NSMutableString string];
            
            for (ContactDataTable *user in _selectedSet)
            {
                FNInviteJoinGroupInfo *gpInfo = [[FNInviteJoinGroupInfo alloc] init];
                
                gpInfo.groupID = _groupId;
                
                gpInfo.userNickname = name;
                
                gpInfo.invitedUserID = user.userId;
                
                [request.groupInfoArray addObject:gpInfo];
                
                [groupName appendFormat:@"\"联系人%@\"、",user.nickName];
            }
            
            if (request.groupInfoArray.count == 0)
            {
                return;
            }
            
            if (groupName.length>1)
            {
                [groupName deleteCharactersInRange:NSMakeRange(groupName.length-1, 1)];
            }
            
            [text appendString:groupName];
            
            if (self.isDisGroup)
            {
                [text appendString:@"加入了讨论组"];
            }
            else
            {
                [text appendString:@"加入了群组"];
            }
            
            __weak __typeof(self) weakSelf = self;
            
            [FNGroupLogic inviteJoinGroup:request callback:^(FNInviteJoinGroupResponse *rspArgs) {
                
                __strong __typeof(weakSelf) strong = weakSelf;
                
                int32_t rc = rspArgs.statusCode;
                
                if (200 == rc)
                {
                    for (UIViewController *vc in self.navigationController.viewControllers)
                    {
                        if ([vc isKindOfClass:[ConversationController class]])
                        {
                            ABGroupAddMsg = text;
                            
                            [self.navigationController popToViewController:vc animated:YES];
                            
                            break;
                        }
                    }
                }
                else if (404 == rc)
                {
                    [[[UIAlertView alloc] initWithTitle:@"FANSZ" message:@"群不存在" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
                }
                else if (500 == rc)
                {
                    [[[UIAlertView alloc] initWithTitle:@"FANSZ" message:@"服务器内部错误" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
                }
                else
                {
                    [[[UIAlertView alloc] initWithTitle:@"FANSZ" message:@"邀请失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
                }
            }];
            
            return;
        }
        
        FNCreateGroupRequest *request = [[FNCreateGroupRequest alloc] init];
        
        request.groupName = name;
        
        request.groupType = 2;
        
        request.nickname = [[CurrentUserTable getLastUser] nickName];
        
        [FNGroupLogic createGroup:request callback:^(FNCreateGroupResponse *rspArgs){
            
            __strong __typeof(weakSelf) strong = weakSelf;
            
            int32_t rc = rspArgs.statusCode;
            
            _groupId = rspArgs.groupID;
            
            if (200 == rc)
            {
                
                FNInviteJoinGroupRequest *request = [[FNInviteJoinGroupRequest alloc] init];
                
                request.groupInfoArray = [NSMutableArray array];
                
                NSMutableString *text = [NSMutableString stringWithString:@"我邀请了"];
                
                NSMutableString *groupName = [NSMutableString string];
                
                for (ContactDataTable *user in _selectedSet)
                {
                    FNInviteJoinGroupInfo *gpInfo = [[FNInviteJoinGroupInfo alloc] init];
                    
                    gpInfo.groupID = _groupId;
                    
                    gpInfo.userNickname = name;
                    
                    gpInfo.invitedUserID = user.userId;
                    
                    [request.groupInfoArray addObject:gpInfo];
                    
                    [groupName appendFormat:@"\"联系人%@\"、",user.nickName];
                }
                
                if (request.groupInfoArray.count == 0)
                {
                    return;
                }
                
                if (groupName.length>1)
                {
                    [groupName deleteCharactersInRange:NSMakeRange(groupName.length-1, 1)];
                }
                
                [text appendString:groupName];
                
                if (self.isDisGroup)
                {
                    [text appendString:@"加入了讨论组"];
                }
                else
                {
                    [text appendString:@"加入了群组"];
                }
                
                __weak __typeof(self) weakSelf = self;
                
                [FNGroupLogic inviteJoinGroup:request callback:^(FNInviteJoinGroupResponse *rspArgs) {
                    
                    __strong __typeof(weakSelf) strong = weakSelf;
                    
                    int32_t rc = rspArgs.statusCode;
                    
                    if (200 == rc)
                    {
                        [strong performSegueWithIdentifier:@"conversation" sender:nil];
                    }
                    else if (404 == rc)
                    {
                        [[[UIAlertView alloc] initWithTitle:@"FANSZ" message:@"群不存在" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
                    }
                    else if (500 == rc)
                    {
                        [[[UIAlertView alloc] initWithTitle:@"FANSZ" message:@"服务器内部错误" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
                    }
                    else
                    {
                        [[[UIAlertView alloc] initWithTitle:@"FANSZ" message:@"邀请失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
                    }
                }];
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"FANSZ" message:@"创建失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            }
        }];
    }
    else
    {
        
        NSMutableArray *array = [NSMutableArray array];

        NSMutableString *groupName = [NSMutableString string];

        for (ContactDataTable *table in _selectedSet)
        {
            FNInviteJoinGroupInfo *info = [[FNInviteJoinGroupInfo alloc] init];
            
            info.groupID = self.groupId;
            
            info.invitedUserID = table.userId;
            
            info.userNickname = table.nickName;
            
            info.userPortraitUrl = table.portrait;
            
            [array addObject:info];
            
            [groupName appendFormat:@"\"联系人%@\"、",table.nickName];
        }
        if (array.count == 0)
        {
            return;
        }
        FNInviteJoinGroupRequest *join = [[FNInviteJoinGroupRequest alloc] init];
        
        join.groupInfoArray = array;
        
        [FNGroupLogic inviteJoinGroup:join callback:^(FNInviteJoinGroupResponse *rspArgs) {
            
            if (rspArgs.statusCode == 200)
            {
                [[[UIAlertView alloc] initWithTitle:@"" message:@"添加成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
                if (_isNewGroup)
                {
                        ABGroupAddMsg = [NSString stringWithFormat:@"我邀请了'%@'加入群组",groupName];

                    [self performSegueWithIdentifier:@"conversation" sender:nil];
                }
                else
                {
                    for (UIViewController *vc in self.navigationController.viewControllers)
                    {
                        if ([vc isKindOfClass:[ConversationController class]])
                        {
                            ABGroupAddMsg = [NSString stringWithFormat:@"我邀请了'%@'加入群组",groupName];
                            
                            [self.navigationController popToViewController:vc animated:YES];
                            
                            break;
                        }
                    }
                }
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"" message:@"添加失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            }
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self readData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)readData
{
    NSMutableArray *personArray = [NSMutableArray arrayWithArray:[ContactDataTable getAll]];
    
    [_tokenizers removeAllObjects];
    
    [_tokenizers addObjectsFromArray:personArray];

}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tokenizers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ABChatContactCell *cell = (ABChatContactCell *)[tableView dequeueReusableCellWithIdentifier:@"ABChatContactCell" forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[ABChatContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ABChatContactCell"];
    }
    
    ContactDataTable *info = _tokenizers[indexPath.row];
    
    if ([info isKindOfClass:[ContactDataTable class]])
    {
        cell.titleLabel.text = [info nickName];
        [cell.iconView setImage:[FNImage imageWithName:@"head_portrait_0"]];
    }
    
    if ([_selectedSet containsObject:info])
    {
        [cell checkTypeCell:YES];
    }
    else
    {
        [cell checkTypeCell:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactDataTable *info = _tokenizers[indexPath.row];

    if (![_selectedSet containsObject:info])
    {
        [_selectedSet addObject:info];
    }
    else
    {
        [_selectedSet removeObject:info];
    }
    
    [tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"conversation"])
    {
        ConversationController *conversationController = segue.destinationViewController;
        conversationController.isCreated = YES;
        
        conversationController.source = @"group";
        NSMutableArray *groups = [FNGroupTable get:_groupId];
        if (groups.count != 0)
        {
            FNGroupTable *group = (FNGroupTable *)groups[0];
            conversationController.toDisplayName = group.groupName;
        }
        conversationController.toUserid = _groupId;
        conversationController.isCreated = YES;
        [FNRecentConversationTable updateUnReadCount:_groupId];
    }
}

- (void)goBack
{
    
}

@end
