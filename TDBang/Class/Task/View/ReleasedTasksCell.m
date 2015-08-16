//
//  ReleasedTasksCell.m
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "ReleasedTasksCell.h"

@implementation ReleasedTasksCell
@synthesize delegate;

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
        [_imvUserHead setImage_oy:nil image:[dicTemp objectForKeyNotNull:@"headFilePath"]];
        
        _lblTitle.text = task.name;
        NSDictionary *dicOther = task.other;
        _lblPeopleSign.text = [NSString stringWithFormat:@"已经有%@位小伙伴接单",[dicOther objectForKeyNotNull:@"signCount"]];
        [_btnPeopleSign setTitle:[NSString stringWithFormat:@"已经有%@位小伙伴接单",[dicOther objectForKeyNotNull:@"signCount"]] forState:UIControlStateNormal];
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
        _lblTaskStatus.text  = strStatus;
        _lblReleaseDate.text = [task.createDate substringToIndex:10];
    }
}

- (IBAction)actionPeopleSign:(id)sender {
    
}
- (IBAction)actionManage:(id)sender {
    if (!delegate && [delegate respondsToSelector:@selector(manageAction:)]) {
        [delegate manageAction:_enTask];
    }
}
@end
