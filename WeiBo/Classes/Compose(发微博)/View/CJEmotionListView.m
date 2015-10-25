//
//  CJEmotionListView.m
//  WeiBo
//
//  Created by mac527 on 15/9/22.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJEmotionListView.h"
#import "CJEmotionPageView.h"


@interface CJEmotionListView () <UIScrollViewDelegate>

@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,weak) UIPageControl *pageControl;
@property (nonatomic ,assign) NSUInteger pageCount;
@end

@implementation CJEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        // 1.scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        // kvc对私有属性赋值
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}
/**
 *  表情分页
 *
 *  @param emotions 表情模型数组
 */
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.pageCount = (emotions.count + CJMaxEmotionCount - 1) / CJMaxEmotionCount;
    self.pageControl.numberOfPages = self.pageCount;
    
    
    for (int i = 0; i < self.pageCount; i++) {
        
        CJEmotionPageView *pageView = [[CJEmotionPageView alloc] init];

        NSRange range;
        range.location = i * CJMaxEmotionCount;
        NSInteger leftEmotions = emotions.count - range.location;
        
        // 判断剩余表情数
        if (leftEmotions >= CJMaxEmotionCount) {
            range.length = CJMaxEmotionCount;
        }else{
            range.length = leftEmotions;
        }
        
        // 截取每一组表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
        
    }
    
    [self setNeedsLayout];
/*
 第一页: 20
 第二页: 40
 
 ...
 */
    
}


#pragma mark - ScrollViewDelegat
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    double pageCount = scrollView.contentOffset.x / scrollView.width;

    self.pageControl.currentPage = (int)(pageCount + 0.5);

}

- (void)layoutSubviews
{
    // 1.pageControl
    CGFloat pageW = self.width;
    CGFloat pageH = 25;
    CGFloat pageX = 0;
    CGFloat pageY = self.height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);

    // 2.scrollView
    CGFloat scrollW = self.width;
    CGFloat scrollH = self.height - pageH;
    CGFloat scrollX = 0;
    CGFloat scrollY = 0;
    self.scrollView.frame = CGRectMake(scrollX, scrollY, scrollW, scrollH);
    self.scrollView.contentSize = CGSizeMake(self.pageCount * scrollW, 0);

    
    
    for (int i = 0; i < self.pageCount; i ++ ) {
        CGFloat pageViewW = self.scrollView.width;
        CGFloat pageViewH = self.scrollView.height;
        CGFloat pageViewX = pageViewW * i;
        CGFloat pageViewY = 0;
        
        CJEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.frame = CGRectMake(pageViewX, pageViewY, pageViewW, pageViewH);
    }
    

    
}
@end
