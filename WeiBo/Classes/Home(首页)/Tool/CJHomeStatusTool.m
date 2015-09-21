//
//  CJHomeStatusTool.m
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJHomeStatusTool.h"
#import "CJNetTool.h"
#import "MJExtension.h"
@implementation CJHomeStatusTool


+ (void)HomeStatusWithParameters:(CJHomeStatusesParam *)parameters success:(void (^)(CJHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure
{

    [CJNetTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameters.keyValues success:^(id json) {
        if (success) {
            
            CJHomeStatusesResult *result = [CJHomeStatusesResult objectWithKeyValues:json];
            
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
