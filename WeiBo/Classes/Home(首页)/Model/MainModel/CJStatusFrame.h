//
//  CJStatusFrame.h
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  Frame模型 




#import <Foundation/Foundation.h>
@class CJStatus;
@interface CJStatusFrame : NSObject

@property (nonatomic, strong) CJStatus *status;
/**
 *  顶部的View(原微博父控件)
 */
@property (nonatomic, assign, readonly) CGRect topViewF;
/**
 *  用户的昵称
 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/**
 *  用户的头像
 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/**
 *  会员图标
 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/**
 *  微博发送的时间
 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/**
 *  微博的来源
 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/**
 *  微博的正文
 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
/**
 *  微博的配图
 */
@property (nonatomic, assign, readonly) CGRect photosViewF;


/**
 *  被转发微博的View(被转发微博的父控件)
 */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/**
 *  被转发用户的昵称
 */
//@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/**
 *  被转发用户的正文
 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/**
 *  被转发微博的配图
 */
@property (nonatomic, assign, readonly) CGRect retweetPhotosViewF;
/**
 *  被转发微博的工具条
 */
@property (nonatomic, assign, readonly) CGRect retweetToolBarF;


/**
 *  微博的工具条(底部工具条父控件)
 */
@property (nonatomic, assign, readonly) CGRect statusToolF;

/** 
 *   cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;


@end
