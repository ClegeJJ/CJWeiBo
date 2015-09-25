//
//  CJEmotionPopView.h
//  WeiBo
//
//  Created by mac527 on 15/9/24.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJEmotionButton.h"
@interface CJEmotionPopView : UIView

+ (instancetype)popView;



- (void)showPopViewWithBtn:(CJEmotionButton *)emotionButton;

@end
