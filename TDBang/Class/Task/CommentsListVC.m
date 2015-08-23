//
//  CommentsListVC.m
//  TDBang
//
//  Created by sunjason on 15/8/17.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "CommentsListVC.h"
#import "TaskCommentCell.h"
#import "QueryComment.h"

@interface CommentsListVC ()

@end

@implementation CommentsListVC
@synthesize arrAllComments;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"评论";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    _tableMain.backgroundColor = [UIColor hexFloatColor:@"f6f6f6"];
}

- (void)fetchAllComments
{
    [[XBToastManager ShardInstance] showprogress];
    [QueryComment getTaskCommentWithSession:@"" taskId:@"" success:^(AFHTTPRequestOperation *operation, NSObject *result) {
        [[XBToastManager ShardInstance] hideprogress];
        QueryCommentParser *parser = [[QueryCommentParser alloc] initWithDictionary:(NSDictionary *)result];
        if ([parser.success boolValue]) {
            
        }else{
            [[XBToastManager ShardInstance] showtoast:@"未查询到评论数据"];
        }
    } failure:^(NSError *error) {
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"网络请求失败"];
    }];
}

#pragma mark - UITableViewDataSource  UITableViewDelegate-
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *vHead;
    if (section == 1) {
        vHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 0.1)];
        vHead.backgroundColor = [UIColor hexFloatColor:@"a6a6a6"];
    }
    return vHead;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vHead;
    if (section == 1) {
        vHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 0.1)];
        vHead.backgroundColor = [UIColor hexFloatColor:@"f6f6f6"];
    }
    return vHead;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(_tableMain.frame), CGRectGetHeight(cell.bounds));
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrAllComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TaskCommentCell";
    TaskCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TaskCommentCell" owner:self options:nil] lastObject];
    }
    
    [cell setContentWithCommentModel:[arrAllComments objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
