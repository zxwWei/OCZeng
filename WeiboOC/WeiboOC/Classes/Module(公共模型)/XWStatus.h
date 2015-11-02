//
//  XWStatus.h
//  WeiboOC
//
//  Created by apple1 on 15/11/2.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWStatus : NSObject

/// 微博创建时间
@property(nonatomic,strong) NSString *created_at;
//var created_at: String?

/// 字符串型的微博ID
@property(nonatomic,copy) NSString *idstr;

/// 微博信息内容
@property(nonatomic,copy) NSString *text;

/// 微博来源
@property(nonatomic,copy) NSString *source;

/// 微博的配图   此时是字符串数组  需要将其转换成url数组
@property(nonatomic,strong) NSArray *pic_urls;

@end
