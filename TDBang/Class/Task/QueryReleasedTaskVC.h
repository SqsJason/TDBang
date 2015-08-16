//
//  QueryReleasedTaskVC.h
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"

@interface QueryReleasedTaskVC : OneBaseVC

@property (weak, nonatomic) IBOutlet UITableView *tvReleasedTasks;
@property (weak, nonatomic) IBOutlet UIView *vButtonHolder;

- (IBAction)actionReleaseTask:(id)sender;

@end
