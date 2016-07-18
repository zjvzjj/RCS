//
//  DeleteContactController.m
//  FetionCloudDemo
//
//  Created by 姜晓光 on 15/12/18.
//  Copyright © 2015年 Fetion. All rights reserved.
//

#import "DeleteContactController.h"

#import "FNContactTable.h"
#import "FNRecentConversationTable.h"

@interface DeleteContactController ()

@property (nonatomic, strong) NSMutableArray *personArray;
@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation DeleteContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.tableView setEditing:YES animated:YES];
    
    self.personArray = [FNContactTable get];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteContactAction:(id)sender
{
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    for (int i = 0; i < array.count; i++) {
        NSIndexPath *index = array[i];
        FNContactTable *contact = self.personArray[index.row];
        [FNContactTable delete:contact.mobileNo];
        [FNRecentConversationTable delete:contact.mobileNo];
    }
    self.personArray = [FNContactTable get];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.personArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteContactCell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contactListCell"];
    }
    FNContactTable *infos = (FNContactTable *)self.personArray[indexPath.row];
    cell.textLabel.text = infos.name;
    return cell;
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
