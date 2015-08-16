//
//  Session.m
//  templateios
//
//  Created by nguyen trung on 10/2/13.
//  Copyright (c) 2013 nguyen trung. All rights reserved.
//


#import "Sessions.h"
#import <objc/runtime.h>
#import "LoginModel.h"
#import "CJSONDeserializer.h"
#import "LoginNewVC.h"

#define SESSION_KEY @"SESSION_DATA"

@implementation Sessions
@synthesize accessToken,userUDID,userInfoModel;
@synthesize locationLat,locationLng;

+ (Sessions*)sharedInstance {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id)init {
    if (self = [super init]) {
        //Init
        [self getData];
    }
    
    return self;
}

- (void)initData {
    self.userUDID                   = nil;
    self.accessToken                = nil;
    self.authValue                  = nil;
    self.profileID                  = nil;
    self.userObjectName             = nil;
    self.numMessage                 = 0;
    self.numPoints                  = 0;
    self.locationLat                = nil;
    self.locationLng                = nil;
    
    self.strExpirationDate          = nil;
    self.ID_for_primaryProfileImage = nil;
}

/*
 * Save properties to NSUserDefaults
 */

- (void)save {
	NSDictionary *allDataTmp     = [self propertiesDictionary];
    NSMutableDictionary *allData = [[NSMutableDictionary alloc] initWithDictionary:allDataTmp];
	
	for (id key in [allDataTmp allKeys]) {
		id value = [allDataTmp objectForKey:key];
		
		if (!([value isKindOfClass:[NSString class]] ||
              [value isKindOfClass:[NSNumber class]])) {
			[allData removeObjectForKey:key];
		}
	}
	
	//Save session
	NSString *sessionKey = [NSString stringWithFormat:@"%@_%@", SESSION_KEY, SESSION_VERSION];
	
    [[NSUserDefaults standardUserDefaults] setObject:allData forKey:sessionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 * Get all properties from NSUserDefaults
 */
- (void)getData {
	NSString     *sessionKey = [NSString stringWithFormat:@"%@_%@", SESSION_KEY, SESSION_VERSION];
	
    NSDictionary *allData    = [[NSUserDefaults standardUserDefaults] objectForKey:sessionKey];
	
    if (allData && ![allData isEqual:[NSNull null]]) {
		[self initData];
		
        NSArray *keyArray =  [allData allKeys];
        int count = (int)[keyArray count];
        for (int i=0; i < count; i++) {
            id obj = [allData objectForKey:[keyArray objectAtIndex:i]];
			if ([self respondsToSelector:NSSelectorFromString([keyArray objectAtIndex:i])]) {
				[self setValue:obj forKey:[keyArray objectAtIndex:i]];
			}
        }
    } else {
        //Init some value
        [self initData];
    }
}
//////////////////////////////////////////////////////////////////////
//Implement all Session-related functions here

- (void) dealloc {
    self.userUDID                   = nil;
    self.accessToken                = nil;
    self.authValue                  = nil;
    self.profileID                  = nil;
    self.userObjectName             = nil;
    self.numPoints                  = 0;
    self.numMessage                 = 0;
    self.strExpirationDate          = nil;
    self.ID_for_primaryProfileImage = nil;
}

//////////////////////////////////////////////////////////////////////
// object extension

- (NSDictionary*)propertiesDictionaryOfObject:(id)obj withClassType:(Class)cls
{
	unsigned int propCount;
	objc_property_t*     properties = class_copyPropertyList(cls, &propCount);
	
	NSMutableDictionary* result     = [NSMutableDictionary dictionary];
	NSString* propertyName;
	id propertyValue;
	
	for(size_t i=0; i<propCount; i++)
	{
		@try
		{
			propertyName  = [NSString stringWithUTF8String:property_getName(properties[i])];
			propertyValue = [obj valueForKey:propertyName];
			
			[result setValue:(propertyValue ? propertyValue : @"nil")
					  forKey:propertyName];
		}
		@catch (NSException* exception)
		{	/* do nothing */	}
	}
	free(properties);
	
	//lookup super classes
	Class superCls = class_getSuperclass(cls);
	while(superCls && ![superCls isEqual:[NSObject class]])
	{
		[result addEntriesFromDictionary:[self propertiesDictionaryOfObject:obj
															  withClassType:superCls]];
		
		superCls = class_getSuperclass(superCls);
	}
	
	return result;
}

- (NSDictionary*)propertiesDictionary
{
	return [self propertiesDictionaryOfObject:self
								withClassType:[self class]];
}

- (NSArray*)methodsArrayOfObject:(id)obj withClassType:(Class)cls
{
	unsigned int propCount;
	Method* methods = class_copyMethodList(cls, &propCount);
	
	NSMutableArray* result = [NSMutableArray array];
	NSString* methodName;
	
	for(size_t i=0; i<propCount; i++)
	{
		@try
		{
			methodName = NSStringFromSelector(method_getName(methods[i]));
			[result addObject:methodName];
		}
		@catch (NSException* exception)
		{	/* do nothing */	}
	}
	free(methods);
	
	return result;
}

- (NSArray*)methodsArray
{
	return [self methodsArrayOfObject:self
						withClassType:[self class]];
}

- (void)gotoLogin:(UIViewController *)fromPage
{
    LoginNewVC* vc = [[LoginNewVC alloc] initWithNibName:@"LoginNewVC" bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [fromPage.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)logout
{
    accessToken = nil;
    userUDID = nil;
    userInfoModel = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kXBCookie];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TDBUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiTypeUserLogout object:nil];
}

- (NSDictionary *)parseJsonData:(NSString *)strJson
{
    NSString *jsonStringSrc     =  strJson;
    NSData *jsonData            =  [jsonStringSrc  dataUsingEncoding : NSUTF8StringEncoding];
    NSError *error              =  nil ;
    NSDictionary *dictionary    =  [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error ];
    return dictionary;
}

- (BOOL)isUserOnline
{
    NSString* cookie = [[[NSUserDefaults standardUserDefaults] objectForKey:kXBCookie] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    __block BOOL isUserOnline = NO;
    if(!cookie || cookie.length == 0)
    {
        [self logout];
        return isUserOnline;
    }else{
        isUserOnline = YES;
        NSDictionary *dicUserInfo = [[NSUserDefaults standardUserDefaults] objectForKey:TDBUserInfo];
        if ([Jxb_Common_Common isNullOrNilObject:dicUserInfo]) {
            [self getCurrentUserInfoSuccess:^(NSObject *result) {
                
            } failure:^(NSError *error) {
                
            }];
        }else{
            ENUserInfo *userInfo = [[ENUserInfo alloc] initUserInfoModelWithDic:dicUserInfo];
            [Sessions sharedInstance].userInfoModel = userInfo;
        }
        
        return isUserOnline;
    }
}

- (void) getCurrentUserInfoSuccess:(void(^)(NSObject* result))success failure:(void(^)(NSError* error))failure
{
    [LoginModel getCurrentUserInfoSuccess:^(AFHTTPRequestOperation *operation, NSObject *result) {
        [[XBToastManager ShardInstance] hideprogress];
        
        UserInfoParser* userInfoParser = [[UserInfoParser alloc] initWithDictionary:(NSDictionary*)result];
        if ([userInfoParser.success boolValue]) {
            NSDictionary *dictionary    =  [self parseJsonData:userInfoParser.result];
            ENUserInfo *userInfo        = [[ENUserInfo alloc] initUserInfoModelWithDic:dictionary];
            if (userInfo != nil) {
                [Sessions sharedInstance].userInfoModel = userInfo;
                success(result);
            }else{
                [self logout];
                failure(nil);
            }
        }else{
            failure(nil);
            [self logout];
        }
    } failure:^(NSError *error) {
        failure(error);
        [[XBToastManager ShardInstance] hideprogress];
        [self logout];
    }];
}


@end