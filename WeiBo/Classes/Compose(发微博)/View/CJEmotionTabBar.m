//
//  CJEmotionTabBar.m
//  WeiBo
//
//  Created by mac527 on 15/9/22.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJEmotionTabBar.h"
#import "CJEmotionTabBarButton.h"
@interface CJEmotionTabBar ()

@property (nonatomic ,weak) CJEmotionTabBarButton *selectedBtn;

@end

@implementation CJEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addButtonWithTitle:@"最近" type:CJEmotionTabBarButtonTypeRecent];
        [self addButtonWithTitle:@"默认" type:CJEmotionTabBarButtonTypeDefault];
        [self addButtonWithTitle:@"Emoji" type:CJEmotionTabBarButtonTypeEmoji];
        [self addButtonWithTitle:@"浪小花" type:CJEmotionTabBarButtonTypeLXH];
        
    }
    return self;
}

/**
 *  添加一个CJEmotionTabBarButton
 *
 *  @param title 标题
 *  @param type  类型
 */
- (void)addButtonWithTitle:(NSString *)title type:(CJEmotionTabBarButtonType)type;
{

    CJEmotionTabBarButton *button = [[CJEmotionTabBarButton alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(emotionbuttonClick:) forControlEvents:UIControlEventTouchDown];
    button.tag = type;
    [self addSubview:button];
}


- (void)emotionbuttonClick:(CJEmotionTabBarButton *)button
{
    
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectedButton:)]) {
        [self.delegate emotionTabBar:self didSelectedButton:(int)button.tag];
    }
}

- (void)layoutSubviews
{
    
    
    CGFloat Y = 0;
    CGFloat W = kWidth / self.subviews.count;
    CGFloat H = self.frame.size.height;
    
    
    for (int index = 0 ;index < self.subviews.count ; index ++)
    {
        
        CJEmotionTabBarButton *button = self.subviews[index];
        CGFloat X = W * index;
        button.frame = CGRectMake(X, Y, W, H);

        if (index == 1) {
            [self emotionbuttonClick:button];
        }
        
        
    }


}

@end
