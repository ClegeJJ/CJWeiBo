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
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
        }
    }
    
    
    
    // 拿出所有子控件
    for (int i = 0; i < self.subviews.count; i ++) {
        UIImageView *imageView = self.subviews[i];
        if (i < photosCount) {  // 显示
            
            imageView.hidden = NO;
            
            CJPhoto *photo = photos[i];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        }else { // 隐藏
        
            imageView.hidden = YES;
            
        }
        
    }

}
+ (CGSize)sizeWithCount:(int)count;
{
    // 最大的列数
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
    int maxColumns = CJStatusPhotosMaxColumns(self.photos.count);
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIImageView *imageView = self.subviews[i];
        
        CGFloat W =CJPhotosWH;
        CGFloat H =CJPhotosWH;
        
        int col = i % maxColumns;
        int row = i / maxColumns;
        CGFloat X = col * (CJPhotosWH + CJPhotosMargin);
        CGFloat Y = row * (CJPhotosWH + CJPhotosMargin);

        imageView.frame = CGRectMake(X, Y, W, H);
    }

}

@end
