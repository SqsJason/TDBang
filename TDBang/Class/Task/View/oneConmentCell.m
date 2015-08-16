//
//  oneConmentCell.m
//  TDBang
//
//  Created by sunjason on 15/7/26.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "oneConmentCell.h"

@implementation oneConmentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setContentWithCommentModel:(TaskCommentModel *)comment
{
    NSDictionary *userDic = comment.user;
    [_imvHeadImage setImage_oy:nil image:[userDic objectForKeyNotNull:@"headFilePath"]];
    _lblConment.text = comment.content;
}

- (void)updateConstraints{
    _lblConment.preferredMaxLayoutWidth = mainWidth - 75;
    [super updateConstraints];
}

@end
