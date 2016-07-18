//
//  DeleteGroupMemController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/28.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "DeleteGroupMemController.h"
#import "UIView+Toast.h"

#import "FNGroupMembersTable.h"
#import "FNGroupLogic.h"
#import "FNUserConfig.h"
#import "FNContactTable.h"
#import "ContactDataTable.h"
#import "CurrentUserTable.h"
#import "ABChatContactCell.h"
#import "FNImage.h"
#import "ConversationController.h"
#import "FNGroupTable.h"

NSString *DisGroupAddMsg = nil;

@interface DeleteGroupMemController ()

@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, assign) NSInteger selectCount;

@end

@implementation DeleteGroupMemController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.tableView setEditing:YES animated:YES];
    self.selectCount = 0;
    [self.tableView registerClass:[ABChatContactCell class] forCellReuseIdentifier:@"ABChatContactCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteGroupMember" forIndexPath:indexPath];
    if (self.isAdd || self.isCreate) {
        FNContactTable *member = self.sourceArray[indexPath.row];
        cell.textLabel.text = member.name;
    }
    else
    {
        FNGroupMembersTable *member = self.sourceArray[indexPath.row];
        cell.textLabel.text = member.memberNickName;
    }
    [cell.imageView setImage:[FNImage imageWithName:@"head_portrait_0"]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ++self.selectCount;
    if (self.isCreate) {
        self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"创建(%ld)",(long)self.selectCount];
    }
}

//取消选中的行
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    --self.selectCount;
    if (self.isCreate) {
        self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"创建(%ld)",(long)self.selectCount];
    }
}

