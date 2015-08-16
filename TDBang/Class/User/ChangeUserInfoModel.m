//
//  ChangeUserInfoModel.m
//  TDBang
//
//  Created by sunjason on 15/8/2.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "ChangeUserInfoModel.h"

@implementation UpdateUserInfoParser

@synthesize success;
@synthesize result;

@end

@implementation ChangeUserInfoModel

+ (void)updateUserInfo:(NSString *)phone
           identityNum:(NSString *)idNumber
              nickName:(NSString *)nickName
                gender:(NSString *)gender
                   age:(NSString *)age
           companyName:(NSString *)companyName
              userDesc:(NSString *)userDesc
               success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success
               failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@&tel=%@&serialId=%@&nickName=%@&sex=%@&age=%@&companyName=%@&userDesc=%@",API_URL(aUpdateUserInfo),[Sessions sharedInstance].accessToken,phone,idNumber,nickName,gender,age,companyName,userDesc];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"URL: %@",url);
    
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

@end
