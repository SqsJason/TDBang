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





