//
//  CJNetTool.h
//  WeiBo
//
//  Created by mac527 on 15/9/19.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  发送网络请求工具

#import <Foundation/Foundation.h>

@interface CJNetTool : NSObject
+ (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+ (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters farmDatas:(NSArray *)farmDatas success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


+ (void)getWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
