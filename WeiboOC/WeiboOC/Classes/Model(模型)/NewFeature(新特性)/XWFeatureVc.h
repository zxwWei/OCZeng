//
//  XWFeatureVc.h
//  WeiboOC
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWFeatureVc : UICollectionViewController

@end



// 自定义cell
@interface XWCollectionCell : UICollectionViewCell

/// 下标
@property(nonatomic,assign) NSInteger imageIndex;

// 动画方法
-(void)startAnimation;
@end