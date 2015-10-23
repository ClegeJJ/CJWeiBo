//
//  CJStatusDetailTopToolBar.m
//  WeiBo
//
//  Created by mac527 on 15/10/23.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusDetailTopToolBar.h"

@interface CJStatusDetailTopToolBar()

@property (nonatomic, weak) UIButton *repostsBtn;
@property (nonatomic, weak) UIButton *commentsBtn;
@property (nonatomic, weak) UIButton *attitudesBtn;
@property (nonatomic, weak) UIImageView *divider;
@end
@implementation CJStatusDetailTopToolBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1. 设置与用户交互 button才能监听事件
        self.userInteractionEnabled = YES;
        // 2. 设置bar的背景颜色
        self.backgroundColor = [UIColor clearColor];
        // 3. 设置子控件
        self.repostsBtn = [self setupButtonWithTitle:@"转发 1000" image:nil bgImage:@"timeline_card_middlebottom_highlighted"];
        
        self.commentsBtn = [self setupButtonWithTitle:@"评论 999" image:nil bgImage:@"timeline_card_middlebottom_highlighted"];

        self.attitudesBtn = [self setupButtonWithTitle:@"赞 0" image:nil bgImage:@"timeline_card_middlebottom_highlighted"];
        
        UIImageView *divider = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"timeline_card_bottom_line"]];
        [self addSubview:divider];
        self.divider = divider;
    }
    return self;
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
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];   // 字体
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);  // 调整button内间距
    
    btn.adjustsImageWhenHighlighted = NO;  // 自动调整图片
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    return btn;
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
    
    CGFloat repostsBtnX = 0;
    CGFloat repostsBtnY = 10;
    CGFloat repostsBtnW = self.width / 6;
    CGFloat repostsBtnH = self.height - repostsBtnY;
    
    CGFloat dividerW = 1;
    
    CGFloat attitudeBtnX = self.width - repostsBtnW;
    
    self.repostsBtn.frame = CGRectMake(repostsBtnX, repostsBtnY, repostsBtnW, repostsBtnH);
    self.divider.frame = CGRectMake(repostsBtnW, repostsBtnY, dividerW, repostsBtnH);
    self.commentsBtn.frame = CGRectMake(repostsBtnW + 1, repostsBtnY, repostsBtnW, repostsBtnH);
    self.attitudesBtn.frame = CGRectMake(attitudeBtnX, repostsBtnY, repostsBtnW, repostsBtnH);
}

@end
