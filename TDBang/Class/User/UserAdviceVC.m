//
//  UserAdviceVC.m
//  TDBang
//
//  Created by sunjason on 15/8/22.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "UserAdviceVC.h"
#import "ChangeUserInfoModel.h"

@interface UserAdviceVC ()

@end

@implementation UserAdviceVC
@synthesize adviceTaskId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"建议";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    _tvInputAdvice.layer.cornerRadius = 5.0;
    _tvInputAdvice.layer.masksToBounds = YES;
    _tvInputAdvice.layer.borderColor = [UIColor colorWithWhite:220/255.0f alpha:1.0f].CGColor;
    _tvInputAdvice.layer.borderWidth = 0.5;
    
    _btnSubmit.layer.cornerRadius = 5.0;
    _btnSubmit.layer.masksToBounds = YES;
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 0.0)];
    bgView.backgroundColor = [UIColor colorWithRed:233.0/255 green:233.0/255 blue:233.0/255 alpha:1];
    return bgView;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 140;
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return _inputAdviceCell;
    }else{
        return _submitAdviceCell;
    }
}

- (IBAction)actionSubmit:(id)sender {
    [ChangeUserInfoModel submitAdviceTaskId:adviceTaskId
                                    content:_tvInputAdvice.text
                                    success:^(AFHTTPRequestOperation *operation, NSObject *result) {
                                        [[XBToastManager ShardInstance] showtoast:@"提交成功"];
                                    } failure:^(NSError *error) {
                                        [[XBToastManager ShardInstance] showtoast:@"网络连接失败"];
                                    }];
}
@end
