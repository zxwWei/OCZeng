//
//  XWHomeTableVC.m
//  WeiboOC
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWHomeTableVC.h"
#import "XWUserAccount.h"
#import "XWUser.h"

@interface XWHomeTableVC ()

@end

@implementation XWHomeTableVC


#pragma mark - 分组
-(instancetype)init{
    
    return [self initWithStyle:UITableViewStyleGrouped];
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 获取微博数据
    
    [self loadStatuse];
}
;
#pragma mark - 初始化导航条控件
-(void)loadStatuse{
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 一定要设置 获取到所有的微博信息
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"access_token"] = [XWUserAccount shareAccount].access_token;
    NSLog(@"%@",[XWUserAccount shareAccount].access_token);
    
    [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
//        NSString *resultStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        XWUser *user = [XWUser objectWithJSONData:responseObject];
        
        
        // TODO: 嵌套模型的转换 swift 和 oc 的 理解  各种属性的关系
        NSLog(@"%@",user);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        
    }];
    

}

@end
