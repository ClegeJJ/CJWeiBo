//
//  CJNavigationController.m
//  WeiBo
//
//  Created by mac527 on 15/9/11.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJNavigationController.h"

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
    textAttri[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAttri forState:UIControlStateNormal];
    
    NSMutableDictionary *disabledTextAttri = [NSMutableDictionary dictionary];
    disabledTextAttri[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disabledTextAttri forState:UIControlStateDisabled];

}

/**
 *  拦截所有的Push操作
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{


    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];

}

@end
