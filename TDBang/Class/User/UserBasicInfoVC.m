//
//  UserBasicInfoVC.m
//  TDBang
//
//  Created by sunjason on 15/7/30.
//  Copyright (c) 2015年 tengdabang. All rights reserved.

#import "UserBasicInfoVC.h"
#import "ChangeUserInfoModel.h"

@interface UserBasicInfoVC ()
{
    NSMutableArray *arrTextFields;
    NSString *currentGender;
}

@property (nonatomic, strong) NSArray *arrCells;

@end

@implementation UserBasicInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"用户基本资料";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    _imvUserHead.layer.cornerRadius  = _imvUserHead.frame.size.width/2;
    _imvUserHead.layer.masksToBounds = YES;
    
    _arrCells = @[
                   _BasicInfoCell,
                   _PhoneNumberCell,
                   _IndentityCell,
                   _UserNameCell,
                   _UserAgeCell,
                   _UserGenderCell,
                   _ComponyNameCell,
                   _UserDescribeCell,
                   _ReleaseTaskCell
                  ];
    
    
    _btnPublic.layer.cornerRadius = 5.0;
    _btnPublic.layer.masksToBounds = YES;
    
    
    QRadioButton *rbMale = [[QRadioButton alloc] initWithDelegate:self groupId:@"1"];
    rbMale.tag = 1;
    rbMale.frame = CGRectMake(10, 2, 70, 40);
    [rbMale setTitle:@"男" forState:UIControlStateNormal];
    [rbMale setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rbMale.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
    [self.vGender addSubview:rbMale];
    [rbMale setChecked:YES];
    
    QRadioButton *rbFemale = [[QRadioButton alloc] initWithDelegate:self groupId:@"1"];
    rbFemale.tag = 0;
    rbFemale.frame = CGRectMake(90, 2, 70, 40);
    [rbFemale setTitle:@"女" forState:UIControlStateNormal];
    [rbFemale setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rbFemale.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
    [self.vGender addSubview:rbFemale];
    
    if ([[Sessions sharedInstance].userInfoModel.sex isEqualToString:@"女"]) {
        currentGender = @"0";
        [rbFemale setChecked:YES];
    }else{
        currentGender = @"1";
        [rbMale setChecked:YES];
    }
    
    arrTextFields = [NSMutableArray array];
    __weak typeof (self) sSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [arrTextFields addObject:sSelf.tfChangeIdentity];
        [arrTextFields addObject:sSelf.tfEditUserPhone];
        [arrTextFields addObject:sSelf.tfeditUserName];
        [arrTextFields addObject:sSelf.tfEditUserAge];
        [arrTextFields addObject:sSelf.tfEditUserCompany];
        [arrTextFields addObject:sSelf.tfEditUserDescribe];
    });
}

- (void) hideAllKeyboards
{
    for (UITextField *tf in arrTextFields) {
        if ([tf isFirstResponder]) {
            [tf resignFirstResponder];
            break;
        }
        
    }
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
        return 120;
    }else{
        return [(UITableViewCell *)[_arrCells objectAtIndex:indexPath.row] frame].size.height;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return _arrCells.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([Sessions sharedInstance].userInfoModel != nil) {
        [_imvUserHead setImage_oy:nil image:[Sessions sharedInstance].userInfoModel.headFilePath];
        _lblUserName.text           = [Sessions sharedInstance].userInfoModel.nickName;
        _lblUserPhoneNum.text       = [Sessions sharedInstance].userInfoModel.tel;
        _tfEditUserPhone.text       = [Sessions sharedInstance].userInfoModel.tel;
        _tfChangeIdentity.text      = [Sessions sharedInstance].userInfoModel.serialId;
        _tfeditUserName.text        = [Sessions sharedInstance].userInfoModel.nickName;
        _tfEditUserAge.text         = [Sessions sharedInstance].userInfoModel.age;
        _tfEditUserGender.text      = [Sessions sharedInstance].userInfoModel.sex;
        _tfEditUserCompany.text     = [Sessions sharedInstance].userInfoModel.companyName;
        _tfEditUserDescribe.text    = [Sessions sharedInstance].userInfoModel.userDesc;
    }
    if (indexPath.section == 0) {
        return _UserInfoTitleCell;
    }else{
        return [_arrCells objectAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)action_saveUserInfo:(id)sender {
    if(_tfEditUserPhone.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写电话号码"];
        return;
    }
    
    if(_tfChangeIdentity.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写身份证号码"];
        return;
    }
    
    if(_tfeditUserName.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写用户名"];
        return;
    }
    
    if(_tfEditUserAge.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写年龄"];
        return;
    }
    
    if(_tfEditUserGender.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"选择性别"];
        return;
    }
    if(_tfEditUserCompany.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写公司名称"];
        return;
    }
    if(_tfEditUserDescribe.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写自我描述"];
        return;
    }
    
    __weak typeof(self) wSelf = self;
    
    [ChangeUserInfoModel updateUserInfo:_tfEditUserPhone.text
                            identityNum:_tfChangeIdentity.text
                               nickName:_tfeditUserName.text
                                 gender:currentGender
                                    age:_tfEditUserAge.text
                            companyName:_tfEditUserCompany.text
                               userDesc:_tfEditUserDescribe.text
                                success:^(AFHTTPRequestOperation *operation, NSObject *result) {
                                    UpdateUserInfoParser *parser = [[UpdateUserInfoParser alloc] initWithDictionary:(NSDictionary *)result];
                                    if ([parser.success boolValue]) {
                                        [wSelf updateUserInfoSuccess];
                                    }else{
                                        [[XBToastManager ShardInstance] showtoast:parser.result];
                                        if ([parser.result isEqualToString:ErrorLoginFailed]) {
                                            [[Sessions sharedInstance] logout];
                                            [[Sessions sharedInstance] gotoLogin:self];
                                        }
                                    }
                                } failure:^(NSError *error) {
                                    [[XBToastManager ShardInstance] showtoast:@"网络连接异常"];
                                }];
    [self hideAllKeyboards];
}

- (void) updateUserInfoSuccess
{
    [Sessions sharedInstance].userInfoModel.nickName = self.tfeditUserName.text;
    [Sessions sharedInstance].userInfoModel.serialId = self.tfChangeIdentity.text;
    
    [Sessions sharedInstance].userInfoModel.tel = self.tfEditUserPhone.text;
    
    [Sessions sharedInstance].userInfoModel.age = self.tfEditUserAge.text;
    
    [Sessions sharedInstance].userInfoModel.sex = currentGender;
    
    [Sessions sharedInstance].userInfoModel.companyName = self.tfEditUserCompany.text;
    
    [Sessions sharedInstance].userInfoModel.userDesc = self.tfEditUserDescribe.text;
    
    ENUserInfo *userInfo = [Sessions sharedInstance].userInfoModel;
    NSDictionary *dicUserInfo = [[Sessions sharedInstance] propertiesDictionaryOfObject:userInfo withClassType:[ENUserInfo class]];
    [[NSUserDefaults standardUserDefaults] setObject:dicUserInfo forKey:TDBUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiTypeUserUpdateInfo object:nil];
    [[XBToastManager ShardInstance] showtoast:@"信息修改成功"];
}

#pragma mark - QRadioButtonDelegate

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    if ([groupId integerValue] == 1) {
        currentGender = [NSString stringWithFormat:@"%ld",(long)radio.tag];
    }
}

@end
