//
//  AppDelegate.m
//  TDBang
//
//  Created by sunjason on 15/7/21.
//  Copyright (c) 2015年 tengdabang. All rights reserved.
//

#import "AppDelegate.h"
#import "UserInstance.h"
#import "TabHomeVC.h"
#import "TabMineVC.h"
#import "TabNewestVC.h"
#import "TabProductVC.h"
#import "TabShopCartVC.h"
#import "CartModel.h"
#import "APService.h"
#import "OyTool.h"
#import "OYDownLibVC.h"

#define oyUseLib    0

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (UIViewController*)loadFramework
{
    NSLog(@"%@",NSHomeDirectory());
    NSString* libFile = [NSString stringWithFormat:@"%@/Documents/OY.framework",NSHomeDirectory()];
    //判断一下有没有这个文件的存在　如果没有直接跳出
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:libFile]) {
        NSLog(@"There isn't have the file");
        return nil;
    }
    
    //复制到程序中
    NSError *error = nil;
    
    NSBundle *frameworkBundle = [NSBundle bundleWithPath:libFile];
    if (frameworkBundle && [frameworkBundle load]) {
        NSLog(@"bundle load framework success.");
    }else {
        NSLog(@"bundle load framework err:%@",error);
        return nil;
    }
    
    Class pacteraClass = NSClassFromString(@"OYMainClass");
    if (!pacteraClass) {
        NSLog(@"Unable to get TestDylib class");
        return nil;
    }
    
    NSObject *pacteraObject = [pacteraClass new];//必须new
    NSArray* vcs = [pacteraObject performSelector:@selector(getMainTabVC:appDelegate:) withObject:_window withObject:self];
    
    [frameworkBundle unload];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = vcs;
    tabBarController.delegate = self;
    
    
    // customise TabBar UI Effect
    [UITabBar appearance].tintColor = BG_COLOR;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:TABBAR_TEXT_NOR_COLOR} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:TABBAR_TEXT_HLT_COLOR} forState:UIControlStateSelected];
    
    // customise NavigationBar UI Effect
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithRenderColor:NAVBAR_COLOR renderSize:CGSizeMake(10., 10.)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    UITabBar *tabBar = tabBarController.tabBar;
    tabBar.backgroundColor = BG_COLOR;
    
    
    return tabBarController;
}

- (void)getMainTabVC:(UIViewController *)mainTabVC appDelegate:(AppDelegate *)deleagte
{
    
}

- (UITabBarController*)setRootVC:(BOOL)bShowCart
{
    TabHomeVC *homeVC = [[TabHomeVC alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UIImage *unselectedImage = [UIImage imageNamed:@"tab-home"];
    UIImage *selectedImage = [UIImage imageNamed:@"tab-home-s"];
    
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    homeVC.tabBarItem.tag = 0;
    
    TabProductVC *proVC = [[TabProductVC alloc] init];
    UINavigationController *proNav = [[UINavigationController alloc] initWithRootViewController:proVC];
    unselectedImage = [UIImage imageNamed:@"tab-pro"];
    selectedImage = [UIImage imageNamed:@"tab-pro-s"];
    
    proNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"任务"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    proNav.tabBarItem.tag = 1;
    
    TabNewestVC * newVc = [[TabNewestVC alloc] init];
    UINavigationController * newNav = [[UINavigationController alloc] initWithRootViewController:newVc];
    unselectedImage = [UIImage imageNamed:@"tab-new"];
    selectedImage = [UIImage imageNamed:@"tab-new-s"];
    
    newNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"管理"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    newNav.tabBarItem.tag = 2;
    
    TabShopCartVC * cartVc = [[TabShopCartVC alloc] init];
    UINavigationController * cartNav = [[UINavigationController alloc] initWithRootViewController:cartVc];
    unselectedImage = [UIImage imageNamed:@"tab-cart"];
    selectedImage = [UIImage imageNamed:@"tab-cart-s"];
    
    cartNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物"
                                                       image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    cartNav.tabBarItem.tag = 3;
    
    TabMineVC * mineVc = [[TabMineVC alloc] init];
    UINavigationController * mineNav = [[UINavigationController alloc] initWithRootViewController:mineVc];
    unselectedImage = [UIImage imageNamed:@"tab-mine"];
    selectedImage = [UIImage imageNamed:@"tab-mine-s"];
    
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                       image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    mineNav.tabBarItem.tag = 3;
    
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    if(bShowCart)
        tabBarController.viewControllers = @[homeNav,proNav,newNav,mineNav];
    else
        tabBarController.viewControllers = @[homeNav,proNav,newNav,mineNav];
    tabBarController.delegate = self;
    
    
    // customise TabBar UI Effect
    [UITabBar appearance].tintColor = BG_COLOR;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:TABBAR_TEXT_NOR_COLOR} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:TABBAR_TEXT_HLT_COLOR} forState:UIControlStateSelected];
    
    // customise NavigationBar UI Effect
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithRenderColor:NAVBAR_COLOR renderSize:CGSizeMake(10., 10.)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    UITabBar *tabBar = tabBarController.tabBar;
    tabBar.backgroundColor = BG_COLOR;
    
    return tabBarController;
}

