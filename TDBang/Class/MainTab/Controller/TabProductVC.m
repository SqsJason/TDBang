//
//  TabProductVC.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/18.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "TabProductVC.h"
#import "AllProView.h"
#import "SearchVC.h"
#import "ProductDetailVC.h"
#import "TaskDetailVC.h"
#import "ReleaseTaskVC.h"
#import "GetRecommendTasks.h"

typedef enum
{
    TbViewType_Type = 0,
    TbViewType_Order = 1,
    TbViewType_Smart = 2
}TbViewType;

typedef enum
{
    TDBTsakStatusType_baoming_pre = 0,//任务状态：草稿：未支付，不可报名
    TDBTsakStatusType_BaoMing_Ing = 1,//任务状态：已支付，选标中
    TDBTsakStatusType_Start_Ing = 2,// 任务选标完成，正在执行中
    TDBTsakStatusType_Task_End = 3,// 任务已截止
    TDBTsakStatusType_Task_Delete = 4// 任务已删除
    
}TDBTsakStatus;

@interface TabProductVC ()<UITableViewDataSource,UITableViewDelegate,AllProViewDelegate>
{
    LMDropdownView  *dropdownView;
    
    UIButton        *btnType;
    UIButton        *btnOrder;
    UIButton        *btnSmart;
    AllProView      *allProView;
    
    UITableView     *tbViewType;
    UITableView     *tbTaskList;
    
    TbViewType      tbType;
    NSArray         *arrOfType;
    NSArray         *arrOfTypeImage;
    NSArray         *arrOfOrder;
    NSArray         *arrOfOrderFlag;
    NSArray         *arrOfSmart;
    NSArray         *arrOfSmartFlag;
    NSInteger       indexType;
    NSInteger       indexOrder;
    NSInteger       indexSmart;
    
    NSInteger       pageNo;
    NSInteger       pageSize;
    float           distance;
    
    NSArray         *arrDistances;
}
@end

@implementation TabProductVC

- (id)init
{
    self = [super init];
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewPro:) name:kDidShowNewPro object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotiTypeUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotiTypeUserLogout object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务";
    __weak typeof(self)wSelf = self;
    [self actionCustomRightBtnWithNrlImage:@"icon_release_white" htlImage:@"icon_release_white" title:@"" action:^{
        [wSelf gotoReleaseTask];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyData) name:NotiTypeUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyData) name:NotiTypeUserLogout object:nil];
    
    arrOfType = @[@"距离",@"同城",@"500米以内",@"1000米以内",@"5公里以内",@"10公里以内"];
    arrOfOrder = @[@"任务状态",@"全部",@"报名中",@"进行中",@"已完成"];
    arrOfSmart = @[@"智能排序",@"发布时间",@"离我最近",@"佣金金额",@"商户星级"];
    arrOfOrderFlag = @[@"10",@"20",@"30",@"31",@"50"];
    
    NSArray *arrAllListTitles = @[arrOfType,arrOfOrder,arrOfSmart];
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:arrAllListTitles selectedColor:RGB(245, 175, 57)];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 0, mainWidth, 44);
    [self.view addSubview:menu];
    
    /*
    float btnWidth = (mainWidth-1.5)/3;
    
    btnType = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, 44)];
    [btnType setTitle:[arrOfType objectAtIndex:0] forState:UIControlStateNormal];
    btnType.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnType setBackgroundColor:[UIColor hexFloatColor:@"f8f8f8"]];
    [btnType setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnType addTarget:self action:@selector(btnTypeAction) forControlEvents:UIControlEventTouchUpInside];
    [btnType setImage:[UIImage imageNamed:@"product_type_distance"] forState:UIControlStateNormal];
    [btnType setImageEdgeInsets:UIEdgeInsetsMake(8,0,8,0)];
    [self.view addSubview:btnType];

    btnOrder = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth + 0.5, 0, btnWidth , 43.5)];
    [btnOrder setTitle:[arrOfOrder objectAtIndex:0] forState:UIControlStateNormal];
    btnOrder.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnOrder setBackgroundColor:[UIColor hexFloatColor:@"f8f8f8"]];
    [btnOrder setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnOrder addTarget:self action:@selector(btnOrderAction) forControlEvents:UIControlEventTouchUpInside];
    [btnOrder setImage:[UIImage imageNamed:@"product_type_status"] forState:UIControlStateNormal];
    [btnOrder setImageEdgeInsets:UIEdgeInsetsMake(8,0,8,0)];
    [self.view addSubview:btnOrder];
    
    btnSmart = [[UIButton alloc] initWithFrame:CGRectMake(2*btnWidth + 1, 0, btnWidth, 43.5)];
    [btnSmart setTitle:[arrOfSmart objectAtIndex:0] forState:UIControlStateNormal];
    btnSmart.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnSmart setBackgroundColor:[UIColor hexFloatColor:@"f8f8f8"]];
    [btnSmart setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnSmart addTarget:self action:@selector(btnSmartAction) forControlEvents:UIControlEventTouchUpInside];
    [btnSmart setImage:[UIImage imageNamed:@"product_type_smart"] forState:UIControlStateNormal];
    [btnSmart setImageEdgeInsets:UIEdgeInsetsMake(8,0,8,0)];
    [self.view addSubview:btnSmart];
     */
    
