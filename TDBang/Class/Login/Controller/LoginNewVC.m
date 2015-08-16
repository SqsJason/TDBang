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
#import "UserInfoModel.h"
#import "CJSONDeserializer.h"

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
    
    tfUserName.text = @"";
    tfPassword.text = @"";
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
    
    __weak typeof(self) weakSelf = self;
    [[XBToastManager ShardInstance] showprogress];
    [LoginModel doLogin:tfUserName.text pwd:tfPassword.text success:^(AFHTTPRequestOperation* operation, NSObject* result){
        [[XBToastManager ShardInstance] hideprogress];
        
        LoginParserNew* parser2 = [[LoginParserNew alloc] initWithDictionary:(NSDictionary*)result];
        if ([parser2.success boolValue]) {
            //登陆成功
            [weakSelf getUserBasicInfo];
        }else{
            //登录失败
            [[XBToastManager ShardInstance] showtoast:parser2.result];
        }
    } failure:^(NSError* error){
        
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"登录失败"];
    }];
}

- (void) didUserLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiTypeUserLogin object:nil];
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    self.tabBarController.selectedIndex = 1;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)getUserBasicInfo
{
    __weak typeof(self) weakSelf = self;
    [LoginModel getCurrentUserInfoSuccess:^(AFHTTPRequestOperation *operation, NSObject *result) {
        UserInfoParser* userInfoParser = [[UserInfoParser alloc] initWithDictionary:(NSDictionary*)result];
        if ([userInfoParser.success boolValue]) {
            
            NSString *jsonStringSrc     =  userInfoParser.result;
            NSData *jsonData            =  [jsonStringSrc  dataUsingEncoding : NSUTF8StringEncoding];
            NSError *error              =  nil ;
            NSDictionary *dictionary    =  [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error ];
            
            NSString* cookie = [NSString stringWithFormat:@"_uName=%@;_uid=%@",tfUserName.text,[Sessions sharedInstance].userUDID];
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:kXBCookie];
            [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:TDBUserInfo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            ENUserInfo *userInfo     = [[ENUserInfo alloc] initUserInfoModelWithDic:dictionary];
            
            if (userInfo != nil) {
                [Sessions sharedInstance].userInfoModel = userInfo;
                [weakSelf didUserLogin];
            }else{
                
            }
        }
        [[XBToastManager ShardInstance] hideprogress];
    } failure:^(NSError *error) {
        [[XBToastManager ShardInstance] hideprogress];
    }];
}

- (IBAction)actionQQLogin:(id)sender {
    
}

- (IBAction)actionRegister:(id)sender {
    RegUserNewVC* vc  = [[RegUserNewVC alloc] initWithNibName:@"RegUserNewVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
