//
//  ChangePwdModel.h
//  TDBang
//
//  Created by sunjason on 15/8/2.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangePwdParser : OneBaseParser
@property (nonatomic,copy)NSNumber* success;
@property (nonatomic,copy)NSString* result;
@end

@interface ChangePwdModel : NSObject

+ (void)changePwd:(NSString*)newPwd oldPwd:(NSString*)oldPwd success:(void(^)(AFHTTPRequestOperation* operation, NSObject* result))success failure:(void(^)(NSError* error))failure;

@end
