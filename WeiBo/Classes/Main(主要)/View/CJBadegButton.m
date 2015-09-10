//
//  CJBadegButton.m
//  WeiBo
//
//  Created by mac527 on 15/9/10.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJBadegButton.h"




@implementation CJBadegButton


- (instancetype)initWithFrame:(CGRect)frame
{

    if (self == [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        
        
        self.hidden = YES;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.userInteractionEnabled = NO;
        
        

    }
    return self;
}



/**
 *  set方法设置属性 宽高
 */
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];

    if (badgeValue) { // 有值 算宽高
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        CGFloat badgW = self.currentBackgroundImage.size.width;
        CGFloat badgH = self.currentBackgroundImage.size.height;

        if (badgeValue.length > 1) {
            CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
            
            badgW = size.width + 10;
        }

        self.frame = CGRectMake(0, 0, badgW, badgH);
        
    }else{ // 空值 隐藏
        
        self.hidden = YES;
        
        
    }




}

@end
