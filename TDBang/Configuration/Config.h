//
//  Config.h
//  LunchClick
//
//  Created by Harry Nguyen on 1/3/14.
//  Copyright (c) 2014 Harry Nguyen. All rights reserved.
//

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \

/////////////////////////////////////

//Appdelegate
#define haveSelectedCity                @"haveSelectedCity"

#define heightColorBottomInImages       0
#define heightBootomItem    44

// folder data in local

#define folderData                      @"data"
#define folderUser                      @"User"
#define folderUserMatch                 @"UserMatch"

/// show message

#define mCheckConnection                @"Please check your internet connection!"
#define mLoading                        @"Loading..."
#define mPleaseWait                     @"Please wait..."
#define mNotice                         @"Notice"
#define mWarning                        @"Warning"
#define mNoResult                       @"No result"
#define mError                          @"Error"


#define NotiTypeUserLogin               @"Noti_TypeUserLogin"
#define NotiTypeUserLogout              @"Noti_TypeUserLogout"
#define NotiTypeUserUpdateInfo          @"Noti_TypeUserUpdateInfo"

#define NotiTypeReleaseTask             @"Noti_TypeReleaseTaskSuccess"

///Error Messages
#define ErrorLoginFailed                @"登录出现异常"
