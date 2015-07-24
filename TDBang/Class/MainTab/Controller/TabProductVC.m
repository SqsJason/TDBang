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

typedef enum
{
    TbViewType_Type = 0,
    TbViewType_Order = 1,
    TbViewType_Smart = 2
}TbViewType;

@interface TabProductVC ()<UITableViewDataSource,UITableViewDelegate,AllProViewDelegate>
{
    LMDropdownView  *dropdownView;
    
    UIButton        *btnType;
    UIButton        *btnOrder;
    UIButton        *btnSmart;
    AllProView      *allProView;
    
    UITableView     *tbViewType;
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务";
    __weak typeof (self) wSelf = self;
    
    if(![OyTool ShardInstance].bIsForReview)
    {
        [self actionCustomRightBtnWithNrlImage:@"search" htlImage:@"search" title:@"" action:^{
            SearchVC* vc = [[SearchVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [wSelf.navigationController pushViewController:vc animated:YES];
        }];
        
        
        arrOfType = @[@"距离",@"同城",@"500米以内",@"1000米以内",@"5公里以内",@"10公里以内"];
        arrOfOrder = @[@"任务状态",@"全部",@"报名中",@"进行中",@"已完成"];
        arrOfSmart = @[@"智能排序",@"发布时间",@"离我最近",@"佣金金额",@"商户星级"];
        arrOfOrderFlag = @[@"10",@"20",@"30",@"31",@"50"];
    }
    else
    {
        arrOfType = @[@"家用电器",@"化妆个护",@"钟表首饰",@"其他商品"];
        arrOfTypeImage = @[@"sort104",@"sort2",@"sort222",@"sort312"];
        arrOfOrder = @[@"即将揭晓",@"人气",@"价值（由高到低）",@"价值（由低到高）",@"最新"];
        arrOfOrderFlag = @[@"10",@"20",@"30",@"31",@"50"];
    }
    
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
    
    UIImageView *imvDownDis = [[UIImageView alloc] initWithFrame:CGRectMake(btnType.frame.origin.x + btnWidth - 13, 15, 10, 15)];
    imvDownDis.image =[UIImage imageNamed:@"down"];
    [self.view addSubview:imvDownDis];
    
    btnOrder = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth + 0.5, 0, btnWidth , 43.5)];
    [btnOrder setTitle:[arrOfOrder objectAtIndex:0] forState:UIControlStateNormal];
    btnOrder.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnOrder setBackgroundColor:[UIColor hexFloatColor:@"f8f8f8"]];
    [btnOrder setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnOrder addTarget:self action:@selector(btnOrderAction) forControlEvents:UIControlEventTouchUpInside];
    [btnOrder setImage:[UIImage imageNamed:@"product_type_status"] forState:UIControlStateNormal];
    [btnOrder setImageEdgeInsets:UIEdgeInsetsMake(8,0,8,0)];
    [self.view addSubview:btnOrder];
    
    UIImageView *imvDownSta = [[UIImageView alloc] initWithFrame:CGRectMake(btnOrder.frame.origin.x + btnWidth - 13, 15, 10, 15)];
    imvDownSta.image =[UIImage imageNamed:@"down"];
    [self.view addSubview:imvDownSta];
    
    btnSmart = [[UIButton alloc] initWithFrame:CGRectMake(2*btnWidth + 1, 0, btnWidth, 43.5)];
    [btnSmart setTitle:[arrOfSmart objectAtIndex:0] forState:UIControlStateNormal];
    btnSmart.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnSmart setBackgroundColor:[UIColor hexFloatColor:@"f8f8f8"]];
    [btnSmart setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnSmart addTarget:self action:@selector(btnSmartAction) forControlEvents:UIControlEventTouchUpInside];
    [btnSmart setImage:[UIImage imageNamed:@"product_type_smart"] forState:UIControlStateNormal];
    [btnSmart setImageEdgeInsets:UIEdgeInsetsMake(8,0,8,0)];
    [self.view addSubview:btnSmart];
    
    UIImageView *imvDownSmar = [[UIImageView alloc] initWithFrame:CGRectMake(btnSmart.frame.origin.x + btnWidth - 15, 15, 10, 15)];
    imvDownSmar.image =[UIImage imageNamed:@"down"];
    [self.view addSubview:imvDownSmar];
    
    UIImageView *imgLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(btnWidth + 0.5, 0, 0.5, 43.5)];
    imgLine1.backgroundColor = [UIColor hexFloatColor:@"dedede"];
    [self.view addSubview:imgLine1];
    
    UIImageView *imgLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(2*btnWidth + 1, 0, 0.5, 43.5)];
    imgLine2.backgroundColor = [UIColor hexFloatColor:@"dedede"];
    [self.view addSubview:imgLine2];
    
    UIImageView *imgLine3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43.5, mainWidth, 0.5)];
    imgLine3.backgroundColor = [UIColor hexFloatColor:@"dedede"];
    [self.view addSubview:imgLine3];
    
    tbViewType = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tbViewType.delegate = self;
    tbViewType.dataSource = self;
    tbViewType.backgroundColor = [UIColor whiteColor];
    tbViewType.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tbViewType.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tbType = TbViewType_Type;
    
    dropdownView = [[LMDropdownView alloc] init];
    dropdownView.contentBackgroundColor = [UIColor whiteColor];
    
    allProView = [[AllProView alloc] initWithOrder:CGRectMake(0, 44, mainWidth, self.view.bounds.size.height - 155) indexOrder:[[arrOfOrderFlag objectAtIndex:indexOrder] intValue]];
    allProView.delegate = self;
    allProView.proType = [[[arrOfTypeImage objectAtIndex:0] stringByReplacingOccurrencesOfString:@"sort" withString:@""] intValue];
    [self.view addSubview:allProView];
}

- (void)doClickProduct:(int)goodsId
{
    ProductDetailVC* vc = [[ProductDetailVC alloc] initWithGoodsId:goodsId codeId:0];
    vc.hidesBottomBarWhenPushed = YES;
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
@end