//    UIImageView *imgLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(btnWidth + 0.5, 0, 0.5, 43.5)];
//    imgLine1.backgroundColor = [UIColor hexFloatColor:@"dedede"];
//    [self.view addSubview:imgLine1];
//    
//    UIImageView *imgLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(2*btnWidth + 1, 0, 0.5, 43.5)];
//    imgLine2.backgroundColor = [UIColor hexFloatColor:@"dedede"];
//    [self.view addSubview:imgLine2];
//    
//    UIImageView *imgLine3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43.5, mainWidth, 0.5)];
//    imgLine3.backgroundColor = [UIColor hexFloatColor:@"dedede"];
//    [self.view addSubview:imgLine3];
    
    tbViewType = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tbViewType.delegate = self;
    tbViewType.dataSource = self;
    tbViewType.backgroundColor = [UIColor whiteColor];
    tbViewType.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tbViewType.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbViewType.tag = 0;
    tbType = TbViewType_Type;
    
    
    tbTaskList = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tbTaskList.delegate = self;
    tbTaskList.dataSource = self;
    tbTaskList.backgroundColor = [UIColor redColor];
    tbTaskList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tbTaskList.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbTaskList.tag = 1;
    
    dropdownView = [[LMDropdownView alloc] init];
    dropdownView.contentBackgroundColor = [UIColor whiteColor];
    
    allProView = [[AllProView alloc] initWithOrder:CGRectMake(0, 44, mainWidth, self.view.bounds.size.height - 155) indexOrder:[[arrOfOrderFlag objectAtIndex:indexOrder] intValue]];
    allProView.delegate = self;
    allProView.proType = [[[arrOfTypeImage objectAtIndex:0] stringByReplacingOccurrencesOfString:@"sort" withString:@""] intValue];
    [self.view addSubview:allProView];
    
    pageNo = 0;
    pageSize = 10;
    
    __weak typeof(self) weakSelf = self;
    [tbTaskList addPullToRefreshWithActionHandler:^{
        [weakSelf getNewestTasks];
    }];
}

- (void)gotoReleaseTask
{
    ReleaseTaskVC *releaseTask = [[ReleaseTaskVC alloc] initWithNibName:@"ReleaseTaskVC" bundle:nil];
    releaseTask.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:releaseTask animated:YES];
}

- (void)getNewestTasks
{
    __weak UITableView* wTb = tbTaskList;
    NSString *strLat;
    if ([Sessions sharedInstance].locationLat != nil) {
        strLat = [Sessions sharedInstance].locationLat;
    }else{
        strLat = @"0";
    }
    strLat = @"";
    
    NSString *strLng;
    if ([Sessions sharedInstance].locationLat != nil) {
        strLng = [Sessions sharedInstance].locationLng;
    }else{
        strLng = @"0";
    }
    strLng = @"";
    
    NSString *strProvince;
    if ([Sessions sharedInstance].locationLat != nil) {
        strProvince = [Sessions sharedInstance].province;
    }else{
        strProvince = @"0";
    }
    strProvince = @"江苏";
    NSString *strCity;
    strCity = @"徐州";
    NSString *strDis = @"";
    NSString *strStreet = @"";
    NSString *strDistance = @"";
    
    //distance查询距离半径
    [GetRecommendTasks fentchTasksWithPage:[NSString stringWithFormat:@"%ld",(long)pageNo]
                                      rows:[NSString stringWithFormat:@"%ld",(long)pageSize]
                                       lat:strLat
                                       lng:strLng
                                  province:strProvince
                                      city:strCity
                                       dis:strDis
                                    street:strStreet
                                  distance:strDistance
                                    status:@"2"
                                     order:@""
                                   success:^(AFHTTPRequestOperation *operation, NSObject *result) {
                                       [wTb.pullToRefreshView stopAnimating];
                                       QueryTasksParser *parser = [[QueryTasksParser alloc] initWithDictionary:(NSDictionary *)result];
                                       if ([parser.success boolValue]) {
                                           pageNo ++;
                                       }else{
                                           
                                       }
                                   } failure:^(NSError *error) {
                                       [wTb.pullToRefreshView stopAnimating];
                                   }];
}

#pragma mark - load data
/**
 *  刷新数据
 */
