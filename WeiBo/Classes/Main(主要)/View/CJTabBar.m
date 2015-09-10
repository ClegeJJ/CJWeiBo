//
//  CJTabBar.m
//  WeiBo
//
//  Created by mac527 on 15/9/9.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJTabBar.h"
#import "CJTabBarButton.h"
@interface CJTabBar()

@property (nonatomic ,weak) CJTabBarButton *selectedButton;

@end

@implementation CJTabBar



/**
 *  添加一个 UITabBarItem
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{

    CJTabBarButton *button = [[CJTabBarButton alloc] init];
    
    button.item = item;
    
    [self addSubview:button];

    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
}


/**
 *  监听点击事件 切换控制器
 */
- (void)buttonClick:(CJTabBarButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(self.selectedButton.tag - 2015) to:(button.tag - 2015)];
        
    }
    
    self.selectedButton.selected = NO;

    button.selected = YES;
    
    self.selectedButton = button;

}


/**
 *  调整子控件位置
 */
- (void)layoutSubviews
{

    [super layoutSubviews];
    
    CGFloat Y = 0;
    CGFloat W = kWidth / self.subviews.count;
    CGFloat H = self.frame.size.height;
    for (int index = 0 ;index < self.subviews.count ; index ++)
    {

        CJTabBarButton *button = self.subviews[index];
    
        CGFloat X = W * index;
        
        button.frame = CGRectMake(X, Y, W, H);
     
        button.tag = 2015 + index;
        
        if (index == 0) {
            [self buttonClick:button];
        }
        

    }

}

@end
