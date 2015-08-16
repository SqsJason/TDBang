//
//  ChangePasswordVC.h
//  TDBang
//
//  Created by sunjason on 15/8/2.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"

@interface ChangePasswordVC : OneBaseVC
@property (weak, nonatomic) IBOutlet UITextField *tfOldPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfNewPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmNewPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnChange;
- (IBAction)actionChangeClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *vContentHolder;


@end
