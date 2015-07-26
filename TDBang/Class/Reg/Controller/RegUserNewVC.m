//
//  RegUserNewVC.m
//  TDBang
//
//  Created by sunjason on 15/7/26.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "RegUserNewVC.h"
#import "RegModel.h"
#import "RegUserNextVC.h"
#import "RegSetPwdVC.h"
#import "CJSONDeserializer.h"

@interface RegUserNewVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *vHolder;

@property (weak, nonatomic) IBOutlet UITextField *tfNickName;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPass;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;

- (IBAction)actionGetCode:(id)sender;
- (IBAction)actionRegister:(id)sender;


@end

@implementation RegUserNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"注册";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
//    UIGestureRecognizer *tapGesture = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(getBackKeyBoard)];
//    [_vHolder addGestureRecognizer:tapGesture];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if(string.length > 0)
//    {
//        if(textField.text.length > 10)
//            return NO;
//        if([string isEqualToString:@"0"])
//            return YES;
//        if([string intValue] == 0)
//            return NO;
//    }
//    return YES;
//}

- (IBAction)actionGetCode:(id)sender {
    if(![[Jxb_Common_Common sharedInstance] validatePhone:_tfPhone.text])
    {
        [[XBToastManager ShardInstance] showtoast:@"输入的手机号不正确"];
        return;
    }
    
    [[XBToastManager ShardInstance] showprogress];
    [RegModel regPhoneSms:_tfPhone.text success:^(AFHTTPRequestOperation* operation, NSObject* result){
        [[XBToastManager ShardInstance] hideprogress];
        NSDictionary *dic = (NSDictionary *)result;

        RegSms* sms = [[RegSms alloc] initWithDictionary:(NSDictionary*)result];
        if(![sms.state boolValue])
        {
            [[XBToastManager ShardInstance] showtoast:[dic objectForKey:@"result"]];
            return ;
        }else{
            NSLog(@"Success Get Code.");
        }
    } failure:^(NSError* error){
        [[XBToastManager ShardInstance] hideprogress];
    }];
}

- (IBAction)actionRegister:(id)sender {
    if(_tfNickName.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入昵称"];
        return;
    }
    if(_tfPhone.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入手机号"];
        return;
    }
    if(_tfCode.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入验证码"];
        return;
    }
    if(_tfPassword.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入密码"];
        return;
    }
    if(_tfConfirmPass.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入确认密码"];
        return;
    }
    
    __weak typeof (self) wSelf = self;
    [[XBToastManager ShardInstance] showprogress];
    
    [RegModel regPhoneCode:_tfPhone.text code:_tfCode.text pwd:_tfPassword.text nickName:_tfNickName.text success:^(AFHTTPRequestOperation *operation, NSObject *result) {
        //NSDictionary* dic = [operation.response allHeaderFields];
        [[XBToastManager ShardInstance] hideprogress];
        RegResut* p = [[RegResut alloc] initWithDictionary:(NSDictionary*)result];
        if([p.code intValue] == 1)
        {
            [[XBToastManager ShardInstance] hideprogress];
            [[XBToastManager ShardInstance] showtoast:@"验证码校验不正确[1]"];
            return ;
        }
        if([p.state intValue] == 1)
        {
            [[XBToastManager ShardInstance] showtoast:@"验证码校验不正确[2]"];
            return;
        }
        if([p.state intValue] == 0)
        {
            RegSetPwdVC* vc = [[RegSetPwdVC alloc] initWithStr:p.str phone:_tfPhone.text];
            vc.hidesBottomBarWhenPushed = YES;
            [wSelf.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {
        [[XBToastManager ShardInstance] hideprogress];
    }];
}

- (void)getBackKeyBoard
{
    for (UITextField *tf in [_vHolder subviews]) {
        if ([tf isFirstResponder]) {
            [tf resignFirstResponder];
        }
    }
}

@end
