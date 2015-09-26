//
//  CJEmotionPageView.m
//  WeiBo
//
//  Created by mac527 on 15/9/24.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  



#import "CJEmotionPageView.h"
#import "CJEmotion.h"
#import "CJEmotionButton.h"
#import "CJEmotionPopView.h"

@interface CJEmotionPageView()

@property (nonatomic ,weak) UIButton *deleteButton;
@property (nonatomic ,strong) CJEmotionPopView *popView;

@end

@implementation CJEmotionPageView

- (CJEmotionPopView *)popView
{

    if (_popView == nil) {
        
        _popView = [CJEmotionPopView popView];
        
    }
    
    return _popView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted" ] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
        
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}

/**
 *  传递模型数据
 *
 */
- (void)setEmotions:(NSArray *)emotions
{
    
    _emotions = emotions;
    
    
    for (int i = 0; i < emotions.count; i ++) {
        CJEmotionButton *button = [[CJEmotionButton alloc] init];
        button.emotion = emotions[i];
        [button addTarget:self action:@selector(emotionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }

}


- (void)layoutSubviews
{
    
    CGFloat btnW = (self.width - (2 * CJPageViewInset)) / CJEmotionMaxCols;
    CGFloat btnH = (self.height - CJPageViewInset) / CJEmotionMaxRows;
    
    for (int i = 0; i < self.emotions.count; i ++ ) {
        
        CGFloat btnX = CJPageViewInset + (i%CJEmotionMaxCols) * btnW;
        CGFloat btnY = CJPageViewInset + (i/CJEmotionMaxCols) * btnH;
        CJEmotionButton *button = self.subviews[i + 1];
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    self.deleteButton.height = btnH;
    self.deleteButton.width = btnW;
    self.deleteButton.x = self.width - btnW - CJPageViewInset;
    self.deleteButton.y = self.height - btnH;

}

/**
 *  监听长按手势
 */
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    // 寻找当前长按的表情按钮
    CGPoint loco = [recognizer locationInView:recognizer.view];
    CJEmotionButton *selectedBtn = nil;
    for (int i = 0 ; i < self.emotions.count; i ++) {
        CJEmotionButton *btn = self.subviews[i + 1];
        
        if (CGRectContainsPoint(btn.frame, loco))
        {
            selectedBtn = btn;
            break;
        }
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            
            
            [self emotionButtonClick:selectedBtn];
            
            break;
        case UIGestureRecognizerStateChanged: // 改变
        case UIGestureRecognizerStateBegan: // 开始
            
            [self.popView showPopViewWithBtn:selectedBtn];
            
            break;
        default:
            break;
    }
}

/**
 *  监听点击
 */
- (void)emotionButtonClick:(CJEmotionButton *)btn
{
    [self.popView showPopViewWithBtn:btn];
    
    CJEmotion *emotion = btn.emotion;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[CJselectedEmotionKey] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:CJEmotionKeyboardDidSelectedNotification object:nil userInfo:dict];
    
    // 移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.popView removeFromSuperview];
        
    });
}

- (void)deleteButtonClick
{

    NSLog(@"删除");

}
@end
