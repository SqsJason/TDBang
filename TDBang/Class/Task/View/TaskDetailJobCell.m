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
    
    NSString *strName;
    switch ([task.status integerValue]) {
        case TASK_STATUS_baoming_pre:
            strName = @"icon_task_status_zhifu";
            break;
        case TASK_STATUS_BaoMing_ing:
            strName = @"icon_task_status_baoming";
            break;
        case TASK_STATUS_START_ing:
            strName = @"icon_task_status_start_ing";
            break;
        case TASK_STATUS_END:
            strName = @"icon_task_status_wancheng";
            break;
        case TASK_STATUS_DELETE:
            strName = @"";
            break;
            
        default:
            strName = @"";
            break;
    }
    _imvStatusIcon.image = [UIImage imageNamed:strName];
}

- (IBAction)actionMapClick:(id)sender {
}
@end
