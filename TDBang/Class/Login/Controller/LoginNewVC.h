//
//  LoginNewVC.h
//  TDBang
//
//  Created by sunjason on 15/7/27.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface LoginNewVC : OneBaseVC
<
    TencentSessionDelegate
>
{
    TencentOAuth* _tencentOAuth;
}

- (IBAction)actionBack:(id)sender;

@end
