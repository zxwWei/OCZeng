//
//  XWNetWorkTool.m
//  WeiboOC
//
//  Created by apple1 on 15/11/2.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWNetWorkTool.h"

static XWNetWorkTool *netWorkTool = nil;
@interface XWNetWorkTool ()

// 下载管理器
@property(nonatomic,strong) AFHTTPSessionManager *afnManager;

@end

@implementation XWNetWorkTool

/// 申请时分配的appleKey


+(instancetype)sharedInstance{

    if (netWorkTool == nil){
        netWorkTool = [[self alloc]init];
    }
    return netWorkTool;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        netWorkTool = [super allocWithZone:zone];
        
    });
    return netWorkTool;
}

+(void)getblogInfoWithFinishedBlock:(finishedBlock) finished {
    
    // 获取路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"statuses" ofType:@"json"];
    
    // 加载文件数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    finished(dict,nil);
    

}



// 获取ouath url
-(void)getAcessTokenlWithCode:(NSString *)code finished:(finishedBlock) finished{

    // 拼接路径
    // 获取accesToken的url
    NSString *accesTokenUrl = @"https://api.weibo.com/oauth2/access_token";
    
    // 创建http管理器
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    // 其默认是json格式 转换成二进制格式
    // [AFHTTPResponseSerializer serializer]; 设置返回的数据处理方式是二进制
    // [AFJSONResponseSerializer serializer] ;设置返回的数据处理方式是json 默认
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    // 准备可变参数字典
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    
    paramters[@"client_id"] = client_id;
    paramters[@"client_secret"] = client_secret;
    paramters[@"grant_type"] = grant_type;
    paramters[@"code"] = code;
    paramters[@"redirect_uri"] = redirect_uri;
    
    // 发送请求
    [manger POST:accesTokenUrl parameters:paramters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        finished(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        finished(nil,error);
    }];
    
    
    
}





@end
