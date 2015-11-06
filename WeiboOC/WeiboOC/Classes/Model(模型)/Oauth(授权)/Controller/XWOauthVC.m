//
//  XWOauthVC.m
//  WeiboOC
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWOauthVC.h"
#import "XWUserAccount.h"
#import "AppDelegate.h"
#import "XWNetWorkTool.h"

@interface XWOauthVC () <UIWebViewDelegate,MBProgressHUDDelegate>

@property(nonatomic,strong) UIWebView *webView;

@property(nonatomic,strong) MBProgressHUD *hud;
@end

@implementation XWOauthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    // 指定代理
    
    //添加子控件
    [self.view addSubview:webView];
    
//    self.webView = webView;
   
    
    
    self.title = @"新浪微博登陆";
    
    //"https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)"
    // 加载授权页面
    NSString *oauthStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",client_id,redirect_uri];
    
    // 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:oauthStr]];
    
    // 发送请求
    [webView loadRequest:request];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backToMainVc)];
    

}

#pragma mark - webView代理方法

// 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
//  NSLog(@"进来了");
//  self.startView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 150, 100)];
    
    
    // 现实在view上
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.delegate = self;
    hud.labelText = @"正在玩命加载中";
    hud.animationType = MBProgressHUDAnimationZoom;
    self.hud = hud;

}

// 完成加载
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //加载完成后消失
    [self.hud hide:YES afterDelay:1];
    // 去除hud
    [self.hud removeFromSuperview];
}


// 方法限定访问链接是否加载
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //NSLog(@"%@",request.URL);
    
    
    // 如果的它的前缀是回调地址
    if ([request.URL.absoluteString hasPrefix:redirect_uri]) {
        
        // 截取code 获得后面部分
        NSString *code = [request.URL.query componentsSeparatedByString:@"="][1];
        
        NSLog(@"%@",code);
        
        // 获取assesToken
        [self getAcessTokenWithCode:code];
        
        // 让回调页面不在web上显示
        return NO;
     
    }
    return YES;
}




#pragma mark - 获取accesToken

// 获取acessToken
-(void)getAcessTokenWithCode:(NSString *)code{
    
    [[XWNetWorkTool sharedInstance] getAcessTokenlWithCode:code finished:^(id response, NSError *error) {
        
            // 将数据转换成模型
            XWUserAccount *account = [XWUserAccount objectWithJSONData:response];
            NSLog(@"account:%@",account);
    
    
            // 保存数据
            [account saveAccountInfo];
    
            //加载完成后消失
            [self.hud hide:YES afterDelay:1];
            // 去除hud
            [self.hud removeFromSuperview];
    
    
            // 加载完成进入欢迎界面
            AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate switchVcWithIsMain:false];
    }];
    
}



-(void)assesToken:(NSString *)code{

    
//    // 获取accesToken的url
//    NSString *accesTokenUrl = @"https://api.weibo.com/oauth2/access_token";
//    
//    // 创建http管理器
//    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
//    
//    // 其默认是json格式 转换成二进制格式
//    // [AFHTTPResponseSerializer serializer]; 设置返回的数据处理方式是二进制
//    // [AFJSONResponseSerializer serializer] ;设置返回的数据处理方式是json 默认
//    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    
//    // 准备可变参数字典
//    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
//    
//    paramters[@"client_id"] = client_id;
//    paramters[@"client_secret"] = client_secret;
//    paramters[@"grant_type"] = grant_type;
//    paramters[@"code"] = code;
//    paramters[@"redirect_uri"] = redirect_uri;
//    
//    // 发送请求
//    [manger POST:accesTokenUrl parameters:paramters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        
//        // NSString *resultStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        // 将数据转换成模型
//        XWUserAccount *account = [XWUserAccount objectWithJSONData:responseObject];
//        NSLog(@"account:%@",account);
//        
//        
//        // 保存数据
//        [account saveAccountInfo];
//        
//        //加载完成后消失
//        [self.hud hide:YES afterDelay:1];
//        // 去除hud
//        [self.hud removeFromSuperview];
//        
//     
//        // 加载完成进入欢迎界面
//        AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
//        [delegate switchVcWithIsMain:false];
//
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        
//        
//    }];


}


// 登录完成退出
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 懒加载
-(UIWebView *)webView{
    
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}



#pragma mark - 返回主页面
-(void)backToMainVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
