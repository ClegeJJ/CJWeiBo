//
//  CJStatusPhotoView.h
//  WeiBo
//
//  Created by mac527 on 15/9/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJPhoto;
@interface CJStatusPhotoView : UIImageView

@property (nonatomic, strong) CJPhoto *photo;

@property (nonatomic ,weak) UIImageView *gifView;

@end
