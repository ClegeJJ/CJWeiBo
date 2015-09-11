//
//  CJTabBarController.m
//  WeiBo
//
//  Created by mac527 on 15/9/9.
//  Copyright (c) 2015年 mac527. All rights reserved.
//
#import "CJTabBar.h"
#import "CJTabBarButton.h"
#import "CJTabBarController.h"
#import "CJHomeViewController.h"
#import "CJDiscoverViewController.h"
#import "CJMeViewController.h"
#import "CJMessageViewController.h"
#import "CJNavigationController.h"

@interface CJTabBarController () <CJTabBarDelegate>

@property (nonatomic ,weak) CJTabBar *myTabBar;

@end

@implementation CJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpTabBar];
    
    [self setUpAllChildViewController];
    


}


/**
 *  移除系统自带的TabBarItem
 *
 */
- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:YES];
    
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
    homeVC.tabBarItem.badgeValue = @"10";
    [self setUpChildViewControllerWithChildVc:homeVC Title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    // 消息
    CJMessageViewController *messageVC = [[CJMessageViewController alloc] init];
    [self setUpChildViewControllerWithChildVc:messageVC Title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    //广场
    CJDiscoverViewController *discoverVC = [[CJDiscoverViewController alloc] init];
    [self setUpChildViewControllerWithChildVc:discoverVC Title:@"广场" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];

    // 我
    CJMeViewController *meVC = [[CJMeViewController alloc] init];
    [self setUpChildViewControllerWithChildVc:meVC Title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    


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

/**
 *  TabBar 代理方法 把当前被选中的按钮传入
 *
 *  @param from   原来选中的位置
 *  @param to     当前选中的位置
 */
- (void)tabBar:(CJTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{

    self.selectedIndex = to;

}
@end
