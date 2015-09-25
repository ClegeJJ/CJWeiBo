//
//  CJEmotionButton.m
//  WeiBo
//
//  Created by mac527 on 15/9/24.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJEmotionButton.h"
#import "CJEmotion.h"
#import "NSString+Emoji.h"
@implementation CJEmotionButton

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self == [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self == [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;

}

/**
 *  初始化
 */
- (void)setUp
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.adjustsImageWhenHighlighted = NO;

}


/**
 *  传递模型数据
 */
- (void)setEmotion:(CJEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {
        
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        
    }else {
        
        NSString *strEmoji = [emotion.code emoji];
        [self setTitle:strEmoji forState:UIControlStateNormal];

    }
}

@end
