//
//  CJHomeViewController.m
//  WeiBo
//
//  Created by mac527 on 15/9/9.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJHomeViewController.h"

#import "UIBarButtonItem+CJ.h"

#import "CJTitleButton.h"

#import "AFNetworking.h"

#import "UIImageView+WebCache.h"

#import "CJAccount.h"

#import "CJAccountTool.h"

#import "CJUser.h"

#import "CJStatus.h"

#import "CJStatusFrame.h"

#import "CJStatusCell.h"

#import "MJExtension.h"

@interface CJHomeViewController ()

@property (nonatomic ,strong) NSArray *statusFrames; // 所有微博Frame


@end

@implementation CJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(CJStatusFrameBorder, 0, CJStatusFrameBorder, 0);
    self.tableView.backgroundColor = CJColor(226, 226, 226);
    // 设置导航栏内容
    [self setupNavBar];
    
    // 加载微博数据
    [self setupStatusDate];
    

    
}

- (void)setupStatusDate
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [CJAccountTool account].access_token;
    
//    parameters[@"count"] = @2;
    // 3.发送GET请求 获取微博数据
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {

          // 将字典数组转为模型数组(里面放的就是CJStatus模型)
          NSArray *statusArray = [CJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];

          // 装载所有CJStatusFrame
          NSMutableArray *statusFrameArray = [NSMutableArray array];
          // 遍历statusArray数组
          for (CJStatus *status in statusArray) {
              
              CJStatusFrame *statusFrame = [[CJStatusFrame alloc] init];
              statusFrame.status = status;
              [statusFrameArray addObject:statusFrame];
          
          }
          _statusFrames = statusFrameArray;
          
          [self.tableView reloadData];
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          CJLog(@"请求失败：%@",error);
      }];



}

/**
 *  设置导航栏内容
 */
- (void)setupNavBar
{
    // 设置左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 设置右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 设置中间按钮
    CJTitleButton *titleButton = [CJTitleButton buttonWithType:UIButtonTypeCustom];
    
    // 设置箭头图片
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    // 设置选中图片
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    // 设置宽高
    titleButton.bounds = CGRectMake(0, 0, 110, 40);
    
    // 设置标题
    [titleButton setTitle:@"哈哈哈哈" forState:UIControlStateNormal];
    
    // 添加点击事件
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
}

/**
 *  导航栏左边按钮点击时调用
 */
- (void)findFriend
{

    NSLog(@"findFriend");

}
/**
 *  导航栏右边按钮点击时调用
 */
- (void)pop
{

    NSLog(@"pop");

}

/**
 *  导航栏中间按钮点击时调用
 */
- (void)titleButtonClick:(CJTitleButton *)titleButton
{
    if (titleButton.selected) { // 选中状态
    
        titleButton.selected = NO;
    
    }else{  // 普通状态

        titleButton.selected = YES;
        
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    CJStatusCell *cell = [CJStatusCell cellWithTableView:tableView];
    
    // 取出对应行的微博Frame模型
    CJStatusFrame *statusFrame = self.statusFrames[indexPath.row];

    // 给cell赋值
    cell.statusFrame = statusFrame;
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    return statusFrame.cellHeight;

}
@end
