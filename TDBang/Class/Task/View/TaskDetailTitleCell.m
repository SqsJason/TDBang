//
//  TaskDetailTitleCell.m
//  TDBang
//
//  Created by sunjason on 15/7/24.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "TaskDetailTitleCell.h"

@implementation TaskDetailTitleCell
@synthesize delegate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(TaskModel *)task
{
    NSDictionary *dicCreateUser = task.createUser;
    _lblUserName.text = [dicCreateUser objectForKey:@"nickName"];
    [_imvUserHead setImage_oy:nil image:[dicCreateUser objectForKey:@"headFilePath"]];
}

- (IBAction)actionQueryAllTasks:(id)sender {
    [delegate didClickQueryAllTasks];
}

- (IBAction)actionQueryAllAcceptTasks:(id)sender {
    [delegate didClickQueryAllAcceptTasks];
}
@end
