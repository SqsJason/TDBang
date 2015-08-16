//
//  AcceptTasksCell.h
//  TDBang
//
//  Created by sunjason on 15/8/6.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryTasksModel.h"

@interface AcceptTasksCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imvHead;
@property (weak, nonatomic) IBOutlet UILabel *lblDescribe;
@property (weak, nonatomic) IBOutlet UILabel *lblPayment;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (nonatomic, strong) TaskModel *enTask;

- (void)setContentWithTask:(TaskModel *)task;

@end
