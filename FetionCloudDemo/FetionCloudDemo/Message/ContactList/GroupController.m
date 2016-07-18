//
//  GroupController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/17.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "GroupController.h"
#import "CreatGroupController.h"
#import "ConversationController.h"

#import "FNGroupLogic.h"
#import "FNGroupNotify.h"
#import "FNGroupTable.h"
#import "FNEnum.h"
#import "FNNetworkHandle.h"

@interface GroupController ()

@property (nonatomic, strong) NSMutableArray *groupList;

@end

@implementation GroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notifyGroupListChanged)
                                                 name:NOTIFY_GROUP_LIST_CHANGED
                                               object:nil];
    [FNNetworkHandle handelNetwork];
    [self getGroupLists:PGGroup]; //获取群列表
    [self getGroupLists:DGGroup];
}

- (void)viewWillAppear:(BOOL)animated
{
    _groupList = [FNGroupTable get:nil groupType:PGGroup];
    [self.tableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTIFY_GROUP_LIST_CHANGED object:nil];
    self.groupList = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createGroup:(id)sender
{
    [self performSegueWithIdentifier:@"createGroup" sender:nil];
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
            if (groupType == PGGroup) {
                _groupList = [FNGroupTable get:nil groupType:groupType];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
    
    // Configure the cell...
    FNGroupTable *infos = nil;
    infos = (FNGroupTable *)[_groupList objectAtIndex:indexPath.row];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createGroup"])
    {
        CreatGroupController *destinationVC = segue.destinationViewController;
        destinationVC.groupIndertifier = 1;
    }
    else if ([segue.identifier isEqualToString:@"groupConversation"])
    {
        ConversationController *conversationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FNGroupTable *infos = [self.groupList objectAtIndex:indexPath.row];
        conversationVC.toUserid = infos.groupId;
        conversationVC.toDisplayName = infos.groupName;
        
        conversationVC.source = @"group";
    }
}

@end
