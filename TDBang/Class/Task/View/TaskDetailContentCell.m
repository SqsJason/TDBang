//
//  TaskDetailContentCell.m
//  TDBang
//
//  Created by sunjason on 15/7/26.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "TaskDetailContentCell.h"

@implementation TaskDetailContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateConstraints{
    _lblContent.preferredMaxLayoutWidth = mainWidth - 30;
    [super updateConstraints];
}

@end
