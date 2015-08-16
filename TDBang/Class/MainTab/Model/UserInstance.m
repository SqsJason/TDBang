//
//  UserInstance.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/23.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "UserInstance.h"
#import "UserModel.h"
#import "LoginModel.h"

static UserInstance* user = nil;

@interface UserInstance ()
{
    __block NSString* userName;
    __block NSString* userPhone;
    __block NSString* userId;
    __block NSString* userPhoto;
    __block NSString* userFuFen;
    __block NSString* userExp;
    __block NSString* userMoney;
    __block NSString* userLevel;
    __block NSString* userLevelName;
    
    __block NSString* idNo;
    __block NSString* regType;
    __block NSString* userDesc;
    __block NSString* sex;
    __block NSString* serialId;
    __block NSString* tel;
    __block NSString* companyName;
    __block NSString* fuwuStar;
    __block NSString* headFilePath;
    __block NSString* nickName;
    __block NSString* age;
    __block NSString* xinyongStar;
    __block NSString* createDate;
    __block NSString* headFileId;
    __block NSString* loginPwd;
    __block NSString* loginName;
}

@end

@implementation UserInstance
@synthesize userName,userPhone,userId,userPhoto,userFuFen,userExp,userMoney,userLevel,userLevelName;
@synthesize idNo;
@synthesize regType;
@synthesize userDesc;
@synthesize sex;
@synthesize serialId;
@synthesize tel;
@synthesize companyName;
@synthesize fuwuStar;
@synthesize headFilePath;
@synthesize nickName;
@synthesize age;
@synthesize xinyongStar;
@synthesize createDate;
@synthesize headFileId;
@synthesize loginPwd;
@synthesize loginName;

+(UserInstance*)ShardInstnce
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[UserInstance alloc] init];
    });
    return user;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doNotifyApns:) name:kDidNotifyApns object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isUserStillOnline) name:kDidReloadUser object:nil];
    }
    return self;
}

- (void)doNotifyApns:(NSNotification*)noti
{
    NSString* alter = noti.object;
    [[[UIAlertView alloc] initWithTitle:@"" message:alter delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
}

- (void)logout
{
    userName = nil;
    userPhone = nil;
    userId = nil;
    userPhoto = nil;
    userFuFen = nil;
    userExp = nil;
    userMoney = nil;
    userLevel = nil;
    userLevelName = nil;
    idNo = nil;
    regType = nil;
    userDesc = nil;
    sex = nil;
    serialId = nil;
    tel = nil;
    companyName = nil;
    fuwuStar = nil;
    headFilePath = nil;
    nickName = nil;
    age = nil;
    xinyongStar = nil;
    createDate = nil;
    headFileId = nil;
    loginPwd = nil;
    loginName = nil;
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kXBCookie];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)isUserStillOnline
{
    __weak typeof (self) wSelf = self;
    
    NSString* cookie = [[[NSUserDefaults standardUserDefaults] objectForKey:kXBCookie] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(!cookie || cookie.length == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidLoginOk object:nil];
        return;
    }

    [UserModel getUserInfo:^(AFHTTPRequestOperation* operation, NSObject* result){
        OYUser* user = [[OYUser alloc] initWithDictionary:(NSDictionary*)result];
        if ([user.code intValue] == 0)
        {
            [LoginModel getCurrentUserInfoSuccess:^(AFHTTPRequestOperation *operation, NSObject *result) {
                UserInfoParser* userInfoParser = [[UserInfoParser alloc] initWithDictionary:(NSDictionary*)result];
                if ([userInfoParser.success boolValue]) {
                }
            } failure:^(NSError *error) {
                
            }];
        }
        else
        {
            [wSelf logout];
        }
    } failure:^(NSError* error){
    }];
}

@end
