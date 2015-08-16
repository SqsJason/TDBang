//
//  TaskDetailJobCell.m
//  TDBang
//
//  Created by sunjason on 15/7/25.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "TaskDetailJobCell.h"

@implementation TaskDetailJobCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(TaskModel *)task
{
    NSDictionary *dicOther = task.other;
    _lblTaskName.text = task.name;
    _lblPayment.text = [NSString stringWithFormat:@"%@ %@",
                        [dicOther objectForKey:@"fmPayForMoney"],
                        [dicOther objectForKey:@"fmPayForDesc"]];
    _lblWantCount.text = [dicOther objectForKey:@"fmZhaopinCount"];
    _lblWorkDate.text = [NSString stringWithFormat:@"%@ ~ %@",
                         [dicOther objectForKey:@"fmStartDate"],
                         [dicOther objectForKey:@"fmEndDate"]];
    _lblWorkTime.text = [NSString stringWithFormat:@"%@ ~ %@",
                         [dicOther objectForKey:@"fmStartTime"],
                         [dicOther objectForKey:@"fmEndTime"]];
    
    _lblTaskLocation.text = [NSString stringWithFormat:@"%@%@%@",task.city,task.dis,task.street];
    _lblAddress.text = [NSString stringWithFormat:@"距离: %@",[dicOther objectForKey:@"distanceStr"]];
}

- (IBAction)actionMapClick:(id)sender {
}
@end
