//
//  CJTabBarButton.m
//  WeiBo
//
//  Created by mac527 on 15/9/10.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#define CJTabBarButtonRatio 0.6

#import "CJTabBarButton.h"

#import "CJBadegButton.h"

@interface CJTabBarButton ()

@property (nonatomic ,weak) CJBadegButton *badgeButton;

@end

@implementation CJTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        
        [self setTitleColor:CJColor(234, 103, 7) forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    
    // 给每个item添加 数字显示button
    CJBadegButton *badgeButton = [[CJBadegButton alloc] init];
    badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:badgeButton];
    self.badgeButton = badgeButton;
    
    return self;

}


/**
 *  设置数据
 */
- (void)setItem:(UITabBarItem *)item
{
    
    _item = item;
    // 调用KVO方法设置初始值
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    /**
     *  添加KVO 观察属性改变
     */
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];

}


- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];

}

/**
 *  当item 属性改变就会调用
 *
 *  @param keyPath 被观察的值
 *  @param object  被观察的对象
 *  @param change  存放 改变前后的数值
 *  @param context <#context description#>
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    
    // 调用 badgeButton.badgeValue set方法设置属性 宽高
    self.badgeButton.badgeValue = self.item.badgeValue;

    // 设置坐标
    CGFloat badgX = 0;
    badgX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    if (self.badgeButton.badgeValue.length <= 1) {
        badgX = self.frame.size.width - self.badgeButton.frame.size.width - 15;
    }
    CGFloat badgY = 4;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgX;
    badgeF.origin.y = badgY;
    
    self.badgeButton.frame = badgeF;
}

/**
 *  取消高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted {}

/**
 *  设置Button内titleLabel尺寸
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat Y = contentRect.size.height * CJTabBarButtonRatio;
    CGFloat W = contentRect.size.width;
    CGFloat H = contentRect.size.height * (1 - CJTabBarButtonRatio);
    return CGRectMake(0, Y, W, H);

}

/**
 *  设置Button内imageView尺寸
 *
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{

    CGFloat W = contentRect.size.width;
    CGFloat H = contentRect.size.height * CJTabBarButtonRatio;
    return CGRectMake(0, 5, W, H);

}



@end
