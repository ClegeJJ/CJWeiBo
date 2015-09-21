//
//  CJUserInfoTool.h
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJUserInfoParma.h"
#import "CJUserInfoResult.h"
@interface CJUserInfoTool : NSObject

/**
 *  获取用户个人信息
 *
 *  @param parameters 参数
 *  @param success    成功时回掉
 *  @param failure    失败时回掉
 */
+ (void)UserInfoWithParameters:(CJUserInfoParma *)parameters success:(void (^)(CJUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

@end
