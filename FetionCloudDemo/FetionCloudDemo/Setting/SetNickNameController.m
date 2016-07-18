//
//  SetNickNameController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/28.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "SetNickNameController.h"

#import "FNUserConfig.h"
#import "NSString+Extension.h"
#import "CurrentUserTable.h"

@interface SetNickNameController ()

@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UIButton *ensureButton;

@end

@implementation SetNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self ensureButtonValid:NO];
    [self.nickName addTarget:self action:@selector(textFieldOnEditing:) forControlEvents:UIControlEventEditingChanged];
    self.nickName.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 10, 20);
    [btn setBackgroundImage:[FNImage imageWithName:@"return_icon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancel) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"setNickDealloc");
}

#pragma mark - TextfieldDelegate

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSString *currentStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    if (currentStr.length > 20)
//    {
//        return false;
//    }
//    return true;
//}

- (void)textFieldOnEditing:(UITextField *)textField
{
    if (self.nickName.text.length > 0)
    {
        [self ensureButtonValid:YES];
    }
    else
    {
        [self ensureButtonValid:NO];
    }
    
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

#pragma mark - event response

- (IBAction)ensureAction:(UIButton *)sender
{
    if ([NSString isNullString:self.nickName.text]) {
        //???
        [self.view makeToast:@"昵称无效"];
        return;
    }
    [self.view endEditing:YES];
    [FNUserConfig setNickName:self.nickName.text];
    NSString *userId = [FNUserConfig getInstance].userID;
    [[NSUserDefaults standardUserDefaults] setObject:self.nickName.text forKey:userId];
    
    CurrentUserTable *table = [CurrentUserTable getLastUser];
    table.nickName = self.nickName.text;
    table.account = table.account;
    table.userId = table.userId;
    table.password = table.password;
    [CurrentUserTable update:table];
    
    [self cancel];
}

- (void)cancel
{
    [self.view endEditing:YES];
    
    if (![[CurrentUserTable getLastUser] nickName])
    {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"请设置昵称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        
        return;
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)ensureButtonValid:(BOOL)isValid
{
    if (isValid)
    {
        self.ensureButton.userInteractionEnabled = YES;
        self.ensureButton.backgroundColor = RGBA(78, 146, 223, 1.0);
    }
    else
    {
        self.ensureButton.userInteractionEnabled = YES;
        self.ensureButton.backgroundColor = RGBA(201, 221, 245, 1.0);
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
