//
//  CJStatusTopView.m
//  WeiBo
//
//  Created by mac527 on 15/9/15.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusTopView.h"
#import "CJIconView.h"
#import "CJRetweetStatusView.h"
#import "CJStatus.h"
#import "CJUser.h"
#import "CJPhoto.h"
#import "CJStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "CJStatusPhotosView.h"
@interface CJStatusTopView()

/**
 *  字体属性字典
 */
@property (nonatomic, strong) NSMutableDictionary *dict;
/**
 *  用户的昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  用户的头像
 */
@property (nonatomic, weak) CJIconView *iconView;
/**
 *  会员图标
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  微博发送的时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  微博的来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  微博的正文
 */
@property (nonatomic, weak) UILabel *contentLabel;
/**
 *  微博的配图
 */
@property (nonatomic, weak) CJStatusPhotosView *photosView;


/**
 *  被转发微博的View(被转发微博的父控件)
 */
@property (nonatomic, weak) CJRetweetStatusView *retweetView;


@end

@implementation CJStatusTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 初始化字典
        _dict = [NSMutableDictionary dictionary];
        /** 用户的昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = CJStatusNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 用户的头像 */
        CJIconView *iconView = [[CJIconView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /**  会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /**  微博发送的时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = CJStatusTimeFont;
        timeLabel.textColor = CJColor(135, 135, 135);
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /**  微博的来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = [UIFont boldSystemFontOfSize:12];
        sourceLabel.textColor = CJColor(135, 135, 135);
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /**  微博的正文 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = CJStatusContentFont;
        contentLabel.textColor = CJColor(39, 39, 39);
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /**  微博的配图 */
        CJStatusPhotosView *photosView = [[CJStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        /** 被转发微博的View(被转发微博父控件) */
        CJRetweetStatusView *retweetView = [[CJRetweetStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}


/**
 *  拦截setter方法  设置内部子控件数据
 */
- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    CJStatus *status = self.statusFrame.status;
    CJUser *user = status.user;
    
    /** 用户的昵称 */
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    /** 用户的头像 */
    self.iconView.frame = self.statusFrame.iconViewF;
    self.iconView.user = user;
    
    /**  会员图标 */
    if (user.mbrank) {
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLabel.textColor = CJColor(240, 140, 19);
    }else{
        
        self.vipView.frame = self.statusFrame.vipViewF;
        self.vipView.image = [UIImage imageWithName:@"common_icon_membership_expired"];
    }
    
    /**  微博发送的时间 */
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF);
    _dict[NSFontAttributeName] = CJStatusTimeFont;
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:_dict];
    self.timeLabel.frame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    /**  微博的来源 */
    CGFloat sourceViewX = CGRectGetMaxX(self.timeLabel.frame) + CJStatusFrameBorder;
    CGFloat sourceViewY = timeLabelY;
    _dict[NSFontAttributeName] = CJStatusSourceFont;
    CGSize sourceViewSize = [status.source sizeWithAttributes:_dict];
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = (CGRect){{sourceViewX,sourceViewY},sourceViewSize};
    
    /**  微博的正文 */
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    /**  微博的配图 */
    if (status.pic_urls.count) { // 有配图
        self.photosView.hidden = NO;
        self.photosView.photos = status.pic_urls;
        self.photosView.frame = self.statusFrame.photosViewF;
    }else { // 无配图
        self.photosView.hidden = YES;
    }
    
    CJStatus *retReetStatus = self.statusFrame.status.retweeted_status;
    
    /** 设置被转发微博数据*/
    if (retReetStatus) { // 有转发的微博
        // 1.设置frame
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 2.传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
        
    } else{ // 无转发的微博
        self.retweetView.hidden = YES;
    }

}



@end
