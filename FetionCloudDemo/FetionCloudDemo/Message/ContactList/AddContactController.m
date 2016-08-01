//
//  AddContactController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/18.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "AddContactController.h"
#import "UIView+Toast.h"

#import "FNContactTable.h"
#import "NSString+Extension.h"
#import "AFHTTPRequestOperationManager.h"
#import "ContactDataTable.h"
#import "CurrentUserTable.h"
#import "ContactDataTable+Extension.h"
#import "ConversationController.h"


#import "AppDelegate.h"


NSString *ContactAddGroupMsg = nil;

@interface AddContactController ()
{

}

@property (weak, nonatomic) IBOutlet UITextField *accountLabel;

@property (weak, nonatomic) IBOutlet UITextField *nickNameLabel;

@end

@implementation AddContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.contactName)
    {
        //self.accountLabel.text = self.contactName;
        self.accountLabel.text = @"";
        
//        self.nickNameLabel.text = [[ContactDataTable getWithUserId:self.contactId] nickName];
    }
    ContactAddGroupMsg = nil;
    
    //_remoteNum = @"+8616010100122";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ensureAction:(id)sender
{
    
    NSString * str = @"+86";
    
    _remoteNum = [str stringByAppendingString:_accountLabel.text];
    
    [globalRcsApi buddyadd:R user:_remoteNum reason:@"Hello" callback:^(rcs_state* R, BuddyResult *s) {
        if (s->error_code == 200) {
            
            NSLog(@"add buddy ok");
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[[UIAlertView alloc] initWithTitle:@"" message:@"添加好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            });
            
        }else{
            
            NSLog(@"add buddy failed");
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[[UIAlertView alloc] initWithTitle:@"" message:@"发送请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            });
        
        }
    }];


    
//    BOOL account = [NSString isNullString:_accountLabel.text];
//    BOOL nickName = [NSString isNullString:_nickNameLabel.text];
//    
//    BOOL isTrue = [_nickNameLabel.text isContain:@" "];
//    
//    if (isTrue == YES)
//    {
//        [self.view makeToast:@"联系人昵称格式不正确，请重新输入"];
//        return;
//    }
//    if (account || nickName)
//    {
//        [self.view makeToast:@"请填写完整联系人信息"];
//    }
//    else
//    {
//        if (_accountLabel.text.length < 6)
//        {
//            NSInteger count = [[ContactDataTable getAll] count];
//            ContactDataTable *table = [[ContactDataTable alloc] init];
//            table.userId = [ContactDataTable formatWithUserId:self.contactId];
//            table.account = _accountLabel.text;
//            table.nickName = _nickNameLabel.text;
//            table.portrait = [FNImage avatarName:count];
//            [ContactDataTable insert:table];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else
//        {
//            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//            // NSString *url = @"http://192.168.0.102:8080/as/user/getUnameAutoId";
//            NSString *url = @"http://221.176.28.117:8080/as/user/getUnameAutoId";
//            NSDictionary *parameter = @{@"uname":_accountLabel.text,@"appkey":APP_KEY};
//            NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            [manager POST:encodingString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
//                NSLog(@"%@",responseObject);
//                
//                if ([[responseObject valueForKey:@"code"] integerValue] == 2000)
//                {
//                    NSString *bop = [[[responseObject valueForKey:@"cnt"] componentsSeparatedByString:@":"] lastObject];
//                    
//                    NSString *userId = [[CurrentUserTable getLastUser] userId];
//                    
//                    if ([userId isEqualToString:bop])
//                    {
//                        [[[UIAlertView alloc] initWithTitle:@"" message:@"不能添加自己为好友" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//                        
//                        return ;
//                    }account
//                    
//                    ContactDataTable *table = [ContactDataTable getWithUserId:bop];
//                    if (table.account)
//                    {
//                        [[[UIAlertView alloc] initWithTitle:@"" message:@"你已添加过了，请勿重复添加" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//                    }
//                    else
//                    {
//                        NSInteger count = [[ContactDataTable getAll] count];
//                        
//                        ContactDataTable *table = [[ContactDataTable alloc] init];
//                        table.userId = bop;
//                        table.account = _accountLabel.text;
//                        table.nickName = _nickNameLabel.text;
//                        table.portrait = [FNImage avatarName:count];
//                        [ContactDataTable insert:table];
//                        [self.navigationController popViewControllerAnimated:YES];
//                        
//                    }
//                }
//                else
//                {
//                    [[[UIAlertView alloc] initWithTitle:@"" message:@"帐号格式不对" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//                }
//            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                NSLog(@"%@",error);
//                [[[UIAlertView alloc] initWithTitle:@"" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//            }];
//        }
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
