//
//  CJEmotionTool.h
//  WeiBo
//
//  Created by mac527 on 15/10/15.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CJEmotion;
@interface CJEmotionTool : NSObject


+ (NSArray *)defaultEmotion;

+ (NSArray *)LXHEmotion;

+ (NSArray *)emojiEmotion;

+ (UIImage *)emotionWithChs:(NSString *)chs;

+ (NSMutableArray *)recentEmotions;

+ (void)addRecentEmotion:(CJEmotion *)emotion;
@end
