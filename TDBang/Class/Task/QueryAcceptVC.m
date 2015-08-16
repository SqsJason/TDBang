//
//  QueryAcceptVC.m
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "QueryAcceptVC.h"
#import "AcceptTaskModel.h"
#import "AcceptTasksCell.h"

@interface QueryAcceptVC ()

@property (nonatomic, strong) NSMutableArray *arrAcceptTasks;

@end

@implementation QueryAcceptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginOk_Relesae) name:NotiTypeUserLogin object:nil];
    
    self.title = @"已发任务";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    self.view.backgroundColor = Color_CommonBGColor;
    _tvAcceptTasks.backgroundColor = Color_CommonBGColor;
    
    _arrAcceptTasks  = [NSMutableArray array];
    [self updateBaseData];
}

- (void)didLoginOk_Relesae
{
    [_tvAcceptTasks reloadData];
}

- (void) updateBaseData
{
    NSString *userID;
    if (![Jxb_Common_Common isNullOrNilObject:[Sessions sharedInstance].userInfoModel]) {
        if ([[Sessions sharedInstance].userInfoModel isKindOfClass:[ENUserInfo class]]) {
            userID = [Sessions sharedInstance].userInfoModel.userId;
            __weak typeof(self)wSelf = self;
            
            [AcceptTaskModel getAcceptTasksWithSession:nil success:^(AFHTTPRequestOperation *operation, NSObject *result) {
                AcceptTasksParser *parser = [[AcceptTasksParser alloc] initWithDictionary:(NSDictionary *)result];
                if ([parser.success boolValue]) {
                    NSString *strTemp = [NSString stringWithFormat:@"{\"rows\":%@}",parser.result];
                    NSDictionary *dicParser = [[Sessions sharedInstance] parseJsonData:strTemp];
                    
                    for (NSDictionary *dicJson in [dicParser objectForKeyNotNull:@"rows"]) {
                        TaskModel *task = [[TaskModel alloc] initWithDictionary:dicJson];
                        [wSelf.arrAcceptTasks addObject:task];
                    }
                    [wSelf didLoginOk_Relesae];
                }else{
                    [[XBToastManager ShardInstance] showtoast:parser.result];
                }
            } failure:^(NSError *error) {
                [[XBToastManager ShardInstance] showtoast:@"网络请求失败"];
            }];
        }else{
            [[Sessions sharedInstance] logout];
            [[Sessions sharedInstance] gotoLogin:self];
        }
    }else{
        [[Sessions sharedInstance] logout];
        [[Sessions sharedInstance] gotoLogin:self];
    }
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrAcceptTasks.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 10)];
    vHead.backgroundColor = Color_CommonBGColor;
    return vHead;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strIdentifier = @"AcceptTasksCell";
    AcceptTasksCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AcceptTasksCell" owner:self options:nil] lastObject];
    }
    
    [cell setContentWithTask:[_arrAcceptTasks objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
