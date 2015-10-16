//
//  CJEmotionTool.m
//  WeiBo
//
//  Created by mac527 on 15/10/15.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJEmotionTool.h"
#import "MJExtension.h"
#import "CJEmotion.h"
@implementation CJEmotionTool

/**
 *  通过 表情 描述 寻找表情库中的表情
 *
 *  @param chs 表情的描述
 *
 *  @return 返回这个表情图片
 */
+ (UIImage *)emotionWithChs:(NSString *)chs;
{

    NSArray *defaultEmotins = [self defaultEmotion];
    for (CJEmotion *emotion in defaultEmotins) {
        if ([emotion.chs isEqualToString:chs]) {
            return [UIImage imageNamed:emotion.png];
        }
    }
    
    for (CJEmotion *emotion in [self LXHEmotion]) {
        if ([emotion.chs isEqualToString:chs]) {
            return [UIImage imageNamed:emotion.png];
        }
    }
    
    return nil;
}


/**
 *  懒加载 加载一次表情数据
 */
static NSArray *_emojiEmotion, *_defaultEmotion, *_LXHEmotion;
+ (NSArray *)emojiEmotion
{
    if (_emojiEmotion == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
        _emojiEmotion = [CJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];;
    }
    return _defaultEmotion;
}
+ (NSArray *)defaultEmotion
{
    if (_defaultEmotion == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"plist"];
        _defaultEmotion = [CJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];;
    }
    return _defaultEmotion;
}
+ (NSArray *)LXHEmotion
{
    if (_LXHEmotion == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"lxh" ofType:@"plist"];
        _LXHEmotion = [CJEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];;
    }
    return _LXHEmotion;
}

@end
