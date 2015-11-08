//
//  XWHomeTableVC.m
//  WeiboOC
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 ZXW. All rights reserved.
//

#import "XWHomeTableVC.h"
#import "XWUserAccount.h"
#import "XWUser.h"
#import "XWNetWorkTool.h"
#import "XWStatus.h"
#import "XWHomeTableViewCell.h"

@interface XWHomeTableVC ()

/**
    保存微博模型的可变数组
 */
@property(nonatomic,strong) NSMutableArray *statusArrM;

/**
    分割线
 */
@property(nonatomic,strong) UIView *line;
@end

@implementation XWHomeTableVC


//分组
//这个是代码创建的时候用的
-(instancetype)init{
    
    return [self initWithStyle:UITableViewStyleGrouped];
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 190;
    
//    self.tableView.sectionHeaderHeight = 70;  //好像没用
    // 获取微博网络数据
    [self loadStatuse];
    
    // 获取本地数据
//    [self loadLocalStatus];
    
    // 获取用户信息
    [self loadUserinfo];
}


#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusArrM.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    // 取得数据
    XWStatus *statu = self.statusArrM[indexPath.row];

    XWHomeTableViewCell *cell = [XWHomeTableViewCell cellWithTableView:tableView];
    
    // 更新数据
    cell.statu = statu;
    

    return cell;
}


// TODO: 将具体的网络请求放在具体的对像中
#pragma mark - 网络请求下载数据

// 获取账号用户信息
-(void) loadUserinfo{

    [[XWNetWorkTool sharedInstance] getUserinfoWithFinishedBlock:^(id response, NSError *error) {
        // 将二进制数据转换成json
        //NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        
        //NSLog(@"%@",dict);
        
    }];
}



// 获取网络微博数据
-(void)loadStatuse{
        #warning mark - 通过单例需用对象方法
    
    [[XWNetWorkTool sharedInstance] getNetworkBlogstatusWithFinishedBlock:^(id response, NSError *error) {
        // bug responseObject 是data数据来的
        // NSJSONReadingMutableContainers 参数的区别
        // 将二进制数据转换成json
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        
        // 取得微博数据数组
        NSArray *statusArr = dict[@"statuses"];
        
        // 将其转换成微博对象数组
        NSArray *status = [XWStatus objectArrayWithKeyValuesArray:statusArr];
        
        // 将数据插入到可变数组的后面
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];
        
        [self.statusArrM insertObjects:status atIndexes:set];
        
        [self.tableView reloadData];
        
        // 遍历微博对象数组中的每个对象
        for (XWStatus *sts in status ){

          
           //NSLog(@"status:%@",sts.user);
            
        }
    }];
}

// 加载本地数据
-(void)loadLocalStatus{
    [[XWNetWorkTool sharedInstance]getblogInfoWithFinishedBlock:^(id response, NSError *error) {
        
        // 创建微博模型
        // 1.获取微博数据  这些字段是在微博数组里面的
        NSArray *statusesArr = response[@"statuses"];
        
        // 2.把 "微博字典的数组" 转成 "微博模型的数组"
        NSArray *status = [XWStatus objectArrayWithKeyValuesArray:statusesArr];
        
        // 将数据插入到可变数组的后面
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];
        
        [self.statusArrM insertObjects:status atIndexes:set];
        
        
        [self.tableView reloadData];
        
    }];
}



#pragma mark - 懒加载
-(NSMutableArray *)statusArrM{
    if (!_statusArrM) {
        _statusArrM = [NSMutableArray array];
    }
    return _statusArrM;
}



@end
