//
//  LoginController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/16.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "LoginController.h"
#import "AFNetworking.h"

#import "FNConfig.h"
#import "FNAccountLogic.h"
#import "FNMsgNotify.h"
#import "FNGroupMsgNotify.h"
#import "FNGroupNotify.h"
#import "FNUserConfig.h"
#import "FNServerConfig.h"
#import "NSString+Extension.h"

#import "UIView+Toast.h"
#import "CurrentUserTable.h"
#import "DBManager.h"

#import "AppDelegate.h"
#import "FNUserInfo.h"
#import "FNDBManager.h"


@interface LoginController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *eyeButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIButton *ensureButton;

@property (nonatomic, copy) NSString *registerAcount;


@property (weak, nonatomic) IBOutlet UITextField *smsCodeText;

@property (weak, nonatomic) IBOutlet UIButton *smsCodeButton;//获取短信验证码

@property (weak, nonatomic) IBOutlet UIButton *provisionButton;//验证按钮

@property (nonatomic,copy)NSString *userId;



@end

@implementation LoginController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self baseConfriguration];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //按钮和输入框的基本配置
    [self baseConfriguration];
    
    _localNum = @"+8617900010110";
    
    _password = @"Vae5S1CAXBfc";
    
}


- (void)baseConfriguration
{
    self.ensureButton.userInteractionEnabled = NO;
    self.eyeButton.hidden = YES;
    self.nameText.text =  [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    [self.nameText addTarget:self action:@selector(textFieldOnEditing:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordText addTarget:self action:@selector(textFieldOnEditing:) forControlEvents:UIControlEventEditingChanged];
    self.nameText.delegate = self;
    self.passwordText.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"loginDealloc");
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
    if (self.nameText.text.length > 5 && self.passwordText.text.length > 5)
    {
        [self loginButtonValid:YES];
    }
    else
    {
        [self loginButtonValid:NO];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.passwordText)
    {
        self.eyeButton.hidden = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.eyeButton.hidden = YES;
}

#pragma mark - event response
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}


//获取验证码
- (IBAction)getsmscode:(id)sender {
    
    NSString * str1 = @"+86";
    //    _localNum = [str1 stringByAppendingString:_nameText.text];
    
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"/"];
    NSString *spath = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"spconfig"];
    
    R =[globalRcsApi newState:_localNum appId:@"0" clientVendor:@"1" clientVersion:@"2" storagePath:path sysPath:spath ];
    
    [globalRcsApi getsmscode:R number:_localNum callback:^(rcs_state* R, GetSmsResult *s) {
        if(s->error_code == 200)
        {
            _provsid = [NSString stringWithUTF8String:s->session_id];
            NSLog(@"获取验证码成功");
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                //[[[UIAlertView alloc] initWithTitle:@"" message:@"获取验证码成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
                _smsCodeText.text = @"777777";
                _passwordText.text = _password;
                
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[[UIAlertView alloc] initWithTitle:@"" message:@"获取验证码失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
                _smsCodeText.text = @"";
                
            });
            NSLog(@"获取验证码失败");
            
        }
    }];
    
}


//验证
- (IBAction)provisionop:(id)sender {
    
    
    [globalRcsApi provisionotp:R smscode:@"777777" username:_localNum otp:_password sessid:_provsid callback:^(rcs_state* R, ProvisionResult *s) {
        if (s->error_code == 200) {
            // [self AddLogC:"provision ok"];
            NSLog(@"验证成功");
            
            _userId = [NSString stringWithFormat:@"%d",s->user_id];
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[[UIAlertView alloc] initWithTitle:@"" message:@"验证成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[[UIAlertView alloc] initWithTitle:@"" message:@"验证失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
                _passwordText.text =@"";
                
            });
            
        }
    }];
    
    [self AddLogNs:[NSString stringWithFormat:@"call _rcsApi provsion for:%@", _localNum]];
    
}

