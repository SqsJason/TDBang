//
//  NSDictionary+Utility.m
//  ZapSpa
//
//  Created by Andy Boariu on 27/03/14.
//  Copyright (c) 2014 ZapSpa LLC. All rights reserved.
//

#import "NSDictionary+Utility.h"

@implementation NSDictionary (Utility)

// in case of [NSNull null] values a nil is returned ...
- (id)objectForKeyNotNull:(id)key
{
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return nil;
    
    return object;
}

@end
