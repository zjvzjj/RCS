//
//  GroupDetailController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/18.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "GroupDetailController.h"
#import "GroupMemberController.h"
#import "DeleteGroupMemController.h"
#import "UIView+Toast.h"

#import "FNGroupMembersTable.h"
#import "FNGroupLogic.h"
#import "FNUserConfig.h"
#import "FNGroupTable.h"
#import "FNRecentConversationTable.h"
#import "NSString+Extension.h"
#import "FNGroupMsgTable.h"
#import "ABViewController.h"

@interface GroupDetailController ()<UITextFieldDelegate>

@property (nonatomic, assign) int groupType;//群类型
@property (nonatomic, assign) BOOL isOwner;//是否群主
@property (nonatomic, copy) NSString *groupName;//群名字
@property (nonatomic, strong) NSMutableArray *groupMembers;//群成员数组
@property (nonatomic, strong) NSArray *sortMembers;//排序数组

@property (weak, nonatomic) IBOutlet UITextField *groupNameText;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UIView *memberView;//群成员显示区域view
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupMemberLabel;
@property (weak, nonatomic) IBOutlet UILabel *allMemberLabel;

@end

@implementation GroupDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self getBaseData];
    self.groupNameText.returnKeyType = UIReturnKeyDone;
    self.groupNameText.delegate = self;
    
    
    _groupMemberLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSeemMember)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_groupMemberLabel addGestureRecognizer:tap];
}

