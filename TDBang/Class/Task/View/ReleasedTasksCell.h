//
//  ReleasedTasksCell.h
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryTasksModel.h"

@protocol ReleasedTasksDelegate <NSObject>

- (void)manageAction:(TaskModel *)task;

@end

@interface ReleasedTasksCell : UITableViewCell

@property (nonatomic, strong) id<ReleasedTasksDelegate> delegate;
@property (nonatomic, strong) TaskModel *enTask;

@property (weak, nonatomic) IBOutlet UIImageView *imvUserHead;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPeopleSign;
@property (weak, nonatomic) IBOutlet UILabel *lblPayment;
@property (weak, nonatomic) IBOutlet UILabel *lblTaskStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblReleaseDate;

@property (weak, nonatomic) IBOutlet UIButton *btnPeopleSign;
- (IBAction)actionPeopleSign:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnManage;
- (IBAction)actionManage:(id)sender;

- (void)setContentWithTask:(TaskModel *)task;

@end
