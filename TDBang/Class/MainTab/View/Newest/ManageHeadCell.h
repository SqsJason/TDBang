//
//  ManageHeadCell.h
//  TDBang
//
//  Created by sunjason on 15/8/16.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imUserHead;
@property (weak, nonatomic) IBOutlet UILabel *lblUseName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserDescribe;

@property (weak, nonatomic) IBOutlet UIButton *btnLoginNow;

@end
