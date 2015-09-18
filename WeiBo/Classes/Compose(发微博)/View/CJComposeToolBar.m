//
//  CJComposeToolBar.m
//  WeiBo
//
//  Created by mac527 on 15/9/18.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJComposeToolBar.h"

@implementation CJComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]]];
        
        [self addButtonWithImage:@"compose_camerabutton_background"
                       highImage:@"compose_camerabutton_background_highlighted" tag:CJComposeToolBarButtonTypeCamera];
        [self addButtonWithImage:@"compose_toolbar_picture"
                       highImage:@"compose_toolbar_picture_highlighted" tag:CJComposeToolBarButtonTypePhotoLibrary];
        [self addButtonWithImage:@"compose_mentionbutton_background"
                       highImage:@"compose_mentionbutton_background_highlighted" tag:CJComposeToolBarButtonTypeMention];
        [self addButtonWithImage:@"compose_trendbutton_background"
                       highImage:@"compose_trendbutton_background_highlighted" tag:CJComposeToolBarButtonTypeTrend];
        [self addButtonWithImage:@"compose_emoticonbutton_background"
                       highImage:@"compose_emoticonbutton_background_highlighted" tag:CJComposeToolBarButtonTypeEmotion];
        
    }
    return self;
}


- (void)addButtonWithImage:(NSString *)image highImage:(NSString *)highImage tag:(CJComposeToolBarButtonType)type
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highImage] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = type;
    [self addSubview:button];

}

- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickButton:)]) {
        [self.delegate composeToolBar:self didClickButton:(int)button.tag];
    }

}

- (void)layoutSubviews
{
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIButton *btn = self.subviews[i];
        CGFloat btnW = self.frame.size.width / self.subviews.count;
        CGFloat btnH = self.frame.size.height;
        CGFloat btnX = btnW * i;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }

}


@end
