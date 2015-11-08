//
//  XWCompseVC.m
//  WeiboOC
//
//  Created by apple1 on 15/11/8.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWCompseVC.h"
#import "XWPhotoSelctorVC.h"
#import "XWNetWorkTool.h"

@interface XWCompseVC ()

@property(nonatomic,strong) UITextView *textView;

@property(nonatomic,strong) UIToolbar *toolBar;

@property(nonatomic,strong) UIButton *btn;

// 照片选择器
@property(nonatomic,strong) XWPhotoSelctorVC *photoSelctorVc;
@end

@implementation XWCompseVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self prepareUI];
}

#pragma mark - 准备UI
-(void)prepareUI{
    [self setUpTextView];
    [self setUpPhotoSelector];
    [self setUPNav];
    [self setUPToolbar];
}

-(void)setUPNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backToMian)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送微博" style:UIBarButtonItemStylePlain target:self action:@selector(sendCompose)];
}
-(void)setUpTextView{
    
    [self.view addSubview:self.textView];
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"textView":self.textView};
    //      @"H:|-0-[contentLabel]-0-|"
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[textView]-0-|"  options:0 metrics:nil views:views]];
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[textView]-0-|"  options:0 metrics:nil views:views]];

}

-(void)setUpPhotoSelector{
    // 创建
    UIView *view = self.photoSelctorVc.view;
    [self.view addSubview:view];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
//    
    NSDictionary *views = @{@"view":view};
    //      @"H:|-0-[contentLabel]-0-|"
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"  options:0 metrics:nil views:views]];

     //向下偏移
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.view.frame.size.height*0.1]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.6 constant:0]];
}

-(void)setUPToolbar{
//    [self.view addSubview:self.toolBar];
//    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
////    
//    NSDictionary *views = @{@"toolBar":self.toolBar};
//    //      @"H:|-0-[contentLabel]-0-|"
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolBar]-0-|"  options:0 metrics:nil views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[toolBar]-0-|"  options:0 metrics:nil views:views]];
    
    [self.view addSubview:self.btn];
    self.btn.translatesAutoresizingMaskIntoConstraints = NO;
   
#warning mark - 注意添加约束所到的对象
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:40]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:70]];
    
    [self.btn addConstraint:[NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:100]];
    [self.btn addConstraint:[NSLayoutConstraint constraintWithItem:self.btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:40]];
    
}

#pragma mark - 按钮点击事件
-(void)backToMian{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendCompose{
  
    // 获取第一张图片
    UIImage *image = self.photoSelctorVc.photos[0];
    // 获取文本
    NSString *text = self.textView.text;
    NSLog(@"%@",text);
     NSLog(@"%@",image);
#warning mark : -该网络请求好像要带文本
//    NSLog(@"%@",image);
    [[XWNetWorkTool sharedInstance] sendBlogWithImage:image text:text finished:^(id response, NSError *error) {
 
        NSLog(@"成功了");
    }];
}

-(void)turnupPhotoSelctor{

    
}


#pragma mark - 懒加载
-(UITextView *)textView{

    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor orangeColor];
//        _textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    return _textView;
}

-(UIToolbar *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc]init];
        _toolBar.backgroundColor = [UIColor greenColor];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(turnupPhotoSelctor)];
        _toolBar.items = @[item];
        
    }
    return _toolBar;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]init];
        [_btn addTarget:self action:@selector(turnupPhotoSelctor) forControlEvents:UIControlEventTouchUpInside];
        [_btn setBackgroundColor:[UIColor redColor]];
        [_btn setTitle:@"照片选择器" forState:UIControlStateNormal];
//        [_btn sizeToFit];
    }
    return _btn;
}

-(XWPhotoSelctorVC *)photoSelctorVc{
    if (!_photoSelctorVc) {
        _photoSelctorVc = [[XWPhotoSelctorVC alloc]init];
    }
    return _photoSelctorVc;
}

@end
