//
//  XWNetWorkTool.m
//  WeiboOC
//
//  Created by apple1 on 15/11/2.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWNetWorkTool.h"
#import "XWStatus.h"
#import "XWUserAccount.h"

static XWNetWorkTool *netWorkTool = nil;
@interface XWNetWorkTool ()

// 下载管理器
@property(nonatomic,strong) AFHTTPSessionManager *afnManager;

@end

@implementation XWNetWorkTool

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


#pragma mark - 获取数据

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

// 获取用户信息
-(void) getUserinfoWithFinishedBlock:(finishedBlock) finished {
    
    if (![XWUserAccount shareAccount].access_token) {
        
        return;
    }
    if (![XWUserAccount shareAccount].uid) {
        
        return;
    }
    
    // url路径
    NSString *urlStr = @"https://api.weibo.com/2/users/show.json";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 一定要设置 获取到所有的微博信息
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [XWUserAccount shareAccount].access_token;
    parameters[@"uid"] = [XWUserAccount shareAccount].uid;
    
    // 发送请求
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        finished(responseObject,nil);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        finished(nil,error);
    }];
}

// 获取微博信息
-(void) getNetworkBlogstatusWithFinishedBlock:(finishedBlock) finished {

    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    // AFHTTPRequestOperationManager 与 AFHTTPSessionManager区别
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 一定要设置 获取到所有的微博信息
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"access_token"] = [XWUserAccount shareAccount].access_token;
    
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
#warning mark bug  返回的是responseObject 是data数据来的  -出错的地方
        finished(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        finished(nil,error);
        
    } ];

}

// 获取微博本地数据
-(void)getblogInfoWithFinishedBlock:(finishedBlock) finished {
    
    // 获取路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"statuses" ofType:@"json"];
    
    // 加载文件数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    finished(dict,nil);
    

}

// 发微博
-(void)sendBlogWithImage:(UIImage *)image text:(NSString*)text finished:(finishedBlock)finished{
    // 有图片,发送带图片的微博
    NSString  *urlString = @"https://upload.api.weibo.com/2/statuses/upload.json";
    
    // AFHTTPRequestOperationManager 与 AFHTTPSessionManager区别
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 一定要设置 获取到所有的微博信息
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"access_token"] = [XWUserAccount shareAccount].access_token;
    
    // 拼接参数
    parameters[@"status"] = text;
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 将图片转成二进制
        NSData *data = UIImagePNGRepresentation(image);
        // data: 上传图片的2进制
        // name: api 上面写的传递参数名称 "pic"
        // fileName: 上传到服务器后,保存的名称,没有指定可以随便写
        // mimeType: 资源类型:
        // image/png
        // image/jpeg
        // image/gif
        [formData appendPartWithFileData:data name:@"pic" fileName:@"sb" mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        finished(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
        finished(nil,error);
    }];

}





@end
