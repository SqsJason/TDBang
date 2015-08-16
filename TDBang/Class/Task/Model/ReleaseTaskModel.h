//
//  ReleaseTaskModel.h
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReleaseTasksParser : OneBaseParser
@property (nonatomic,copy)NSNumber* success;
@property (nonatomic,copy)NSString* result;
@end

@interface ReleaseTaskModel : NSObject

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
                    success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure;

@end
