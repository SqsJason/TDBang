//
//  UserInstance.h
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/23.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInstance : NSObject

@property(nonatomic,readonly) NSString* userName;
@property(nonatomic,readonly) NSString* userPhone;
@property(nonatomic,readonly) NSString* userPhoto;
@property(nonatomic,readonly) NSString* userFuFen;
@property(nonatomic,readonly) NSString* userExp;
@property(nonatomic,readonly) NSString* userMoney;
@property(nonatomic,readonly) NSString* userLevel;
@property(nonatomic,readonly) NSString* userLevelName;

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

+(UserInstance*)ShardInstnce;
- (void)logout;
- (void)isUserStillOnline;
@end
