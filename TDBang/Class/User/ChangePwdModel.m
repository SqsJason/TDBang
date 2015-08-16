//
//  ChangePwdModel.m
//  TDBang
//
//  Created by sunjason on 15/8/2.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "ChangePwdModel.h"

@implementation ChangePwdParser

@synthesize success,result;

@end

@implementation ChangePwdModel

+ (void)changePwd:(NSString*)newPwd oldPwd:(NSString*)oldPwd success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@&newPwd=%@&oldPwd=%@",API_URL(aChangePassword),appDelegate().accessToken,newPwd,oldPwd];
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

@end
