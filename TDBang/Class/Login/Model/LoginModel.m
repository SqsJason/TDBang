//
//  LoginModel.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/18.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "LoginModel.h"

@implementation LoginParser
@synthesize state;
@end

@implementation LoginParserNew
@synthesize result,success;
@end

@implementation LoginOkParser
@synthesize code;
@end

@implementation LoginModel

+ (void)doLogin:(NSString*)name pwd:(NSString*)pwd success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@&loginName=%@&loginPwd=%@",API_URL(aLogin),[Sessions sharedInstance].accessToken,name,pwd];
    NSLog(@"Login Request URL: %@",url);
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

+ (void)doLoginOK:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    [[XBApi SharedXBApi] requestWithURL:oyLoginOK paras:nil type:XBHttpResponseType_JqueryJson success:success    failure:failure];
}

@end
