//
//  TaskCommentCell.m
//  TDBang
//
//  Created by sunjason on 15/8/17.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "TaskCommentCell.h"

@implementation TaskCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentWithCommentModel:(TaskCommentModel *)commentModel
{
    if ([commentModel isKindOfClass:[TaskCommentModel class]]) {
        NSDictionary *dicUser = commentModel.user;
        [_imvUserHead setImage_oy:nil image:[dicUser objectForKeyNotNull:@"headFilePath"]];
        _lblNickName.text = [dicUser objectForKeyNotNull:@"nickName"];
        
        _lblComment.text = commentModel.content;
        
         NSDictionary *dicTask = commentModel.task;
        _lblTaskName.text = [dicTask objectForKeyNotNull:@"name"];
    }
}

- (void)updateConstraints
{
    _lblComment.preferredMaxLayoutWidth = mainWidth - 70;
    [super updateConstraints];
}

@end
