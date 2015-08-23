//
//  UserAdviceVC.h
//  TDBang
//
//  Created by sunjason on 15/8/22.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"

@interface UserAdviceVC : OneBaseVC
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (strong, nonatomic) IBOutlet UIView *tableAdvice;

@property (strong, nonatomic) IBOutlet UITableViewCell *inputAdviceCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *submitAdviceCell;
@property (weak, nonatomic) IBOutlet UITextView *tvInputAdvice;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic, strong) NSString *adviceTaskId;

- (IBAction)actionSubmit:(id)sender;

@end
