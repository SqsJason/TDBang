//
//  ManageHeadCell.m
//  TDBang
//
//  Created by sunjason on 15/8/16.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "ManageHeadCell.h"

@implementation ManageHeadCell

- (void)awakeFromNib {
    // Initialization code
    self.imUserHead.layer.cornerRadius = 30;
    self.imUserHead.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
