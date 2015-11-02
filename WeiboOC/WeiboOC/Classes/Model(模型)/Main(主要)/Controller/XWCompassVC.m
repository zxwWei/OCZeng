//
//  XWCompassVC.m
//  WeiboOC
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWCompassVC.h"
#import "XWCompassView.h"
#import "XWHomeTableVC.h"
#import "XWMessageTableVC.h"
#import "XWProfileTableVC.h"
#import "XWDiscoverTableVC.h"
#import "XWOauthVC.h"
@interface XWCompassVC ()<XWCompassViewDelegate>

@property(nonatomic,assign) BOOL userLogin;

@property(nonatomic,strong) XWCompassView *vistorView;
@end

@implementation XWCompassVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    // 在某地方处理这个self.userLogin
    //self.userLogin = NO;
}

// MARK:  当加载的时候loadview时，当没登陆的时候进入这个界面
-(void)loadView{
    //self.userLogin = YES;
    self.userLogin ? [super loadView] : [self setupVistor] ;

}

// 替代的界面
-(void)setupVistor{
    //NSLog(@"d");
   
    self.vistorView = [[XWCompassView alloc]init];
    
    self.view = self.vistorView;
    self.vistorView.delegate = self;
    if ([self isKindOfClass:[XWHomeTableVC class]]){
        
        [self.vistorView startAnimation];
        
        // 监听进入后台和前台的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:@"UIApplicationDidBecomeActiveNotification" object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:@"UIApplicationDidEnterBackgroundNotification" object:nil];
        
    }
    else if ([self isKindOfClass:[XWMessageTableVC class]]){
        [self.vistorView setUpImage:@"visitordiscover_image_message" message:@"信息信息"];
    }
    else if ([self isKindOfClass:[XWDiscoverTableVC class]]){
        [self.vistorView setUpImage:@"visitordiscover_image_message" message:@"发现"];
    }
    else if ([self isKindOfClass:[XWProfileTableVC class]]){
        [self.vistorView setUpImage:@"visitordiscover_image_profile" message:@"我的"];
    }
}

#pragma mark - 通知
-(void) didBecomeActive{


}

-(void) didEnterBackground{

}

#pragma mark - 代理方法
-(void)btnClickWithSelf:(XWCompassView *)view btn:(UIButton *)btn{
    
    if (btn == self.vistorView.registerButton){
        NSLog(@"registerButton");
  
        
    }
    else if (btn == self.vistorView.loginButton){
        NSLog(@"loginButton");
        XWOauthVC *oauthVc = [[XWOauthVC alloc]init];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:oauthVc];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}



@end
