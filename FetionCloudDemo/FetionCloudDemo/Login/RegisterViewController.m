//
//  RegisterViewController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"

#import "FNAccountLogic.h"
#import "NSString+Extension.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *ensureText;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self baseCongriguration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)baseCongriguration
{
    self.registerButton.userInteractionEnabled = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 10, 20);
    [btn setBackgroundImage:[FNImage imageWithName:@"return_icon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancel) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = back;
    //放进sb中
    [self.accountText addTarget:self action:@selector(textFieldOnEditing:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordText addTarget:self action:@selector(textFieldOnEditing:) forControlEvents:UIControlEventEditingChanged];
    [self.ensureText addTarget:self action:@selector(textFieldOnEditing:) forControlEvents:UIControlEventEditingChanged];
    self.accountText.delegate = self;
    self.passwordText.delegate = self;
    self.ensureText.delegate = self;
}

#pragma mark - TextfieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *currentStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (currentStr.length > 11)
    {
        return false;
    }
    return true;
}

- (void)textFieldOnEditing:(UITextField *)textField
{
    if (self.accountText.text.length > 5 && self.passwordText.text.length > 5 && self.ensureText.text.length > 5)
    {
        [self registerButtonValid:YES];
    }
    else
    {
        [self registerButtonValid:NO];
    }
}

#pragma mark - event response

- (void)cancel
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)endEditing:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (IBAction)userRegister:(id)sender
{
    if (![NSString isEligible:self.accountText.text])
    {
        [self.view makeToast:@"账号格式不正确，请重新输入"];
        [self clearText:self.accountText];
        return;
    }
    else if (![NSString isEligible:self.passwordText.text])
    {
        [self.view makeToast:@"密码格式不正确，请重新输入"];
        [self clearText:self.passwordText];
        return;
    }
    else if (![self.passwordText.text isEqualToString:self.ensureText.text])
    {
        [self.view makeToast:@"两次密码输入不相同，请重新输入"];
        [self clearText:self.ensureText];
        return;
    }
    else
    {
        [self registerAction];
    }
}

- (IBAction)hidePasswordText:(UIButton *)sender
{
    self.passwordText.secureTextEntry = !self.passwordText.secureTextEntry;
}

- (IBAction)hideRepeatText:(UIButton *)sender
{
    self.ensureText.secureTextEntry = !self.ensureText.secureTextEntry;
}

#pragma mark - private methods

- (void)registerAction
{
    [self activityShow:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://221.176.28.117:8080/as/user/register";
//    NSString *url = @"http://192.168.0.102:8080/as/user/register";
    
    NSDictionary *parameter = @{@"uname":_accountText.text,@"pwd":_passwordText.text,@"nickName":_accountText.text,@"appkey":APP_KEY};
    NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:encodingString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@",responseObject);
        if (responseObject[@"code"] && [responseObject[@"code"] integerValue] == 2000)
        {
            [self.view makeToast:@"创建成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.view makeToast:responseObject[@"cnt"]];
        }
        
        [self activityShow:NO];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (void)clearText:(UITextField *)textField
{
    textField.text = nil;
    [textField becomeFirstResponder];
    [self registerButtonValid:NO];
}

- (void)activityShow:(BOOL)isShow
{
    if (isShow)
    {
        [self.activityView startAnimating];
        self.view.userInteractionEnabled = NO;
    }
    else
    {
        [self.activityView stopAnimating];
        self.view.userInteractionEnabled = YES;
    }
}

- (void)registerButtonValid:(BOOL)isValid
{
    if (isValid)
    {
        self.registerButton.backgroundColor = RGBA(78, 146, 223, 1.0);
        self.registerButton.userInteractionEnabled = YES;
    }
    else
    {
        self.registerButton.backgroundColor = RGBA(201, 221, 245, 1.0);
        self.registerButton.userInteractionEnabled = NO;
    }
}

- (void)dealloc
{
    NSLog(@"registerDealloc");
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
