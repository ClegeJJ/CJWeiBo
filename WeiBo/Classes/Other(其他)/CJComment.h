//
//  CJComment.h
//  WeiBo
//
//  Created by mac527 on 15/9/17.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  存放宏


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
// 0.授权信息
#define AppKey @"3087428443"
#define AppSecret @"cb2c460dcf79e93e80d4a8f396ee4013"
#define AppRedirectURL @"http://www.baidu.com"

// 1.获得RGB颜色
#define CJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 2.自定义Log
#ifdef DEBUG
#define CJLog(...) NSLog(__VA_ARGS__)
#else
#define CJLog(...)
#endif

// 3.定义导航栏文字颜色
#define navButtonColor [UIColor colorWithWhite:0.400 alpha:1.000]

// 4.微博cell相关属性
/** 表格的边框宽度 */
#define CJStatusFrameBorder 7
/** cell的边框宽度 */
#define CJStatusCellBorder 10

/** 昵称的字体 */
#define CJStatusNameFont [UIFont boldSystemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define CJRetweetStatusNameFont [UIFont systemFontOfSize:15]

/** 时间的字体 */
#define CJStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define CJStatusSourceFont [UIFont boldSystemFontOfSize:12]

/** 正文的字体 */
#define CJStatusContentFont [UIFont systemFontOfSize:15]
/** 被转发微博正文的字体 */
#define CJRetweetStatusContentFont [UIFont systemFontOfSize:15]

// 5.微博cell配图相关属性
// 多张配图时图片尺寸
#define CJPhotosWH 70

// 只有一张配图时图片尺寸
#define CJPhotoWH 120
#define CJPhotosMargin 10