//
//  CJEmotionTextView.h
//  WeiBo
//
//  Created by mac527 on 15/9/25.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJTextView.h"
@class CJEmotion;
@interface CJEmotionTextView : CJTextView


- (void)insertEmotion:(CJEmotion *)emotion;


- (NSString *)fullText;
@end
