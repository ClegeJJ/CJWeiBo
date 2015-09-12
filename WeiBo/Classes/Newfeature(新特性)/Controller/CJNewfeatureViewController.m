//
//  CJNewfeatureViewController.m
//  WeiBo
//
//  Created by mac527 on 15/9/11.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJNewfeatureViewController.h"

#import "CJTabBarController.h"

#define CJNewfeatureImage 3  // 新特性加载图片数


@interface CJNewfeatureViewController () <UIScrollViewDelegate>

@property (nonatomic ,weak) UIPageControl *pageControl;

@end

@implementation CJNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建滑动视图
    [self setupScrollView];
    
    
    // 创建pageControl
    [self setupPageControl];


    
}

    // 创建滑动视图
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    
    // 滑动视图宽高
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    
    // 加载图片
    for (int index = 0; index < CJNewfeatureImage; index++) {
        
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",index + 1];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:name]];
        
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        // 设置最后一张图片内容
        if (index == CJNewfeatureImage - 1) {
            
            [self setupLastImageView:imageView];
        }
    }
    
    
    // 分页
    scrollView.pagingEnabled = YES;
    
    // 内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * CJNewfeatureImage , 0);
    
    // 隐藏滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    // 弹簧属性
    scrollView.bounces = NO;
    
    // 设置代理
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    
}

/**
 *  设置最后一张图片上的子控件
 */
- (void)setupLastImageView:(UIImageView *)imageView
{

    imageView.userInteractionEnabled = YES;
    // 1.设置开始按钮
    CGFloat imageViewW = imageView.frame.size.width;
    CGFloat imageViewH = imageView.frame.size.height;
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    [startButton setTitle:@"开始新的旅程" forState:UIControlStateNormal];
    
    startButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    startButton.center = CGPointMake(imageViewW * 0.5, imageViewH * 0.6);
    
    startButton.bounds = (CGRect){CGPointZero , CGSizeMake(200, 50)};

    [startButton addTarget:self action:@selector(startWeiBo) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:startButton];
    
    
    // 2.设置分享给好友按钮
    
    UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    [checkbox setTitle:@"分享新特性" forState:UIControlStateNormal];
    
    checkbox.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    checkbox.center = CGPointMake(imageViewW * 0.5, imageViewH * 0.5);
    
    checkbox.bounds = (CGRect){CGPointZero , CGSizeMake(200, 50)};
    
    checkbox.selected = YES;
    
    checkbox.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [checkbox addTarget:self action:@selector(checkboxButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkbox];
}

/**
 *  开始微博
 */
- (void)startWeiBo
{
    
    self.view.window.rootViewController = [[CJTabBarController alloc] init];

    
}

/**
 *  checkbox 被点击调用
 */
- (void)checkboxButtonClick:(UIButton *)button
{
    
    NSLog(@"%d",button.selected);
    button.selected = !button.isSelected;

}

/**
 *  创建pageControl
 */
- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    // 设置中点
    pageControl.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.95);
    
    // 设置尺寸
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    
    // 设置总共多少页
    pageControl.numberOfPages = CJNewfeatureImage;
    
    // 设置未被选中的颜色
    pageControl.pageIndicatorTintColor = CJColor(189, 189, 189);
    
    // 设置当前选中的颜色
    pageControl.currentPageIndicatorTintColor = CJColor(253, 98, 42);

    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

/**
 *  scrollView代理方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    // 当前X轴移动距离
    CGFloat currenX = scrollView.contentOffset.x;
    
    // 当前X轴移动距离 / scrollView的宽度
    double pageDouble = currenX / scrollView.frame.size.width;
    
    // 转化成整数 四舍五入
    int page = (int)(pageDouble + 0.5);

    // 根据移动距离设置当前页数
    self.pageControl.currentPage = page;
}

@end
