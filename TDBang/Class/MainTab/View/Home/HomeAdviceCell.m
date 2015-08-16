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
    [_imvAdviceIcon setImage_oy:nil image:[dicCreateUser objectForKey:@"headFilePath"]];
    [_lblTitle setText:taskDetil.name];
    
    NSDictionary *dicOther = taskDetil.other;
    int count = [[dicOther objectForKey:@"fmZhaopinCount"] intValue] - [[dicOther objectForKey:@"signCount"] intValue];
    _lblPayment.text  = [NSString stringWithFormat:@"%@%@",[dicOther objectForKey:@"fmPayForMoney"],[dicOther objectForKey:@"fmPayForDesc"]];
    _lblDateTime.text = [NSString stringWithFormat:@"招聘%@人/剩余%@人",[dicOther objectForKey:@"fmZhaopinCount"],[NSString stringWithFormat:@"%d",count]];
    
    if (![Jxb_Common_Common isNullOrNilObject:[dicOther objectForKey:@"distanceStr"]]) {
        _lblDistance.text = [NSString stringWithFormat:@"%@",[dicOther objectForKey:@"distanceStr"]];
    }
}

@end
