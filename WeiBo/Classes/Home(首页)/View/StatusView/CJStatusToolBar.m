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


@property (nonatomic ,strong) NSMutableArray *btns; // 所有button

@property (nonatomic ,strong) NSMutableArray *dividers; // 所有分割线

/**
 *  微博的转发数
 */
@property (nonatomic, strong) UIButton *reposts_countBtn;
/**
 *  微博的评论数
 */
@property (nonatomic, strong) UIButton *comments_countBtn;
/**
 *  微博的表态数
 */
@property (nonatomic, strong) UIButton *attitudes_countBtn;
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
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1. 设置与用户交互 button才能监听事件
        self.userInteractionEnabled = YES;
        
        // 2. 设置bar的背景图片
        self.image = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        self.highlightedImage = [UIImage imageWithColor:CJColor(236, 236, 245)];
        
        // 3. 设置子控件
        self.reposts_countBtn = [self setupButtonWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        self.comments_countBtn = [self setupButtonWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        self.attitudes_countBtn = [self setupButtonWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_middlebottom_highlighted"];
        
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
- (UIButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];  // 文字颜色
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];   // 字体
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);  // 调整button内间距
   
    btn.adjustsImageWhenHighlighted = NO;  // 自动调整图片
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    //  添加按钮到数组
    [self.btns addObject:btn];
    
    return btn;


}

- (void)setStatus:(CJStatus *)status
{
    _status = status;
    
    // 设置转发数据
    [self setupButton:self.reposts_countBtn count:status.reposts_count originalTitle:@"转发"];
    
    // 设置评论数据
    [self setupButton:self.comments_countBtn count:status.comments_count originalTitle:@"评论"];
    
    // 设置赞数据
    [self setupButton:self.attitudes_countBtn count:status.attitudes_count originalTitle:@"赞"];
    
    
}
/**
 *  给工具条内子控件传输模型数据
 *
 *  @param button        要赋值数据的按钮
 *  @param count         数据
 *  @param originalTitle 原标题
 */
- (void)setupButton:(UIButton *)button count:(int)count originalTitle:(NSString *)originalTitle
{
    NSString *title = nil;
    
    if (count) { // 评论大于0
        
        if (count < 10000) { // 评论数小于一万
            
            title = [NSString stringWithFormat:@"%d",count];
            
        } else { // 评论数大于一万
            
            double number = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",number];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }

    }else{ // 评论为0
        title = originalTitle;
    }

    [button setTitle:title forState:UIControlStateNormal];

}

/**
 *  调整子控件位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Y = 0;
    CGFloat H = self.frame.size.height;
    CGFloat dividerW = 2;
    CGFloat btnW = (self.frame.size.width - (dividerW * self.dividers.count)) / self.btns.count;
    // 调整按钮位置
    for (int index = 0; index < self.btns.count; index ++) {
        
        CGFloat X = index * (btnW + dividerW);
        UIButton *btn = self.subviews[index];

        btn.frame = CGRectMake(X, Y, btnW, H);
    }
    

    // 调整分割线位置
    for (int j = 0; j < self.dividers.count; j++) {
        
        UIImageView *divider = self.dividers[j];
        UIButton *btn = self.btns[j];
        CGFloat X = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(X, Y, dividerW, H);
        
    }

}
@end
