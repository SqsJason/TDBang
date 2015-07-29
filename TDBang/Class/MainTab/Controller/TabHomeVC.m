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
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyData) name:kDidNotifyFromBack object:nil];
    
    self.title = @"首页";
    __weak typeof (self) wSelf = self;
    
    if(![OyTool ShardInstance].bIsForReview)
    {
        [self actionCustomRightBtnWithNrlImage:@"search" htlImage:@"search" title:@"" action:^{
            SearchVC* vc = [[SearchVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [wSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    
    if (arrAdvices == nil) {
        arrAdvices = [[NSMutableArray alloc] init];
    }
    
    [arrAdvices addObject:@"Advices1"];
    [arrAdvices addObject:@"Advices2"];
    [arrAdvices addObject:@"Advices3"];
    
    tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor hexFloatColor:@"e6eaea"];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tbView];
    
    [tbView addPullToRefreshWithActionHandler:^{
        [wSelf getNewest];
        [wSelf getOrderShows];
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
    [self getNewest];
    [self getOrderShows];
}

/**
 *  最新揭晓
 */
- (void)getNewest
{
    __weak UITableView* wTb = tbView;
    [HomeModel getNewing:^(AFHTTPRequestOperation* operation, NSObject* result){
         [HomeInstance ShardInstnce].listNewing = [[HomeNewingList alloc] initWithDictionary:(NSDictionary*)result];
        [HomeModel getHomePage:^(AFHTTPRequestOperation* operation, NSObject* result){
            listHomepage = [[HomePageList alloc] initWithDictionary:(NSDictionary*)result];
            [wTb.pullToRefreshView stopAnimating];
            [wTb reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kDidNotifyReloadNewest object:nil];
        } failure:^(NSError* error){
            [wTb.pullToRefreshView stopAnimating];
                //[[XBToastManager ShardInstance] showtoast:[NSString stringWithFormat:@"获取首页商品异常：%@",error]];
        }];
    } failure:^(NSError* error){
        [wTb.pullToRefreshView stopAnimating];
        //[[XBToastManager ShardInstance] showtoast:[NSString stringWithFormat:@"获取最新揭晓异常：%@",error]];
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
        //[[XBToastManager ShardInstance] showtoast:[NSString stringWithFormat:@"获取搜索广告1异常:%@",error]];
    }];

    [HomeModel getSearchAd2:^(AFHTTPRequestOperation* operation, NSObject* result){
        [HomeInstance ShardInstnce].listAd2 = [[HomeSearchAdList alloc] initWithDictionary:(NSDictionary*)result];
        [wTb reloadData];
    } failure:^(NSError* error){
        //[[XBToastManager ShardInstance] showtoast:[NSString stringWithFormat:@"获取搜索广告2异常:%@",error]];
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
        //[[XBToastManager ShardInstance] showtoast:[NSString stringWithFormat:@"获取首页晒单分享异常:%@",error]];
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
        static NSString *CellIdentifier = @"homeAdviceCell";
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
        ShowOrderListVC* vc = [[ShowOrderListVC alloc] initWithGoodsId:0];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(index == 2)
    {
        if(![UserInstance ShardInstnce].userId)
        {
//            LoginVC* vc = [[LoginVC alloc] init];
//            UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
//            [self.navigationController presentViewController:nav animated:YES completion:nil];
            
            LoginNewVC* vc = [[LoginNewVC alloc] initWithNibName:@"LoginNewVC" bundle:nil];
            UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
        else
        {
            MineBuylistVC* vc = [[MineBuylistVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
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
@end
