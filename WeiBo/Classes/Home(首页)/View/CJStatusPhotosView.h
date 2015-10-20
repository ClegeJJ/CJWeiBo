//
//  CJStatusPhotosView.h
//  WeiBo
//
//  Created by mac527 on 15/9/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  微博中图片的父控件

#import <UIKit/UIKit.h>



#define CJStatusPhotosMaxColumns(count) ((count == 4)?2:3)   // 返回最大列数
@interface CJStatusPhotosView : UIImageView

@property (nonatomic ,strong) NSArray *photos;
@property (nonatomic ,strong) NSMutableArray *allWMPhotos;
+ (CGSize)sizeWithCount:(int)count;

@end
