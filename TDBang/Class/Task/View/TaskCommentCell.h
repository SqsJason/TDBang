//
//  TaskCommentCell.h
//  TDBang
//
//  Created by sunjason on 15/8/17.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryComment.h"

@interface TaskCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvUserHead;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UIView *vTaskHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imvTaskImage;
@property (weak, nonatomic) IBOutlet UILabel *lblTaskName;

- (void)setContentWithCommentModel:(TaskCommentModel *)commentModel;

@end