- (void)setCartNum
{
    UITabBarController* tabVC = (UITabBarController*)self.window.rootViewController;
    UINavigationController* navVC = [tabVC.viewControllers objectAtIndex:3];
    __weak typeof (navVC) wNav = navVC;
    [CartModel quertCart:nil value:nil block:^(NSArray* result){
        if(result.count > 0)
            wNav.tabBarItem.badgeValue  = [NSString stringWithFormat:@"%d",(int)result.count];
        else
            wNav.tabBarItem.badgeValue  = nil;
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadApp) name:kDidShowCart object:nil];
    
    [[Sessions sharedInstance] isUserOnline];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //    [self setUmeng];
    //    [self setJPush:launchOptions];
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    
    UIViewController *rootViewController = [self setRootVC:YES];
    [[self window] setRootViewController:rootViewController];
    
    // set  backgroundColor
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    // set  makeKeyAndVisible
    [[self window] makeKeyAndVisible];
    
    //QQ登录权限
    self.qqOAuthAccessToken = [[NSString alloc] init];
    self.qqOAuthOpenId = [[NSString alloc] init];
    self.currentCity = [[NSString alloc] init];
    self.currentCity = @"徐州";
    
    self.accessToken = [[NSString alloc] init];
    [Sessions sharedInstance].accessToken = [OpenUDID value];//userUDID
    [Sessions sharedInstance].userUDID = [OpenUDID value];
    self.accessToken = [OpenUDID value];
    [[Sessions sharedInstance] save];
    
    return YES;
}

- (void)reloadApp
{
    UIViewController* vcMain = [self loadFramework];
    if (vcMain && oyUseLib)
    {
        [[self window] setRootViewController:vcMain];
    }
    else
    {
        UIViewController *rootViewController = [self setRootVC:YES];
        [[self window] setRootViewController:rootViewController];
        [self setCartNum];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidNotifyFromBack object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - thidr part
#pragma mark - umeng
- (void)setUmeng
{
    NSString* umApp = @"TDB_Key";//自行设置key
    [MobClick startWithAppkey:umApp reportPolicy:SENDWIFIONLY channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [OyTool ShardInstance];
    [MobClick updateOnlineConfig];
    [UMFeedback setAppkey:umApp];
}

#pragma mark - JPush
- (void)setJPush:(NSDictionary*)launchOptions
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
//        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                       UIRemoteNotificationTypeSound |
//                                                       UIRemoteNotificationTypeAlert)
//                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
}

#pragma mark - push app delegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidNotifyApns object:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


#pragma mark - 接QQ登录 -
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}

@end

AppDelegate *appDelegate(void)
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
