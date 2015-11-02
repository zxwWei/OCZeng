//
//  XWOauthVC.m
//  WeiboOC
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWOauthVC.h"

@interface XWOauthVC ()

@end

@implementation XWOauthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backToMainVc)];
    
    
}

#pragma mark - 返回主页面
-(void)backToMainVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
