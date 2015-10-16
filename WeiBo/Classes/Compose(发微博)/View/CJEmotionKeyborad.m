//
//  CJEmotionKeyborad.m
//  WeiBo
//
//  Created by mac527 on 15/9/22.
//  Copyright (c) 2015年 mac527. All rights reserved.
//
#import "CJEmotionTabBar.h"
#import "CJEmotionListView.h"
#import "CJEmotionKeyborad.h"
#import "CJEmotionTool.h"
#import "CJEmotion.h"
@interface CJEmotionKeyborad () <CJEmotionTabBarDelegate>

@property (weak ,nonatomic) CJEmotionTabBar *tabBar;
/** 正在显示的ListView */
@property (weak ,nonatomic) CJEmotionListView *showingListView;
/** 表情ListView */
@property (strong ,nonatomic) CJEmotionListView *recentView;
@property (strong ,nonatomic) CJEmotionListView *defaultView;
@property (strong ,nonatomic) CJEmotionListView *emojiView;
@property (strong ,nonatomic) CJEmotionListView *lxhView;


@end
@implementation CJEmotionKeyborad

- (CJEmotionListView *)recentView
{
    if (_recentView == nil) {
        _recentView = [[CJEmotionListView alloc] init];
    }
    return _recentView;
}

- (CJEmotionListView *)defaultView
{
    if (_defaultView == nil) {
        _defaultView = [[CJEmotionListView alloc] init];
        _defaultView.emotions = [CJEmotionTool defaultEmotion];
    }
    return _defaultView;
}
- (CJEmotionListView *)emojiView
{
    if (_emojiView == nil) {
        _emojiView = [[CJEmotionListView alloc] init];
        _emojiView.emotions = [CJEmotionTool emojiEmotion];
    }
    return _emojiView;
}
- (CJEmotionListView *)lxhView
{
    if (_lxhView == nil) {
        _lxhView = [[CJEmotionListView alloc] init];
        _lxhView.emotions = [CJEmotionTool LXHEmotion];
    }
    return _lxhView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =[UIColor whiteColor];
        
        CJEmotionTabBar *tabBar = [[CJEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
    }
    return self;
}

- (void)emotionTabBar:(CJEmotionTabBar *)tabBar didSelectedButton:(CJEmotionTabBarButtonType)buttonType
{
    
    [self.showingListView removeFromSuperview];
    
    
    switch (buttonType) {
        case CJEmotionTabBarButtonTypeRecent: // 最近
            [self addSubview:self.recentView];
            break;
        case CJEmotionTabBarButtonTypeDefault:{ // 默认
            [self addSubview:self.defaultView];
        }
            break;
        case CJEmotionTabBarButtonTypeEmoji:{ // Emoji
            [self addSubview:self.emojiView];
        }
            break;
        case CJEmotionTabBarButtonTypeLXH:{ // 浪小花
            [self addSubview:self.lxhView];
    }
            break;
        default:
            break;
    }
    self.showingListView = [self.subviews lastObject];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    CGFloat tabBarX = 0;
    CGFloat tabBarW = self.frame.size.width;
    CGFloat tabBarH = 44;
    CGFloat tabBarY = self.height - tabBarH;
    self.tabBar.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
    
    self.showingListView.frame = CGRectMake(0, 0, tabBarW, tabBarY);
    
    
}


@end
