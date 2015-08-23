//
//  TabHomeVC.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/18.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "TabHomeVC.h"
#import "HomeModel.h"
#import "HomeAdCell.h"
#import "HomeAdDigitalCell.h"
#import "HomeAdBtnCell.h"
#import "HomeNewCell.h"
#import "HomeHotCell.h"
#import "HomeOrderShowCell.h"
#import "HomeInstance.h"
#import "SearchVC.h"
#import "MineBuylistVC.h"
#import "UserInstance.h"
#import "LoginVC.h"
#import "TabNewestVC.h"
#import "ProductDetailVC.h"
#import "ProductLotteryVC.h"
#import "ShowOrderListVC.h"
#import "ShowOrderDetailVC.h"
#import "HomeAdviceCell.h"
#import "HomeAdviceTitleCell.h"
#import "TaskDetailVC.h"
#import "GetRecommendTasks.h"
#import "SelectCityVC.h"

/*
 tFont: AppleSDGothicNeo-Bold
 2015-07-20 18:11:21.728 OneYuan[4107:1322037]     tFont: AppleSDGothicNeo-Thin
 2015-07-20 18:11:21.728 OneYuan[4107:1322037]     tFont: AppleSDGothicNeo-UltraLight
 2015-07-20 18:11:21.728 OneYuan[4107:1322037]     tFont: AppleSDGothicNeo-Regular
 2015-07-20 18:11:21.728 OneYuan[4107:1322037]     tFont: AppleSDGothicNeo-Light
 2015-07-20 18:11:21.728 OneYuan[4107:1322037]     tFont: AppleSDGothicNeo-Medium
 2015-07-20 18:11:21.728 OneYuan[4107:1322037]     tFont: AppleSDGothicNeo-SemiBold
 */
#define TitleFont [UIFont fontWithName:@"MicrosoftYaHei-Thin" size:16];//CTXiYuanSJ

@interface TabHomeVC ()<UITableViewDataSource,UITableViewDelegate,HomeAdCellDelegate,HomeAdBtnCellDelegate,HomeAdDigitalCellDelegate,HomeHotCellDelegate,HomeNewCellDelegate,HomeOrderShowCellDelegate>
{
    NSTimer                 *timer;
    UITableView             *tbView;
    __block HomePageList    *listHomepage;
    NSMutableArray          *arrAdvices;
}
@end

@implementation TabHomeVC

