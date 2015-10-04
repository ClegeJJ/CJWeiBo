//
//  CJStatusCacheTool.h
//  WeiBo
//
//  Created by mac527 on 15/10/4.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CJHomeStatusesParam;
@interface CJStatusCacheTool : NSObject

/**
 *  通过字典添加一条微博
 *
 *  @param dict 字典
 */
+ (void)addStatusWithDict:(NSDictionary *)dict;

/**
 *  通过数组添加多条微博数据
 *
 *  @param array 微博数组
 */
+ (void)addStatusesWithArray:(NSArray *)array;


/**
 *  根据请求参数读取微博数据
 *
 *  @param param 微博参数
 *
 *  @return 微博数组
 */
+ (NSArray *)statuesWithParam:(CJHomeStatusesParam *)param;


@end
