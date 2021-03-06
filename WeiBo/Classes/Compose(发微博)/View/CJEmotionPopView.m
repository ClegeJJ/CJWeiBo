//
//  CJEmotionPopView.m
//  WeiBo
//
//  Created by mac527 on 15/9/24.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJEmotionPopView.h"
#import "CJEmotionButton.h"
@interface CJEmotionPopView ()
@property (weak, nonatomic) IBOutlet CJEmotionButton *emotionBtn;


@end

@implementation CJEmotionPopView

+ (instancetype)popView
{

    return [[[NSBundle mainBundle] loadNibNamed:@"CJEmotionPopView" owner:nil options:nil] lastObject];

}

- (void)showPopViewWithBtn:(CJEmotionButton *)emotionButton
{
    self.emotionBtn.emotion = emotionButton.emotion;
    
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self];
    
    
    // 设置Frame
    CGRect btnFram = [emotionButton convertRect:emotionButton.bounds toView:nil];
    self.centerX = CGRectGetMidX(btnFram);
    self.y = CGRectGetMidY(btnFram) - self.frame.size.height;
    

}

@end
