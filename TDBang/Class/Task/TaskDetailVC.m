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
#import "QueryComment.h"
#import "UserInfoModel.h"
#import "CommentsListVC.h"
#import "YIPopupTextView.h"

@interface TaskDetailVC ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    YIPopupTextViewDelegate
>
{
    TaskDetailContentCell *contentCell;
    oneConmentCell *oneContentCell;
}

@property (nonatomic, strong) NSMutableArray *arrTasksComments;

@end

@implementation TaskDetailVC
@synthesize taskModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"任务详情";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    _btnWantEnroll.layer.cornerRadius = 5.0f;
    _btnWantEnroll.layer.masksToBounds = YES;
    
    _arrTasksComments = [NSMutableArray array];
    
    _tableView.backgroundColor = [UIColor hexFloatColor:@"f6f6f6"];
    _noticeCell.contentView.backgroundColor = [UIColor hexFloatColor:@"f6f6f6"];
    
    contentCell = [[[NSBundle mainBundle] loadNibNamed:@"TaskDetailContentCell" owner:self options:nil] lastObject];
    
    oneContentCell = [[[NSBundle mainBundle] loadNibNamed:@"oneConmentCell" owner:self options:nil] lastObject];
    oneContentCell.lblConment.text = @"这个问题得到了300+的支持和450+的收藏，答案得到了730+的支持.";
    
    [self queryTaskComments];
}

- (void)queryTaskComments
{
    __weak typeof (self) wSelf = self;
    [QueryComment getTaskCommentWithSession:appDelegate().accessToken
                                     taskId:taskModel.id
                                    success:^(AFHTTPRequestOperation *operation, NSObject *result) {
                                        QueryCommentParser *parser = [[QueryCommentParser alloc] initWithDictionary:(NSDictionary *)result];
                                        if ([parser.success boolValue]) {
                                            [wSelf.arrTasksComments removeAllObjects];
                                            NSString *strTemp = [NSString stringWithFormat:@"{\"rows\":%@}",parser.result];
                                            NSDictionary *dicParser = [[Sessions sharedInstance] parseJsonData:strTemp];
                                            
                                            for (NSDictionary *dicJson in [dicParser objectForKeyNotNull:@"rows"]) {
                                                TaskCommentModel *task = [[TaskCommentModel alloc] initWithDictionary:dicJson];
                                                [wSelf.arrTasksComments addObject:task];
                                            }
                                            
                                            //刷新TableView
                                            [wSelf.tableView reloadData];
                                        }else{
                                            
                                        }
                                    } failure:^(NSError *error) {
                                    }];
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
        {
            if (_arrTasksComments.count > 3) {
                return 2 + 3;
            }else if(_arrTasksComments == 0){
                return 1;
            }else{
                return 2 + _arrTasksComments.count;
            }
        }
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
        return 245;
    }
    
    if (indexPath.section == 2) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        cell.bounds = CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), CGRectGetHeight(cell.bounds));
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        return height + 1;
    }else if (indexPath.section == 3)
    {
        if (indexPath.row == 0) {
            return 44;
        }else{
            if (_arrTasksComments.count > 3) {
                if (indexPath.row == 4) {
                    return 44;
                }else{
                    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
                    cell.bounds = CGRectMake(0, 0, self.tableView.bounds.size.width, cell.bounds.size.height);
                    
                    [cell setNeedsLayout];
                    [cell layoutIfNeeded];
                    
                    float height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                    return height;
                }
            }else if(_arrTasksComments.count == 0){
                if (indexPath.row == 0) {
                    return 44;
                }else{
                    return 0;
                }
            }else{
                if (indexPath.row == _arrTasksComments.count + 1) {
                    return 44;
                }else{
                    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
                    cell.bounds = CGRectMake(0, 0, self.tableView.bounds.size.width, cell.bounds.size.height);
                    
                    [cell setNeedsLayout];
                    [cell layoutIfNeeded];
                    
                    float height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                    return height;
                }
            }
        }
    }else{
        return 185;
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
            [cell setContent:taskModel];
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
            [cell setContent:taskModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            static NSString *reuseIdetify = @"TaskDetailContentCell";
            TaskDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TaskDetailContentCell" owner:self options:nil] lastObject];
            }
            cell.lblContent.text = taskModel.content;
            return cell;
        }
            break;
        case 3:
        {
            if (indexPath.row == 0) {
                return _conmentCell;
            }else{
                if (_arrTasksComments.count > 3) {
                    if (indexPath.row == 4) {
                        return _moreConmentCell;
                    }else{
                        static NSString *CellIdentifier = @"oneConmentCell";
                        oneConmentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"oneConmentCell" owner:self options:nil] lastObject];
                        }
                        [cell setContentWithCommentModel:[_arrTasksComments objectAtIndex:indexPath.row - 1]];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }
                }else if (_arrTasksComments.count == 0){
                    return _moreConmentCell;
                }else{
                    if (indexPath.row == _arrTasksComments.count + 1) {
                        return _moreConmentCell;
                    }else{
                        static NSString *CellIdentifier = @"oneConmentCell";
                        oneConmentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        if (!cell)
                        {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"oneConmentCell" owner:self options:nil] lastObject];
                        }
                        [cell setContentWithCommentModel:[_arrTasksComments objectAtIndex:indexPath.row - 1]];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }
                }
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
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.section == 0){
        ENUserInfo *userModel = [[ENUserInfo alloc] initUserInfoModelWithDic:taskModel.createUser];
        UserInfoVC *userInfoVC = [[UserInfoVC alloc] initWithNibName:@"UserInfoVC" bundle:nil];
        userInfoVC.userInfo = userModel;
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }
    else if (cell == _moreConmentCell)
    {
        //查看跟过评论
        CommentsListVC *commentVC = [[CommentsListVC alloc] initWithNibName:@"CommentsListVC" bundle:nil];
        commentVC.arrAllComments = self.arrTasksComments;
        [self.navigationController pushViewController:commentVC animated:YES];
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
    [QueryComment signTaskWithTaskId:taskModel.id
                             success:^(AFHTTPRequestOperation *operation, NSObject *result) {
                                 QueryCommentParser *parser = [[QueryCommentParser alloc] initWithDictionary:(NSDictionary *)result];
                                 if ([parser.success boolValue]) {
                                     [[XBToastManager ShardInstance] showtoast:@"报名成功"];
                                 }else{
                                     [[XBToastManager ShardInstance] showtoast:[NSString stringWithFormat:@"%@",parser.result]];
                                 }
                             } failure:^(NSError *error) {
                                 
                             }];
}

