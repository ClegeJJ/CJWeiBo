//
//  CJStatusPhotosView.h
//  WeiBo
//
//  Created by mac527 on 15/9/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CJPhotosWH 70   
#define CJPhotosMargin 10

#define CJStatusPhotosMaxColumns(count) ((count == 4)?2:3)   // 返回最大列数
@interface CJStatusPhotosView : UIImageView

@property (nonatomic ,strong) NSArray *photos;

+ (CGSize)sizeWithCount:(int)count;

@end