- (void)refreshMyData
{
    [tbViewType reloadData];
}

- (void)doClickProduct:(int)taskId taskModel:(TaskModel *)taskModel
{
    TaskDetailVC *vc = [[TaskDetailVC alloc] initWithNibName:@"TaskDetailVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    vc.taskModel = taskModel;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  btn action
 */
- (void)btnTypeAction
{
    if ([dropdownView isOpen] && tbType == TbViewType_Type)
    {
        tbType = TbViewType_Type;
        [dropdownView hide];
    }
    else
    {
        tbType = TbViewType_Type;
        [tbViewType reloadData];
        [dropdownView showInView:self.view withContentView:tbViewType atOrigin:CGPointMake(0, 0)];
    }
}

- (void)btnOrderAction
{
    if ([dropdownView isOpen] && tbType == TbViewType_Order)
    {
        tbType = TbViewType_Order;
        [dropdownView hide];
    }
    else
    {
        tbType = TbViewType_Order;
        [tbViewType reloadData];
        [dropdownView showInView:self.view withContentView:tbViewType atOrigin:CGPointMake(0, 0)];
    }
}

- (void)btnSmartAction
{
    
    if ([dropdownView isOpen] && tbType == TbViewType_Smart)
    {
        tbType = TbViewType_Smart;
        [dropdownView hide];
    }
    else
    {
        tbType = TbViewType_Smart;
        [tbViewType reloadData];
        [dropdownView showInView:self.view withContentView:tbViewType atOrigin:CGPointMake(0, 0)];
    }
}

#pragma mark - notify
- (void)showNewPro:(NSNotification*)obj
{
    indexOrder = 0;
    if(btnOrder)
        [btnOrder setTitle:[arrOfOrder objectAtIndex:indexOrder] forState:UIControlStateNormal];
    if(allProView)
        [allProView setTypeAndOrder:[[[arrOfTypeImage objectAtIndex:indexType] stringByReplacingOccurrencesOfString:@"sort" withString:@""] intValue] sort:[[arrOfOrderFlag objectAtIndex:indexOrder] intValue]];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tbType) {
        case 0:
            return arrOfType.count;
            break;
        case 1:
            return arrOfOrder.count;
            break;
        case 2:
            return arrOfSmart.count;
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
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
    
    switch (tbType) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [arrOfType objectAtIndex:indexPath.row]];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [arrOfOrder objectAtIndex:indexPath.row]];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [arrOfSmart objectAtIndex:indexPath.row]];
            break;
            
        default:
            break;
    }
    if(tbType == TbViewType_Type)
    {
        NSString* name = [arrOfTypeImage objectAtIndex:indexPath.row];
        if(indexPath.row == indexType)
        {
            name = [NSString stringWithFormat:@"%@_checked",name];
            cell.textLabel.textColor = mainColor;
            
            UIImageView* imgOK = [[UIImageView alloc] initWithFrame:CGRectMake(mainWidth - 32, 14, 20, 16)];
            imgOK.image = [UIImage imageNamed:@"screening_select"];
            [cell addSubview:imgOK];
        }
        else
        {
            name = [NSString stringWithFormat:@"%@_normal",name];
        }
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 24, 24)];
        img.image = [UIImage imageNamed:name];
        [cell addSubview:img];
    }
    else if(tbType == TbViewType_Order)
    {
        if(indexPath.row == indexOrder)
        {
            cell.textLabel.textColor = mainColor;
            
            UIImageView* imgOK = [[UIImageView alloc] initWithFrame:CGRectMake(mainWidth - 32, 14, 20, 16)];
            imgOK.image = [UIImage imageNamed:@"screening_select"];
            [cell addSubview:imgOK];
        }
    }
    else{
        if(indexPath.row == indexOrder)
        {
            cell.textLabel.textColor = mainColor;
            
            UIImageView* imgOK = [[UIImageView alloc] initWithFrame:CGRectMake(mainWidth - 32, 14, 20, 16)];
            imgOK.image = [UIImage imageNamed:@"screening_select"];
            [cell addSubview:imgOK];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (tbType) {
        case 0:
        {
            indexType = indexPath.row;
            [btnType setTitle:[arrOfType objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            indexOrder = indexPath.row;
            [btnOrder setTitle:[arrOfOrder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            indexSmart = indexPath.row;
            [btnSmart setTitle:[arrOfSmart objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
    [tbViewType reloadData];
    [dropdownView hide];
    
    [allProView setTypeAndOrder:[[[arrOfTypeImage objectAtIndex:indexType] stringByReplacingOccurrencesOfString:@"sort" withString:@""] intValue] sort:[[arrOfOrderFlag objectAtIndex:indexOrder] intValue]];
}

#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSLog(@"%ld -- %ld", (long)column, (long)row);
}

@end
