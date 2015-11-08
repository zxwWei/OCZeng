//
//  XWPhotoSelctorVC.m
//  WeiboOC
//
//  Created by apple1 on 15/11/8.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWPhotoSelctorVC.h"
#import "UIImage+Extension.h"

@interface XWPhotoSelctorVC ()<XWPhotoSelctorCellDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate>

@property(nonatomic,strong) UICollectionViewFlowLayout *layout;

/**
 *  图片数组
 */
@property(nonatomic,strong) NSMutableArray *photos;

/**
 *  记录加号被点击时所在位置
 */
@property(nonatomic,strong) NSIndexPath *currentIndexpath;

@end

@implementation XWPhotoSelctorVC
#define MaxItemCount 6
static NSString * const reuseIdentifier = @"Cell1";

// 1.构造函数
-(instancetype)init{
    
    self.layout = [[UICollectionViewFlowLayout alloc]init];
    
    return [super initWithCollectionViewLayout:self.layout];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 2.注册
    [self.collectionView registerClass:[XWPhotoSelctorCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self preparePhotoCollectionView];
}

-(void)preparePhotoCollectionView{
    
    // 每个cell的大小
    self.layout.itemSize = CGSizeMake(80, 80);
    
    // 设置每组的间距
    self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.photos.count < MaxItemCount ? self.photos.count+1 : self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XWPhotoSelctorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 设定代理
    cell.delegate = self;
    
    // 设定图片 注意数组越界  当替换图片时，最后一张的加号会复用前面的图片
    if (indexPath.item < self.photos.count){
        // 当不设定的时候，直接赋图片给cell.image，但一开始图片数组中并没有图片
        cell.image = self.photos[indexPath.item];
    }
    else{
        cell.image = nil;
    }
    
    return cell;
}

#pragma mark  cell代理事件
// 添加图片
-(void)PhotoCellAddPhotoWithCell:(XWPhotoSelctorCell *)cell{
    // 判断用户是否同意应用访问相册
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        NSLog(@"用户不同意访问相册");
        return;
    }
    
    // 弹出系统相册
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    // 记录cell所在的位置
    self.currentIndexpath = [self.collectionView indexPathForCell:cell];
    
    //TODO: 为什么 设置代理
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)removePhotoWithCell:(XWPhotoSelctorCell *)cell{
        // 根据记录的下标删除
    
    if ([self.collectionView indexPathForCell:cell]) {
        // 删除photos数组中对应的图片
        [self.photos removeObjectAtIndex:self.currentIndexpath.item];
        [self.collectionView reloadData];
    }
    
}

// 选中图片时调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //NSLog(@"%@",info);
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    // 缩减图片 减少内存消耗
    image = [image scaleImageWithNewWidth:300 iamge:image];
    
    // 当是点击加号 当前cell的下标和图片数组中组片张数一样才添加  self.photos.count从1开始
    if (self.currentIndexpath.item == self.photos.count) {
       
        [self.photos addObject:image];
    }
    else{
        // 否则是替换图片
        self.photos[self.currentIndexpath.item] = image;
    }
    
    
    [self.collectionView reloadData];
    // 关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
-(NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

@end


#pragma mark - 自定义cell的实现

@interface XWPhotoSelctorCell ()

/// 删除按钮
@property(nonatomic,strong) UIButton *removeBtn;

/// 添加按钮
@property(nonatomic,strong) UIButton *addBtn;

@end


@implementation XWPhotoSelctorCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self){
    
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


#pragma mark - 准备UI
-(void)prepareUI{
    
    self.backgroundColor = [UIColor brownColor];
    // 添加子控件
    [self.contentView addSubview:self.addBtn];
    [self.contentView addSubview:self.removeBtn];
    
    // 设定约束
    self.addBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.removeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"ad":self.addBtn , @"rb":self.removeBtn};
    
    // 添加按钮
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[ad]-0-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[ad]-0-|" options:0 metrics:nil views:views]];
    
    // 删除按钮
    // 距离右边一定的距离
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rb]-0-|" options:0 metrics:nil views:views]];
    // 距离顶部一定的距离
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[rb]" options:0 metrics:nil views:views]];
}

#pragma mark  数据刷新 
-(void)setImage:(UIImage *)image{
    _image = image;
    
    if (_image == nil) {
        [_addBtn setImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateHighlighted];
    }
    else{
        [self.addBtn setImage:image forState:UIControlStateNormal];
        [self.addBtn setImage:image forState:UIControlStateHighlighted];
    }
    // 当有图片的时 image == nil不成立   _removeBtn.hidden = NO 删除按钮出现
    _removeBtn.hidden = image == nil;
}


#pragma mark - 懒加载
// 设置加号按钮
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]init];
        
        [_addBtn setImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
        // 设置图片的填充模式
        _addBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _addBtn;
}

// 设置删除按钮
-(UIButton *)removeBtn{
    if (!_removeBtn) {
        _removeBtn = [[UIButton alloc]init];
        [_removeBtn setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
        [_removeBtn addTarget:self action:@selector(removePhoto) forControlEvents:UIControlEventTouchUpInside];
        _removeBtn.hidden = YES;
    }
    return _removeBtn;
}

#pragma mark - 按钮点击事件
-(void)addPhoto{

    if ([self.delegate respondsToSelector:@selector(PhotoCellAddPhotoWithCell:)]) {
        [self.delegate PhotoCellAddPhotoWithCell:self];
    }
}

-(void)removePhoto{
    if ([self.delegate respondsToSelector:@selector(removePhotoWithCell:)]) {
        [self.delegate removePhotoWithCell:self];
    }
    
}


@end
