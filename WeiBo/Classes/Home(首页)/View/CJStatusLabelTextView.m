//
//  CJStatusLabelTextView.m
//  WeiBo
//
//  Created by mac527 on 15/10/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusLabelTextView.h"
#import "CJSpecialText.h"
#define CJStatusTextViewCoverTag 9800
@implementation CJStatusLabelTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 关闭编辑
        self.editable = NO;
        // 解决文字不出来的bug
        self.scrollEnabled = NO;
        
        // 容器边距  默认为 {8,0,8,0};
        // 默认左右有间距 但是值为0 ;
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    NSArray *specials = [self.attributedText attribute:@"special" atIndex:0 effectiveRange:NULL];

    for (CJSpecialText *special in specials) {
        self.selectedRange = special.range;
        // self.selectedRange --影响--> self.selectedTextRange
        // 获得选中范围的矩形框
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        self.selectedRange = NSMakeRange(0, 0);
        
        // 遍历数组 判断触摸点与特殊字符矩形框是否有交点
        for (UITextSelectionRect *selectedRect in rects) {
            CGRect rect = selectedRect.rect;
            // 如果长度或者宽度为0 弃用
            if (rect.size.height == 0 || rect.size.width == 0) continue;

            if (CGRectContainsPoint(rect, point)) { // 选中了某个特殊字符
                for (UITextSelectionRect *selectionRect in rects) {
                    CGRect rect = selectionRect.rect;
                    if (rect.size.height == 0 || rect.size.width == 0) continue;
                    UIView *cover = [[UIView alloc] init];
                    cover.backgroundColor = [UIColor greenColor];
                    cover.frame = rect;
                    cover.tag = CJStatusTextViewCoverTag;
                    cover.layer.cornerRadius = 5;
                    [self insertSubview:cover atIndex:0];
                }
                
            }
            
        }
    }

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self touchesCancelled:touches withEvent:event];
        
    });

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in self.subviews) {
        if (view.tag == CJStatusTextViewCoverTag) {
            [view removeFromSuperview];
        }
    }
}

@end
