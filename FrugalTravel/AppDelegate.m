//
//  AppDelegate.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "AppDelegate.h"
#import "HA_RecViewController.h"
#import "HA_DesViewController.h"
#import "HA_ComViewController.h"
#import "HA_MineViewController.h"
#import "HA_MapViewController.h"
#import "HA_LaunchView.h"
#import "HA_LoadView.h"
#import "DKNightVersion.h"
#import "DataBaseHandle.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
// tecent
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
// wechat
#import "WXApi.h"
// weibo
#import "WeiboSDK.h"
#import <iflyMSC/iflyMSC.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 推荐
    HA_RecViewController *recVC = [[HA_RecViewController alloc] init];
    UINavigationController *recNaVC = [[UINavigationController alloc] initWithRootViewController:recVC];
    recNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:[UIImage imageNamed:@"recG"] selectedImage:[UIImage imageNamed:@"recL"]];
    
    // 目的地
    HA_DesViewController *desVC = [[HA_DesViewController alloc] init];
    UINavigationController *desNaVC = [[UINavigationController alloc] initWithRootViewController:desVC];
    desNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"目的地" image:[UIImage imageNamed:@"desG"] selectedImage:[UIImage imageNamed:@"desL"]];
    
    // 社区
    HA_ComViewController *comVC = [[HA_ComViewController alloc] init];
    UINavigationController *comNaVC = [[UINavigationController alloc] initWithRootViewController:comVC];
    comNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"社区" image:[UIImage imageNamed:@"comG"] selectedImage:[UIImage imageNamed:@"comL"]];
    
    // 我的
    HA_MineViewController *mineVC = [[HA_MineViewController alloc] init];
    UINavigationController *mineNaVC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"mineG"] selectedImage:[UIImage imageNamed:@"mineL"]];
    
    // 地图
    HA_MapViewController *mapVC = [[HA_MapViewController alloc] init];
    UINavigationController *mapNaVC = [[UINavigationController alloc] initWithRootViewController:mapVC];
    mapNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"地图" image:[UIImage imageNamed:@"mapG"] selectedImage:[UIImage imageNamed:@"mapL"]];
    
    // tabbar
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    tabbar.viewControllers = @[recNaVC,desNaVC,comNaVC,mapNaVC,mineNaVC];
    tabbar.tabBar.tintColor = [UIColor colorWithRed:0.159 green:0.584 blue:0.362 alpha:1.000];

    tabbar.tabBar.dk_barTintColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor darkGrayColor]);
    // 引导页/登录页
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 使用 NSUserDefaults 读取用户数据
    if (![useDef boolForKey:@"notFirst"]) {
        // 如果是第一次进入引导页
        HA_LaunchView *launch = [[HA_LaunchView alloc] init];
        launch.tabbar = tabbar;
        _window.rootViewController = launch;
        
    }
    else{
        // 否则直接进入应用
        HA_LoadView *load = [[HA_LoadView alloc] init];
        load.tabbar = tabbar;
        _window.rootViewController = load;
    }
    
    
    [self createShareSDK];
    // 科大讯飞
    NSString *initStr = [[NSString alloc] initWithFormat:@"appid=%@",@"56d792ed"];
    [IFlySpeechUtility createUtility:initStr];
    
    return YES;
}

- (void)createShareSDK{
    [ShareSDK registerApp:@"ffc5036c5c4a" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            default:
                break;
        }
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@"4012211604"
                                          appSecret:@"4d4a3f6dcd72093f11da15321c71d8ee"
                                        redirectUri:@"http://www.sharesdk.cn"
                                           authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"2");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"3");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"4");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"5");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"6");
}


@end
