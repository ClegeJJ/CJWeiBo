//
//  UIBarButtonItem+CJ.m
//  WeiBo
//
//  Created by mac527 on 15/9/11.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "UIBarButtonItem+CJ.h"

@implementation UIBarButtonItem (CJ)


+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highImage] forState:UIControlStateHighlighted];
    button.bounds = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]  initWithCustomView:button];

}

@end
