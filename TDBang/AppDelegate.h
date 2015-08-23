//
//  AppDelegate.h
//  TDBang
//
//  Created by sunjason on 15/7/21.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate : UIResponder
<
UIApplicationDelegate
>

@property (strong, nonatomic) UIWindow      *window;
@property (strong, nonatomic) NSString      *accessToken;
@property (nonatomic, strong) ENUserInfo    *userInfo;
@property (nonatomic, strong) NSString      *qqOAuthAccessToken;
@property (nonatomic, strong) NSString      *qqOAuthOpenId;
@property (nonatomic, strong) NSString      *currentCity;

- (void)setCartNum;

@end

AppDelegate *appDelegate(void);