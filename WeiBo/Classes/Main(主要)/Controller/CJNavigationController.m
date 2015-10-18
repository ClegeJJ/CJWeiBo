//
//  CJNavigationController.m
//  WeiBo
//
//  Created by mac527 on 15/9/11.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJNavigationController.h"
#import "UIBarButtonItem+CJ.h"
#import "CJTabBarController.h"
@interface CJNavigationController ()

@end

@implementation CJNavigationController


+ (void)initialize
{
    // 设置导航栏主题
    [self setupNavTheme];
    
    // 设置导航栏按钮主题
    [self setupTabBarItemTheme];

}

// 设置导航栏主题
+ (void)setupNavTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    NSMutableDictionary *textAttri = [NSMutableDictionary dictionary];
    textAttri[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
    textAttri[NSForegroundColorAttributeName] = navButtonColor;
    
    [navBar setTitleTextAttributes:textAttri];

}

// 设置导航栏按钮主题
+ (void)setupTabBarItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttri = [NSMutableDictionary dictionary];
    textAttri[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    textAttri[NSForegroundColorAttributeName] = CJColor(84, 84, 84);
    [item setTitleTextAttributes:textAttri forState:UIControlStateNormal];
    
    NSMutableDictionary *disabledTextAttri = [NSMutableDictionary dictionary];
    disabledTextAttri[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disabledTextAttri forState:UIControlStateDisabled];

    
    // 导航栏返回按钮箭头颜色
//    UINavigationBar *nav = [UINavigationBar appearance];
//    nav.tintColor = CJColor(84, 84, 84);
//    [nav setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
}

/**
 *  拦截所有的Push操作
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" highImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" highImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
        
    }
    [super pushViewController:viewController animated:animated];

}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self  popToRootViewControllerAnimated:YES];
    CJTabBarController *tabConroller = (CJTabBarController *)self.tabBarController;
    [tabConroller removeTabBarItem];
}
@end
