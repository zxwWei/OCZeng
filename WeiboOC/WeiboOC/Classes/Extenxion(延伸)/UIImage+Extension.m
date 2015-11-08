//
//  UIImage+Extension.m
//  WeiboOC
//
//  Created by apple1 on 15/11/8.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

-(UIImage *)scaleImageWithNewWidth:(CGFloat)newWidth iamge:(UIImage *)image{

    
    // 当图片宽度小于newWidth,直接返回
    if (image.size.width < newWidth) {
        return image;
    }
    // 计算缩放好后的高度
    // newHeight / newWidth = height / width
    CGFloat newHeight = newWidth * image.size.width / image.size.width ;
    
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    // 将图片等比例缩放到 newSize
    
    // 开启图片上下文
    UIGraphicsBeginImageContext(newSize);
    
    // 绘图
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // 获取绘制好的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭绘图上下文
    UIGraphicsEndImageContext();
    
    // 返回绘制好的新图
    return newImage;
    
    
}

@end
