//
//  XWWelcomeVC.m
//  WeiboOC
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWWelcomeVC.h"
#import "AppDelegate.h"
#import "XWTabBarVC.h"

@interface XWWelcomeVC ()

// 背景
@property(nonatomic,strong) UIImageView *bgView;

// 欢迎标签
@property(nonatomic,strong) UILabel *welcomeLabel;

// 头像
@property(nonatomic,strong) UIImageView *iconView;

// 约束
@property(nonatomic,strong) NSLayoutConstraint *bottomConstraint;
@end

@implementation XWWelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self prepareUI];
    
}

#pragma mark - 准备UI
-(void)prepareUI{
    
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.welcomeLabel];
    
    self.bgView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.welcomeLabel.translatesAutoresizingMaskIntoConstraints = NO;

    
    // 头像
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-160];
    
    [self.view addConstraint:self.bottomConstraint];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:85]];
    
       [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:85]];

    
    // 欢迎归来
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.welcomeLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.welcomeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeBottom multiplier:1 constant:16]];
    
   
    // 背景
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bgView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bgView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bgView  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

}

#pragma mark - 当view已经出现时执行
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.bottomConstraint.constant = -([UIScreen mainScreen].bounds.size.height - 160 );
    
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:0 animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 animations:^{
            
            self.welcomeLabel.alpha = 1;
            
        } completion:^(BOOL finished) {
            // 显示完毕做的事情
            [UIApplication sharedApplication].keyWindow.rootViewController = [[XWTabBarVC alloc]init];
            
        }];
        
        
    }];
    
    
}

#pragma mark - 懒加载
-(UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        
        _bgView.image = [UIImage imageNamed:@"ad_background"];
        [_bgView sizeToFit];
    }
    return _bgView;
}

-(UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc]init];
        _iconView.image = [UIImage imageNamed:@"avatar_default_big"];
        _iconView.layer.cornerRadius = 42.5;
        _iconView.clipsToBounds = YES;
        [_iconView sizeToFit];
    }
    return _iconView;
}

-(UILabel *)welcomeLabel{
    if (_welcomeLabel == nil) {
        _welcomeLabel = [[UILabel alloc]init];
 
        _welcomeLabel.text = @"欢迎归来";
        _welcomeLabel.alpha = 0;
        [_welcomeLabel sizeToFit];
    }
    return _welcomeLabel;

}


@end
