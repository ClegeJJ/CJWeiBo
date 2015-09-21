//
//  CJUserInfoTool.m
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJUserInfoTool.h"
#import "CJNetTool.h"
#import "MJExtension.h"
@implementation CJUserInfoTool

+ (void)UserInfoWithParameters:(CJUserInfoParma *)parameters success:(void (^)(CJUserInfoResult *))success failure:(void (^)(NSError *))failure
{

    // 发送GET请求 获取微博数据
    [CJNetTool getWithUrl:@"https://api.weibo.com/2/users/show.json" parameters:parameters.keyValues success:^(id json) {
        if (success) {
            CJUserInfoResult *result = [CJUserInfoResult objectWithKeyValues:json];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];



}

@end