//登录
- (IBAction)loginAction:(id)sender {
    
    [globalRcsApi login:R username:_localNum password:_password callback:^(rcs_state* R, LoginResult *s) {
        if (s->error_code == 200) {
            
            NSLog(@"userid=============%d,%s,%d",R->last_id,R->number,R->started);
            
            //            [FNUserConfig initWithUserid:_localNum];
            
            //-----------------------------------start--------------------------------------
            
            
            [DBManager initDBWithUserId:_localNum];
            
            CurrentUserTable *table = [CurrentUserTable getWithUserId:_userId];
            
            if (table.account)
            {
                CurrentUserTable *t = [[CurrentUserTable alloc] init];
                t.userId = _userId;
                t.password = _password;
                //t.account = _nameText.text;
                t.account = _localNum;
                t.nickName = table.nickName;
                [CurrentUserTable update:t];
                
            }else{
                
                CurrentUserTable *t = [[CurrentUserTable alloc] init];
                t.userId = _userId;
                t.password = _password;
                //t.account = _nameText.text;
                t.account = _localNum;
                [CurrentUserTable insert:t];
                
            }
            
            [FNUserInfo ShareStaticConst].localNum = _localNum;
            [[NSUserDefaults standardUserDefaults] setObject:_localNum forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] setObject:_password forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:_userId forKey:@"userId"];
            
            [DBManager initDBWithUserId:_localNum];
            
            [FNUserInfo ShareStaticConst].localNum = _localNum;
            [FNUserConfig initWithUserid:_userId];
            
            [FNDBManager initDB:_userId];
            
            
            
            //--------------------------------------end----------------------------------------
            
            
            //切换VC
            dispatch_async(dispatch_get_main_queue(),^{
                
                [UIApplication sharedApplication].keyWindow.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarController"];
                
                // [[[UIAlertView alloc] initWithTitle:@"" message:@"登录成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[[UIAlertView alloc] initWithTitle:@"" message:@"登录失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            });
            
            NSLog(@"login failed");
        }
    }];
    
    //    if (![NSString isEligible:self.nameText.text])
    //    {
    //        [self.view makeToast:@"账号格式不正确，请重新输入"];
    //        [self clearText:self.nameText];
    //        return;
    //    }
    //    else if (![NSString isEligible:self.passwordText.text])
    //    {
    //        [self.view makeToast:@"密码格式不正确，请重新输入"];
    //        [self clearText:self.passwordText];
    //        return;
    //    }
    //
    //    [self login];
    
    
}



//- (IBAction)userLogin:(UIButton *)sender
//{
//    if (![NSString isEligible:self.nameText.text])
//    {
//        [self.view makeToast:@"账号格式不正确，请重新输入"];
//        [self clearText:self.nameText];
//        return;
//    }
//    else if (![NSString isEligible:self.passwordText.text])
//    {
//        [self.view makeToast:@"密码格式不正确，请重新输入"];
//        [self clearText:self.passwordText];
//        return;
//    }
//    [self login];
//}


- (void)login
{
    //11111
    [self activityShow:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // NSString *url = @"http://192.168.0.102:8080/as/user/login";
    NSString *url = @"http://221.176.28.117:8080/as/user/login";
    
    //__block NSString *password = _passwordText.text;
    __block NSString *password = _password;
    
    
    // NSDictionary *parameter = @{@"uname":_nameText.text,@"pwd":_passwordText.text,@"appkey":APP_KEY};
    
    NSDictionary *parameter = @{@"uname":_localNum,@"pwd":password,@"appkey":APP_KEY};
    NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:encodingString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"%@",responseObject);
        
        [self activityShow:NO];
        
        if (responseObject[@"code"] && [responseObject[@"code"] integerValue] == 2000)
        {
            //[DBManager initDBWithUserId:_nameText.text];
            
            [DBManager initDBWithUserId:_localNum];
            
            CurrentUserTable *table = [CurrentUserTable getWithUserId:responseObject[@"cnt"][@"bopId"]];
            
            if (table.account)
            {
                CurrentUserTable *t = [[CurrentUserTable alloc] init];
                t.userId = responseObject[@"cnt"][@"bopId"];
                t.password = password;
                
                //t.account = _nameText.text;
                t.account = _localNum;
                t.nickName = table.nickName;
                
                [CurrentUserTable update:t];
            }
            else
            {
                CurrentUserTable *t = [[CurrentUserTable alloc] init];
                t.userId = responseObject[@"cnt"][@"bopId"];
                t.password = password;
                //t.account = _nameText.text;
                t.account = _localNum;
                t.account = _localNum;
                [CurrentUserTable insert:t];
                
            }
            
            //[[NSUserDefaults standardUserDefaults] setObject:_nameText.text forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] setObject:_localNum forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"cnt"][@"token"] forKey:@"bopToken"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"cnt"][@"bopId"] forKey:@"bopId"];
            //设置
            [FNConfig setAppToken:responseObject[@"cnt"][@"token"] userId:responseObject[@"cnt"][@"bopId"]];
            //切换vc
            // [UIApplication sharedApplication].keyWindow.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarController"];
            
            //切换VC
            dispatch_async(dispatch_get_main_queue(),^{
                
                [UIApplication sharedApplication].keyWindow.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarController"];
                
            });
            
            if (![[CurrentUserTable getLastUser] nickName])
            {
                [self performSelector:@selector(setNick) withObject:nil afterDelay:1];
            }
        }
        else
        {
            [self.view makeToast:responseObject[@"cnt"]];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self activityShow:NO];
    }];
    
}
- (void)setNick
{
    [[UIApplication sharedApplication].keyWindow.rootViewController performSegueWithIdentifier:@"setNickName" sender:nil];
}

