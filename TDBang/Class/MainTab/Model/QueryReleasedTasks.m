//
//  QueryReleasedTasks.m
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "QueryReleasedTasks.h"

@implementation QueryReleasedTasksParser

@synthesize success,result;

@end

@implementation QueryReleasedTasks

+ (void)getReleasedTasksWithUserId:(NSString *)uid success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@&userId=%@",API_URL(aGetReleasedTasks),appDelegate().accessToken,uid];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

@end
