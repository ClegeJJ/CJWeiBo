//
//  CJOAuthTool.h
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  授权工具类

#import <Foundation/Foundation.h>
#import "CJOAuthResult.h"
#import "CJOAuthParma.h"
@interface CJOAuthTool : NSObject
/**
 *  加载首页的微博数据
 *
 *  @param parameters 请求参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)oauthWithParam:(CJOAuthParma *)parma success:(void (^)(CJOAuthResult *result))success failure:(void (^)(NSError *error))failure;


@end
