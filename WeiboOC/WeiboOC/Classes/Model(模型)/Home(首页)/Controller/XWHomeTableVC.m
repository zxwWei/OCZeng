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


#pragma mark - 分组 
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
    //[self loadStatuse];
    
    // 获取本地数据
    [self loadLocalStatus];
}



// 获取acessToken
-(void)getAcessTokenWithCode:(NSString *)code{
    
    [[XWNetWorkTool sharedInstance] getAcessTokenlWithCode:code finished:^(id response, NSError *error) {
       
        
    }];

}



// 加载本地数据
-(void)loadLocalStatus{
    [XWNetWorkTool getblogInfoWithFinishedBlock:^(id response, NSError *error) {
    
//        NSLog(@"%@",response);
        // 创建微博模型
        
        // 1.获取微博数据  这些字段是在微博数组里面的
        NSArray *statusesArr = response[@"statuses"];
        
        // 2.把 "微博字典的数组" 转成 "微博模型的数组"
        NSArray *status = [XWStatus objectArrayWithKeyValuesArray:statusesArr];
        
//        // 遍历微博对象数组中的每个对象
//        for (XWStatus *sts in status ){
//            
//            NSLog(@"status:%@",sts.text);
//        }
        
        // 将数据插入到可变数组的后面
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];
        
        [self.statusArrM insertObjects:status atIndexes:set];
        
        
        [self.tableView reloadData];
    
    }];
}

#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusArrM.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    // 取得数据
    XWStatus *statu = self.statusArrM[indexPath.row];

    XWHomeTableViewCell *cell = [XWHomeTableViewCell cellWithTableView:tableView];
    
    cell.statu = statu;
    
//    static NSString *Id = @"cell";     // UITableViewCellStyleSubtitle 必需的
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
//    
//    cell.textLabel.text = statu.text;
    
    
    return cell;
}


#pragma mark - 初始化导航条控件
-(void)loadStatuse{
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 一定要设置 获取到所有的微博信息
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"access_token"] = [XWUserAccount shareAccount].access_token;
    NSLog(@"%@",[XWUserAccount shareAccount].access_token);
    
    [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
//        NSString *resultStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        XWUser *user = [XWUser objectWithJSONData:responseObject];
        
        
        // TODO: 嵌套模型的转换 swift 和 oc 的 理解  各种属性的关系
        NSLog(@"%@",user);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        
    }];
}



#warning mark - 现在只有一组，只能显示一个头部块 想实现每组有头部块 应该对cell的contentview进行操作
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    return self.line;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 44;
//}

#pragma mark - 懒加载
-(NSMutableArray *)statusArrM{
    if (!_statusArrM) {
        _statusArrM = [NSMutableArray array];
    }
    return _statusArrM;
}
//
//-(UIView *)line{
//    if (!_line) {
//        
//        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthS, 30)];
//        _line.backgroundColor = [UIColor redColor];
//    }
//    return _line;
//}



@end
