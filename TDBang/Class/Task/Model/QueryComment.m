//
//  QueryComment.m
//  TDBang
//
//  Created by sunjason on 15/8/6.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "QueryComment.h"

@implementation TaskCommentModel

@end

@implementation QueryCommentParser
@synthesize success,result;
@end

@implementation QueryComment

+ (void)getTaskCommentWithSession:(NSString *)sessionID taskId:(NSString *)taskId success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@&taskId=%@",API_URL(aTaskComments),[Sessions sharedInstance].accessToken,taskId];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

@end
