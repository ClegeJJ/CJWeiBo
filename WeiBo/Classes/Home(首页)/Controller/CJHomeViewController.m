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



@interface CJHomeViewController ()

@property (nonatomic ,strong) NSArray *statuses; // 所有微博


@end

@implementation CJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
//    parameters[@"count"] = @1;
    // 3.发送GET请求 获取微博数据
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          self.statuses = responseObject[@"statuses"];
//          CJLog(@"%@",self.statuses);
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

    
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Home_Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }

    NSDictionary *status = self.statuses[indexPath.row];

    // 正文
    cell.textLabel.text = status[@"text"];
    
    
    // 昵称
    NSDictionary *user = status[@"user"];
    cell.detailTextLabel.text = user[@"name"];
    
    // 头像
    NSString *iconUrl = user[@"profile_image_url"];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
    

    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//
//}
@end
