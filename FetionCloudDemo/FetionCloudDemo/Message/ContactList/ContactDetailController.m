//
//  ContactDetailController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/18.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "ContactDetailController.h"
#import "FNContactTable.h"
#import "FNRecentConversationTable.h"
#import "FNMsgTable.h"
#import "ContactDataTable.h"
#import "AppDelegate.h"


@interface ContactDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation ContactDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ContactDataTable *contact = [ContactDataTable getWithUserId:self.userId];
    self.accountLabel.text = contact.account;
    self.remarkLabel.text = contact.nickName;
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    
    
    
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    
    
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteContact:(id)sender
{
    [ContactDataTable del:self.userId];
    [FNRecentConversationTable delete:self.userId];
    [FNMsgTable deleteByUserId:self.userId];
    
    [globalRcsApi buddydel:R userId:[self.userId intValue] callback:^(rcs_state* R, BuddyResult *s) {
        if (s->error_code == 200) {
            
            NSLog(@"delete buddy ok");
        }
        else{
            
            NSLog(@"delete buddy failed");
        }
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
