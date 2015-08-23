//
//  CommentsListVC.h
//  TDBang
//
//  Created by sunjason on 15/8/17.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"

@interface CommentsListVC : OneBaseVC
<
UITableViewDataSource,
UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableMain;

@property (nonatomic, strong) NSMutableArray *arrAllComments;

@end
