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
    NSString* url = [NSString stringWithFormat:@"%@&SessionID=%@", API_URL(aReleasedTask), appDelegate().accessToken];
    if (![fmName isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmName=%@",fmName]];
//        [url stringByAppendingFormat:@"&fmName=%@",fmName];
    }
    if (![fmContent isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmContent=%@",fmContent]];
//        [url stringByAppendingFormat:@"&fmContent=%@",fmContent];
    }
    if (![fmPayForMoney isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmPayForMoney=%@",fmPayForMoney]];
//        [url stringByAppendingFormat:@"&fmPayForMoney=%@",fmPayForMoney];
    }
    
    if (![province isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&province=%@",province]];
        [url stringByAppendingFormat:@"&province=%@",province];
    }
    if (![city isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&city=%@",city]];
//        [url stringByAppendingFormat:@"&city=%@",city];
    }
    if (![dis isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&dis=%@",dis]];
//        [url stringByAppendingFormat:@"&dis=%@",dis];
    }
    if (![street isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&street=%@",street]];
//        [url stringByAppendingFormat:@"&street=%@",street];
    }
    if (![lat isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&lat=%@",lat]];
//        [url stringByAppendingFormat:@"&lat=%@",lat];
    }
    if (![lng isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&lng=%@",lng]];
//        [url stringByAppendingFormat:@"&lng=%@",lng];
    }
    if (![fmStartDate isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmStartDate=%@",fmStartDate]];
//        [url stringByAppendingFormat:@"&fmStartDate=%@",fmStartDate];
    }
    
    if (![fmEndDate isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmEndDate=%@",fmEndDate]];
//        [url stringByAppendingFormat:@"&fmEndDate=%@",fmEndDate];
    }
    if (![fmStartTime isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmStartTime=%@",fmStartTime]];
//        [url stringByAppendingFormat:@"&fmStartTime=%@",fmStartTime];
    }
    if (![fmEndTime isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmEndTime=%@",fmEndTime]];
//        [url stringByAppendingFormat:@"&fmEndTime=%@",fmEndTime];
    }
    if (![fmPayForJie isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmPayForJie=%@",fmPayForJie]];
//        [url stringByAppendingFormat:@"&fmPayForJie=%@",fmPayForJie];
    }
    if (![fmPayForDesc isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmPayForDesc=%@",fmPayForDesc]];
//        [url stringByAppendingFormat:@"&fmPayForDesc=%@",fmPayForDesc];
    }
    
    if (![fmZhaopinCount isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmZhaopinCount=%@",fmZhaopinCount]];
//        [url stringByAppendingFormat:@"&fmZhaopinCount=%@",fmZhaopinCount];
    }
    if (![fmPhone isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmPhone=%@",fmPhone]];
//        [url stringByAppendingFormat:@"&fmPhone=%@",fmPhone];
    }
    if (![fmQQ isEqualToString:@""]) {
        [url stringByAppendingString:[NSString stringWithFormat:@"&fmQQ=%@",fmQQ]];
//        [url stringByAppendingFormat:@"&fmQQ=%@",fmQQ];
    }
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [[XBApi SharedXBApi] requestWithURL:url paras:nil type:XBHttpResponseType_Json success:success failure:failure];
}

@end
