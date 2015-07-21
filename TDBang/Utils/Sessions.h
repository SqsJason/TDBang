//
//  Session.h
//  templateios
//
//  Created by nguyen trung on 10/2/13.
//  Copyright (c) 2013 nguyen trung. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SESSION_VERSION @"09012014"

@interface Sessions : NSObject

@property (nonatomic, strong) NSString  *accessToken;//用户唯一识别码
@property (nonatomic, strong) NSString  *authValue;
@property (nonatomic, strong) NSString  *profileID;//用户账号ID
@property (nonatomic, strong) NSString  *userObjectName;//用户名
@property (nonatomic, strong) NSString  *userUDID;//用户唯一识别码

@property (nonatomic, assign) int       numMessage;
@property (nonatomic, assign) int       numPoints;

@property (nonatomic, strong) NSString  *strExpirationDate;
@property (nonatomic, strong) NSString  *ID_for_primaryProfileImage;


+ (Sessions *)sharedInstance;
- (void)initData;
- (void)save;
- (void)getData;

////////////////////////////////////////////////////
//Define all Session-related functions here

@end

