//
//  XWHomeTableVC.m
//  WeiboOC
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWHomeTableVC.h"
#import "XWUserAccount.h"

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
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"client_id"] = [XWUserAccount shareAccount].access_token;
    
    [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    

}

@end
