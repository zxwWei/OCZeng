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
@property(nonatomic,strong) UILabel *txtLabel;


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

// 准备UI
-(void) prepareUI {
    
    [self.contentView addSubview:self.txtLabel];
    
    [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.equalTo(self.contentView).with.offset(10);
//        make.centerX.equalTo(self.contentView.mas_centerX);
        make.edges.equalTo(self.contentView).width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}


#pragma mark - 数据重写 
-(void)setStatu:(XWStatus *)statu{
    _statu = statu;
    
    _txtLabel.text = statu.text;
}


#pragma mark - 懒加载
-(UILabel *)txtLabel{
    if (!_txtLabel) {
        _txtLabel = [[UILabel alloc]init];
        
        _txtLabel.numberOfLines = 0;
        [_txtLabel sizeToFit];
    }
    return _txtLabel;
}


@end
