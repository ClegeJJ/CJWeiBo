//
//  CJUser.h
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  用户类  微博用户(发微博的作者)

#import <Foundation/Foundation.h>

typedef enum {
    CJUserVerifiedTypeNone = -1, // 没有任何认证
    
    CJUserVerifiedPersonal = 0,  // 个人认证
    
    CJUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    CJUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    CJUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    CJUserVerifiedDaren = 220 // 微博达人
} CJUserVerifiedType;

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
/**
 *  认证类型
 */
@property (nonatomic, assign) CJUserVerifiedType verified_type;


@end
