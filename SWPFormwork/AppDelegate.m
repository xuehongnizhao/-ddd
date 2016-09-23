//
//  AppDelegate.m
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "AppDelegate.h"

#import "SwpTabBarController.h"

#import "LoginViewController.h"
#import "AppDelegate+MasterInterfaceData.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [self swpAppGetMasterInterfaceData];
    
    self.window                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor    = [UIColor whiteColor];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:isLogin]) {
        self.window.rootViewController = [[LoginViewController alloc ]init];
    }else{
         self.window.rootViewController =  [SwpTabBarController shareInstance];
    }
  
  
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*!
 *  @author swp_song
 *
 *  @brief  swpAppGetMasterInterfaceData    ( 获取 主接口 数据 )
 */
- (void)swpAppGetMasterInterfaceData {
    
    // 设置 网络 环境
    [AppDelegate swpSetMasterInterfaceBaseURL:@"http://wangyifei.youzhiapp.com/youzhi/" baseSet:@"action/ac_base/"];
    
    // 获取 主接口 数据 返回 成功 或 失败 block 如果 不做处理 可以 传 nil
    [AppDelegate swpGetMasterInterfaceData:nil resultError:nil];
}

@end
