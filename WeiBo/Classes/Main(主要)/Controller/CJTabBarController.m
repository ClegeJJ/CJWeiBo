//
//  CJTabBarController.m
//  WeiBo
//
//  Created by mac527 on 15/9/9.
//  Copyright (c) 2015年 mac527. All rights reserved.
//
#import "CJTabBar.h"
#import "CJUnreadCountTool.h"
#import "CJAccount.h"
#import "CJAccountTool.h"
#import "CJTabBarButton.h"
#import "CJTabBarController.h"
#import "CJHomeViewController.h"
#import "CJDiscoverViewController.h"
#import "CJMeViewController.h"
#import "CJMessageViewController.h"
#import "CJNavigationController.h"
#import "CJComposeViewController.h"


@interface CJTabBarController () <CJTabBarDelegate>

@property (nonatomic ,weak) CJTabBar *myTabBar;

@property (nonatomic ,weak) CJHomeViewController *home;
@property (nonatomic ,weak) CJDiscoverViewController *discover;
@property (nonatomic ,weak) CJMeViewController *me;
@property (nonatomic ,weak) CJMessageViewController *message;

@end

@implementation CJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置标签栏
    [self setUpTabBar];
    
    // 设置子控制器
    [self setUpAllChildViewController];
    
    // 添加定时器 发送未读数请求
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    
#warning 固定写法 定时操作放在子线程
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
/**
 *  检查未读消息
 */
- (void)checkUnreadCount
{
    
    CJUnreadCountParma *parma = [CJUnreadCountParma parma];
    parma.uid = @([CJAccountTool account].uid);
    [CJUnreadCountTool unreadCountWithParam:parma success:^(CJUnreadCountResult *result) {
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
    } failure:^(NSError *error) {
    }];
}
/**
 *  移除系统自带的TabBarItem
 */
- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:YES];
    
    [self removeTabBarItem];
}

- (void)removeTabBarItem
{
    for (UIView *view in self.tabBar.subviews) {
        
        if ([view isKindOfClass:[UIControl class]]) {
            
            [view removeFromSuperview];
            
        }
    }

}
/**
 *  初始化自定义TabBar
 */
- (void)setUpTabBar
{
    CJTabBar *myTabBar = [[CJTabBar alloc] initWithFrame:self.tabBar.bounds];
    myTabBar.delegate = self;
    [self.tabBar addSubview:myTabBar];
    self.myTabBar = myTabBar;
    
}


/**
 *  初始化所有控制器
 */
- (void)setUpAllChildViewController
{
    
    // 首页
    CJHomeViewController *homeVC = [[CJHomeViewController alloc] init];
    [self setUpChildViewControllerWithChildVc:homeVC Title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    self.home= homeVC;
    
    // 消息
    CJMessageViewController *messageVC = [[CJMessageViewController alloc] init];
    [self setUpChildViewControllerWithChildVc:messageVC Title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    self.message = messageVC;
    
    //广场
    CJDiscoverViewController *discoverVC = [[CJDiscoverViewController alloc] init];
    [self setUpChildViewControllerWithChildVc:discoverVC Title:@"广场" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    self.discover = discoverVC;
    
    // 我
    CJMeViewController *meVC = [[CJMeViewController alloc] init];
    [self setUpChildViewControllerWithChildVc:meVC Title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    self.me = meVC;


}

/**
 *  设置一个子控制器
 *
 *  @param childVc           <#childVc description#>
 *  @param title             <#title description#>
 *  @param imageName         <#imageName description#>
 *  @param selectedImageName <#selectedImageName description#>
 */
- (void)setUpChildViewControllerWithChildVc:(UIViewController *)childVc Title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    childVc.title = title;
    
    
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    CJNavigationController *nav = [[CJNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    [self.myTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}



#pragma mark - 代理方法
/**
 *  TabBar 代理方法 把当前被选中的按钮传入
 *
 *  @param from   原来选中的位置
 *  @param to     当前选中的位置
 */
- (void)tabBar:(CJTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    
    if (from == to && from == 0) {
        [self.home clickAgain];
    }
    self.selectedIndex = to;

}

- (void)tabBarDidCilckPlusButton:(CJTabBar *)tabBar
{
    CJComposeViewController *compose = [[CJComposeViewController alloc] init];
    CJNavigationController *nav = [[CJNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];

}
@end