- (IBAction)wantComplaintAction:(id)sender {
    
}
- (IBAction)actionCommentClick:(id)sender {
    // NOTE: maxCount = 0 to hide count
    YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"输入评论" maxCount:300];
    popupTextView.delegate = self;
    //popupTextView.closeButton.hidden = YES;
    popupTextView.text = self.textviewComment.text;
    [popupTextView showInView:self.view];
}

#pragma mark - YIPopupTextViewDelegate -
- (void)popupTextView:(YIPopupTextView*)textView willDismissWithText:(NSString*)text{
    
}

- (void)popupTextView:(YIPopupTextView*)textView didDismissWithText:(NSString*)text
{
    
}

- (void)sendComment:(NSString *)text
{
    if (text.length != 0) {
        __weak typeof(self) wSelf = self;
        [QueryComment writeCommentWithTaskId:taskModel.id
                              commentContent:text
                                     success:^(AFHTTPRequestOperation *operation, NSObject *result) {
                                         QueryCommentParser *parser = [[QueryCommentParser alloc] initWithDictionary:(NSDictionary *)result];
                                         if ([parser.success boolValue]) {
                                             [wSelf queryTaskComments];
                                         }else{
                                             [[XBToastManager ShardInstance] showtoast:@"评论发送失败"];
                                         }
                                     } failure:^(NSError *error) {
                                         [[XBToastManager ShardInstance] showtoast:@"网络异常,请检查网络连接"];
                                     }];
    }
}

-(void)showDeactiveView:(UIView *)outView duration:(CFTimeInterval)duration withTag:(int)aTag
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration             = duration;
    animation.removedOnCompletion  = NO;
    animation.fillMode             = kCAFillModeForwards;
    animation.timingFunction       = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    NSMutableArray * values        = [NSMutableArray array];
    if (aTag == 0) {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.98, 0.98, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    }else{
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.5)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.5)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.5)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    }
    animation.values = values;
    [outView.layer addAnimation:animation forKey:nil];
}

@end
