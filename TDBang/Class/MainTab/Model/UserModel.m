//
//  UserModel.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/19.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "UserModel.h"

@implementation OYUser
@synthesize username;
@end

@implementation UserModel

+ (void)getUserInfo:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    [[XBApi SharedXBApi] requestWithURL:oyGetUserInfo paras:nil type:XBHttpResponseType_JqueryJson success:success failure:failure];
}

+ (void)getUserDetail:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    [[XBApi SharedXBApi] requestWithURL:oyMineUserUrl paras:nil type:XBHttpResponseType_Common success:success failure:failure];
}

+ (void)uploadHeadImage:(NSData *)imageData success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@",API_URL(aGetHomeAdviceTasks),appDelegate().accessToken];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

@end
