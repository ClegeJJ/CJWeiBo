//
//  UITextView+CJ.m
//  WeiBo
//
//  Created by mac527 on 15/9/25.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "UITextView+CJ.h"

@implementation UITextView (CJ)

- (void)insertAttributedText:(NSAttributedString *)imageStr
{
    
    // 光标选中的范围
    NSRange range = self.selectedRange;
    // 拼接图片 文字
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] init];
    [attriStr appendAttributedString:self.attributedText];
    // 插入图片到 光标
    [attriStr insertAttributedString:imageStr atIndex:range.location];
    
    // 设置图片大小
    [attriStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attriStr.length)];
    
    // 设置属性文字
    self.attributedText = attriStr;
    
    // 设置光标位置
    self.selectedRange = NSMakeRange(range.location + 1, 0);


}

@end
