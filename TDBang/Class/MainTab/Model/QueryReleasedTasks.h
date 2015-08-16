//
//  QueryReleasedTasks.h
//  TDBang
//
//  Created by sunjason on 15/8/5.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryReleasedTasksParser : OneBaseParser
@property (nonatomic,copy)NSNumber* success;
@property (nonatomic,copy)NSString* result;
@end

@interface QueryReleasedTasks : NSObject

+ (void)getReleasedTasksWithUserId:(NSString *)uid success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure;

@end