- (IBAction)endEditing:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)changePasswordStyle:(id)sender
{
    self.passwordText.secureTextEntry = !self.passwordText.secureTextEntry;
}

- (IBAction)userRegister:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstLogin:) name:@"firstLogin" object:nil];
    [self performSegueWithIdentifier:@"register" sender:nil];
}

- (void)firstLogin:(NSNotification *)notify
{
    self.registerAcount = notify.object;
    FNSendWelcomeLanguageRequest *request = [[FNSendWelcomeLanguageRequest alloc] init];
    request.isFirstLogin = 1;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"firstLogin" object:nil];
}

#pragma mark ------------------------------------------------private methods--------------------

//只有demo用，第一次登录后发送问候语
- (void)sendWelcomeLanguage
{
    FNSendWelcomeLanguageRequest *request = [[FNSendWelcomeLanguageRequest alloc] init];
    request.isFirstLogin = 1;
    
    [FNAccountLogic sendWelcomeLanguage:request callback:^(FNSendWelcomeLanguageResponse *reponse){
        NSLog(@"SendWelcomeLanguageResponse:%d",reponse.statusCode);
    }];
    
    if (self.registerAcount)
    {
        [FNAccountLogic sendGroupWelcomeLanguage:request callback:^(FNSendWelcomeLanguageResponse *reponse){
            NSLog(@"SendGroupWelcomeLanguageResponse:%d",reponse.statusCode);
        }];
    }
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

- (void)loginButtonValid:(BOOL)isVaild
{
    if (isVaild)
    {
        self.ensureButton.backgroundColor = [UIColor whiteColor];
        self.ensureButton.userInteractionEnabled = YES;
    }
    else
    {
        self.ensureButton.backgroundColor = RGBA(79, 184, 206, 1);
        self.ensureButton.userInteractionEnabled = NO;
    }
}

- (void)clearText:(UITextField *)textField
{
    textField.text = nil;
    [textField becomeFirstResponder];
    [self loginButtonValid:NO];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)AddLogNs:(NSString*) log
{
    if (log == nil) {
        return;
    }
    
    printf("%s \n", log.UTF8String);
    
}


@end
