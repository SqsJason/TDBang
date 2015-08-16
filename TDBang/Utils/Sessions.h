//
//  Session.h
//  templateios
//
//  Created by nguyen trung on 10/2/13.
//  Copyright (c) 2013 nguyen trung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

typedef NS_ENUM(NSInteger, TaskStatusType) {
    TASK_STATUS_baoming_pre = 1,
    TASK_STATUS_BaoMing_ing = 2,
    TASK_STATUS_START_ing = 3,
    TASK_STATUS_END = 4,
    TASK_STATUS_DELETE = 5
};

/*
 public static final int TASK_STATUS_baoming_pre = 1;// 任务状态：草稿：未支付，不可报名
 public static final int TASK_STATUS_BaoMing_ing = 2;// 任务状态：已支付，选标中
 public static final int TASK_STATUS_START_ing = 3;// 任务选标完成，正在执行中
 public static final int TASK_STATUS_END = 4;// 任务已截止
 public static final int TASK_STATUS_DELETE = 5;// 任务已删除
 */

#define SESSION_VERSION @"09012014"

@interface Sessions : NSObject

@property (nonatomic, strong) NSString      *accessToken;//用户唯一识别码
@property (nonatomic, strong) NSString      *authValue;
@property (nonatomic, strong) NSString      *profileID;//用户账号ID
@property (nonatomic, strong) NSString      *userObjectName;//用户名
@property (nonatomic, strong) NSString      *userUDID;//用户唯一识别码

@property (nonatomic, assign) int           numMessage;
@property (nonatomic, assign) int           numPoints;

@property (nonatomic, strong) NSString      *strExpirationDate;
@property (nonatomic, strong) NSString      *ID_for_primaryProfileImage;
@property (nonatomic, strong) ENUserInfo    *userInfoModel;
@property (nonatomic, strong) NSString      *locationLat;
@property (nonatomic, strong) NSString      *locationLng;
@property (nonatomic, strong) NSString      *province;
@property (nonatomic, strong) NSString      *city;//城市
@property (nonatomic, strong) NSString      *street;//街道
@property (nonatomic, strong) NSString      *dis;//区


+ (Sessions *)sharedInstance;
- (void)initData;
- (void)save;
- (void)getData;

- (void)gotoLogin:(UIViewController *)fromPage;

- (void)logout;
- (BOOL)isUserOnline;
- (void)getCurrentUserInfoSuccess:(void(^)(NSObject* result))success failure:(void(^)(NSError* error))failure;

- (NSDictionary *)parseJsonData:(NSString *)strJson;

- (NSDictionary*)propertiesDictionaryOfObject:(id)obj withClassType:(Class)cls;

////////////////////////////////////////////////////
//Define all Session-related functions here

@end

