//
//  DiscussionGroupController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/17.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "DiscussionGroupController.h"
#import "DeleteGroupMemController.h"
#import "ConversationController.h"
#import "UIView+Toast.h"

#import "FNGroupLogic.h"
#import "FNGroupNotify.h"
#import "FNGroupTable.h"
#import "FNEnum.h"
#import "ABViewController.h"
#import "FNNetworkHandle.h"

@interface DiscussionGroupController ()

@property (nonatomic, strong) NSMutableArray *disGroupList;

@end

@implementation DiscussionGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    //讨论组暂未排序
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notifyGroupListChanged)
                                                 name:NOTIFY_GROUP_LIST_CHANGED
                                               object:nil];
    [FNNetworkHandle handelNetwork];
    //bug
    [self getGroupLists:DGGroup]; //获取讨论组列表
    [self getGroupLists:PGGroup];
}

- (void)viewWillAppear:(BOOL)animated
{
    _disGroupList = [FNGroupTable get:nil groupType:DGGroup];
    [self.tableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.disGroupList = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)notifyGroupListChanged
{
    [self getGroupLists:PGGroup]; //获取群列表
}

- (void)getGroupLists:(int32_t)groupType {
    FNGetGroupListRequest *gpListReq = [[FNGetGroupListRequest alloc] init];
    gpListReq.groupType = groupType;
    
    [FNGroupLogic getGroupList:gpListReq callback:^(FNGetGroupListResponse *rspArgs) {
        int32_t rc = rspArgs.statusCode;
        if (200 == rc)
        {
            if (groupType == DGGroup) {
                _disGroupList = [FNGroupTable get:nil groupType:groupType];
                [self.tableView reloadData];
            }
        }
        else
        {
            NSLog(@"get group list failed!");
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _disGroupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discussionGroupCell" forIndexPath:indexPath];

    FNGroupTable *infos = nil;
    infos = (FNGroupTable *)[_disGroupList objectAtIndex:indexPath.row];
    NSString *nameStr = nil;
    if (infos.groupName.length > 10)
    {
        nameStr = [[infos.groupName substringToIndex:10] stringByAppendingString:@"..."];
    }
    else
    {
        nameStr = infos.groupName;
    }
    if (!infos.groupName)
    {
        nameStr = infos.groupId;
    }
    cell.textLabel.text = nameStr;
    
    return cell;
}

- (IBAction)createDisGroup:(id)sender
{
    DeleteGroupMemController *create = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"DeleteGroupMemController"];
    create.isCreate = YES;
    [self.navigationController pushViewController:create animated:YES];
//    [self performSegueWithIdentifier:@"createDisGroup" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createDisGroup"])
    {
//        DeleteGroupMemController *destinationVC = segue.destinationViewController;
//        destinationVC.isCreate = YES;
        
        ABViewController *ab = segue.destinationViewController;
        
        ab.isNewGroup = YES;
        
        ab.isDisGroup = YES;
        
    }
    else if ([segue.identifier isEqualToString:@"disGroupConversation"])
    {
        ConversationController *conversationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FNGroupTable *infos = [self.disGroupList objectAtIndex:indexPath.row];
        conversationVC.toUserid = infos.groupId;
        conversationVC.toDisplayName = infos.groupName;
        conversationVC.source = @"group";
    }
}

@end
