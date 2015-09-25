//
//  HWEmotionAttachment.m
//  黑马微博2期
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWEmotionAttachment.h"
#import "CJEmotion.h"

@implementation HWEmotionAttachment
- (void)setEmotion:(CJEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
