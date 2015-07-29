//
//  ReleaseTaskVC.m
//  TDBang
//
//  Created by sunjason on 15/7/29.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "ReleaseTaskVC.h"

@interface ReleaseTaskVC ()

@property (nonatomic, strong) NSArray *arrCells;

@end

@implementation ReleaseTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _arrCells = @[_titleCell,
                  _inputContentCell,
                  _taskInfoCell,
                  _taskName,
                  _taskPaymentCell,
                  _taskSalary,
                  _taskPeopleCell,
                  _taskTiimeCell,
                  _taskDateCell,
                  _taskPlaceCell,
                  _taskConnectCell];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *vHead;
    if (section == 1) {
        vHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 1)];
        vHead.backgroundColor = [UIColor hexFloatColor:@"a6a6a6"];
    }
    return vHead;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vHead;
    if (section == 1) {
        vHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 0.1)];
        vHead.backgroundColor = [UIColor hexFloatColor:@"f6f6f6"];
    }
    return vHead;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(UITableView *)[_arrCells objectAtIndex:indexPath.row] frame].size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_arrCells objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (IBAction)actionStartTime:(id)sender {
}

- (IBAction)actionEndTime:(id)sender {
}

- (IBAction)actionStartDate:(id)sender {
}

- (IBAction)actionEndDate:(id)sender {
}
@end
