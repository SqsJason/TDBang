//
//  TaskDetailVC.h
//  TDBang
//
//  Created by sunjason on 15/7/24.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskDetailVC : OneBaseVC

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UITableViewCell *conmentCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *moreConmentCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *noticeCell;

@property (strong, nonatomic) TaskModel *taskModel;

@property (weak, nonatomic) IBOutlet UIButton *btnWantEnroll;
- (IBAction)wantEnrollAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnWantComplaint;
- (IBAction)wantComplaintAction:(id)sender;

@end
