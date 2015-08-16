//
//  TaskDetailTitleCell.h
//  TDBang
//
//  Created by sunjason on 15/7/24.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaskDetailTitleDelegate <NSObject>

- (void)didClickQueryAllTasks;
- (void)didClickQueryAllAcceptTasks;

@end

@interface TaskDetailTitleCell : UITableViewCell

@property (nonatomic, strong) id<TaskDetailTitleDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imvUserHead;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIView *vStarHolder;

@property (weak, nonatomic) IBOutlet UIButton *btnAllTasks;
@property (weak, nonatomic) IBOutlet UIButton *btnAllAcceptTasks;
- (IBAction)actionQueryAllTasks:(id)sender;
- (IBAction)actionQueryAllAcceptTasks:(id)sender;

- (void)setContent:(TaskModel *)task;

@end
