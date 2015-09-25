//
//  CJTextView.m
//  WeiBo
//
//  Created by mac527 on 15/9/17.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJTextView.h"

@interface CJTextView ()

@property (nonatomic ,weak) UILabel *placeholderLabel;

@end

@implementation CJTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:17];
        // 添加通知 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        self.placeholderLabel = label;
        self.placeholderLabel.textColor = [UIColor grayColor];

    }
    return self;
}



- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

/**
 *  设置提醒文字
 */
- (void)setPlaceholder:(NSString *)placeholder
{

    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    CGFloat X = 5;
    CGFloat Y = 7;
    CGFloat maxW = self.frame.size.width - 2 * X;
    CGFloat maxH = self.frame.size.height - 2 * Y;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.font;
    CGSize size = [placeholder boundingRectWithSize:CGSizeMake(maxW, maxH) options:0 attributes:dict context:nil].size;
    self.placeholderLabel.frame = CGRectMake(X, Y, size.width, size.height);
    
}




/**
 *  通知方法
 */
- (void)textDidChange
{
    
    
    self.placeholderLabel.hidden = self.text.length | self.attributedText.length;
    
}
//
- (void)setAttributedText:(NSAttributedString *)attributedText
{

    [super setAttributedText:attributedText];
    
    [self textDidChange];
    
}

@end
