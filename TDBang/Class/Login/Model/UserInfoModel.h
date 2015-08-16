//
//  UserInfoModel.h
//  TDBang
//
//  Created by sunjason on 15/7/31.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ENUserInfo : NSObject

@property (nonatomic, copy) NSString *idNo;
@property (nonatomic, copy) NSString *regType;
@property (nonatomic, copy) NSString *userDesc;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *serialId;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *fuwuStar;
@property (nonatomic, copy) NSString *headFilePath;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *xinyongStar;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *headFileId;
@property (nonatomic, copy) NSString *loginPwd;
@property (nonatomic, copy) NSString *loginName;

- (ENUserInfo *)initUserInfoModelWithDic:(NSDictionary *)dic;

@end
