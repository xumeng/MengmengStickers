//
//  AppDelegate.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "AppDelegate.h"
#import "XMShareView.h"
#import "AppMacro.h"
#import "Constants.h"
#import "GKFadeNavigationController.h"

#import "ViewController.h"
#import "UserViewController.h"


@interface AppDelegate ()<WeiboSDKDelegate, QQApiInterfaceDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [self init3rdParty];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //  去掉返回按钮上的文字
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
    //                                                         forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x39394a)];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           UIColorFromRGB(0x39394a), NSForegroundColorAttributeName,
                                                           SYSTEMFONT(15), NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:APP_COLOR];
    
    [[UITabBar appearance] setTintColor:APP_COLOR];
    
    
    //设置SVProgressHUD样式
//    [SVProgressHUD setBackgroundColor:UIColorFromRGBA(0x000000, 0.7)];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    //    [[UINavigationBar appearance] setTranslucent:NO];     //  设置导航栏半透明
    
    //    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
    //                                                        NSForegroundColorAttributeName : APP_COLOR_BLACK
    //                                                        } forState:UIControlStateSelected];
    
    [NSThread sleepForTimeInterval:1];
    
    
    UITabBarController *tabBarController  = [[UITabBarController alloc] init];

    
    ViewController *homeVC = [[ViewController alloc] init];
    UserViewController *userVC = [[UserViewController alloc] init];
    GKFadeNavigationController *nav1 = [[GKFadeNavigationController alloc] initWithRootViewController:homeVC];
    GKFadeNavigationController *nav2 = [[GKFadeNavigationController alloc] initWithRootViewController:userVC];
    
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"热门"  image:nil tag:0];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"  image:nil tag:1];
    
    [nav1.tabBarItem setImage:[[UIImage imageNamed:@"icon_home_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav1.tabBarItem setSelectedImage:[[UIImage imageNamed:@"icon_home_home_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [nav2.tabBarItem setImage:[[UIImage imageNamed:@"icon_home_people"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav2.tabBarItem setSelectedImage:[[UIImage imageNamed:@"icon_home_people_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    [nav1.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
//    [nav2.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
//    tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    
    tabBarController.viewControllers = @[ nav1,nav2];
    
    self.window.rootViewController = tabBarController;

    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
//        return [TencentOAuth HandleOpenURL:url];
        return [QQApiInterface handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wx"]) {
        
        ViewController *vc = (ViewController *)self.window.rootViewController;
        return [WXApi handleOpenURL:url delegate:vc];
        
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
        return [TencentOAuth HandleOpenURL:url];
        
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else{
        
        ViewController *vc = (ViewController *)self.window.rootViewController;
        return [WXApi handleOpenURL:url delegate:vc];
        
    }
}


/**
 *  初始化第三方组件
 */
- (void)init3rdParty
{
    [WXApi registerApp:APP_KEY_WEIXIN];
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:APP_KEY_WEIBO];
    
}

#pragma mark - 实现代理回调
/**
 *  微博
 *
 *  @param response 响应体。根据 WeiboSDKResponseStatusCode 作对应的处理. 
 *  具体参见 `WeiboSDKResponseStatusCode` 枚举.
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString *message;
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
            message = @"分享成功";
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
            message = @"取消分享";
            break;
        case WeiboSDKResponseStatusCodeSentFail:
            message = @"分享失败";
            break;
        default:
            message = @"分享失败";
            break;
    }
    showAlert(message);
}

/**
 *  处理来至QQ的请求
 *
 *  @param req QQApi请求消息基类
 */
- (void)onReq:(QQBaseReq *)req
{
    
}

/**
 *  处理来至QQ的响应
 *
 *  @param resp 响应体，根据响应结果作对应处理
 */
- (void)onResp:(QQBaseResp *)resp
{
    NSString *message;
    if([resp.result integerValue] == 0) {
        message = @"分享成功";
    }else{
        message = @"分享失败";
    }
    showAlert(message);
}


@end
