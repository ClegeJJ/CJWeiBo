//
//  UIBarButtonItem+CJ.h
//  WeiBo
//
//  Created by mac527 on 15/9/11.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CJ)

/**
 *  快速创建一个自定义button的UIBarButtonItem
 *
 *  @param image     普通状态图片
 *  @param highImage 高亮状态图片
 *  @param target    监听目标
 *  @param action    监听事件
 *
 *  @return <#return value description#>
 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;



@end
