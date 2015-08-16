//
//  RegModel.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/3/3.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "RegModel.h"

@implementation RegSms
@synthesize state;
@synthesize str;
@end

@implementation RegResut
@synthesize state,str;
@end

@implementation RegisterResut

@synthesize result,success;
@end

@implementation RegGetCode
@synthesize result,success;
@end


@implementation RegModel


/*
 发送验证码：
	地址：user.do?method=getCode
	参数：SessionID=0000001&phone=1370000000
	返回值：{"success","true", "result":"发送成功"}
 */
+ (void)regPhoneSms:(NSString*)phone success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@&phone=%@",API_URL(aGetCode),[Sessions sharedInstance].accessToken,phone];
    NSDictionary *parasDic;
    if (![Jxb_Common_Common isNullOrNilObject:phone] && ![Jxb_Common_Common isNullOrNilObject:[Sessions sharedInstance].accessToken]) {
        parasDic = @{@"SessionID" : [Sessions sharedInstance].accessToken, @"phone" : phone};
    }
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}


/*
 注册：
	地址：user.do?method=doRegister
	参数：SessionID=0000001&phone=1370000000&code=1111&pwd=123123&nickName=用户昵称
	返回值：{"success","true", "result":"注册成功"}
 */
+ (void)regPhoneCode:(NSString*)phone code:(NSString*)code pwd:(NSString *)pwd nickName:(NSString *)nickN success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@&phone=%@&code=%@&pwd=%@&nickName=%@",API_URL(aRegister),[Sessions sharedInstance].userUDID,phone,code,pwd,nickN];
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}


+ (void)regPhoneCode:(NSString*)phone code:(NSString*)code success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:oyRegPhoneCode,phone,code];
    NSString* refer = [NSString stringWithFormat:oyRegRefer,phone];
    [[XBApi SharedXBApi] requestWithURL2:url referer:refer paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

+ (void)regPhoneSetPwd:(NSString*)str pwd:(NSString*)pwd success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:oyRegSetPwd,str,pwd];
    NSString* refer = [NSString stringWithFormat:oyRegSetPwdRefer,str];
    [[XBApi SharedXBApi] requestWithURL2:url referer:refer paras:nil type:XBHttpResponseType_JqueryJson success:success failure:failure];
}

+ (void)regPhoneOK:(NSString*)str success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* refer = [NSString stringWithFormat:oyRegSetPwdRefer,str];
    [[XBApi SharedXBApi] requestWithURL2:oyRegOkUrl referer:refer paras:nil type:XBHttpResponseType_JqueryJson success:success failure:failure];
}

@end
