//
//  XWNetWorkTool.m
//  WeiboOC
//
//  Created by apple1 on 15/11/2.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWNetWorkTool.h"


@interface XWNetWorkTool ()

// 下载管理器
@property(nonatomic,strong) AFHTTPSessionManager *afnManager;

@end

@implementation XWNetWorkTool

/// 申请时分配的appleKey



// 获取ouath url
-(NSURL *)getOauthUrlWithclientid:(NSString *)clientid redirecturi:(NSString *)redirecturi granttype:(NSString *)granttype clientsecret:(NSString *) clientsecret{

    // 拼接路径
    
    
    //NSString *urlString = @"https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)";
    
    return nil;
}





@end
