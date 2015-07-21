//
//  Session.m
//  templateios
//
//  Created by nguyen trung on 10/2/13.
//  Copyright (c) 2013 nguyen trung. All rights reserved.
//


#import "Sessions.h"
#import <objc/runtime.h>

#define SESSION_KEY @"SESSION_DATA"

@implementation Sessions
@synthesize accessToken,userUDID;

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


@end