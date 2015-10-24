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
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UIImageView *arrowView;
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
        self.backgroundColor = CJGlobelBackgroundColor;
        // 3. 设置子控件
        self.repostsBtn = [self title:@"转发 1000"];
        self.repostsBtn.tag = CJStatusDetailTopToolBarButtonTypeReposts;
        
        self.commentsBtn =  [self title:@"评论 999"];
        self.commentsBtn.tag = CJStatusDetailTopToolBarButtonTypeComment;
        
        self.attitudesBtn = [self title:@"赞 10212"];
        self.attitudesBtn.tag = CJStatusDetailTopToolBarButtonTypeAttitude;
        
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"statusdetail_comment_top_arrow"]];
        [self addSubview:arrowView];
        self.arrowView = arrowView;
        
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
 */
- (UIButton *)title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];   // 字体
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);

    [self addSubview:btn];
    
    return btn;
}


- (void)buttonClick:(UIButton *)button
{
    self.selectedBtn.selected = NO;
    self.selectedBtn = button;
    self.selectedBtn.selected = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.arrowView.centerX = button.centerX;
    }];
    
    if ([self.delegate respondsToSelector:@selector(statusDetailTopToolBar:didClickButton:)]) {
        [self.delegate statusDetailTopToolBar:self didClickButton:(int)button.tag];
    }
}
- (void)setDelegate:(id<CJStatusDetailTopToolBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选中了评论按钮
    [self buttonClick:self.commentsBtn];
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
    CGFloat repostsBtnW = self.width / 5;
    CGFloat repostsBtnH = self.height - repostsBtnY;
    
    CGFloat dividerW = 2;
    
    CGFloat attitudeBtnX = self.width - repostsBtnW;

    self.repostsBtn.frame = CGRectMake(repostsBtnX, repostsBtnY, repostsBtnW, repostsBtnH);
    self.commentsBtn.frame = CGRectMake(repostsBtnW + dividerW, repostsBtnY, repostsBtnW, repostsBtnH);
    self.attitudesBtn.frame = CGRectMake(attitudeBtnX, repostsBtnY, repostsBtnW, repostsBtnH);
    self.arrowView.x = self.commentsBtn.centerX;
    self.arrowView.y = self.height - self.arrowView.height;
}

- (void)drawRect:(CGRect)rect
{
    rect.origin.y = 10;
    [[UIImage resizedImageWithName:@"statusdetail_comment_top_background"] drawInRect:rect];
}

@end
