//
//  CJStatusCell.m
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusCell.h"
#import "CJStatus.h"
#import "CJUser.h"
#import "CJStatusFrame.h"
#import "UIImageView+WebCache.h"

@interface CJStatusCell()


/**
 *  顶部的View(原微博父控件)
 */
@property (nonatomic, weak) UIImageView *topView;
/**
 *  用户的昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  用户的头像
 */
@property (nonatomic, weak) UIImageView *iconView;
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
@property (nonatomic, weak) UIImageView *photoView;



/**
 *  被转发微博的View(被转发微博的父控件)
 */
@property (nonatomic, weak) UIImageView *retweetView;
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



/**
 *  微博的工具条(底部工具条父控件)
 */
@property (nonatomic, weak) UIImageView *statusTool;



@end

@implementation CJStatusCell



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Home_Cell";
    
    CJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[CJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [self setupStatusToolBar];
        
    }
    return self;
}
/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    /** 顶部的View(原微博父控件) */
    UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    /** 用户的昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 用户的头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /**  会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /**  微博发送的时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /**  微博的来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /**  微博的正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    /**  微博的配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    

}
/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews
{
    /** 被转发微博的View(被转发微博父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 被转发微博用户的昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /**  被转发微博的正文 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /**  被转发微博的配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}
/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    /**  微博的工具条(底部工具条父控件)*/
    UIImageView *statusTool = [[UIImageView alloc] init];
    [self.topView addSubview:statusTool];
    self.statusTool = statusTool;
}

- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    
    _statusFrame = statusFrame;
    

    // 1.原创微博
    [self setupOriginalData];
    
    // 2.被转发微博
    [self setupRetweetData];
}

- (void)setupOriginalData
{
    CJStatus *status = self.statusFrame.status;
    CJUser *user = status.user;
    
    /** 顶部的View(原微博父控件) */
    self.topView.frame = self.statusFrame.topViewF;
    
    /** 用户的昵称 */
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    self.nameLabel.font = CJStatusNameFont;
    
    /** 用户的头像 */
    self.iconView.frame = self.statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    /**  会员图标 */
    if (user.vip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:@"common_icon_membership"];
        self.vipView.frame = self.statusFrame.vipViewF;
    }else{
        self.vipView.hidden = YES;
    }
    
    
    /**  微博发送的时间 */
    self.timeLabel.font = CJStatusTimeFont;
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelF;
    
    /**  微博的来源 */
    self.sourceLabel.font = CJStatusSourceFont;
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    /**  微博的正文 */
    self.contentLabel.font = CJStatusContentFont;
    self.contentLabel.text = status.text;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    /**  微博的配图 */
    if (status.thumbnail_pic) { // 有配图
        self.photoView.hidden = NO;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        self.photoView.frame = self.statusFrame.photoViewF;
    }else { // 无配图
        self.photoView.hidden = YES;
    }
}

- (void)setupRetweetData
{
    CJStatus *retReetStatus = self.statusFrame.status.retweeted_status;
    CJUser *user = retReetStatus.user;

    
    if (retReetStatus) { // 有转发的微博
        
        // 1.父控件
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 2.昵称
        self.retweetNameLabel.text = user.name;
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        self.retweetNameLabel.font = CJRetweetStatusNameFont;
        
        // 3.正文
        self.retweetContentLabel.font = CJRetweetStatusContentFont;
        self.retweetContentLabel.text = retReetStatus.text;
        self.retweetContentLabel.numberOfLines = 0;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 4.配图
        if (retReetStatus.thumbnail_pic) { // 有配图
            self.retweetPhotoView.hidden = NO;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retReetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
        }else { // 无配图
            self.retweetPhotoView.hidden = YES;
        }
    } else{ // 无转发的微博
        self.retweetView.hidden = YES;
    }
}
@end
