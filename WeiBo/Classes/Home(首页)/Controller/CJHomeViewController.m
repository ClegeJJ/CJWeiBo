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
@interface CJHomeViewController ()

@end

@implementation CJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
