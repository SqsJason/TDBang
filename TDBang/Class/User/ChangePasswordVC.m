//
//  ChangePasswordVC.m
//  TDBang
//
//  Created by sunjason on 15/8/2.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "ChangePwdModel.h"

@interface ChangePasswordVC ()

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _btnChange.layer.cornerRadius = 5.0;
    _btnChange.layer.masksToBounds = YES;
    self.title = @"修改密码";
    
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    UITapGestureRecognizer *_left = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap:)];
    [self.view addGestureRecognizer:_left];
    
}

- (void) handTap:(UITapGestureRecognizer*) gesture
{
    for (UITextField *tf in [_vContentHolder subviews]) {
        if ([tf isFirstResponder]) {
            [tf resignFirstResponder];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionChangeClicked:(id)sender {
    if(_tfOldPwd.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输原密码"];
        return;
    }
    if(_tfNewPwd.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输新密码"];
        return;
    }
    if(_tfConfirmNewPwd.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输确认密码"];
        return;
    }
    
    [[XBToastManager ShardInstance] showprogress];
    [ChangePwdModel changePwd:_tfNewPwd.text oldPwd:_tfOldPwd.text success:^(AFHTTPRequestOperation *operation, NSObject *result) {
        [[XBToastManager ShardInstance] hideprogress];
        ChangePwdParser *parser = [[ChangePwdParser alloc] initWithDictionary:(NSDictionary*)result];
        if ([parser.success boolValue]) {
            [[XBToastManager ShardInstance] showtoast:@"密码修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSError *error) {
        [[XBToastManager ShardInstance] hideprogress];
    }];
}
@end