- (void)addMembers
{
    FNInviteJoinGroupRequest *request = [[FNInviteJoinGroupRequest alloc] init];
    request.groupInfoArray = [NSMutableArray array];

    if (self.isCreate || self.isAdd)
    {
        CurrentUserTable *contact = [CurrentUserTable getLastUser];
        FNInviteJoinGroupInfo *gpInfo = [[FNInviteJoinGroupInfo alloc] init];
        gpInfo.groupID = self.groupId;
        gpInfo.userNickname = contact.nickName;
        gpInfo.invitedUserID = contact.userId;
        gpInfo.userPortraitUrl = @"hahatest";
        [request.groupInfoArray addObject:gpInfo];
    }
    
    if (request.groupInfoArray.count == 0)
    {
        return;
    }
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    NSMutableString *memberName = [NSMutableString string];
    for (int i = 0; i < array.count; i++) {
        NSIndexPath *index = array[i];
        FNContactTable *contact = self.sourceArray[index.row];
        FNInviteJoinGroupInfo *gpInfo = [[FNInviteJoinGroupInfo alloc] init];
        gpInfo.groupID = self.groupId;
        gpInfo.userNickname = contact.name;
        gpInfo.invitedUserID = contact.mobileNo;
        gpInfo.userPortraitUrl = @"hahatest";
        [memberName appendFormat:@"\"联系人%@\"、",contact.name];
        [request.groupInfoArray addObject:gpInfo];
    }
    [FNGroupLogic inviteJoinGroup:request callback:^(FNInviteJoinGroupResponse *rspArgs) {
        int32_t rc = rspArgs.statusCode;
        NSLog(@"invite join return code:%d", rc);
        if (200 == rc) {
            NSLog(@"invite join success!");
            //bug 没有对群详情进来时候的场景进行判断
            if (self.isCreate)
            {
                DisGroupAddMsg = [NSString stringWithFormat:@"我邀请了'%@'加入群组",memberName];
                ConversationController *conversationController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ConversationController"];
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
                [self.navigationController pushViewController:conversationController animated:YES];
//                [self.navigationController popViewControllerAnimated:YES];
            }
            else if (self.isAdd)
            {
                DisGroupAddMsg = [NSString stringWithFormat:@"'%@'加入群组",memberName];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                if (self.isDetail)
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
                }
            }
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"" message:@"添加失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }];
}

- (void)deleteMembers
{
//    NSMutableArray *array = [NSMutableArray arrayWithArray:self.sourceArray];
    //这个地方bug机率会增加
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    __block int count = 0;
    for (int i = 0; i < array.count; i++) {
        NSIndexPath *index = array[i];
        FNGroupMembersTable *info = [self.sourceArray objectAtIndex:index.row];
        NSString *kickID = info.memberID;
        FNKickOutGroupRequest *request = [[FNKickOutGroupRequest alloc] init];
        request.groupID = self.groupId;
        request.kickedUserID = kickID;
        [FNGroupLogic kickOutGroup:request callback:^(FNKickOutGroupResponse *rspArgs) {
            int32_t rc = rspArgs.statusCode;
            NSLog(@"kick out return code:%d", rc);
            if (200 == rc) {
                count++;
                if (count == array.count) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } else {
                NSLog(@"kick out target failed!");
            }
        }];
    }
//    [self.tableView beginUpdates];
//    [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self.tableView endUpdates];
//    [self.tableView reloadData];
}

- (void)createDisGroup
{
    NSMutableString *groupName = [NSMutableString string];
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    for (int i = 0; i < array.count; i++) {
        if (i == 3) {
            break;
        }
        NSIndexPath *index = array[i];
        FNContactTable *contact = self.sourceArray[index.row];
        [groupName appendFormat:@"%@、",contact.name];
    }
    
    if ([groupName isEqualToString:@""])
    {
        [self.view makeToast:@"没有选中联系人"];
        return;
    }
    FNCreateGroupRequest *requet = [[FNCreateGroupRequest alloc] init];
    requet.groupName = groupName;
    requet.groupType = 2;
    requet.nickname = [CurrentUserTable getLastUser].nickName;
    [FNGroupLogic createGroup:requet callback:^(FNCreateGroupResponse *rspArgs){
        int32_t rc = rspArgs.statusCode;
        NSLog(@"create group return code:%d", rc);
        if (200 == rc)
        {
             [self.view makeToast:@"创建成功"];
//            self.isCreate = YES;
            self.groupId = rspArgs.groupID;
            [self addMembers];
        }
        else
        {
            [self.view makeToast:@"创建失败,请重试!"];
        }
    }];
}

- (void)setIsAdd:(BOOL)isAdd
{
    if (_isAdd != isAdd) {
        _isAdd = isAdd;
    }
    if (isAdd)
    {
        self.title = @"选择联系人";
        UIBarButtonItem *morebutton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addMembers)];
        self.navigationItem.rightBarButtonItem = morebutton;
        NSArray *array = [ContactDataTable getAll];
        self.sourceArray = [NSMutableArray array];
        [self.sourceArray removeAllObjects];
        for (ContactDataTable *contact in array)
        {
            FNContactTable *address = [[FNContactTable alloc] init];
            address.name = contact.nickName;
            address.userID = contact.userId;
            address.mobileNo = contact.userId;
            [self.sourceArray addObject:address];
        }
        [self.tableView reloadData];
    }
    else
    {
        self.title = @"删除成员";
        UIBarButtonItem *morebutton = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteMembers)];
        self.navigationItem.rightBarButtonItem = morebutton;
        self.sourceArray = [NSMutableArray arrayWithArray:self.personArray];
        [self.tableView reloadData];
    }
}

- (void)setIsCreate:(BOOL)isCreate
{
    if (_isCreate != isCreate)
    {
        _isCreate = isCreate;
    }
    if (isCreate) {
        self.title = @"选择联系人";
        UIBarButtonItem *morebutton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(createDisGroup)];
        self.navigationItem.rightBarButtonItem = morebutton;
        NSArray *array = [ContactDataTable getAll];
        self.sourceArray = [NSMutableArray array];
        [self.sourceArray removeAllObjects];
        for (ContactDataTable *contact in array)
        {
            FNContactTable *address = [[FNContactTable alloc] init];
            address.name = contact.nickName;
            address.userID = contact.userId;
            address.mobileNo = contact.userId;
            [self.sourceArray addObject:address];
        }
        [self.tableView reloadData];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
