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

const static int flTimeWait = 150;

@interface RegUserNewVC ()<UITextFieldDelegate>
{
    __block NSString    *myPhone;
    __block int         leftTime;
    __block NSTimer     *timer;
}

@property (weak, nonatomic) IBOutlet UIView *vHolder;

@property (weak, nonatomic) IBOutlet UITextField *tfNickName;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPass;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;
@property (weak, nonatomic) IBOutlet UIView *vBlurBG;

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
    
    UITapGestureRecognizer *_left = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap:)];
    [self.view addGestureRecognizer:_left];
    
    _btnGetCode.layer.cornerRadius = 5;
    _btnGetCode.layer.borderWidth = 0.5;
    _btnGetCode.layer.borderColor = [UIColor hexFloatColor:@"dedede"].CGColor;
    
    _vBlurBG.layer.cornerRadius = 5.0;
    _vBlurBG.layer.masksToBounds = YES;
}

- (void)timerAction
{
    leftTime--;
    if(leftTime<=0)
    {
        [_btnGetCode setEnabled:YES];
        [_btnGetCode setTitle:@"点击重新发送" forState:UIControlStateNormal];
        [_btnGetCode setTitle:@"点击重新发送" forState:UIControlStateDisabled];
    }
    else
    {
        [_btnGetCode setEnabled:NO];
        [_btnGetCode setTitle:[NSString stringWithFormat:@"%d秒后可重新发送",leftTime] forState:UIControlStateNormal];
        [_btnGetCode setTitle:[NSString stringWithFormat:@"%d秒后可重新发送",leftTime] forState:UIControlStateDisabled];
    }
}

- (void) handTap:(UITapGestureRecognizer*) gesture
{
    for (UITextField *tf in [_vHolder subviews]) {
        if ([tf isFirstResponder]) {
            [tf resignFirstResponder];
            break;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(string.length > 0)
    {
        if(textField.text.length > 10)
            return NO;
        if([string isEqualToString:@"0"])
            return YES;
        if([string intValue] == 0)
            return NO;
    }
    return YES;
}

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

        RegGetCode* sms = [[RegGetCode alloc] initWithDictionary:(NSDictionary*)result];
        if(![sms.success boolValue])
        {
            [[XBToastManager ShardInstance] showtoast:[dic objectForKey:@"result"]];
            return ;
        }else{
            leftTime = flTimeWait;
            [_btnGetCode setTitle:[NSString stringWithFormat:@"%d秒后可重新发送",flTimeWait] forState:UIControlStateNormal];

            if(timer)
                [timer invalidate];
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
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

@end
