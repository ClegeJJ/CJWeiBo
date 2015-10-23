//
//  CJStatusToolBar.m
//  WeiBo
//
//  Created by mac527 on 15/9/15.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusToolBar.h"

#import "CJStatus.h"

@interface CJStatusToolBar()


@property (nonatomic ,strong) NSMutableArray *dividers; // 所有分割线


@end

@implementation CJStatusToolBar


- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizedImageWithName:@"Status_toolBar_background"];
        self.highlightedImage = [UIImage imageWithColor:CJColor(236, 236, 245)];
        // 设置分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}
/**
 *  设置分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"timeline_card_bottom_line"]];
    [self addSubview:divider];
    
    //     添加分割线到数组
    [self.dividers addObject:divider];
}

/**
 *  调整子控件位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger dividerCount = self.dividers.count;
    CGFloat dividerFirstX = self.width / (dividerCount + 1);
    CGFloat dividerH = self.height;
    
    // 设置分割线的frame
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 3;
        divider.height = dividerH;
        divider.centerX = (i + 1) * dividerFirstX;
        divider.centerY = dividerH * 0.5;
    }

}


//- (void)drawRect:(CGRect)rect
//{
////    [UIImage imageNamed:@"common_button_red"];
//    
//    //        self.highlightedImage = [UIImage imageWithColor:CJColor(236, 236, 245)];
//}
@end
