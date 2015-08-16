//
//  ChangeUserInfoModel.h
//  TDBang
//
//  Created by sunjason on 15/8/2.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateUserInfoParser : OneBaseParser
@property (nonatomic,copy)NSNumber* success;
@property (nonatomic,copy)NSString* result;
@end

@interface ChangeUserInfoModel : NSObject
+ (void)updateUserInfo:(NSString*)phone
           identityNum:(NSString *)idNumber
              nickName:(NSString*)nickName
                gender:(NSString *)gender
                   age:(NSString *)age
           companyName:(NSString *)companyName
              userDesc:(NSString *)userDesc
               success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success
               failure:(void(^)(NSError* error))failure;

@end