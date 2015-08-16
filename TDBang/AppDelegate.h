//
//  AppDelegate.h
//  TDBang
//
//  Created by sunjason on 15/7/21.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow      *window;
@property (strong, nonatomic) NSString      *accessToken;
@property (nonatomic, strong) ENUserInfo    *userInfo;

- (void)setCartNum;

@end

AppDelegate *appDelegate(void);