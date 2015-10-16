//
//  CJStatus.h
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  微博模型(一个IWStatus对象就代表一条微博)

#import <Foundation/Foundation.h>
@class CJUser;



@interface CJStatus : NSObject


/**
 *  微博的发送时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的正文
 */
@property (nonatomic, copy) NSString *text;

/**
 *  微博的正文(带有属性文字的正文)
 */
@property (nonatomic, copy) NSAttributedString *attributedString;

/**
 *  微博的配图
 */
@property (nonatomic, strong) NSArray *pic_urls;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  微博的作者
 */
@property (nonatomic, strong) CJUser *user;
/**
 *  被转发的微博
 */
@property (nonatomic, strong) CJStatus *retweeted_status;
/**
 *  被转发的微博的正文
 */
@property (nonatomic, copy) NSAttributedString *retweetedAttributedSting;

@end
/*
 {
 "created_at": "Tue May 31 17:46:55 +0800 2011",
 "id": 11488058246,
 "text": "求关注。"，
 "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
 "reposts_count": 8,
 "comments_count": 9,
 "user": {
         "id": 1404376560,
         "name": "zaku",
         "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
         }
 }
 
*/