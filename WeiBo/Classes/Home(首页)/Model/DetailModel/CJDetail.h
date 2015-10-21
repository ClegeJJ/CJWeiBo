//
//  CJDetail.h
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CJUser;
@interface CJDetail : NSObject
/**
 *  评论的发送时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  评论的正文
 */
@property (nonatomic, copy) NSString *text;
/**
 *  评论的作者
 */
@property (nonatomic, strong) CJUser *user;
@end
