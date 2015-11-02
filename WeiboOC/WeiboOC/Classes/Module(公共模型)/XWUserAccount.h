//
//  XWUserAccount.h
//  WeiboOC
//
//  Created by apple1 on 15/11/2.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWUserAccount : NSObject


// 用户登录信息
+(instancetype)shareAccount;

// 用户是否登录
-(BOOL)isLogin;

// 保存用户信息
-(void)saveAccountInfo;

/// 用于调用access_token，接口获取授权后的access token。
@property(nonatomic,copy) NSString *access_token;

/// access_token的生命周期，单位是秒数。
@property(nonatomic,assign) NSTimeInterval expires_in;

/**
 *  access_token的生命周期，单位是秒数。
 */
@property (nonatomic,copy) NSString * remind_in;


/// 当前授权用户的UID。
@property(nonatomic,copy) NSString *uid;

/// 过期时间
@property(nonatomic,strong) NSDate *expires_date;

/// 友好显示名称
@property(nonatomic,copy) NSString *name;

/// 头像
@property(nonatomic,copy) NSString *avatar_large;

@end
