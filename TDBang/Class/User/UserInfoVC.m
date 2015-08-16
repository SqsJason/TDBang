//
//  UserInfoVC.m
//  TDBang
//
//  Created by sunjason on 15/7/28.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "UserInfoVC.h"

@interface UserInfoVC ()
{
    NSMutableArray *arrTextFields;
}

@end

@implementation UserInfoVC
@synthesize userInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"管理中心";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    _tvUserInfo.backgroundColor = [UIColor hexFloatColor:@"f6f6f6"];
    _imv_TitleImage.layer.cornerRadius = 40.0;
    _imv_TitleImage.layer.masksToBounds = YES;
    
    if (arrTextFields == nil) {
        arrTextFields = [[NSMutableArray alloc] init];
    }else{
        [arrTextFields removeAllObjects];
    }
    
    [_imv_TitleImage setImage_oy:nil image:userInfo.headFilePath];
    
    _tfPhoneNumber.text = userInfo.tel;
    _tfUserAge.text = userInfo.age;
    _tfUserName.text = userInfo.nickName;
    _tfUserGender.text = userInfo.sex;
    _tfCompanyDescribe.text = userInfo.companyName;
    _tfOwnDescribe.text = userInfo.userDesc;
    
    _lblCredit.text = [NSString stringWithFormat:@"信用: %@颗星",userInfo.xinyongStar];
    _lblService.text = [NSString stringWithFormat:@"服务: %@颗星",userInfo.fuwuStar];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }else{
        return  0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vHead;
    if (section == 1) {
        vHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 10)];
        vHead.backgroundColor = [UIColor hexFloatColor:@"f6f6f6"];
    }
    return vHead;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 120;
        }else{
            return 44;
        }
    }else{
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else{
        return 7;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return _TitleImageCell;
        }else{
            return _TwoButtonsCell;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                return _BasicInfoCell;
                break;
            case 1:
                return _PhoneNumberCell;
                break;
            case 2:
                return _UserNameCell;
                break;
            case 3:
                return _UserAgeCell;
                break;
            case 4:
                return _UserGenderCell;
                break;
            case 5:
                return _CompanyDetailCell;
                break;
            case 6:
                return _OwnDecribeCell;
                break;
                
            default:
                return [[UITableViewCell alloc] init];
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)actionHoleTasks:(id)sender {
}
- (IBAction)actionUpcomingTasks:(id)sender {
}
@end
