//
//  CJUser.h
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  用户类  微博用户(发微博的作者)

#import <Foundation/Foundation.h>

@interface CJUser : NSObject

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  是否为vip
 */
@property (nonatomic, assign) int mbrank;
@end
