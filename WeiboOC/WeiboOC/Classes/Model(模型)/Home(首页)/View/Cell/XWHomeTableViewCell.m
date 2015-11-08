//
//  XWHomeTableViewCell.m
//  WeiboOC
//
//  Created by apple1 on 15/11/5.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWHomeTableViewCell.h"
#import "XWStatus.h"

@interface XWHomeTableViewCell ()

/**
 *  内容文本
 */
@property(nonatomic,strong) UILabel *contentLabel;

/**
 *  pictureView
 */
@property(nonatomic,strong) UIImageView *pictureView;

/**
 *  顶部块
 */
@property(nonatomic,strong) UIView *topView;
@end

@implementation XWHomeTableViewCell


+(instancetype)cellWithTableView:(UITableView*)tableview{
    static NSString *Id = @"cell";
    
    XWHomeTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:Id];
    if (!cell){
        cell = [[XWHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self){
    
        [self prepareUI];
    }
    return  self;
}

#pragma mark - 准备UI
-(void) prepareUI {
    
    [self setUpcontentLabel];
    [self setUpTopView];

}

-(void) setUpcontentLabel{
    
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.translatesAutoresizingMaskIntoConstraints = false;
    #warning mark - 注意字典的写法
    NSDictionary *views = @{@"contentLabel":self.contentLabel};
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentLabel]-0-|" options:0 metrics:nil views: views] ];
}

-(void) setUpTopView{
//    [self.contentView addSubview:self.topView];
//    self.topView.translatesAutoresizingMaskIntoConstraints = false;
    
    
}

#pragma mark - 数据重写 
-(void)setStatu:(XWStatus *)statu{
    _statu = statu;
    
    _contentLabel.text = statu.text;
    
}


#pragma mark - 懒加载
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        
        _contentLabel.numberOfLines = 0;
        _contentLabel.backgroundColor = [UIColor grayColor];
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor greenColor];
    }
    return _topView;
}


//-(UIImageView *)pictureView{
//    if (!) {
//        <#statements#>
//    }
//}


@end
