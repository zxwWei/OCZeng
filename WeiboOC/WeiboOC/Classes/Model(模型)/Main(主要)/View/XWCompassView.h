//
//  XWCompassView.h
//  WeiboOC
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWCompassView;

// 代理方法
@protocol XWCompassViewDelegate <NSObject>

-(void) btnClickWithSelf:(XWCompassView *) view btn:(UIButton *)btn;

@end

@interface XWCompassView : UIView

@property(nonatomic,strong,readonly) UIButton *registerButton;
@property(nonatomic,strong,readonly) UIButton *loginButton;

// 定义代理
@property(nonatomic,weak) id<XWCompassViewDelegate> delegate;

-(void)setUpImage:(NSString *)imageName message:(NSString *)message;

-(void) startAnimation;
@end
