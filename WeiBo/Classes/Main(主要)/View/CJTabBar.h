//
//  CJTabBar.h
//  WeiBo
//
//  Created by mac527 on 15/9/9.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJTabBar;
@protocol CJTabBarDelegate <NSObject>

@optional

- (void)tabBar:(CJTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;
- (void)tabBarDidCilckPlusButton:(CJTabBar *)tabBar;
@end

@interface CJTabBar : UIView

@property (nonatomic ,weak) id <CJTabBarDelegate> delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
