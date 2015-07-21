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

#define titleCancel                     @"Cancel"
#define titleOK                         @"OK"
#define NotiFreshDatebook               @"Noti_FreshDatebook"
#define NotiCreateproposal              @"Noti_CreateProposal"
#define NotiReproposalSuccess           @"Noti_ReProposalSuccess"
#define NotiReproposalSuccessOK         @"Noti_ReProposalSuccessOK"
#define NotiEmailAddressAlreadyUsed     @"Noti_EmailAddressAlreadyUsed"

#define AskQuestionNow                  @"AskQuestionNow"
#define NotiGetDateActivities           @"Noti_GetDateActivities"
#define NotiUpdateCurrentCity           @"Noti_UpdateCurrentCity"

#define chatMessageType                 @"chat:messageWithQuestion"
#define chatMessageWithQueType          @"chat:message"

///Modify For V 2.0.0
#define NotiTypeTodayMatched            @"profileMatch:matched"
#define NotiTypeTodayLiked              @"profileMatch:liked"
#define NotiTypeTodayReminder           @"profileMatch:reminder"


///Modify For V 2.4.3
#define NotiTypeDatebookShowFRAlert     @"Noti_DatebookShowFRAlert"
#define NotiTypeUpdatePrimaryPhoto      @"Noti_UpdatePrimaryPhoto"

#define NotiTypeCrashLogMessage         @"Noti_CrashLogMessage"

////////////////////////////////

// define colors
#define CLGRAY89                        0x898989
#define CLGRAY99                        0xa0a0a0
#define CLWHITE                         0xffffff
#define CLBLACK                         0x000000
#define CLRedF16                        0xf16963
#define CLBlue125                       0x1252a3
