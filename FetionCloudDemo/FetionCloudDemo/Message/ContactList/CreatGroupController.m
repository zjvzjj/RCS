//
//  CreatGroupController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/18.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "CreatGroupController.h"
#import "UIView+Toast.h"
#import "DeleteGroupMemController.h"

#import "FNGroupLogic.h"
#import "FNUserConfig.h"
#import "NSString+Extension.h"
#import "ABViewController.h"
#import "CurrentUserTable.h"

@interface CreatGroupController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *groupName;
@property (weak, nonatomic) IBOutlet UIButton *creatButton;
@property (nonatomic, assign) BOOL isCreate;
@property (nonatomic, copy) NSString *groupId;

@end

@implementation CreatGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.groupName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.groupName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 20) {
                textField.text = [toBeString substringToIndex:20];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > 20) {
            textField.text = [toBeString substringToIndex:20];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createGroupAction:(UIButton *)sender
{
    if (self.isCreate)
    {
        [self performSegueWithIdentifier:@"abListViewController" sender:nil];
    }
    else
    {
        NSString *groupName = _groupName.text;
        BOOL isTrue = [groupName isContain:@" "];
        if (!groupName.length)
        {
            [self.view makeToast:@"群名称不能为空"];
            return;
        }
        else if (isTrue == YES)
        {
            [self.view makeToast:@"群名称格式不正确，请重新输入"];

            return;
        }
        sender.userInteractionEnabled = NO;
        FNCreateGroupRequest *requet = [[FNCreateGroupRequest alloc] init];
        requet.groupName = groupName;
        requet.groupType = self.groupIndertifier;
        requet.nickname = [[CurrentUserTable getLastUser] nickName];
        requet.groupConfig = 0;
        requet.groupPortraitUrl = @"hahatest";
        [FNGroupLogic createGroup:requet callback:^(FNCreateGroupResponse *rspArgs){
            int32_t rc = rspArgs.statusCode;
            NSLog(@"create group return code:%d", rc);
            sender.userInteractionEnabled = YES;
            if (200 == rc)
            {
                [self.view endEditing:YES];
                self.isCreate = YES;
                self.groupId = rspArgs.groupID;
//                [self inviteSelf];
            }
            else
            {
                [self.view makeToast:@"网络错误,请重试!"];
            }
        }];
    }
}

- (void)inviteSelf
{

    FNInviteJoinGroupInfo *info = [[FNInviteJoinGroupInfo alloc] init];
        
    info.groupID = self.groupId;
    
    info.invitedUserID = [[CurrentUserTable getLastUser] userId];
    
    info.userNickname = [[CurrentUserTable getLastUser] nickName];
    
    info.userPortraitUrl = @"";

    
    FNInviteJoinGroupRequest *join = [[FNInviteJoinGroupRequest alloc] init];
    
    join.groupInfoArray = @[info];
    
    [FNGroupLogic inviteJoinGroup:join callback:^(FNInviteJoinGroupResponse *rspArgs) {
        
        if (rspArgs.statusCode == 200)
        {
            [self.view makeToast:@"创建成功"];

        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"" message:@"创建失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }];
}

- (void)finishAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setIsCreate:(BOOL)isCreate
{
    if (_isCreate != isCreate)
    {
        _isCreate = isCreate;
    }
    
    if (isCreate == YES)
    {
        self.title = @"创建成功";
        [self.creatButton setTitle:@"邀请群成员" forState:UIControlStateNormal];
        UIBarButtonItem *morebutton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction)];
        self.navigationItem.rightBarButtonItem = morebutton;
    }
}

//- (void)setGroupIndertifier:(int32_t)groupIndertifier
//{
//    if (_groupIndertifier != groupIndertifier)
//    {
//        _groupIndertifier = groupIndertifier;
//    }
//    switch (groupIndertifier) {
//        case 1:
//            self.title = @"创建群";
//            break;
//        case 2:
//            self.title = @"创建讨论组";
//            break;
//            
//        default:
//            break;
//    }
//}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"abListViewController"])
    {
        ABViewController *ab = segue.destinationViewController;
        
        ab.isNewGroup = YES;
        
        ab.groupId = self.self.groupId;
    }

}

@end
