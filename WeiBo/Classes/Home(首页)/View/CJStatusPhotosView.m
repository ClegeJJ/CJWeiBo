//
//  CJStatusPhotosView.m
//  WeiBo
//
//  Created by mac527 on 15/9/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//
#import "CJPhoto.h"
#import "CJStatusPhotosView.h"
#import "UIImageView+WebCache.h"
#import "CJStatusPhotoView.h"

@implementation CJStatusPhotosView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    
        
    }
    return self;
}


- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;
    
    // 如果不够 创建足够的imageView
    if (self.subviews.count < photosCount) {
        while (self.subviews.count < photosCount ) {
            CJStatusPhotoView *photoView = [[CJStatusPhotoView alloc] init];
            [self addSubview:photoView];
        }
    }
    
    
    
    // 拿出所有子控件
    for (int i = 0; i < self.subviews.count; i ++) {
        CJStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) {  // 显示
            
            photoView.hidden = NO;
            
            photoView.photo = photos[i];



            
        }else { // 隐藏
        
            photoView.hidden = YES;
            
        }
        
    }

}
+ (CGSize)sizeWithCount:(int)count;
{
    // 最大的列数
    if (count == 1) {
        return CGSizeMake(100, 100);
    }
    
    int maxColumns = CJStatusPhotosMaxColumns(count);
    
    // 列数
    int cols = count >= maxColumns ? maxColumns : count;
    
    CGFloat W = (cols - 1) * CJPhotosMargin + cols * CJPhotosWH;
    
    //  行数
    int rows = 0;
    
    if (count % maxColumns == 0) { // 3/6/9
        rows = count / maxColumns;
    }else { // 1/2/4/5/7/8
        rows = count / maxColumns + 1;
    }
    CGFloat H = (rows - 1) * CJPhotosMargin + rows * CJPhotosWH;
    
    
    
    return CGSizeMake(W, H);
}
/**
 *  调整子控件位置
 */
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    int maxColumns = CJStatusPhotosMaxColumns(self.photos.count);
    
    CGFloat W = 0;
    CGFloat H = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        CJStatusPhotoView *imageView = self.subviews[i];
        
        W = self.photos.count > 1 ? CJPhotosWH : CJPhotoWH;
        H = self.photos.count > 1 ? CJPhotosWH : CJPhotoWH;

        int col = i % maxColumns;
        int row = i / maxColumns;
        CGFloat X = col * (CJPhotosWH + CJPhotosMargin);
        CGFloat Y = row * (CJPhotosWH + CJPhotosMargin);

        imageView.frame = CGRectMake(X, Y, W, H);
    }
}

@end