- (void)dealloc
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kDidNotifyFromBack object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NotiTypeUserLogin object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NotiTypeUserLogout object:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:nil htlImage:nil title:appDelegate().currentCity action:^{
        SelectCityVC* vc = [[SelectCityVC alloc] initWithNibName:@"SelectCityVC" bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [wSelf.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyData) name:kDidNotifyFromBack object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyData) name:NotiTypeUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyData) name:NotiTypeUserLogout object:nil];
    
    self.title = @"首页";
    __weak typeof (self) wSelf = self;
    
    if (arrAdvices == nil) {
        arrAdvices = [[NSMutableArray alloc] init];
    }

    tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor hexFloatColor:@"e6eaea"];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tbView];
    
    [tbView addPullToRefreshWithActionHandler:^{
        [wSelf getNewestRecommentTasks];
    }];
 
    [tbView.pullToRefreshView setOYStyle];
    
    [tbView triggerPullToRefresh];
    
    [self getLoadAds];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(refreshMyData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark - load data
/**
 *  刷新数据
 */
- (void)refreshMyData
{
    [tbView reloadData];
}

/**
 *  最新推荐任务
 */
- (void)getNewestRecommentTasks
{
    __weak UITableView* wTb = tbView;
    [GetRecommendTasks getRecommendTasksWithCity:@"徐州" success:^(AFHTTPRequestOperation *operation, NSObject *result) {
        [wTb.pullToRefreshView stopAnimating];
        RecommentTasksParser *parser = [[RecommentTasksParser alloc] initWithDictionary:(NSDictionary *)result];
        if ([parser.success boolValue]) {
            
            [wTb reloadData];
        }
    } failure:^(NSError *error) {
        [wTb.pullToRefreshView stopAnimating];
    }];
}

/**
 *  1元搜索广告
 */
- (void)getLoadAds
{
    __weak UITableView* wTb = tbView;
    [HomeModel getSearchAd1:^(AFHTTPRequestOperation* operation, NSObject* result){
        [HomeInstance ShardInstnce].listAd1 = [[HomeSearchAdList alloc] initWithDictionary:(NSDictionary*)result];
        [wTb reloadData];
    } failure:^(NSError* error){
    }];

    [HomeModel getSearchAd2:^(AFHTTPRequestOperation* operation, NSObject* result){
        [HomeInstance ShardInstnce].listAd2 = [[HomeSearchAdList alloc] initWithDictionary:(NSDictionary*)result];
        [wTb reloadData];
    } failure:^(NSError* error){
    }];
}

/**
 *  晒单分享
 */
- (void)getOrderShows
{
    __weak typeof (tbView) wTb = tbView;
    [HomeModel getOrderShow:^(AFHTTPRequestOperation* operation, NSObject* result){
        [HomeInstance ShardInstnce].listOrderShows = [[HomeOrderShowList alloc] initWithDictionary:(NSDictionary*)result];
        [wTb reloadData];
    } failure:^(NSError* error){
    }];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 + arrAdvices.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 2;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return indexPath.row == 0 ? 150:175;
    }
    if (indexPath.section == 1 && indexPath.row == 0)
        return 34;
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 2)
        return 0.1;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0)
    {
        if(row == 0)
        {
            static NSString *CellIdentifier = @"homeAdCell";
            HomeAdCell *cell = (HomeAdCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell == nil)
            {
                cell = [[HomeAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.delegate = self;
            [cell getAds];
            return cell;
        }
        else if(row == 1)
        {
            static NSString *CellIdentifier = @"homeAdBtnCell";
            HomeAdBtnCell *cell = (HomeAdBtnCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell == nil)
            {
                cell = [[HomeAdBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.delegate = self;
            return cell;
        }
    }
    if (section == 1)
    {
        static NSString *CellIdentifier = @"homeAdviceCell";
        HomeAdviceTitleCell *cell = (HomeAdviceTitleCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeAdviceTitleCell" owner:self options:nil] lastObject];
            cell.backgroundColor = [UIColor hexFloatColor:@"e6eaea"];
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"HomeAdviceCell";
        HomeAdviceCell *cell = (HomeAdviceCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeAdviceCell" owner:self options:nil] lastObject];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        
    }
    else
    {
        TaskDetailVC *vc = [[TaskDetailVC alloc] initWithNibName:@"TaskDetailVC" bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - delegate;
- (void)adClick:(NSString *)key
{
    if([key rangeOfString:@"search,"].length > 0)
    {
        NSString* searchKey = [key stringByReplacingOccurrencesOfString:@"search," withString:@""];
        SearchVC* vc = [[SearchVC alloc] initWithKey:searchKey];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([key rangeOfString:@"goodsdetail,"].length > 0)
    {
        NSString* goodsId = [key stringByReplacingOccurrencesOfString:@"goodsdetail," withString:@""];
        ProductDetailVC* vc = [[ProductDetailVC alloc] initWithGoodsId:[goodsId intValue] codeId:0];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)btnHomeClick:(int)index
{
    if(index == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidShowNewPro object:[NSNumber numberWithInt:4]];
        self.tabBarController.selectedIndex = 1;
    }
    else if(index == 1)
    {
//        ShowOrderListVC* vc = [[ShowOrderListVC alloc] initWithGoodsId:0];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(index == 2)
    {
//        if(![UserInstance ShardInstnce].userId)
//        {
//            LoginNewVC* vc = [[LoginNewVC alloc] initWithNibName:@"LoginNewVC" bundle:nil];
//            UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            [self.navigationController presentViewController:nav animated:YES completion:nil];
//        }
//        else
//        {
//            MineBuylistVC* vc = [[MineBuylistVC alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
        
    }
}

#pragma mark - newest delegate
- (void)doClickGoods:(int)goodsId codeId:(int)codeId
{
    if(goodsId == 0)
    {
        ProductDetailVC* vc = [[ProductDetailVC alloc] initWithGoodsId:goodsId codeId:codeId];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        ProductLotteryVC* vc = [[ProductLotteryVC alloc] initWithGoods:goodsId codeId:codeId];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - show delegate
- (void)doCickShare:(int)postId
{
    ShowOrderDetailVC* vc = [[ShowOrderDetailVC alloc] initWithPostId:postId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)firstItemClicked:(UIButton *)sender
{
    
}

- (void)secondItemClicked:(UIButton *)sender
{
    
}

@end
