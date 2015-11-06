//
//  XWNetWorkTool.h
//  WeiboOC
//
//  Created by apple1 on 15/11/2.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^finishedBlock)(id response,NSError *error);

@interface XWNetWorkTool : NSObject

/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 * 获取本地数据
 */
+(void)getblogInfoWithFinishedBlock:(finishedBlock) finished;

/// 获取url方法
-(void)getAcessTokenlWithCode:(NSString *)code finished:(finishedBlock) finished;


@end
