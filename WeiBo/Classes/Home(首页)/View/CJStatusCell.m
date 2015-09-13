//
//  CJStatusCell.m
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusCell.h"

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


@end
