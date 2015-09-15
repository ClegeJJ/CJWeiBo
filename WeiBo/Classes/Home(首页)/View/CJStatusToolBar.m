//
//  CJStatusToolBar.m
//  WeiBo
//
//  Created by mac527 on 15/9/15.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusToolBar.h"

@interface CJStatusToolBar()


@property (nonatomic ,strong) NSMutableArray *btns; // 所有button

@property (nonatomic ,strong) NSMutableArray *dividers; // 所有分割线

@end

@implementation CJStatusToolBar


- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self == [super initWithFrame:frame]) {
        
        // 1. 设置与用户交互 button才能监听事件
        self.userInteractionEnabled = YES;
        
        // 2. 设置bar的背景图片
        self.image = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        self.highlightedImage = [UIImage imageWithColor:CJColor(236, 236, 245)];
        
        // 3. 设置子控件
        [self setupButtonWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_middlebottom_highlighted"];
        [self setupButtonWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        [self setupButtonWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        // 4. 设置分割线
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
 *  设置按钮
 *
 *  @param title   标题
 *  @param image   小图片
 *  @param bgImage 选中时背景图片
 */
- (void)setupButtonWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];  // 文字颜色
    btn.titleLabel.font = [UIFont systemFontOfSize:13];   // 字体
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);  // 调整button内间距
   
    btn.adjustsImageWhenHighlighted = NO;  // 自动调整图片
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
//     添加按钮到数组
    [self.btns addObject:btn];
    
//    return btn;


}

- (void)test
{

    NSLog(@"aa");
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Y = 0;
    CGFloat H = self.frame.size.height;
    CGFloat btnW = self.frame.size.width / self.btns.count;
    // 调整按钮位置
    for (int index = 0; index < self.btns.count; index ++) {
        
        CGFloat X = index * btnW;
        UIButton *btn = self.subviews[index];

        btn.frame = CGRectMake(X, Y, btnW, H);
    }
    
    CGFloat dividerW = 2;
    // 调整分割线位置
    for (int j = 0; j < self.dividers.count; j++) {
        
        UIImageView *divider = self.dividers[j];
        UIButton *btn = self.btns[j];

        CGFloat X = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(X, Y, dividerW, H);
        
    }

}
@end
