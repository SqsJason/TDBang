//
//  oneConmentCell.h
//  TDBang
//
//  Created by sunjason on 15/7/26.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryComment.h"

@interface oneConmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *lblConment;

- (void) setContentWithCommentModel:(TaskCommentModel *)comment;

@end
