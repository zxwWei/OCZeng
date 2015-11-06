//
//  XWHomeTableViewCell.h
//  WeiboOC
//
//  Created by apple1 on 15/11/5.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWStatus;

@interface XWHomeTableViewCell : UITableViewCell


/**
 *  返回一个cell的方法
 */
+(instancetype)cellWithTableView:(UITableView*)tableview;
@property(nonatomic,strong) XWStatus *statu;

@end
