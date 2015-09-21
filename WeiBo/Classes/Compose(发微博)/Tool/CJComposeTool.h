//
//  CJComposeTool.h
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJComposeParma.h"
#import "CJComposeResult.h"
@interface CJComposeTool : NSObject

/**
 *  发送一条文字微博
 *
 *  @param parameters 请求参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)composeWithParameters:(CJComposeParma *)params success:(void (^)(CJComposeResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一条有配图的微博
 *
 *  @param parameters 请求参数
 *  @param farmDatas  文件参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 *
 */
+ (void)composeWithparameters:(CJComposeParma *)params farmDatas:(NSArray *)farmDatas success:(void (^)(CJComposeResult *result))success failure:(void (^)(NSError *error))failure;

@end
