//
//  TaskDetailVC.m
//  TDBang
//
//  Created by sunjason on 15/7/24.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "TaskDetailVC.h"
#import "TaskDetailTitleCell.h"
#import "TaskDetailJobCell.h"
#import "TaskDetailContentCell.h"
#import "oneConmentCell.h"
#import "UserInfoVC.h"

@interface TaskDetailVC ()<UITableViewDataSource, UITableViewDelegate>
{
    TaskDetailContentCell *contentCell;
    oneConmentCell *oneContentCell;
}

@end

@implementation TaskDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"任务详情";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    _btnWantEnroll.layer.cornerRadius = 20.0f;
    _btnWantEnroll.layer.masksToBounds = YES;
    
    _noticeCell.contentView.backgroundColor = [UIColor hexFloatColor:@"f6f6f6"];
    
    contentCell = [[[NSBundle mainBundle] loadNibNamed:@"TaskDetailContentCell" owner:self options:nil] lastObject];
    contentCell.lblContent.text = @"这个问题得到了300+的支持和450+的收藏，答案得到了730+的支持，很详细的说明了如何在iOS7和iOS8上实现UITableView的动态行高功能.";
    
    oneContentCell = [[[NSBundle mainBundle] loadNibNamed:@"oneConmentCell" owner:self options:nil] lastObject];
    oneContentCell.lblConment.text = @"这个问题得到了300+的支持和450+的收藏，答案得到了730+的支持.";
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 3;
            break;
        case 4:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)getCellHeight:(UITableViewCell*)cell
{
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    
    if (indexPath.section == 1) {
        return 255;
    }
    
    if (indexPath.section == 2) {
        return [self getCellHeight:contentCell];
    }else if (indexPath.section == 3)
    {
        //只创建一个cell用作测量高度
        if (indexPath.row == 0) {
            return 44;
        }else if (indexPath.row == 1){
            oneContentCell.lblConment.text = @"这个问题得到了300+的支持和450+的收藏，答案得到了730+的支持，很详细的说明了如何在iOS7和iOS8上实现UITableView的动态行高功能.这个问题得到了300+的支持和450+的收藏，答案得到了730+的支持，很详细的说明了如何在iOS7和iOS8上实现UITableView的动态行高功能.";
            return [self getCellHeight:oneContentCell];
        }else{
            return 44;
        }
    }else{
        return 200;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 4)
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
    
    switch (section) {
        case 0:
        {
            static NSString *CellIdentifier = @"TaskDetailTitleCell";
            TaskDetailTitleCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TaskDetailTitleCell" owner:self options:nil] lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            static NSString *CellIdentifier = @"TaskDetailJobCell";
            TaskDetailJobCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TaskDetailJobCell" owner:self options:nil] lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return contentCell;
        }
            break;
        case 3:
        {
            if (indexPath.row == 0) {
                return _conmentCell;
            }else if (indexPath.row == 1){
                return oneContentCell;
            }else{
                return _moreConmentCell;
            }
        }
            break;
        case 4:
        {
            return _noticeCell;
        }
            break;
            
        default:
            return [(UITableViewCell *)[UITableViewCell alloc] init];
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.section == 0){
        UserInfoVC *userInfo = [[UserInfoVC alloc] initWithNibName:@"UserInfoVC" bundle:nil];
        [self.navigationController pushViewController:userInfo animated:YES];
    }
}


#pragma mark - delegate;
- (void)adClick:(NSString *)key
{
    
}

- (void)btnHomeClick:(int)index
{
    
}

- (IBAction)wantEnrollAction:(id)sender {
}
- (IBAction)wantComplaintAction:(id)sender {
}
@end
