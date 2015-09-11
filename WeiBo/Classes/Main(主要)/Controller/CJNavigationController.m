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

    [self setupNavTheme];
    
    [self setupTabBarItemTheme];

}

+ (void)setupNavTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    NSMutableDictionary *textAttri = [NSMutableDictionary dictionary];
    textAttri[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
    textAttri[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.400 alpha:1.000];
    [navBar setTitleTextAttributes:textAttri];

}


+ (void)setupTabBarItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttri = [NSMutableDictionary dictionary];
    textAttri[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    textAttri[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    
    
//    [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
    [item setTitleTextAttributes:textAttri forState:UIControlStateNormal];



}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{


    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];

}

@end
