//
//  CJRetweetStatusView.m
//  WeiBo
//
//  Created by mac527 on 15/9/15.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJRetweetStatusView.h"
#import "CJStatus.h"
#import "CJUser.h"
#import "CJStatusFrame.h"
#import "UIImageView+WebCache.h"
@interface CJRetweetStatusView()
/**
 *  被转发用户的昵称
 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/**
 *  被转发用户的正文
 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/**
 *  被转发微博的配图
 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;
@end

@implementation CJRetweetStatusView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        
        /** 被转发微博用户的昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = CJRetweetStatusNameFont;
        retweetNameLabel.textColor = CJColor(67, 107, 163);
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        /**  被转发微博的正文 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.textColor = CJColor(90, 90, 90);
        retweetContentLabel.font = CJRetweetStatusContentFont;
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /**  被转发微博的配图 */
        UIImageView *retweetPhotoView = [[UIImageView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}

- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    CJStatus *retReetStatus = self.statusFrame.status.retweeted_status;
    CJUser *user = retReetStatus.user;
    
    // 1.昵称
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    // 2.正文
    self.retweetContentLabel.text = retReetStatus.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    // 3.配图
    if (retReetStatus.thumbnail_pic) { // 有配图
        self.retweetPhotoView.hidden = NO;
        [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retReetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
    }else { // 无配图
        self.retweetPhotoView.hidden = YES;
    }



}


@end
