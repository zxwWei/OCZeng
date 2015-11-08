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
#import "XWPhotoSelctorVC.h"

@interface AppDelegate ()

@property(nonatomic,strong) XWTabBarVC *tabBarVc;
@property(nonatomic,strong) XWWelcomeVC *welcomeVc;
@property(nonatomic,strong) XWFeatureVc *featureVc;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#pragma Warning - 窗口的frame啊
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //self.window = [[UIWindow alloc] init];
    [self.window makeKeyAndVisible];
    
    self.tabBarVc = [[XWTabBarVC alloc]init];
    
     self.welcomeVc = [[XWWelcomeVC alloc] init];
    
    
//    NSLog(@"初始化");
     self.featureVc = [[XWFeatureVc alloc] init];
//    XWHomeTableVC *home = [[XWHomeTableVC alloc] init];
    self.window.rootViewController = [self defaultController];
    //self.window.rootViewController = [[XWPhotoSelctorVC alloc]init];
    
    
    return YES;
}


// MARK: - 根据版本号来判断进入那一个控制器

-(UIViewController *) defaultController{
    
//    // if did not have account show tabbar
//    if [XWUserAccount ] {
//        
//        return XWMainTabBarController()
//    }
    
    
    return [self getVersion] ? self.featureVc : self.welcomeVc;
}


// MARK: - 判断版本号
-(BOOL)getVersion{

    // 获取当前的版本号
//    let curretnVersionStr = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
    NSString *currentVersionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 将其转换成double
    double curretnVersion = currentVersionStr.doubleValue;
    // 获取之前的版本号
    
    NSString *sandBoxVersionKey = @"sandBoxVersionKey";
    double sandBoxVersion = [[NSUserDefaults standardUserDefaults]doubleForKey:sandBoxVersionKey];
    
    //print("sandBoxVersion\(sandBoxVersion)")
    
    
//    // 保存当前版本号
    [[NSUserDefaults standardUserDefaults] setDouble:curretnVersion forKey:sandBoxVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    return  curretnVersion > sandBoxVersion;
}


// 根据需要切换控制器
-(void)switchVcWithIsMain:(BOOL) isMain {

    self.window.rootViewController = isMain ? self.tabBarVc : self.welcomeVc;
}



@end
