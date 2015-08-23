//
//  QueryComment.h
//  TDBang
//
//  Created by sunjason on 15/8/6.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskCommentModel : OneBaseParser

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDictionary *id;
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSDictionary *task;
@property (nonatomic, strong) NSString *commendType;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSDictionary *user;

@end

@interface QueryCommentParser : OneBaseParser
@property (nonatomic,copy)NSNumber* success;
@property (nonatomic,copy)NSString* result;
@end

@interface QueryComment : NSObject

+ (void)getTaskCommentWithSession:(NSString *)sessionID taskId:(NSString *)taskId success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure;

+ (void)writeCommentWithTaskId:(NSString *)taskId commentContent:(NSString *)commentContent success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure;

+ (void)signTaskWithTaskId:(NSString *)taskId success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure;

@end
