//
//  XWPhotoSelctorVC.h
//  WeiboOC
//
//  Created by apple1 on 15/11/8.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWPhotoSelctorCell;

@interface XWPhotoSelctorVC : UICollectionViewController

/**
 *  图片数组
 */
@property(nonatomic,strong,readonly) NSMutableArray *photos;
@end



// 自定义cell
// 代理
@protocol XWPhotoSelctorCellDelegate <NSObject>

-(void)PhotoCellAddPhotoWithCell:(XWPhotoSelctorCell*)cell;

-(void)removePhotoWithCell:(XWPhotoSelctorCell*)cell;

@end

@interface XWPhotoSelctorCell : UICollectionViewCell

// 注册代理
@property(nonatomic,weak) id<XWPhotoSelctorCellDelegate> delegate;

// 按钮背景图片
@property(nonatomic,strong) UIImage *image;

@end