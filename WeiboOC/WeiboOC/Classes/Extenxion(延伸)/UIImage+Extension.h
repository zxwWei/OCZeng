//
//  UIImage+Extension.h
//  WeiboOC
//
//  Created by apple1 on 15/11/8.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


/**
 *  返回经缩减的图片
 */
-(UIImage *)scaleImageWithNewWidth:(CGFloat)newWidth iamge:(UIImage *)image;
@end
