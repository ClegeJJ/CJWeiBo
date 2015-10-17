//
//  CJStatusLabelTextView.h
//  WeiBo
//
//  Created by mac527 on 15/10/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  微博正文控件 - 图文混排 - 文字监控事件

#import <UIKit/UIKit.h>

@interface CJStatusLabelTextView : UITextView

/**
 *  特殊文字所在的矩形框
 */
@property (nonatomic ,strong) NSMutableArray *speicalRects;
@end
