//
//  XWFeatureVc.m
//  WeiboOC
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWFeatureVc.h"
#import "UIColor+Extesion.h"

#define itemCount 4

@interface XWFeatureVc ()

@property(nonatomic,strong) UICollectionViewFlowLayout *layout;
@end

@implementation XWFeatureVc

static NSString * const reuseIdentifier = @"Cell";



-(instancetype)init{

    self.layout = [[UICollectionViewFlowLayout alloc]init];
  //UICollectionViewFlowLayout UICollectionViewLayout
    
    return [super initWithCollectionViewLayout:self.layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    // 注册
    [self.collectionView registerClass:[XWCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self prepareLayout];
}



#pragma mark  - 参数设置
-(void)prepareLayout{
    
    self.layout.itemSize = [UIScreen mainScreen].bounds.size;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    // 分页
    self.collectionView.pagingEnabled = YES;
    // 取消弹簧效果
    self.collectionView.bounces = NO;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XWCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageIndex = indexPath.item;
  

    return cell;
}

// MARK: - collectionView分页滚动完毕cell看不到的时候调用

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    // 取得正在显示的cell
    NSIndexPath * indexPath1 = [[collectionView indexPathsForVisibleItems] firstObject];
    
    XWCollectionCell *cell1 = (XWCollectionCell*)[collectionView cellForItemAtIndexPath:indexPath1];
    
    if (indexPath1.item == itemCount - 1){
        
        [cell1 startAnimation];
    }

}

@end


#pragma mark - 自定义cell的实现

@interface XWCollectionCell ()

@property(nonatomic,strong) UIImageView *featureView;

@property(nonatomic,strong) UIButton *startBtn;


@end

@implementation XWCollectionCell



// 注意构造方法
// 错误方法
//-(instancetype)initWithFrame:(CGRect)frame{
//    [self prepareUI];
//    [super initWithFrame:frame];
//}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self){
//        [self prepareUI];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self){
     
        [self prepareUI];
    }
    return self;
}



//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//       [self prepareUI];
//    }
//    return self;
//}

#pragma mark - 准备UI
-(void)prepareUI{
    
    // 添加子控件
    [self.contentView addSubview:self.featureView];
    [self.contentView addSubview:self.startBtn];
    
    self.featureView.translatesAutoresizingMaskIntoConstraints = NO;
    self.startBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 约束
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.featureView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
     [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.featureView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
     [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.featureView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
     [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.featureView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
     // 开始按钮
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.startBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-160]];
    
     [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.startBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    

}


#pragma mark - index重写
-(void)setImageIndex:(NSInteger)imageIndex{
    _imageIndex = imageIndex;
    
    _featureView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%zd",_imageIndex + 1]];

}

#pragma mark - 懒加载
-(UIImageView *)featureView{
    if (!_featureView) {
        _featureView = [[UIImageView alloc]init];
//        _featureView.image = [UIImage imageNamed:@"new_feature_1"];
    }
    return _featureView;
}

-(UIButton *)startBtn{
    if (!_startBtn){
        _startBtn = [[UIButton alloc]init];
     
        _startBtn.hidden = YES;
        // 设置按钮背景
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        
        // 设置文字
        [_startBtn setTitle:@"开始体验" forState:UIControlStateNormal];
        
        [_startBtn addTarget:self action:@selector(jumpToVc) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

#pragma mark - 按钮点击事件
-(void)jumpToVc{


}

#pragma mark - 按钮的动画

-(void)startAnimation{
    _startBtn.hidden = NO;
    
    // 设置其缩放为0
    _startBtn.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:1 animations:^{
        
        _startBtn.transform = CGAffineTransformIdentity;
    }];
}






@end
