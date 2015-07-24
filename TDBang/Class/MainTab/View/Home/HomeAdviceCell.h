//
//  HomeAdviceCell.h
//  TDBang
//
//  Created by sunjason on 15/7/22.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeAdviceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imvAdviceIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintsTitlePaddingLeft;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
