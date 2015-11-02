//
//  XWUserAccount.m
//  WeiboOC
//
//  Created by apple1 on 15/11/2.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWUserAccount.h"


// MARK: - 定义静态属性
static XWUserAccount *account = nil;

@implementation XWUserAccount

//{"access_token":"2.00Qe7qEG9SkFEBfbc46e5daa00XD6L",
//    "remind_in":"140167",
//    "expires_in":140167,
//    "uid":"5568397832"}*/

// MARK: - 用户登录信息
+(instancetype)shareAccount{

    if (account == nil){
        account = [ [self alloc ] init];
    }
    return account;
}

// MARK: - 在allocWithZone里获取数据
+(instancetype)allocWithZone:(struct _NSZone *)zone{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       //登录账号数据初始化在allocWithZone方法
        account = [super allocWithZone:zone];
        
        // 读取数据
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        account.access_token = [defaults objectForKey:@"access_token"];
        account.remind_in = [defaults objectForKey:@"remind_in"];
        account.expires_date = [defaults objectForKey:@"expires_date"];
        account.uid = [defaults objectForKey:@"uid"];
    });
    return account;
}


// MARK: - 用户是否登录
-(BOOL)isLogin{
    
    return self.access_token.length;
}

// MARK: - 保存用户信息
-(void)saveAccountInfo{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.access_token forKey:@"access_token"];
    [defaults setObject:self.remind_in  forKey:@"remind_in"];
    [defaults setObject:self.expires_date forKey:@"expires_date"];
    [defaults setObject:self.uid forKey:@"uid"];
    [defaults synchronize];

}

@end
