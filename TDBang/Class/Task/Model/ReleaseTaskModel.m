//
//  ReleaseTaskModel.m
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "ReleaseTaskModel.h"

@implementation ReleaseTasksParser

@synthesize success,result;

@end

@implementation ReleaseTaskModel

+ (void)releaseTasksWithfmName:(NSString *)fmName
                     fmContent:(NSString *)fmContent
                 fmPayForMoney:(NSString *)fmPayForMoney
                      province:(NSString *)province
                          city:(NSString *)city
                           dis:(NSString *)dis
                        street:(NSString *)street
                           lat:(NSString *)lat
                           lng:(NSString *)lng
                   fmStartDate:(NSString *)fmStartDate
                     fmEndDate:(NSString *)fmEndDate
                   fmStartTime:(NSString *)fmStartTime
                     fmEndTime:(NSString *)fmEndTime
                   fmPayForJie:(NSString *)fmPayForJie
                  fmPayForDesc:(NSString *)fmPayForDesc
                fmZhaopinCount:(NSString *)fmZhaopinCount
                       fmPhone:(NSString *)fmPhone
                          fmQQ:(NSString *)fmQQ
                       success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure
{
    NSString* url = [[NSString alloc] initWithFormat:@"%@&SessionID=%@", API_URL(aReleasedTask), appDelegate().accessToken];
    if (![fmName isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmName=%@",fmName];
    }
    if (![fmContent isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmContent=%@",fmContent];
    }
    if (![fmPayForMoney isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmPayForMoney=%@",fmPayForMoney];
    }
    
    if (![province isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&province=%@",province];
    }
    if (![city isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&city=%@",city];
    }
    if (![dis isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&dis=%@",dis];
    }
    if (![street isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&street=%@",street];
    }
    if (![lat isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&lat=%@",lat];
    }
    if (![lng isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&lng=%@",lng];
    }
    if (![fmStartDate isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmStartDate=%@",fmStartDate];
    }
    
    if (![fmEndDate isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmEndDate=%@",fmEndDate];
    }
    if (![fmStartTime isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmStartTime=%@",fmStartTime];
    }
    if (![fmEndTime isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmEndTime=%@",fmEndTime];
    }
    if (![fmPayForJie isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmPayForJie=%@",fmPayForJie];
    }
    if (![fmPayForDesc isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmPayForDesc=%@",fmPayForDesc];
    }
    
    if (![fmZhaopinCount isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmZhaopinCount=%@",fmZhaopinCount];
    }
    if (![fmPhone isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmPhone=%@",fmPhone];
    }
    if (![fmQQ isEqualToString:@""]) {
        url = [url stringByAppendingFormat:@"&fmQQ=%@",fmQQ];
    }
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

@end
