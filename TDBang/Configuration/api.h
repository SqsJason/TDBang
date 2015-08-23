//
//  api.h
//  LunchClick
//
//  Created by Harry Nguyen on 1/3/14.
//  Copyright (c) 2014 Harry Nguyen. All rights reserved.
//

#define SERVER_TEST

#ifdef  SERVER_TEST
//Dev 环境
#define RootURL                     @"http://121.42.212.16:7002/TDBServer/%@"

#else
//Live 环境
#define RootURL                     @"http://121.42.212.16:7002/TDBServer/%@"

#endif

////////////////////////////////////////////////////
#define methodPost                  @"POST"
#define methodPut                   @"PUT"
#define methodDelete                @"DELETE"

#define apiRequestTimeout           15.0 //TimeOut 15秒钟
#define API_URL(api) [NSString stringWithFormat:RootURL, api]
////////////////////////////////////////////////////

/// API

//发送验证码
#define aGetCode                    @"user.do?method=getCode"

//注册
#define aRegister                   @"user.do?method=doRegister"

//登录
#define aLogin                      @"user.do?method=doLogin"

//获取当前用户信息
#define aGetCurrentUserInfo         @"user.do?method=getCurrentUserInfo"
#define aGetUserInfoById            @"user.do?method=getById"
#define aChangePassword             @"user.do?method=updatePwd"
#define aUpdateUserInfo             @"user.do?method=saveUser"
#define aUpdateUserHead             @"user.do?method=updateUserHead"

//查询任务
#define aQueryTasks                 @"task.do?method=query"

//任务相关
#define aGetRecommentTasks          @"task.do?method=queryRecommendYou"

//获取首页推荐任务
#define aGetHomeAdviceTasks         @"task.do?method=queryRecommendDefault"

//查询某个人已接的任务
#define aGetReleasedTasks           @"task.do?method=queryReleaseByUserId"

//查询某个人已接的任务
#define aReleasedTask               @"task.do?method=save"

//查询某个人已接的任务
#define aAcceptTask                 @"task.do?method=queryMySign"

#define aTaskComments               @"task.do?method=queryComment"
#define aSaveComments               @"task.do?method=saveComment"
#define aSignTask                   @"task.do?method=saveSign"
#define aComplain                   @"task.do?method=saveComplain"

