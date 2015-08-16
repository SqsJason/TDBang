//
//  GetRecommendTasks.h
//  TDBang
//
//  Created by sunjason on 15/8/2.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommentTasksParser : OneBaseParser
@property (nonatomic,copy)NSNumber* success;
@property (nonatomic,copy)NSString* result;
@end

@interface QueryTasksParser : OneBaseParser
@property (nonatomic,copy)NSNumber* success;
@property (nonatomic,copy)NSString* result;
@end

@interface GetRecommendTasks : NSObject

+ (void)getRecommendTasksWithCity:(NSString *)cityname success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure;

+ (void)fentchTasksWithPage:(NSString *)pageNo
                       rows:(NSString *)pageSize
                        lat:(NSString *)lat
                        lng:(NSString *)lng
                   province:(NSString *)province
                       city:(NSString *)city
                        dis:(NSString *)dic
                     street:(NSString *)street
                   distance:(NSString *)distance
                     status:(NSString *)status
                      order:(NSString *)order
                    success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure;

@end
