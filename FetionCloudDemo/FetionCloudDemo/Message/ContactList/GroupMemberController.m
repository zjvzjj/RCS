//
//  GroupMemberController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/18.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "GroupMemberController.h"
#import "KxMenu.h"
#import "DeleteGroupMemController.h"
#import "UIView+Toast.h"
#import "FNGroupMembersTable.h"
#import "FNGroupLogic.h"
#import "FNUserConfig.h"
#import "FNContactTable.h"
#import "ConversationController.h"

NSString *DeleteGroupMsg = nil;

@interface GroupMemberController ()

@property (nonatomic, strong) NSMutableArray *memberList;
@property (nonatomic, strong) NSArray *sortMembers;
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation GroupMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.isAdd = YES;
    
//    NSArray *arr = [FNGroupMembersTable getGroupMemberByNickName:@"1" number:4 page:2];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.memberList = [FNGroupMembersTable get:self.groupID];
    [self sortDataSource:self.memberList];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.deleteButton removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sortDataSource:(NSMutableArray *)members
{
    NSMutableArray *sortArray = [NSMutableArray array];
    for (int i = 0; i < members.count; i++) {
        FNGroupMembersTable *info = [self.memberList objectAtIndex:i];
        if (0 == info.identity)
        {
            [sortArray addObject:info];
            [self.memberList removeObjectAtIndex:i];
        }
    }
    
    for (int i = 0; i < self.memberList.count; i++) {
        FNGroupMembersTable *info = [self.memberList objectAtIndex:i];
        [sortArray addObject:info];
    }
    self.sortMembers = nil;
    self.sortMembers = [NSArray arrayWithArray:sortArray];
    [self.tableView reloadData];
}

- (void)moreAction
{
    if (self.isAdd)
    {
        NSArray *menuItems =
        @[
          [KxMenuItem menuItem:@"邀请新成员"
                         image:nil
                        target:self
                        action:@selector(pushAddContact)],
          [KxMenuItem menuItem:@"删除群成员"
                         image:nil
                        target:self
                        action:@selector(deleteGroupMembers)],
          ];
        
        KxMenuItem *first = menuItems[0];
        first.alignment = NSTextAlignmentCenter;
        
        CGRect frame = CGRectMake(self.view.frame.size.width - 50, 14, 40, 40);
        [KxMenu showMenuInView:self.navigationController.view fromRect:frame menuItems:menuItems];
    }
    else
    {
        [self tableViewOnEditing:NO];
    }
    
}

- (void)pushAddContact
{
    self.isAdd = YES;
    [self performSegueWithIdentifier:@"deleteGroupMember" sender:nil];
}

- (void)deleteGroupMembers
{
    self.isAdd = NO;
    [self tableViewOnEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sortMembers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupMemberCell" forIndexPath:indexPath];
    FNGroupMembersTable *info = [self.sortMembers objectAtIndex:indexPath.row];
    NSString *memberName = nil;
    if (info.memberNickName)
    {
        memberName = info.memberNickName;
    }
    else
    {
        memberName = info.memberID;
    }
    cell.textLabel.text = memberName;

    if (info.identity == 0)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (管理员)",memberName];
        cell.textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        cell.userInteractionEnabled = NO;
    }
    
    if (indexPath.row%3==0)
    {
        [cell.imageView setImage:[FNImage imageWithName:@"head_portrait_0"]];
    }
    else if (indexPath.row%3==1)
    {
        [cell.imageView setImage:[FNImage imageWithName:@"head_portrait_1"]];
    }
    else if (indexPath.row%3==2)
    {
        [cell.imageView setImage:[FNImage imageWithName:@"head_portrait_2"]];
    }

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.deleteButton setTitleColor:RGBA(42, 132, 255, 1.0) forState:UIControlStateNormal];
    self.deleteButton.userInteractionEnabled = YES;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    if (array.count == 0)
    {
        [self.deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.deleteButton.userInteractionEnabled = NO;
    }
}

