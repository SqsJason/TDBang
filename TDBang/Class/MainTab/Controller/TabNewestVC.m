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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyData) name:NotiTypeUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyData) name:NotiTypeUserLogout object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNewest) name:kDidNotifyReloadNewest object:nil];
    
    if (![OyTool ShardInstance].bIsForReview)
    {
        dicTypeName = @{@"0":@"全部分类▽",@"100":@"手机数码▽",@"106":@"电脑办公▽",@"104":@"家用电器▽",@"2":@"化妆个护▽",@"222":@"钟表首饰▽",@"312":@"其他商品▽"};
    }
    else
    {
        dicTypeName = @{@"104":@"家用电器▽",@"2":@"化妆个护▽",@"222":@"钟表首饰▽",@"312":@"其他商品▽"};
    }
    
    __weak typeof (self) wSelf = self;
    
    tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor hexFloatColor:@"e6eaea"];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tbView];

    if([OyTool ShardInstance].bIsForReview)
        iCodeType =  [[dicTypeName.allKeys objectAtIndex:0] intValue];
    else
        iCodeType = 0;
    [tbView addPullToRefreshWithActionHandler:^{
        __strong typeof (wSelf) sSelf = wSelf;
        sSelf->curPage = 1;
        [wSelf getData:^{
            sSelf->listNew = nil;
        }];
    }];
    
    [tbView addInfiniteScrollingWithActionHandler:^{
        __strong typeof (wSelf) sSelf = wSelf;
        sSelf->curPage ++;
        [wSelf getData:nil];
    }];
    
    [tbView.pullToRefreshView setOYStyle];
    [tbView triggerPullToRefresh];
    
    AllProTypeView* tview = [[AllProTypeView alloc] initWithFrame:self.view.bounds];
    tview.delegate = self;
    
    dropdownView = [[LMDropdownView alloc] init];
    dropdownView.contentBackgroundColor = [UIColor whiteColor];
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
    [tbView reloadData];
}


#pragma mark - right button action
- (void)btnRightAction
{
    if ([dropdownView isOpen])
    {
        [dropdownView hide];
    }
    else
    {
        [tbView reloadData];
        [dropdownView showInView:self.view withContentView:tbView atOrigin:CGPointMake(0, 0)];
    }

}

#pragma mark - notify
- (void)reloadNewest
{
    [NewestModel getAllNewest:iCodeType page:curPage size:10 index:1 success:^(AFHTTPRequestOperation* operation, NSObject* result){
        NewestProList* list = [[NewestProList alloc] initWithDictionary:(NSDictionary*)result];
        listNew =  [NSMutableArray arrayWithArray:list.Rows];
        [tbView reloadData];
    } failure:^(NSError* error){
        //[[XBToastManager ShardInstance] showtoast:[NSString stringWithFormat:@"获取最新揭晓页面数据异常:%@",error]];
    }];
}

#pragma mark - getdata
- (void)getData:(void (^)(void))block
{
    [NewestModel getAllNewest:iCodeType page:curPage size:10 index:(curPage-1)*10+1 success:^(AFHTTPRequestOperation* operation, NSObject* result){
        [tbView.pullToRefreshView stopAnimating];
        [tbView.infiniteScrollingView stopAnimating];
        if(block!=NULL)
            block();
        NewestProList* list = [[NewestProList alloc] initWithDictionary:(NSDictionary*)result];
        if (!listNew)
        {
            listNew = [NSMutableArray arrayWithArray:list.Rows];
        }
        else
        {
            [listNew addObjectsFromArray:list.Rows];
        }
        [tbView reloadData];
        [tbView setShowsInfiniteScrolling:listNew.count<[list.count integerValue]];
    } failure:^(NSError* error){
        [tbView.pullToRefreshView stopAnimating];
        [tbView.infiniteScrollingView stopAnimating];
    }];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2)
        return 60;
    return 44;
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 150;
    if (section == 1 || section == 2)
        return 35;
    return 15;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if ([[Sessions sharedInstance] isUserOnline])
        {
            MineUserView* v = [[MineUserView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 150)];
            if ([[Sessions sharedInstance].userInfoModel isKindOfClass:[ENUserInfo class]]) {
                [v setUserBasicInfo:[Sessions sharedInstance].userInfoModel hideJiFenButton:YES];
            }else{
                [[Sessions sharedInstance] isUserOnline];
            }
            return v;
        }
        else
        {
            MineLoginView* v = [[MineLoginView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 150)];
            [v setButtonsHide:YES];
            return v;
        }
    }
    if (section == 1 || section == 2)
    {
        UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 35)];
        headV.backgroundColor = [UIColor clearColor];
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, mainWidth-30, 35)];
        if (section == 1) {
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
    if (indexPath.section == 3) {
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
    }else{
        static NSString *CellIdentifier = @"homeNewCell";
        HomeNewCell *cell = (HomeNewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[HomeNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setDelegate:self];
        
        if (indexPath.section == 0) {
            [cell setHolderButtonImage_O:@"icon_yifarenwu"
                                 Title_O:@"已发任务"
                                 Image_T:@"icon_yijierenwu"
                                 Title_T:@"已接任务"
                                     tag:0];
        }else if (indexPath.section == 1){
            [cell setHolderButtonImage_O:@"icon_wodepinglun"
                                 Title_O:@"我的评论"
                                 Image_T:@"icon_tadepinglun"
                                 Title_T:@"他的评论"
                                     tag:1];
        }else if(indexPath.section == 2){
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
        [self.navigationController pushViewController:acceptVC animated:YES];
    }
}

@end
