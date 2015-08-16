//
//  GetRecommendTasks.m
//  TDBang
//
//  Created by sunjason on 15/8/2.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "GetRecommendTasks.h"

@implementation QueryTasksParser

@synthesize success,result;

@end

@implementation RecommentTasksParser
@synthesize success,result;
@end

@implementation GetRecommendTasks

+ (void)getRecommendTasksWithCity:(NSString *)cityname success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@&city=%@",API_URL(aGetHomeAdviceTasks),[Sessions sharedInstance].accessToken,cityname];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

+ (void)fentchTasksWithPage:(NSString *)pageNo
                       rows:(NSString *)pageSize
                        lat:(NSString *)lat
                        lng:(NSString *)lng
                   province:(NSString *)province
                       city:(NSString *)city
                        dis:(NSString *)dis
                     street:(NSString *)street
                   distance:(NSString *)distance
                     status:(NSString *)status
                      order:(NSString *)order
                    success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success
                    failure:(void(^)(NSError* error))failure
{
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@&page=%@&rows=%@&lat=%@&lng=%@",
                     API_URL(aQueryTasks),
                     [Sessions sharedInstance].accessToken,
                     pageNo,
                     pageSize,
                     lat,
                     lng];
    if (![province isEqualToString:@""]) {
        [url stringByAppendingFormat:@"&province=%@",province];
    }
    if (![city isEqualToString:@""]) {
        [url stringByAppendingFormat:@"&city=%@",city];
    }
    if (![dis isEqualToString:@""]) {
        [url stringByAppendingFormat:@"&dis=%@",dis];
    }
    if (![street isEqualToString:@""]) {
        [url stringByAppendingFormat:@"&street=%@",street];
    }
    if (![distance isEqualToString:@""]) {
        [url stringByAppendingFormat:@"&distance=%@",distance];
    }
    if (![status isEqualToString:@""]) {
        [url stringByAppendingFormat:@"&status=%@",status];
    }
    if (![order isEqualToString:@""]) {
        [url stringByAppendingFormat:@"&order=%@",order];
    }
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}


@end