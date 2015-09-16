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
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@implementation CJStatusPhotosView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
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
            photoView.tag = self.subviews.count;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
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
- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
    
    NSUInteger count = self.photos.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        
        CJPhoto *cjphoto = self.photos[i];
        NSString *photoUrl = [cjphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

+ (CGSize)sizeWithCount:(int)count;
{
    // 最大的列数
    if (count == 1) {
        return CGSizeMake(CJPhotoWH, CJPhotoWH);
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
