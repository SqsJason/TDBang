//
//  AcceptTaskModel.m
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "AcceptTaskModel.h"

@implementation AcceptTasksParser

@end

@implementation AcceptTaskModel

+ (void)getAcceptTasksWithSession:(NSString *)sessionID success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@",API_URL(aAcceptTask),[Sessions sharedInstance].accessToken];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

@end
