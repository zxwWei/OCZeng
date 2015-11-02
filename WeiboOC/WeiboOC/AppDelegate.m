//
//  AppDelegate.m
//  WeiboOC
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "AppDelegate.h"
#import "XWTabBarVC.h"
#import "XWWelcomeVC.h"
#import "XWFeatureVc.h"
#import "XWHomeTableVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#pragma Warning - 窗口的frame啊
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //self.window = [[UIWindow alloc] init];
    [self.window makeKeyAndVisible];
    
    XWTabBarVC *tabBar = [[XWTabBarVC alloc]init];
    
//    XWWelcomeVC *welcomeVc = [[XWWelcomeVC alloc] init];
    
//    NSLog(@"初始化");
     XWFeatureVc *featureVc = [[XWFeatureVc alloc] init];
//    XWHomeTableVC *home = [[XWHomeTableVC alloc] init];
    self.window.rootViewController = featureVc;
    
    
    return YES;
}



@end
