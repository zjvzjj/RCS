//
//  ModifyPasswordController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/17.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "UIView+Toast.h"

#import "FNAccountLogic.h"
#import "NSString+Extension.h"

@interface ModifyPasswordController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *lastPassword;
@property (weak, nonatomic) IBOutlet UITextField *repeatPassword;

@end

@implementation ModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ensureChangePassword:(id)sender
{
    NSString *oldPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldPassword"];
    if (![self.oldPassword.text isEqualToString:oldPassword])
    {
        [self.view makeToast:@"原密码错误"];
        return;
    }
    if (![NSString isEligible:self.lastPassword.text])
    {
        [self.view makeToast:@"新密码格式错误"];
        return;
    }
    if (![self.lastPassword.text isEqualToString:self.repeatPassword.text])
    {
        [self.view makeToast:@"新密码不一致"];
        return;
    }
    FNModifyPwdRequest *req = [[FNModifyPwdRequest alloc] init];
    req.oldPwd = self.oldPassword.text;
    req.theNewPwd = self.lastPassword.text;
//    
//    [FNAccountLogic modifyPwd:req callback:^(FNModifyPwdResponse *rspArgs) {
//        int32_t rc = rspArgs.statusCode;
//        NSLog(@"modify password return code: %d", rc);
//        switch (rc) {
//            case 200:
//                NSLog(@"modfiy pwd success!");
//                //???是否回到登录界面
//                [UIApplication sharedApplication].keyWindow.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
//                break;
//            case 400:
//                NSLog(@"not supported login type!");
//                break;
//            case 404:
//                NSLog(@"account not existed!");
//                break;
//            case 500:
//                NSLog(@"server inner error!");
//                break;
//            default:
//                NSLog(@"modify pwd failed!");
//                break;
//        }
//    }];
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
