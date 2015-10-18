//
//  CJTitleButton.m
//  WeiBo
//
//  Created by mac527 on 15/9/11.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJTitleButton.h"
#define CJTitleButtonImageW 30
@interface CJTitleButton()
@property (nonatomic ,assign) CGFloat BtnW;
@end

@implementation CJTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 高亮时是否自动调整图片
        self.adjustsImageWhenHighlighted = NO;
        
        // 设置选中时背景图片
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        // 设置标题文字颜色
        [self setTitleColor:navButtonColor forState:UIControlStateNormal];
        // 字体
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        // 图片显示样式居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字显示样式右对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        //        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}



// 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.width = self.BtnW + CJTitleButtonImageW + 5;
    frame.origin.x = ([UIScreen mainScreen].bounds.size.width - frame.size.width) / 2;
    [super setFrame:frame];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    // 根据文字计算自己的宽度
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.titleLabel.font;
    self.BtnW = [title sizeWithAttributes:dict].width;
    CGRect frame = self.frame;
    frame.size.width = self.BtnW + CJTitleButtonImageW + 5;
    self.frame = frame;
    [super setTitle:title forState:state];
    //    [self sizeToFit];
//    self.backgroundColor = CJRandomColor;
}
/**
 *  调整button内部imageView位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = CJTitleButtonImageW;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}
/**
 *  调整button内部titleLabel位置
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width - CJTitleButtonImageW;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = 0;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
@end
