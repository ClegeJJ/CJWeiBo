//
//  CJStatusLabelTextView.m
//  WeiBo
//
//  Created by mac527 on 15/10/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusLabelTextView.h"
#import "CJSpecialText.h"
#import "CJCopyLabel.h"
#define CJStatusTextViewCoverTag 9800
@interface CJStatusLabelTextView()
@property (nonatomic, weak) UITextView *textView;
@end

@implementation CJStatusLabelTextView
- (NSMutableArray *)speicalRects
{
    if (!_speicalRects) {
        _speicalRects = [NSMutableArray array];
        NSArray *specials = [self.textView.attributedText attribute:@"special" atIndex:0 effectiveRange:NULL];
        NSMutableArray *allRects = [NSMutableArray array];
        for (CJSpecialText *special in specials) {
            self.textView.selectedRange = special.range;
            // self.selectedRange --影响--> self.selectedTextRange
            // rects内装载的是textView内所有特殊文字矩形框
            NSArray *rects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            // 恢复被选中范围
            self.textView.selectedRange = NSMakeRange(0, 0);
            // 一段特殊文字可能分成多段 (换行)
            // tmps装载这段特殊文字所有的矩形框;
            NSMutableArray *tmps = [NSMutableArray array];
            for (UITextSelectionRect *selectedRect in rects) {
                CGRect rect = selectedRect.rect;
                // 如果长度或者宽度为0 弃用
                if (rect.size.height == 0 || rect.size.width == 0) continue;
            
                [tmps addObject:[NSValue valueWithCGRect:rect]];
            }
            [allRects addObject:tmps];
        }
        _speicalRects = allRects;
    }
    return _speicalRects;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITextView *textView = [[UITextView alloc] init];
        // 设置TextView不能跟用户交互
        textView.userInteractionEnabled = NO;
        textView.textColor = CJColor(90, 90, 90);
        [self addSubview:textView];
        self.textView = textView;

        // 关闭编辑
        self.textView.editable = NO;
        // 解决文字不出来的bug
        self.textView.scrollEnabled = NO;
        // 容器边距  默认为 {8,0,8,0};
        // 默认左右有间距 但是值为0 ;
        self.textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma mark - 公共接口
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    
    self.textView.attributedText = attributedText;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取触摸点
    UITouch *touch = [touches anyObject];

    CGPoint point = [touch locationInView:self];
    // 标记  : 触摸点是否在特殊字符上
    BOOL contains = NO;
    // 获取某一段特殊字符
    for (NSArray *tmps in self.speicalRects) {
        // 获取这一段特殊字符中所有的矩形框
        for (NSValue *rectValue in tmps) {
            
            CGRect rect = [rectValue CGRectValue];
            // 判断触摸点与特殊字符矩形框是否有交点
            if (CGRectContainsPoint(rect, point)) { // 选中了某个特殊字符
                contains = YES;
                break; // 停止遍历
            }
    }
        if (contains) { // 触摸点在某段特殊字符上
            // 获得选中范围的矩形框
            for (NSValue *selecedRect in tmps) {
                CJCopyLabel *cover = [[CJCopyLabel alloc] init];
                cover.backgroundColor = [UIColor lightGrayColor];
                cover.frame = [selecedRect CGRectValue];
                cover.tag = CJStatusTextViewCoverTag;
                cover.layer.cornerRadius = 5;
                [self.textView insertSubview:cover atIndex:0];
            }
            break; // 停止遍历
        }
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 删除遮盖
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 删除遮盖
    for (UIView *view in self.textView.subviews) {
        if (view.tag == CJStatusTextViewCoverTag) {
            [view removeFromSuperview];
        }
    }
}
/**
 *  触摸点是否在自己身上
 *
 *  @param point 触摸点
 *  @param event 事件
 *
 *  @return 如果是 自己来处理事件  如果不是 抛给后面的控件
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (NSArray *tmps in self.speicalRects) {
        for (NSValue *rectValue in tmps) {
            if (CGRectContainsPoint(rectValue.CGRectValue, point)) {
                return YES;
                break;
            }
        }
    }
    return NO;
}

@end
