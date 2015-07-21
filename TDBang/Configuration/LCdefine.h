//
//  LCdefine.h
//  Lola
//
//  Created by LC-Mac on 15/7/6.
//  Copyright (c) 2015年 LOLA LLC. All rights reserved.
//

#ifndef Lola_LCdefine_h
#define Lola_LCdefine_h


//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//单例对象申明
#define SHARED_INSTANCE_DECLARE(className)   +(className *)sharedInstance;
#define SHARED_INSTANCE_DEFINE(className) \
+ (className *)sharedInstance { \
static className *_ ## className = nil; \
if (!_ ## className) { \
_ ## className = [[className alloc] init]; \
} \
return _ ## className; \
}


#endif
