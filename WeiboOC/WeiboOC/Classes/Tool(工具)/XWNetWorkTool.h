//
//  XWNetWorkTool.h
//  WeiboOC
//
//  Created by apple1 on 15/11/2.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWNetWorkTool : NSObject



/// 获取url方法
-(NSURL *)getOauthUrlWithclientid:(NSString *)clientid redirecturi:(NSString *)redirecturi granttype:(NSString *)granttype clientsecret:(NSString *) clientsecret;


@end
