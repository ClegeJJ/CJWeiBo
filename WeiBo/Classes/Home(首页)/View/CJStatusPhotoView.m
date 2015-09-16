//
//  CJStatusPhotoView.m
//  WeiBo
//
//  Created by mac527 on 15/9/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//
#import "CJPhoto.h"
#import "CJStatusPhotoView.h"
#import "UIImageView+WebCache.h"
@interface CJStatusPhotoView()

@property (nonatomic ,weak) UIImageView *gifView;

@end

@implementation CJStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
    }
    return self;
}


- (void)setPhoto:(CJPhoto *)photo
{
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
    // 不管是gif 还是 GIF ！！！
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"]) {
    
        self.gifView.hidden = NO;
        
    
    }else {
    
        self.gifView.hidden = YES;
        
    }
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    for (int i = 0; i<self.subviews.count; i++) {
        
        UIImageView *gifView = self.subviews[i];
        gifView.layer.anchorPoint = CGPointMake(1, 1);
        gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
        
    }

}
@end
