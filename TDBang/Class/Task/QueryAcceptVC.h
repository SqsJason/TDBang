//
//  QueryAcceptVC.h
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"

@interface QueryAcceptVC : OneBaseVC
<
UITableViewDataSource,UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tvAcceptTasks;


@end
