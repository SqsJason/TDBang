//
//  UserBasicInfoVC.h
//  TDBang
//
//  Created by sunjason on 15/7/30.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"

@interface UserBasicInfoVC : OneBaseVC

@property (strong, nonatomic) IBOutlet UITableViewCell *UserInfoTitleCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *BasicInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *PhoneNumberCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *UserNameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *UserAgeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *UserGenderCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *ComponyNameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *UserDescribeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *ReleaseTaskCell;


@end
