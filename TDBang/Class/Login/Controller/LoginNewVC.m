//
//  LoginNewVC.m
//  TDBang
//
//  Created by sunjason on 15/7/27.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "LoginNewVC.h"
#import "RegUserNewVC.h"
#import "LoginModel.h"

@interface LoginNewVC ()
{
    __weak IBOutlet UIView *vHolder;
    __weak IBOutlet UIImageView *imvHead;
    __weak IBOutlet UITextField *tfUserName;
    __weak IBOutlet UITextField *tfPassword;
    __weak IBOutlet UIButton *btnLogin;
    __weak IBOutlet UIButton *btnQQLogin;
    
}
- (IBAction)actionLogin:(id)sender;
- (IBAction)actionQQLogin:(id)sender;
- (IBAction)actionRegister:(id)sender;


@end

@implementation LoginNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_register"]]];
    
    self.title = @"登录";
    
    UITapGestureRecognizer *_left = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap:)];
    [self.view addGestureRecognizer:_left];
}

- (void) handTap:(UITapGestureRecognizer*) gesture
{
    for (UITextField *tf in [vHolder subviews]) {
        if ([tf isFirstResponder]) {
            [tf resignFirstResponder];
            break;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UINavigationBar appearance].hidden =YES;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UINavigationBar appearance].hidden =NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)actionLogin:(id)sender {
    if(tfUserName.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入账号"];
        return;
    }
    if(tfPassword.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入密码"];
        return;
    }
    [[XBToastManager ShardInstance] showprogress];
    [LoginModel doLogin:tfUserName.text pwd:tfPassword.text success:^(AFHTTPRequestOperation* operation, NSObject* result){
        
        [[XBToastManager ShardInstance] hideprogress];
        
        LoginParserNew* parser2 = [[LoginParserNew alloc] initWithDictionary:(NSDictionary*)result];
        tfUserName.text = parser2.result;
        if ([parser2.success boolValue]) {
            //登陆成功
            
        }else{
            //登录失败
        }
    } failure:^(NSError* error){
        
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"登录失败"];
    }];
}

- (IBAction)actionQQLogin:(id)sender {
    
}

- (IBAction)actionRegister:(id)sender {
    RegUserNewVC* vc  = [[RegUserNewVC alloc] initWithNibName:@"RegUserNewVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
