//
//  CJEmotionTabBar.h
//  WeiBo
//
//  Created by mac527 on 15/9/22.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    
    CJEmotionTabBarButtonTypeRecent = 1231,
    CJEmotionTabBarButtonTypeDefault = 232,
    CJEmotionTabBarButtonTypeEmoji = 324532,
    CJEmotionTabBarButtonTypeLXH = 12321321


} CJEmotionTabBarButtonType;
@class CJEmotionTabBar;

@protocol CJEmotionTabBarDelegate <NSObject>

@optional

- (void)emotionTabBar:(CJEmotionTabBar *)tabBar didSelectedButton:(CJEmotionTabBarButtonType)buttonType;

@end

@interface CJEmotionTabBar : UIView

@property (nonatomic ,weak) id <CJEmotionTabBarDelegate> delegate;

@end
