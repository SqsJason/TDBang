//
//  ReleaseTaskVC.m
//  TDBang
//
//  Created by sunjason on 15/7/29.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "ReleaseTaskVC.h"
#import "ReleaseTaskModel.h"

static const float RadioButton_W = 60;

@interface ReleaseTaskVC ()
{
    NSString *currRadioIndex;
    NSString *currSalaryType;
}

@property (nonatomic, strong) NSArray *arrCells;

@end

@implementation ReleaseTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"任务发布";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    _arrCells = @[_titleCell,
                  _inputContentCell,
                  _taskInfoCell,
                  _taskName,
                  _taskPaymentCell,
                  _taskSalary,
                  _taskPeopleCell,
                  _taskTiimeCell,
                  _taskDateCell,
                  _taskPlaceCell,
                  _taskConnectCell,
                  _QQNumberCell,
                  _releaseCell];
    
    _btnRelease.layer.cornerRadius = 5.;
    _btnRelease.layer.masksToBounds = YES;
    _releaseCell.contentView.backgroundColor = Color_CommonBGColor;
    self.tblReleaseTask.backgroundColor = Color_CommonBGColor;
    
    currRadioIndex = @"0";
    currSalaryType = @"元/天";
    
    QRadioButton *rbDayJie = [[QRadioButton alloc] initWithDelegate:self groupId:@"1"];
    rbDayJie.tag = 0;
    rbDayJie.frame = CGRectMake(10, 2, RadioButton_W, 40);
    [rbDayJie setTitle:@"日结" forState:UIControlStateNormal];
    [rbDayJie setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rbDayJie.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
    [self.vPaymentType addSubview:rbDayJie];
    [rbDayJie setChecked:YES];
    
    QRadioButton *rbWeekJie = [[QRadioButton alloc] initWithDelegate:self groupId:@"1"];
    rbWeekJie.tag = 1;
    rbWeekJie.frame = CGRectMake(70, 2, RadioButton_W, 40);
    [rbWeekJie setTitle:@"周结" forState:UIControlStateNormal];
    [rbWeekJie setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rbWeekJie.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
    [self.vPaymentType addSubview:rbWeekJie];
    
    QRadioButton *rbMonthJie = [[QRadioButton alloc] initWithDelegate:self groupId:@"1"];
    rbMonthJie.tag = 2;
    rbMonthJie.frame = CGRectMake(130, 2, RadioButton_W, 40);
    [rbMonthJie setTitle:@"月结" forState:UIControlStateNormal];
    [rbMonthJie setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rbMonthJie.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
    [self.vPaymentType addSubview:rbMonthJie];
    
    QRadioButton *rbFinishJie = [[QRadioButton alloc] initWithDelegate:self groupId:@"1"];
    rbFinishJie.tag = 3;
    rbFinishJie.frame = CGRectMake(180, 2, RadioButton_W + 20, 40);
    [rbFinishJie setTitle:@"完工结算" forState:UIControlStateNormal];
    [rbFinishJie setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rbFinishJie.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
    [self.vPaymentType addSubview:rbFinishJie];
    
    QRadioButton *rbSalaryDay = [[QRadioButton alloc] initWithDelegate:self groupId:@"2"];
    rbSalaryDay.tag = 0;
    rbSalaryDay.frame = CGRectMake(0, 2, RadioButton_W, 40);
    [rbSalaryDay setTitle:@"元/天" forState:UIControlStateNormal];
    [rbSalaryDay setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rbSalaryDay.titleLabel setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [self.vSalary addSubview:rbSalaryDay];
    [rbSalaryDay setChecked:YES];
    
    QRadioButton *rbSalaryHour = [[QRadioButton alloc] initWithDelegate:self groupId:@"2"];
    rbSalaryHour.tag = 1;
    rbSalaryHour.frame = CGRectMake(65, 2, RadioButton_W, 40);
    [rbSalaryHour setTitle:@"元/小时" forState:UIControlStateNormal];
    [rbSalaryHour setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rbSalaryHour.titleLabel setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [self.vSalary addSubview:rbSalaryHour];
    
}

#pragma mark - UITableViewDataSource  UITableViewDelegate-
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *vHead;
    if (section == 1) {
        vHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 1)];
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
    return [(UITableView *)[_arrCells objectAtIndex:indexPath.row] frame].size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_arrCells objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (IBAction)actionStartTime:(id)sender {
}

- (IBAction)actionEndTime:(id)sender {
}

- (IBAction)actionStartDate:(id)sender {
}

- (IBAction)actionEndDate:(id)sender {
}

//发布任务
- (IBAction)actionRelease:(id)sender {
    if([_tvInputTaskContent.text isEqualToString:@"请输入工作内容或工作要求"])
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写工作内容或工作要求"];
        return;
    }
    
    if(_tfTaskName.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写工作名称"];
        return;
    }
    
    if(_tfSalary.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写工资"];
        return;
    }
    
    if(_tfPeopleNum.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写招聘人数"];
        return;
    }
    if(_tfLocation.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写工作地点"];
        return;
    }
    if(_tfPhoneNumber.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填写电话号码"];
        return;
    }
    
    if(_tfQQNumber.text.length == 0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请填QQ号码"];
        return;
    }
    
    //117.198639,34.276989
    __weak typeof(self) wSelf = self;
    [ReleaseTaskModel releaseTasksWithfmName:_tfTaskName.text
                                   fmContent:_tvInputTaskContent.text
                               fmPayForMoney:_tfSalary.text
                                    province:@"江苏"
                                        city:@"徐州"
                                         dis:@"白云区"
                                      street:@"和平大道"
                                         lat:@"34.276989"
                                         lng:@"117.198639"
                                 fmStartDate:@"2015-9-1"
                                   fmEndDate:@"2015-9-10"
                                 fmStartTime:@"09:00"
                                   fmEndTime:@"19:00"
                                 fmPayForJie:currRadioIndex
                                fmPayForDesc:currSalaryType
                              fmZhaopinCount:_tfPeopleNum.text
                                     fmPhone:_tfPhoneNumber.text
                                        fmQQ:_tfQQNumber.text
                                     success:^(AFHTTPRequestOperation *operation, NSObject *result) {
                                         ReleaseTasksParser *parser = [[ReleaseTasksParser alloc] initWithDictionary:(NSDictionary *)result];
                                         if ([parser.success boolValue]) {
                                             [[XBToastManager ShardInstance] showtoast:@"任务发送成功"];
                                             
                                             [[NSNotificationCenter defaultCenter] postNotificationName:NotiTypeReleaseTask object:nil];
                                             
                                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                 [wSelf releaseSuccess];
                                             });
                                         }else{
                                             [[XBToastManager ShardInstance] showtoast:parser.result];
                                         }
                                     } failure:^(NSError *error) {
                                         [[XBToastManager ShardInstance] showtoast:@"网络连接失败"];
                                     }];
}

- (void)releaseSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - QRadioButtonDelegate

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    if ([groupId integerValue] == 1) {
        currRadioIndex = [NSString stringWithFormat:@"%ld",(long)radio.tag];
    }else{
        if (radio.tag == 0) {
            currSalaryType = @"元/天";
        }else{
            currSalaryType = @"元/小时";
        }
    }
}


@end
