//
//  TabNewestVC.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/18.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "TabNewestVC.h"
#import "HomeInstance.h"
#import "NewestingCell.h"
#import "NewestedCell.h"
#import "NewestModel.h"
#import "AllProTypeView.h"
#import "ProductLotteryVC.h"
#import "ProductDetailVC.h"
#import "MineLoginView.h"
#import "HomeNewCell.h"
#import "TaskDetailVC.h"
#import "MineUserView.h"
#import "QueryReleasedTaskVC.h"
#import "QueryAcceptVC.h"
#import "ManageHeadCell.h"

@interface TabNewestVC ()
<
UITableViewDataSource,
UITableViewDelegate,
AllProTypeViewDelegate,
HomeNewCellDelegate,
HomeNewCellDelegate
>
{
    LMDropdownView  *dropdownView;
    
    __block UITableView     *tbView;
    __block int             curPage;
    __block int             iCodeType;
    __block NSMutableArray  *listNew;
    
    NSArray                 *arrOfTypeImage;
    UIButton                *btnRigth;
    
    NSDictionary            *dicTypeName;
}
@end

@implementation TabNewestVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotiTypeUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotiTypeUserLogout object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyDataAll) name:NotiTypeUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyData) name:NotiTypeUserLogout object:nil];
    
    tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor hexFloatColor:@"e6eaea"];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tbView];
}

- (void)actionCustomNavBtn:(UIButton *)btn nrlImage:(NSString *)nrlImage
                  htlImage:(NSString *)hltImage
                     title:(NSString *)title {
    [btn setImage:[UIImage imageNamed:nrlImage] forState:UIControlStateNormal];
    if (hltImage) {
        [btn setImage:[UIImage imageNamed:hltImage] forState:UIControlStateHighlighted];
    } else {
        [btn setImage:[UIImage imageNamed:nrlImage] forState:UIControlStateNormal];
    }
    if (title) {
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    [btn sizeToFit];
}

#pragma mark - load data
/**
 *  刷新数据
 */
- (void)refreshMyData
{
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [tbView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)refreshMyDataAll
{
    [tbView reloadData];
}


#pragma mark - right button action
- (void)btnRightAction{}

#pragma mark - notify
- (void)reloadNewest{}

#pragma mark - getdata
- (void)getData:(void (^)(void))block
{}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3)
        return 60;
    return 44;
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
        return 0;
    if (section == 2 || section == 3)
        return 35;
    return 15;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3)
    {
        UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 35)];
        headV.backgroundColor = [UIColor clearColor];
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, mainWidth-30, 35)];
        if (section == 2) {
            lblTitle.text = @"任务评论";
        }else{
            lblTitle.text = @"投诉与建议";
        }
        lblTitle.font = [UIFont systemFontOfSize:16];
        lblTitle.textColor = [UIColor darkGrayColor];
        
        [headV addSubview:lblTitle];
        
        return headV;
    }
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 20)];
    headV.backgroundColor = [UIColor clearColor];
    return headV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        UITableViewCell *cell =  nil;
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] init];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString* title = nil;
        NSString* image = nil;
        title = @"系统公告";
        image = @"home_btn_new";
        cell.textLabel.text = [NSString stringWithFormat:@"        %@",title];
        
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 24, 24)];
        img.image = [UIImage imageNamed:image];
        [cell addSubview:img];
        
        return cell;
    }else if (indexPath.section == 0){
        ManageHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManageHeadCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ManageHeadCell" owner:self options:nil] lastObject];
        if ([[Sessions sharedInstance] isUserOnline])
        {
            cell.btnLoginNow.hidden = YES;
            cell.lblUserDescribe.hidden = NO;
            if ([[Sessions sharedInstance].userInfoModel isKindOfClass:[ENUserInfo class]]) {
                cell.lblUseName.text = [NSString stringWithFormat:@"欢迎您,%@",[Sessions sharedInstance].userInfoModel.nickName];
                cell.lblUserDescribe.text = [Sessions sharedInstance].userInfoModel.userDesc;
                [cell.imUserHead setImage_oy:nil image:[Sessions sharedInstance].userInfoModel.headFilePath];
            }
        }else
        {
            cell.btnLoginNow.hidden = NO;
            cell.lblUserDescribe.hidden = YES;
            cell.lblUseName.text = @"您还没有登陆哦~";
            cell.lblUserDescribe.text = [Sessions sharedInstance].userInfoModel.userDesc;
            [cell.imUserHead setImage:[UIImage imageNamed:@"photo_login"]];
        }
        return cell;
    }else{
        static NSString *CellIdentifier = @"homeNewCell";
        HomeNewCell *cell = (HomeNewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[HomeNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setDelegate:self];
        
        if (indexPath.section == 1) {
            [cell setHolderButtonImage_O:@"icon_yifarenwu"
                                 Title_O:@"已发任务"
                                 Image_T:@"icon_yijierenwu"
                                 Title_T:@"已接任务"
                                     tag:0];
        }else if (indexPath.section == 2){
            [cell setHolderButtonImage_O:@"icon_wodepinglun"
                                 Title_O:@"我的评论"
                                 Image_T:@"icon_tadepinglun"
                                 Title_T:@"他的评论"
                                     tag:1];
        }else if(indexPath.section == 3){
            [cell setHolderButtonImage_O:@"icon_tousu"
                                 Title_O:@"投诉"
                                 Image_T:@"icon_jianyi"
                                 Title_T:@"建议"
                                     tag:2];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - type view delegate
- (void)selectedTypeCode:(int)code{}

-(void)doClickGoods:(int)goodsId codeId:(int)codeId{}

- (void)firstItemClicked:(UIButton *)sender
{
    if (sender.tag == 0) {
        QueryReleasedTaskVC *releaseTask = [[QueryReleasedTaskVC alloc] initWithNibName:@"QueryReleasedTaskVC" bundle:nil];
        releaseTask.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:releaseTask animated:YES];
    }
}

- (void)secondItemClicked:(UIButton *)sender;
{
    if (sender.tag == 0) {
        QueryAcceptVC *acceptVC = [[QueryAcceptVC alloc] initWithNibName:@"QueryAcceptVC" bundle:nil];
        acceptVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:acceptVC animated:YES];
    }
}

@end