- (void)tableViewOnEditing:(BOOL)isEdit
{
    if (isEdit)
    {
        if (1 == self.groupType)
        {
            self.title = @"选择群成员";
        }
        else
        {
            self.title = @"选择讨论组成员";
        }
        self.navigationItem.rightBarButtonItem.title = @"取消";
        [self.tableView setEditing:YES animated:YES];
        [[UIApplication sharedApplication].keyWindow addSubview:self.deleteButton];
    }
    else
    {
        if (1 == self.groupType)
        {
            self.title = @"群成员";
        }
        else
        {
            self.title = @"讨论组成员";
        }
        self.navigationItem.rightBarButtonItem.title = @"更多";
        [self.tableView setEditing:NO animated:YES];
        self.isAdd = YES;
        [self.deleteButton removeFromSuperview];
    }
}

- (void)deleteMembers
{
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    NSMutableArray *userIdList = [NSMutableArray array];
    NSMutableString *msg = [NSMutableString stringWithString:@"删除"];
    for (int i = 0; i < array.count; i++) {
        NSIndexPath *index = array[i];
        FNGroupMembersTable *info = [self.sortMembers objectAtIndex:index.row];
        NSString *kickID = info.memberID ;
        [userIdList addObject:kickID];
        [msg appendFormat:@"'联系人%@'",info.memberNickName];
    }
    FNBatchKickOutGroupRequest *request = [[FNBatchKickOutGroupRequest alloc] init];
    request.groupID = self.groupID;
    request.kickedUserIDList = [NSArray arrayWithArray:userIdList];
    [FNGroupLogic batchKickOutGroup:request callback:^(FNBatchKickOutGroupResponse *rspArgs) {
        int32_t rc = rspArgs.statusCode;
        NSLog(@"kick out return code:%d", rc);
        if (200 == rc)
        {
            [self tableViewOnEditing:NO];
            [self.view makeToast:@"删除成功"];
            self.memberList = [FNGroupMembersTable get:self.groupID];
            [self sortDataSource:self.memberList];
            
            
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[ConversationController class]])
                {
                    DeleteGroupMsg = msg;
                    
                    [self.navigationController popToViewController:vc animated:YES];
                    
                    break;
                }
            }

        }
        else
        {
            NSLog(@"kick out target failed!");
        }
    }];
}

- (void)setGroupMemberInfo:(NSIndexPath *)index
{
    FNGroupMembersTable *info = [self.sortMembers objectAtIndex:index.row];
    FNSetGroupMemberInfoRequest *request = [[FNSetGroupMemberInfoRequest alloc] init];
    request.groupId = self.groupID;
    request.userId = info.memberID;
    request.memberName = info.memberNickName;//@"oldName";
    request.memberPortraitUrl = @"layayiyatest";
    request.updateFieldFlags = 2;
    [FNGroupLogic setGroupMemberInfo:request callback:^(FNSetGroupMemberInfoResponse *rspArgs) {
        int32_t rc = rspArgs.statusCode;
        NSLog(@"setGroupMemberInfo return code:%d", rc);
        if (200 == rc)
        {
            self.memberList = [FNGroupMembersTable get:self.groupID];
            [self sortDataSource:self.memberList];
        }
        else
        {
            NSLog(@"setGroupMemberName failed!");
        }
    }];
}

- (void)setIsOwner:(BOOL)isOwner
{
    if (_isOwner != isOwner)
    {
        _isOwner = isOwner;
    }
    if (isOwner)
    {
        UIBarButtonItem *morebutton = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
        self.navigationItem.rightBarButtonItem = morebutton;
    }
    else
    {
        if (2 == self.groupType)
        {

        }
    }
}

- (UIButton *)deleteButton
{
    if (!_deleteButton)
    {
        self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 56, SCREEN_WIDTH, 56)];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(deleteMembers) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton.backgroundColor = RGBA(248, 248, 248, 1.0);
        self.deleteButton.userInteractionEnabled = NO;
    }
    return _deleteButton;
}

- (void)setGroupType:(int)groupType
{
    if (_groupType != groupType)
    {
        _groupType = groupType;
        if (1 == groupType)
        {
            self.title = @"群成员";
        }
        else
        {
            self.title = @"讨论组成员";
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DeleteGroupMemController *destVC = segue.destinationViewController;
    destVC.groupId = self.groupID;
    destVC.personArray = self.sortMembers;
    destVC.isAdd = self.isAdd;
    destVC.isDetail = YES;
}

@end
