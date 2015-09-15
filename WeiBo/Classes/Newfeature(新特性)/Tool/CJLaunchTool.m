//
//  CJLaunchTool.m
//  WeiBo
//
//  Created by mac527 on 15/9/12.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  登录工具类

#import "CJLaunchTool.h"

#import "CJTabBarController.h"

#import "CJNewfeatureViewController.h"

@implementation CJLaunchTool

/**
 *  判断要跳转的控制器
 */
+ (void)chooseRootViewController
{

    // 取出沙盒中上次存储的版本数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:@"VersionCode"];
    
    // 取出当前版本数据
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 3.判断是否为新版本
    if ([currentVersion isEqualToString:lastVersion]) { // 非第一次运行 非新版本
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[CJTabBarController alloc] init];
        
    }   else{ // 新版本
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[CJNewfeatureViewController alloc] init];
        
        [defaults setObject:currentVersion forKey:@"VersionCode"];
        [defaults synchronize];
    }


}


@end
