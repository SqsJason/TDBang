//
//  HomeAdviceCell.m
//  TDBang
//
//  Created by sunjason on 15/7/22.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "HomeAdviceCell.h"

@implementation HomeAdviceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(TaskModel *)taskDetil
{
    NSDictionary *dicCreateUser = taskDetil.createUser;
    [_imvBigPhoto setImage_oy:nil image:[dicCreateUser objectForKey:@"headFilePath"]];
    [_lblTitle setText:taskDetil.name];
    
    NSDictionary *dicOther = taskDetil.other;
    int count = [[dicOther objectForKey:@"fmZhaopinCount"] intValue] - [[dicOther objectForKey:@"signCount"] intValue];
    _lblPayment.text  = [NSString stringWithFormat:@"%@%@",[dicOther objectForKey:@"fmPayForMoney"],[dicOther objectForKey:@"fmPayForDesc"]];
    if (count < 0) {
        count = 0;
    }
    _lblDateTime.text = [NSString stringWithFormat:@"招聘%@人/剩余%@人",[dicOther objectForKey:@"fmZhaopinCount"],[NSString stringWithFormat:@"%d",count]];
    
    if (![Jxb_Common_Common isNullOrNilObject:[dicOther objectForKey:@"distanceStr"]]) {
        _lblDistance.text = [NSString stringWithFormat:@"%@",[dicOther objectForKey:@"distanceStr"]];
    }

    NSString *strName;
    switch ([taskDetil.status integerValue]) {
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
    _imvStatusImage.image = [UIImage imageNamed:strName];
}

@end
