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

@interface TabNewestVC () <UITableViewDataSource,UITableViewDelegate,AllProTypeViewDelegate,HomeNewCellDelegate>
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理";
    
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
    
    btnRigth = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRigth addTarget:self action:@selector(btnRightAction) forControlEvents:UIControlEventTouchUpInside];
    if(![OyTool ShardInstance].bIsForReview)
    {
        [self actionCustomNavBtn:btnRigth nrlImage:@"" htlImage:@"" title:@"全部分类▽"];
    }
    else
    {
        [self actionCustomNavBtn:btnRigth nrlImage:@"" htlImage:@"" title:[dicTypeName.allValues objectAtIndex:0]];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRigth];
    
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
        MineLoginView* v = [[MineLoginView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 150)];
        return v;
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
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    TaskDetailVC *vc = [[TaskDetailVC alloc] initWithNibName:@"TaskDetailVC" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
    if(indexPath.row < [[[[HomeInstance ShardInstnce] listNewing] listItems] count])
    {
        HomeNewing* item = [[[[HomeInstance ShardInstnce] listNewing] listItems] objectAtIndex:indexPath.row];
        ProductDetailVC* vc = [[ProductDetailVC alloc] initWithGoodsId:0 codeId:[item.codeID intValue]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        NewestProItme* item = [listNew objectAtIndex:indexPath.row - [HomeInstance ShardInstnce].listNewing.listItems.count];
        
        ProductLotteryVC* vc = [[ProductLotteryVC alloc] initWithGoods:[item.codeGoodsID intValue] codeId:[item.codeID intValue]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - type view delegate
- (void)selectedTypeCode:(int)code
{
    iCodeType = code;
    [dropdownView hide];
    
    NSString* key = [NSString stringWithFormat:@"%d",code];
    NSString* name = [dicTypeName objectForKey:key];
    
    [self actionCustomNavBtn:btnRigth nrlImage:@"" htlImage:@"0" title:name];
    
    __weak typeof (self) wSelf = self;
    curPage = 1;
    [self getData:^{
        __strong typeof (wSelf) sSelf = wSelf;
        sSelf->listNew = nil;
    }];
}

-(void)doClickGoods:(int)goodsId codeId:(int)codeId
{
    
}

@end
