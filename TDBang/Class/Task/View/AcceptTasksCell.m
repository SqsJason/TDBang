//
//  AcceptTasksCell.m
//  TDBang
//
//  Created by sunjason on 15/8/6.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "AcceptTasksCell.h"

@implementation AcceptTasksCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentWithTask:(TaskModel *)task
{
    _enTask = task;
    if ([task isKindOfClass:[TaskModel class]]) {
        NSDictionary *dicTemp = task.createUser;
        [_imvHead setImage_oy:nil image:[dicTemp objectForKeyNotNull:@"headFilePath"]];
        
        _lblTitle.text = task.name;
        NSDictionary *dicOther = task.other;
        if (![Jxb_Common_Common isNullOrNilObject:[dicOther objectForKeyNotNull:@"signCount"]]) {
            _lblDescribe.text = [NSString stringWithFormat:@"已经有%@位小伙伴接单",[dicOther objectForKeyNotNull:@"signCount"]];
        }else{
            _lblDescribe.text = @"暂时还没有小伙伴接单";
        }
        _lblPayment.text = [NSString stringWithFormat:@"%@%@",[dicOther objectForKeyNotNull:@"fmPayForMoney"],[dicOther objectForKeyNotNull:@"fmPayForDesc"]];
        NSInteger iStatus = [task.status integerValue];
        NSString *strStatus;
        switch (iStatus) {
            case 1:
                strStatus = @"未支付";
                break;
            case 2:
                strStatus = @"正在接单";
                break;
            case 3:
                strStatus = @"正在执行";
                break;
            case 4:
                strStatus = @"任务已截止";
                break;
            case 5:
                strStatus = @"任务已删除";
                break;
                
            default:
                break;
        }
        _lblStatus.text = strStatus;
        _lblDateTime.text = [task.createDate substringToIndex:10];
    }
}

@end
