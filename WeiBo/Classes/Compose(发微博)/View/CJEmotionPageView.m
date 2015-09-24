//
//  CJEmotionPageView.m
//  WeiBo
//
//  Created by mac527 on 15/9/24.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  

#import "CJEmotionPageView.h"
#import "CJEmotion.h"
#define CJPageViewInset 20

@implementation CJEmotionPageView



- (void)setEmotions:(NSArray *)emotions
{
    
    _emotions = emotions;
    
    UIImage *image = [UIImage imageNamed:@"d_aoteman"];
    NSLog(@"%@",image);
    
    for (int i = 0; i < emotions.count; i ++) {
        UIButton *button = [[UIButton alloc] init];
        CJEmotion *emotion = emotions[i];
        
#warning TODO

        if (emotion.png) {

            [button setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
            NSLog(@"%@",emotion.png);
        }else {
        
            [button setTitle:emotion.code forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:32];
        }
        [self addSubview:button];
    }

}


- (void)layoutSubviews
{
    
    CGFloat btnW = (self.width - (2 * CJPageViewInset)) / 7;
    CGFloat btnH = (self.height - CJPageViewInset) / 3;
    
    for (int i = 0; i < self.subviews.count; i ++ ) {
        
        CGFloat btnX = CJPageViewInset + (i%7) * btnW;
        CGFloat btnY = CJPageViewInset + (i/7) * btnH;
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);

        
    }

}
@end
