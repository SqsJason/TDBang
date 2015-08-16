//
//  TabMineVC.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/18.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "TabMineVC.h"
#import "LoginVC.h"
#import "UserModel.h"
#import "UserInstance.h"
#import "MineLoginView.h"
#import "MineUserView.h"
#import "MineBuylistVC.h"
#import "MineMyOrderVC.h"
#import "MineShowOrderVC.h"
#import "MineMoneyDetailVC.h"
#import "MineMyAddressVC.h"
#import "SettingVC.h"
#import "MineRechargeVC.h"
#import "UserBasicInfoVC.h"
#import "ChangePasswordVC.h"

@interface TabMineVC () <UITableViewDataSource,UITableViewDelegate,MineLoginViewDelegate,MineUserViewDelegate>
{
    __block UITableView     *tbView;
    
    NSArray *arrTitles;
    NSArray *arrImages;
}
@end

@implementation TabMineVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UserInstance ShardInstnce] isUserStillOnline];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotiTypeUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotiTypeUserUpdateInfo object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginOk) name:NotiTypeUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginOk) name:NotiTypeUserUpdateInfo object:nil];
    
    self.title = @"我的";
    
    arrTitles = @[@"基本资料",@"我的银行卡",@"账户充值",@"余额提现",@"修改密码"];
    arrImages = @[@"me1",@"me2",@"me3",@"me6",@"me7"];//@"me4",@"me5",
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 10, 50, 40)];
    [rightBtn setTitle:@"退出" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn addTarget:self action:@selector(gotoLogin) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
    tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tbView];
}

- (void)gotoLogin
{
    [[Sessions sharedInstance] logout];
    [self didLoginOk];
}

- (void)didLoginOk
{
    [tbView reloadData];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 160;
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if ([[Sessions sharedInstance] isUserOnline])
        {
            MineUserView* v = [[MineUserView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 150)];
            v.delegate = self;
            if ([[Sessions sharedInstance].userInfoModel isKindOfClass:[ENUserInfo class]]) {
                [v setUserBasicInfo:[Sessions sharedInstance].userInfoModel hideJiFenButton:NO];
            }else{
                [[Sessions sharedInstance] isUserOnline];
            }
            return v;
        }
        else
        {
            MineLoginView* v = [[MineLoginView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 150)];
            [v setButtonsHide:NO];
            v.delegate = self;
            return v;
        }
    }else{
        UIView *sectionHeaderV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 10)];
        return sectionHeaderV;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =  nil;
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] init];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString* title = nil;
    NSString* image = nil;
    title = [arrTitles objectAtIndex:indexPath.section];
    image = [arrImages objectAtIndex:indexPath.section];
    cell.textLabel.text = [NSString stringWithFormat:@"        %@",title];
    
    UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 24, 24)];
    img.image = [UIImage imageNamed:image];
    [cell addSubview:img];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        UserBasicInfoVC* vc = [[UserBasicInfoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1)
    {
//        MineMyOrderVC* vc = [[MineMyOrderVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2)
    {
//        MineShowOrderVC* vc = [[MineShowOrderVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 3)
    {
//        MineMoneyDetailVC* vc = [[MineMoneyDetailVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 4)
    {
        ChangePasswordVC *changePwd = [[ChangePasswordVC alloc] initWithNibName:@"ChangePasswordVC" bundle:nil];
        changePwd.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changePwd animated:YES];
    }
}

#pragma mark - login view delegate
- (void)doLogin
{
    [[Sessions sharedInstance] gotoLogin:self];
}

- (void)btnPayAction
{
    SCLAlertView* alert = [[SCLAlertView alloc] init];
    alert.showAnimationType = FadeIn;
    [alert showWarning:self.tabBarController title:@"提示" subTitle:@"请前往官方网站完成充值" closeButtonTitle:@"好的" duration:0];
}
@end
