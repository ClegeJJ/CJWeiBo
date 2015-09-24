//
//  CJEmotionTabBarButton.m
//  WeiBo
//
//  Created by mac527 on 15/9/22.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJEmotionTabBarButton.h"

@implementation CJEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
/**
 *  重写 取消高亮状态
 *
 */
- (void)setHighlighted:(BOOL)highlighted
{


}

@end
