//
//  TaskDetailJobCell.h
//  TDBang
//
//  Created by sunjason on 15/7/25.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaskDetailJobDelegate <NSObject>

- (void)didClickMap;

@end

@interface TaskDetailJobCell : UITableViewCell

@property (nonatomic, strong) id<TaskDetailJobDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblSignCount;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftCount;
@property (weak, nonatomic) IBOutlet UILabel *lblTaskName;
@property (weak, nonatomic) IBOutlet UILabel *lblPayment;
@property (weak, nonatomic) IBOutlet UILabel *lblWantCount;
@property (weak, nonatomic) IBOutlet UILabel *lblWorkDate;
@property (weak, nonatomic) IBOutlet UILabel *lblWorkTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTaskLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imvStatusIcon;
@property (weak, nonatomic) IBOutlet UIButton *btnMap;

- (IBAction)actionMapClick:(id)sender;

- (void)setContent:(TaskModel *)task;

@end
