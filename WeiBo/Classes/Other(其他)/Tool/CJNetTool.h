//
//  CJNetTool.h
//  WeiBo
//
//  Created by mac527 on 15/9/19.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  发送网络请求工具

#import <Foundation/Foundation.h>

@interface CJNetTool : NSObject

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一个POST请求
 *
 *  @param url        请求路径
 *  @param parameters 请求参数
 *  @param farmDatas  文件参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters farmDatas:(NSArray *)farmDatas success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一个GET请求
 *
 *  @param url        请求路径
 *  @param parameters 请求参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)getWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
