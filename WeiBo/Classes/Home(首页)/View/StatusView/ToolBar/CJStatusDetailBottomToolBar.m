//
//  CJStatusDetailBottomToolBar.m
//  WeiBo
//
//  Created by mac527 on 15/10/23.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusDetailBottomToolBar.h"

@interface CJStatusDetailBottomToolBar()


@end

@implementation CJStatusDetailBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1. 设置与用户交互 button才能监听事件
        self.userInteractionEnabled = YES;
        // 2. 设置bar的背景颜色
        self.backgroundColor = [UIColor clearColor];
        // 3. 设置子控件
        [self setupButtonWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        [self setupButtonWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        [self setupButtonWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_middlebottom_highlighted"];
        
    }
    return self;
}

/**
 *  设置按钮
 *
 *  @param title   标题
 *  @param image   小图片
 *  @param bgImage 选中时背景图片
 */
- (UIButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];  // 文字颜色
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];   // 字体
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);  // 调整button内间距
    
    btn.adjustsImageWhenHighlighted = NO;  // 自动调整图片
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    //  添加按钮到数组
    return btn;
    
    
}
- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImageWithName:@"statusdetail_toolbar_background"] drawInRect:rect];
}


/**
 *  调整子控件位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat margin = 10;
    CGFloat btnW = (self.width - (count + 1) * margin) / count;
    CGFloat btnY = 5;
    CGFloat btnH = self.height - 2 * btnY;
    for (int i = 0; i < count ; i ++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = btnY;
        btn.x = margin + i * (btnW + margin);
    }
}

@end
