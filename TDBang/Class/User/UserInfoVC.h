//
//  UserInfoVC.h
//  TDBang
//
//  Created by sunjason on 15/7/28.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"
#import "UserInfoModel.h"

@interface UserInfoVC : OneBaseVC<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvUserInfo;

@property (strong, nonatomic) IBOutlet UITableViewCell *TitleImageCell;
@property (weak, nonatomic) IBOutlet UIImageView *imv_TitleImage;
@property (weak, nonatomic) IBOutlet UIView *vTitleCreditHolder;
@property (weak, nonatomic) IBOutlet UIView *vTitleServiceHolder;

@property (strong, nonatomic) IBOutlet UITableViewCell *TwoButtonsCell;
@property (weak, nonatomic) IBOutlet UIButton *btnHoleTasks;
- (IBAction)actionHoleTasks:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnUpcomingTasks;
- (IBAction)actionUpcomingTasks:(id)sender;

@property (strong, nonatomic) IBOutlet UITableViewCell *BasicInfoCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *PhoneNumberCell;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;


@property (strong, nonatomic) IBOutlet UITableViewCell *UserNameCell;
@property (weak, nonatomic) IBOutlet UITextField *tfUserName;


@property (strong, nonatomic) IBOutlet UITableViewCell *UserAgeCell;
@property (weak, nonatomic) IBOutlet UITextField *tfUserAge;


@property (strong, nonatomic) IBOutlet UITableViewCell *UserGenderCell;
@property (weak, nonatomic) IBOutlet UITextField *tfUserGender;


@property (strong, nonatomic) IBOutlet UITableViewCell *CompanyDetailCell;
@property (weak, nonatomic) IBOutlet UITextField *tfCompanyDescribe;

@property (strong, nonatomic) IBOutlet UITableViewCell *OwnDecribeCell;
@property (weak, nonatomic) IBOutlet UITextField *tfOwnDescribe;


@property (nonatomic, strong) ENUserInfo *userInfo;

@property (weak, nonatomic) IBOutlet UILabel *lblCredit;
@property (weak, nonatomic) IBOutlet UILabel *lblService;

@end
