//
//  QueryTasksModel.h
//  TDBang
//
//  Created by sunjason on 15/8/3.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "OneBaseParser.h"

@interface TaskModel : OneBaseParser

@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSDictionary *other;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *commendType;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSDictionary *createUser;
@property (nonatomic, strong) NSString *dis;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *payType;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *createUserId;

@end

@interface QueryTasksModel : OneBaseParser

@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSMutableArray *rows;

@end
