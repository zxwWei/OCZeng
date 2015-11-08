//
//  UIColor+Extesion.m
//  WeiboOC
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "UIColor+Extesion.h"

@implementation UIColor (Extesion)

+(UIColor*) randomColor{
    
    return [UIColor colorWithRed:( arc4random_uniform(256)  /  255 )  green:( arc4random_uniform(256) / 255 )  blue:( arc4random_uniform(256) / 255 )  alpha:1];
}



@end
