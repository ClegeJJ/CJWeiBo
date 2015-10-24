//
//  CJDetailCommentTool.h
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  微博评论工具类

#import <Foundation/Foundation.h>
#import "CJDetailCommentParam.h"
#import "CJDetailCommentResult.h"
#import "CJDetailRepostParma.h"
#import "CJDetailRepostResult.h"
@interface CJDetailTool : NSObject

/**
 *  加载微博详情界面评论数据
 *
 *  @param parameters 请求参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)detailCommentWithParam:(CJDetailCommentParam *)param success:(void (^)(CJDetailCommentResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载微博详情界面转发数据
 *
 *  @param parameters 请求参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)detailRepostWithParam:(CJDetailRepostParma *)param success:(void (^)(CJDetailRepostResult *result))success failure:(void (^)(NSError *error))failure;
@end