- (void)goSeemMember
{
    [self performSegueWithIdentifier:@"groupMember" sender:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getBaseData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getBaseData
{
    if (![[FNGroupTable get:self.groupId] count])
    {
        return;
    }
    
    FNGroupTable *group = [[FNGroupTable get:self.groupId] objectAtIndex:0];
    self.groupName = group.groupName;
    self.groupType = group.groupType;
    
    self.groupMembers = [FNGroupMembersTable get:self.groupId];
    self.allMemberLabel.text = [NSString stringWithFormat:@"%ld人",self.groupMembers.count];
    [self checkUserIndentity:self.groupMembers];

    FNGetGroupMemberListRequest *request = [[FNGetGroupMemberListRequest alloc] init];
    request.groupID = self.groupId;
    
    [FNGroupLogic getGroupMemberList:request callback:^(FNGetGroupMemberListResponse *rspArgs)
     {
         NSInteger responseCode = rspArgs.statusCode;
         if ( 200 == responseCode )
         {
             self.groupMembers = [FNGroupMembersTable get:self.groupId];
             self.allMemberLabel.text = [NSString stringWithFormat:@"%ld人",self.groupMembers.count];
             [self checkUserIndentity:self.groupMembers];
         }
     }];
}

- (void)checkUserIndentity:(NSMutableArray *)members
{
    NSMutableArray *sortArray = [NSMutableArray array];
    NSString *userID = [FNUserConfig getInstance].userID;
    for (int i = 0; i < members.count; i++) {
        FNGroupMembersTable *info = [self.groupMembers objectAtIndex:i];
        if (0 == info.identity) {
            if ([info.memberID isEqualToString:userID]) {
                self.isOwner = YES;
            }
            [sortArray addObject:info];
            [self.groupMembers removeObjectAtIndex:i];
        }
    }
    
    for (int i = 0; i < self.groupMembers.count; i++) {
        FNGroupMembersTable *info = [self.groupMembers objectAtIndex:i];
        [sortArray addObject:info];
    }
    self.sortMembers = [NSArray arrayWithArray:sortArray];
}

- (IBAction)exitAction:(UIButton *)sender
{
    if (self.isOwner)
    {
        [self ownerDeletGroup];
    }
    else
    {
        [self memberExitGroup];
    }
}

- (void)addMember
{
    //TODO:过滤已有成员
    [self performSegueWithIdentifier:@"abListViewController" sender:nil];
}

- (void)memberExitGroup
{
    FNExitGroupRequest *exitGpReq = [[FNExitGroupRequest alloc] init];
    exitGpReq.groupID = self.groupId;
    [FNGroupLogic exitGroup:exitGpReq callback:^(FNExitGroupResponse *rspArgs) {
        
        NSLog(@"exit group return code:%d", rspArgs.statusCode);
        if (200 == rspArgs.statusCode)
        {
            NSLog(@"exit group success!");
            [FNRecentConversationTable delete:self.groupId];
            [FNGroupMsgTable deleteByGroupId:self.groupId];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else if (405 == rspArgs.statusCode)
        {
            NSLog(@"group creater can not exit group, try delete group");
        }
        else
        {
            NSLog(@"exit group failed!");
        }
    }];
}

- (void)ownerDeletGroup
{
    FNDeleteGroupRequest *request = [[FNDeleteGroupRequest alloc] init];
    request.groupID = self.groupId;
    [FNGroupLogic delGroup:request callback:^(FNDeleteGroupResponse *rspArgs) {
        int32_t rc = rspArgs.statusCode;
        NSLog(@"delete group return code:%d", rc);
        if (200 == rc)
        {
            NSLog(@"delete group success!");
            [FNRecentConversationTable delete:self.groupId];
            [FNGroupMsgTable deleteByGroupId:self.groupId];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else if (404 == rc)
        {
            NSLog(@"group not exists!");
        }
        else if (500 == rc)
        {
            NSLog(@"server inner error!");
        }
        else
        {
            NSLog(@"delete group failed!");
        }
    }];
}

- (void)ownerSetGroupName
{
    NSString *groupName = self.groupNameText.text;
    if ([groupName isContain:@" "] || groupName.length == 0) {
        [self.view makeToast:@"群昵称包含空格符"];
        return;
    }
    
    FNSetGroupInfoRequest *request = [[FNSetGroupInfoRequest alloc] init];
    request.groupID = self.groupId;
    request.groupName = groupName;
    request.groupPortraitUrl = @"lalalalalatest";
    request.groupConfig = 2;
    request.updateFieldFlags = 1;
    
    [FNGroupLogic setGroupInfo:request callback:^(FNSetGroupInfoResponse *rspArgs) {
        int32_t rc = rspArgs.statusCode;
        NSLog(@"set group info return code:%d", rc);
        if (200 == rc) {
            //TODO:保存在本界面会出现之前的会话界面titile仍没有变化
//            [self.view makeToast:@"修改成功"];
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        } else if (404 == rc) {
            [self.view makeToast:@"该群不存在!"];
        } else if (500 == rc) {
            [self.view makeToast:@"服务器错误"];
        } else {
            [self.view makeToast:@"修改失败"];
        }
    }];
}
////TEST
//- (void)changeGroupOwner
//{
//    FNChangeGroupOwnerRequest *request = [[FNChangeGroupOwnerRequest alloc] init];
//    request.groupId = self.groupId;
//    request.userId = @"61";
//   [FNGroupLogic changeGroupOwner:request callback:^(FNChangeGroupOwnerResponse *rspArgs) {
//       NSLog(@"%d",rspArgs.statusCode);
//   }];
//}

#pragma setter

- (void)setIsOwner:(BOOL)isOwner
{
    if (_isOwner != isOwner)
    {
        _isOwner = isOwner;
    }
    if (isOwner)
    {
        //修改群昵称的 现在不确定
        self.groupNameText.userInteractionEnabled = YES;
        if (1 == self.groupType)
        {
            [self.exitButton setTitle:@"解散并退出该群" forState:UIControlStateNormal];
        }
        else
        {
            [self.exitButton setTitle:@"退出讨论组" forState:UIControlStateNormal];
        }
    }
    else
    {
        self.groupNameText.userInteractionEnabled = NO;
        if (1 == self.groupType)
        {
            [self.exitButton setTitle:@"退出该群" forState:UIControlStateNormal];
        }
        else
        {
            [self.exitButton setTitle:@"退出讨论组" forState:UIControlStateNormal];
        }
    }
}

- (void)setGroupName:(NSString *)groupName
{
    if (_groupName != groupName)
    {
        _groupName = groupName;
        self.groupNameText.text = _groupName;
    }
}

- (void)setGroupType:(int)groupType
{
    if (_groupType != groupType)
    {
        _groupType = groupType;
        if (1 == groupType)
        {
            self.title = @"群信息";
            self.groupNameLabel.text = @"群名称";
            self.groupMemberLabel.text = @"群成员";
        }
        else
        {
            self.title = @"讨论组信息";
            self.groupNameLabel.text = @"讨论组名称";
            self.groupMemberLabel.text = @"讨论组成员";
        }
    }
}

- (void)setSortMembers:(NSArray *)sortMembers
{
    if (_sortMembers != sortMembers) {
        _sortMembers = sortMembers;
    }
    for (UIView *subview in [self.memberView subviews]) {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            [subview removeFromSuperview];
        }
    }
    CGFloat width = 44;//(self.memberView.frame.size.width - 72)/5;
    CGFloat x = width + 18;
    for (int i = 0; i < sortMembers.count; i++)
    {
        if (i == 4)
        {
            break;
        }
        UIImageView *member = [[UIImageView alloc] initWithFrame:CGRectMake(0 + x *i, 50, width, width)];
        [member setImage:[FNImage avatarWithIndex:i]];
        
        //name
        [self.memberView addSubview:member];

    }
    //change
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addButton.frame = CGRectMake(4*x, 50, width, width);
    [addButton addTarget:self action:@selector(addMember) forControlEvents:UIControlEventTouchUpInside];
    [self.memberView addSubview:addButton];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self ownerSetGroupName];
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"groupMember"])
    {
        GroupMemberController *groupMemberVC = segue.destinationViewController;
        groupMemberVC.groupID = self.groupId;
        groupMemberVC.groupType = self.groupType;
        groupMemberVC.isOwner = self.isOwner;
    }
    else if ([segue.identifier isEqualToString:@"deleteGroupMember"])
    {
        DeleteGroupMemController *destVC = segue.destinationViewController;
        destVC.groupId = self.groupId;
        destVC.isAdd = YES;
        destVC.isDetail = YES;
    }
    else if ([segue.identifier isEqualToString:@"abListViewController"])
    {
        ABViewController *ab = segue.destinationViewController;
        
        ab.groupId = self.groupId;
        ab.isNewGroup = NO;
        if ([[[self.groupId componentsSeparatedByString:@":"] firstObject] isEqualToString:@"PG"])
        {
            ab.isDisGroup = NO;
        }
        else
        {
            ab.isDisGroup = YES;
        }
    }
}

#pragma mark 获得群组头像
- (UIImage*)getImageTogether:(NSArray*)imageArray withSize:(CGFloat)imageWidth
{
    UIImage * needImage = nil;
    UIGraphicsBeginImageContext(CGSizeMake(imageWidth, imageWidth));
    NSInteger number = imageArray.count>9 ? 9 : imageArray.count;
    CGFloat smallImageW = imageWidth * 0.25;
    CGFloat spaceL = smallImageW * 0.25 * 0.25;
    
    for (int i = 0; i  < number; i++) {
        int row = i / 3;
        int cloum = i % 3;
        CGRect rct = CGRectMake(cloum*(smallImageW+spaceL)+spaceL, row*(smallImageW+spaceL)+spaceL, smallImageW, smallImageW);
        UIImage *currentimage = imageArray[i];
        [currentimage drawInRect:rct];
    }
    needImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return needImage;
}
@end
