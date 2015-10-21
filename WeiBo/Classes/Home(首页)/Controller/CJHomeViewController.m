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

#import "CJHomeStatusTool.h"

#import "CJUserInfoTool.h"

#import "UIImageView+WebCache.h"

#import "CJAccount.h"

#import "CJAccountTool.h"

#import "CJUser.h"

#import "CJStatus.h"

#import "CJStatusFrame.h"

#import "CJStatusCell.h"

#import "MJExtension.h"

#import "MJRefresh.h"

#import "MWPhotoBrowser.h"

#import "CJDetailViewController.h"
@interface CJHomeViewController () <MWPhotoBrowserDelegate>

@property (nonatomic ,strong) NSMutableArray *statusFrames; // 所有微博Frame

@property (nonatomic, strong) NSArray *allWMPhotos;

@property (nonatomic ,strong) CJTitleButton *titleButton;

@end

@implementation CJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(CJStatusFrameBorder, 0, CJStatusFrameBorder, 0);
    self.tableView.backgroundColor = CJColor(226, 226, 226);
    
    // 集成刷新控件
    [self setupRefreshControl];
    
    // 设置导航栏内容
    [self setupNavBar];
    
    // 获得当前用户数据
    [self setupUserData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoDidTap:) name:CJPhotoDidTapNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)photoDidTap:(NSNotification *)notification
{
    self.allWMPhotos = notification.userInfo[CJShowPhotoBrowserKey];
    NSInteger index = [notification.userInfo[CJPhotoIndexKey] integerValue];
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = NO;
    [browser setCurrentPhotoIndex:index];
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:browser];
    nv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nv animated:YES completion:nil];
//    [self.navigationController pushViewController:browser animated:YES];
    
}
#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.allWMPhotos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.allWMPhotos.count) {
        return [self.allWMPhotos objectAtIndex:index];
    }
    return nil;
}
/**
 *  懒加载
 */
- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}


/**
 *  集成刷新控件
 */
- (void)setupRefreshControl
{

    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewData)];

    
    // 上拉刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
    
}
/**
 *  上拉tableView就会调用
 */
- (void)refreshMoreData
{
    
    // 1.封装请求参数
    CJHomeStatusesParam *param = [CJHomeStatusesParam parma];
    param.count = @10;
    if (self.statusFrames.count) {
        CJStatusFrame *statusFrame = [self.statusFrames lastObject];
        long long maxID = [statusFrame.status.idstr longLongValue] - 1;
        param.max_id = @(maxID);
    }
    // 2.发送GET请求 获取微博数据
    [CJHomeStatusTool HomeStatusWithParameters:param success:^(CJHomeStatusesResult *result)  {

        // 装载所有CJStatusFrame
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        // 遍历statusArray数组
        for (CJStatus *status in result.statuses) {
            // 给statusFrame模型赋值
            CJStatusFrame *statusFrame = [[CJStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        [_statusFrames addObjectsFromArray:statusFrameArray];
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
        
        // 刷新tableView
        [self.tableView reloadData];
        
          } failure:^(NSError *error) {
      [self showMessageForRefreshDataWithTitle:@"用户请求超时"];
      [self.tableView.footer endRefreshing];

    }];
}

/**
 *  下拉tableView就会调用
 */
- (void)refreshNewData
{
    // 1.封装请求参数
    CJHomeStatusesParam *param = [CJHomeStatusesParam parma];
    // 是否为第一次加载数据
    if (self.statusFrames.count) {
        CJStatusFrame *statusFrame = self.statusFrames[0];
        param.since_id = @([statusFrame.status.idstr longLongValue]);
    }
    param.count = @30;
        // 2.发送GET请求 获取微博数据
    [CJHomeStatusTool HomeStatusWithParameters:param success:^(CJHomeStatusesResult *result) {
        // 将字典数组转为模型数组(里面放的就是CJStatus模型)
        // 装载所有CJStatusFrame
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        // 遍历statusArray数组
        for (CJStatus *status in result.statuses) {
            // 给statusFrame模型赋值
            CJStatusFrame *statusFrame = [[CJStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
            
        }
        // 中间临时数组 用于拼接旧微博数据和新微博数据
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:_statusFrames];
        _statusFrames = tempArray;
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        
        // 弹出信息提醒
        NSString *title = nil;
        if (statusFrameArray.count) { // 有新微博数据
            
            title = [NSString stringWithFormat:@"%lu 条新微博",statusFrameArray.count];
            
        }else { // 无新微博数据
            title = @"没有新的微博";
        }
        [self showMessageForRefreshDataWithTitle:title];
        
        // 刷新tableView
        [self.tableView reloadData];
#warning bug
        self.tabBarItem.badgeValue = @"";
        
    } failure:^(NSError *error) {
        [self showMessageForRefreshDataWithTitle:@"用户请求超时"];
        [self.tableView.header endRefreshing];

    }];


}
/**
 *  提示最新微博数据
 */
- (void)showMessageForRefreshDataWithTitle:(NSString *)title
{

    // 创建一个 btn
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.navigationController.view insertSubview:messageBtn belowSubview:self.navigationController.navigationBar];
    
    // 设置属性
    [messageBtn setBackgroundColor:[UIColor orangeColor]];
    messageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    messageBtn.userInteractionEnabled = NO;
    messageBtn.titleLabel.textColor = [UIColor whiteColor];
    

    CGFloat W = self.navigationController.navigationBar.frame.size.width;
    CGFloat H = 30;
    CGFloat X = 0;
    CGFloat Y = self.navigationController.navigationBar.frame.size.height - H;
    messageBtn.frame = CGRectMake(X, Y, W, H);
    [messageBtn setTitle:title forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.5 animations:^{
        messageBtn.transform = CGAffineTransformMakeTranslation(0, 50);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            messageBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [messageBtn removeFromSuperview];
        }];
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
    titleButton.bounds = CGRectMake(0, 0, 0, 40);
    
    // 设置标题
    if ([CJAccountTool account].name) {
        [titleButton setTitle:[CJAccountTool account].name forState:UIControlStateNormal];
    }else {
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
   
    // 添加点击事件
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    // 分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 *  加载用户数据  归档用户昵称 方便下次使用时直接获取
 */
- (void)setupUserData
{
    
    // 1.封装请求参数
    CJUserInfoParma *parma = [CJUserInfoParma parma];
    parma.uid = @([CJAccountTool account].uid);

    // 2.发送GET请求 获取微博数据
    [CJUserInfoTool UserInfoWithParameters:parma success:^(CJUserInfoResult *result) {
        [self.titleButton setTitle:result.name forState:UIControlStateNormal];

        // 保存昵称
        CJAccount *account = [CJAccountTool account];
        account.name = result.name;
        [CJAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
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
 *  再次点击home
 */
- (void)clickAgain
{
    [self.tableView.header beginRefreshing];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CJDetailViewController *detail = [[CJDetailViewController alloc] init];
    detail.statusF = self.statusFrames[indexPath.row];
    detail.view.backgroundColor = self.tableView.backgroundColor;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
