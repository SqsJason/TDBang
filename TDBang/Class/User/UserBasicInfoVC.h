//
//  UserBasicInfoVC.h
//  TDBang
//
//  Created by sunjason on 15/7/30.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"

@interface UserBasicInfoVC : OneBaseVC
<
    QRadioButtonDelegate
>

@property (strong, nonatomic) IBOutlet UITableViewCell *UserInfoTitleCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *BasicInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *PhoneNumberCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *UserNameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *UserAgeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *UserGenderCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *ComponyNameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *UserDescribeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *ReleaseTaskCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *IndentityCell;

@property (weak, nonatomic) IBOutlet UITextField *tfUserIdentity;
@property (weak, nonatomic) IBOutlet UIImageView *imvUserHead;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserPhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *tfEditUserPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfeditUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfEditUserAge;
@property (weak, nonatomic) IBOutlet UITextField *tfEditUserGender;
@property (weak, nonatomic) IBOutlet UITextField *tfEditUserCompany;
@property (weak, nonatomic) IBOutlet UITextField *tfEditUserDescribe;
@property (weak, nonatomic) IBOutlet UIView *vGender;

@property (weak, nonatomic) IBOutlet UIButton *btnPublic;
- (IBAction)action_saveUserInfo:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *tfChangeIdentity;

@end
