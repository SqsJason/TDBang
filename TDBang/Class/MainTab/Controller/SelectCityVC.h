//
//  SelectCityVC.h
//  TDBang
//
//  Created by sunjason on 15/8/22.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseVC.h"

@interface SelectCityVC : OneBaseVC
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableSelectCity;

@property (nonatomic, strong) NSMutableDictionary *cities;

@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;

@end
