//
//  TaskDetailVC.m
//  TDBang
//
//  Created by sunjason on 15/7/24.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "TaskDetailVC.h"

@interface TaskDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TaskDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 3;
            break;
        case 4:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return indexPath.row == 0 ? 150:175;
    }
    if (indexPath.section == 1 && indexPath.row == 0)
        return 34;
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 2)
        return 0.1;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section) {
        case 0:
        {
            if (row == 0) {
                
            }else{
                
            }
        }
            break;
        case 1:
        {
            if (row == 0) {
                
            }else{
                
            }
        }
            break;
        case 2:
        {
            if (row == 0) {
                
            }else{
                
            }
        }
            break;
        case 3:
        {
            if (row == 0) {
                
            }else if(row == 1){
                
            }else{
                
            }
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    return [(UITableViewCell *)[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


#pragma mark - delegate;
- (void)adClick:(NSString *)key
{
    
}

- (void)btnHomeClick:(int)index
{
    
}

@end
