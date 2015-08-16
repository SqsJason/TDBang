//
//  UserInfoModel.m
//  TDBang
//
//  Created by sunjason on 15/7/31.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "UserInfoModel.h"

@implementation ENUserInfo

@synthesize idNo;
@synthesize regType;
@synthesize userDesc;
@synthesize sex;
@synthesize serialId;
@synthesize tel;
@synthesize companyName;
@synthesize fuwuStar;
@synthesize headFilePath;
@synthesize userId;
@synthesize nickName;
@synthesize age;
@synthesize xinyongStar;
@synthesize createDate;
@synthesize headFileId;
@synthesize loginPwd;
@synthesize loginName;

/*
 {
 "idNo": "",
 "regType": "",
 "userDesc": "很自恋 很猖狂， 很霸道，很有主见很自恋 很猖狂， 很霸道，很有主见，很会玩，很多朋友。，很会玩，很多朋友。",
 "sex": "0",
 "serialId": "20BEF479-6F44-4B9A-A51A-35359F73D50F",
 "tel": "13864237327",
 "companyName": "百度",
 "fuwuStar": 1,
 "headFilePath": "http://121.42.212.16:7002/TDBServer//fileupload/userHead/1437573482724.jpg",
 "id": 13,
 "nickName": "小破孩",
 "age": 28,
 "xinyongStar": 1,
 "createDate": "2015-07-21 12:04:26",
 "headFileId": 6,
 "loginPwd": "",
 "loginName": "13864237327"
 }
 */

- (ENUserInfo *)initUserInfoModelWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"idNo"]]) {
        self.idNo = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"id"] intValue]];
    }else{
        self.idNo = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"regType"]]) {
        self.regType = [dic objectForKey:@"regType"];
    }else{
        self.regType = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"userDesc"]]) {
        self.userDesc = [dic objectForKey:@"userDesc"];
    }else{
        self.userDesc = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"sex"]]) {
        if ([[dic objectForKey:@"sex"] integerValue] == 0) {
            self.sex = @"女";
        }else{
            self.sex = @"男";
        }
    }else{
        self.sex = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"serialId"]]) {
        self.serialId = [dic objectForKey:@"serialId"];
    }else{
        self.serialId = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"tel"]]) {
        self.tel = [dic objectForKey:@"tel"];
    }else{
        self.tel = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"companyName"]]) {
        self.companyName = [dic objectForKey:@"companyName"];
    }else{
        self.companyName = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"fuwuStar"]]) {
        self.fuwuStar = [dic objectForKey:@"fuwuStar"];
    }else{
        self.fuwuStar = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"headFilePath"]]) {
        self.headFilePath = [dic objectForKey:@"headFilePath"];
    }else{
        self.headFilePath = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"id"]]) {
        self.userId = [dic objectForKey:@"id"];
    }else{
        self.userId = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"nickName"]]) {
        self.nickName = [dic objectForKey:@"nickName"];
    }else{
        self.nickName = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"age"]]) {
        self.age = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"age"] intValue]];
    }else{
        self.age = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"xinyongStar"]]) {
        self.xinyongStar = [dic objectForKey:@"xinyongStar"];
    }else{
        self.xinyongStar = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"createDate"]]) {
        self.createDate = [dic objectForKey:@"createDate"];
    }else{
        self.createDate = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"headFileId"]]) {
        self.headFileId = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"headFileId"] intValue]];
    }else{
        self.headFileId = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"loginPwd"]]) {
        self.loginPwd = [dic objectForKey:@"loginPwd"];
    }else{
        self.loginPwd = @"";
    }
    
    if (![Jxb_Common_Common isNullOrNilObject:[dic objectForKey:@"loginName"]]) {
        self.loginName = [dic objectForKey:@"loginName"];
    }else{
        self.loginName = @"";
    }
    
    return self;
}

@end
