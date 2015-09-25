//
//  CJEmotionTextView.m
//  WeiBo
//
//  Created by mac527 on 15/9/25.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJEmotionTextView.h"
#import "CJEmotion.h"
#import "NSString+Emoji.h"
#import "UITextView+CJ.h"
#import "HWEmotionAttachment.h"

@implementation CJEmotionTextView


- (void)insertEmotion:(CJEmotion *)emotion
{

    if (emotion.code) { // emoji
        
        [self insertText:emotion.code.emoji];
        
    }else if (emotion.png){ // 图片
        HWEmotionAttachment *attac = [[HWEmotionAttachment alloc] init];
        attac.emotion = emotion;
        attac.bounds = CGRectMake(0, -4, self.font.lineHeight, self.font.lineHeight);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attac];
        
        [self insertAttributedText:imageStr];
        
        
    }


}

- (NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    
    // 遍历所有的属性文字（图片、emoji、普通文字）
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        // 如果是图片表情
        HWEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) { // 图片
            NSLog(@"%@",attch.emotion.chs);
            
            [fullText appendString:attch.emotion.chs];
        } else { // emoji、普通文本
            // 获得这个范围内的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    
    return fullText;
}
@end
