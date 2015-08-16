//
//  AllProView.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/21.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "AllProView.h"
#import "AllProModel.h"
#import "AllProItemCell.h"
#import "HomeAdviceCell.h"
#import "GetRecommendTasks.h"
#import "CJSONDeserializer.h"

#define pageSize    10

@interface AllProView ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak id<AllProViewDelegate> delegate;
    
    __block UITableView     *tbView;
    __block NSMutableArray  *arrPros;
    
    __block int             curPage;
    __block int             proType;
    __block int             proSort;
    NSMutableArray          *arrAdvices;
    NSInteger               pageNo;
    NSInteger               AllProViewPageSize;
    float                   distance;
    __block NSMutableArray  *arrQueryTasks;
}

@end

@implementation AllProView
@synthesize delegate,proType;

- (id)initWithOrder:(CGRect)frame indexOrder:(int)indexOrder
{
    proSort = indexOrder;
    self = [self initWithFrame:frame];
    if(self)
    {
    
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        __weak typeof (self) wSelf = self;
        
        self.backgroundColor = [UIColor redColor];
        
        arrQueryTasks = [NSMutableArray array];
        
        
        tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, frame.size.height) style:UITableViewStyleGrouped];
        tbView.delegate = self;
        tbView.dataSource = self;
        tbView.backgroundColor = [UIColor hexFloatColor:@"e6eaea"];
        tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:tbView];
        
        if (arrAdvices == nil) {
            arrAdvices = [[NSMutableArray alloc] init];
        }
        
        [arrAdvices addObject:@"Advices1"];
        [arrAdvices addObject:@"Advices2"];
        [arrAdvices addObject:@"Advices3"];
        [arrAdvices addObject:@"Advices4"];
        [arrAdvices addObject:@"Advices5"];
        [arrAdvices addObject:@"Advices6"];
        
        proType = 0;
        pageNo  = 1;
        __weak typeof (wSelf) weakSelf = self;
        [tbView addPullToRefreshWithActionHandler:^{
            [weakSelf getNewestTasks];
        }];
        
        [tbView addInfiniteScrollingWithActionHandler:^{
            [weakSelf getNewestTasks];
        }];
        
        [tbView.pullToRefreshView setOYStyle];
        [tbView triggerPullToRefresh];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveReleaseNoti) name:NotiTypeReleaseTask object:nil];
    }
    return self;
}

- (void)receiveReleaseNoti
{
    pageNo = 1;
    [self getNewestTasks];
}

#pragma mark - set data
- (void)setTypeAndOrder:(int)type sort:(int)sort
{
    proType = type;
    proSort = sort;
    curPage = 1;
    __weak typeof (self) wSelf = self;
    [self getDatas:proType sort:proSort block:^{
        __strong typeof (wSelf) sSelf = wSelf;
        sSelf->arrPros = nil;
    }];
}

#pragma mark - get data
- (void)getDatas:(int)type sort:(int)sort block:(void (^)(void))block
{
    [AllProModel getAllProduct:type sort:sort page:curPage size:pageSize success:^(AFHTTPRequestOperation* operation, NSObject* result){
        [tbView.pullToRefreshView stopAnimating];
        [tbView.infiniteScrollingView stopAnimating];
        if(block!=NULL)
            block();
        AllProList* list = [[AllProList alloc] initWithDictionary:(NSDictionary*)result];
        if(!arrPros)
            arrPros = [NSMutableArray arrayWithArray:list.Rows];
        else
            [arrPros addObjectsFromArray:list.Rows];
        [tbView reloadData];
        [tbView setShowsInfiniteScrolling:arrPros.count < [list.count intValue]];
    }   failure:^(NSError* error){
        [tbView.pullToRefreshView stopAnimating];
        [tbView.infiniteScrollingView stopAnimating];
    }];
}

- (void)getNewestTasks
{
    //117.198639,34.276989
    __weak UITableView* wTb = tbView;
    NSString *strLat;
    if ([Sessions sharedInstance].locationLat != nil) {
        strLat = [Sessions sharedInstance].locationLat;
    }else{
        strLat = @"0";
    }
    strLat = @"34.276989";
    
    NSString *strLng;
    if ([Sessions sharedInstance].locationLat != nil) {
        strLng = [Sessions sharedInstance].locationLng;
    }else{
        strLng = @"0";
    }
    strLng = @"117.198639";
    
    NSString *strProvince;
    if ([Sessions sharedInstance].locationLat != nil) {
        strProvince = [Sessions sharedInstance].province;
    }else{
        strProvince = @"0";
    }
    strProvince = @"";
    NSString *strCity;
    strCity = @"";
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
                                    status:@""
                                     order:@""
                                   success:^(AFHTTPRequestOperation *operation, NSObject *result) {
                                       [wTb.pullToRefreshView stopAnimating];
                                       [tbView.infiniteScrollingView stopAnimating];
                                       
                                       QueryTasksParser *parser = [[QueryTasksParser alloc] initWithDictionary:(NSDictionary *)result];
                                       if ([parser.success boolValue]) {
                                           pageNo ++;
                                           NSString *strResult = [(NSDictionary *)result objectForKey:@"result"];
                                           //将解析得到的内容存放字典中，编码格式为UTF8，防止取值的时候发生乱码
                                           NSDictionary *rootDic = [[CJSONDeserializer deserializer] deserialize:[strResult dataUsingEncoding:NSUTF8StringEncoding] error:nil];
                                           if (![Jxb_Common_Common isNullOrNilObject:[rootDic objectForKey:@"rows"]]) {
                                               for (NSDictionary *dic in [rootDic objectForKey:@"rows"]) {
                                                   TaskModel *taskModel = [[TaskModel alloc] initWithDictionary:dic];
                                                   [arrQueryTasks addObject:taskModel];
                                               }
                                           }else{
                                               [[XBToastManager ShardInstance] showtoast:@"未查到相关任务"];
                                           }
                                       }else{
                                           [[XBToastManager ShardInstance] showtoast:@"未查到相关任务"];
                                       }
                                       
                                       [wTb reloadData];
                                   } failure:^(NSError *error) {
                                       [wTb.pullToRefreshView stopAnimating];
                                       [tbView.infiniteScrollingView stopAnimating];
                                       [[XBToastManager ShardInstance] showtoast:@"网络请求失败"];
                                   }];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrQueryTasks.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"homeAdviceCell";
    HomeAdviceCell *cell = (HomeAdviceCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeAdviceCell" owner:self options:nil] lastObject];
    }
    
    [cell setContent:[arrQueryTasks objectAtIndex:indexPath.section]];
    
    cell.imvAdviceIcon.hidden = YES;
    cell.constraintsTitlePaddingLeft.constant = -20;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(delegate)
    {
        [delegate doClickProduct:(int)indexPath.row taskModel:[arrQueryTasks objectAtIndex:indexPath.section]];
    }
}

@end
