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
#import "CJStatusCacheTool.h"
#import "CJStatus.h"
@implementation CJHomeStatusTool


+ (void)HomeStatusWithParameters:(CJHomeStatusesParam *)parameters success:(void (^)(CJHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure
{
    NSArray *dictArray = [CJStatusCacheTool statuesWithParam:parameters];
    
    if (dictArray.count) { // 有缓存数据
        
        if (success) {
            
            CJHomeStatusesResult *result = [[CJHomeStatusesResult alloc] init];
            
            result.statuses = [CJStatus objectArrayWithKeyValuesArray:dictArray];
            
            success(result);
        }
    } else{
    
        [CJNetTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameters.keyValues success:^(id json) {
            
            if (success) {
                NSArray *dictArray = json[@"statuses"];
                [CJStatusCacheTool addStatusesWithArray:dictArray];

                CJHomeStatusesResult *result = [CJHomeStatusesResult objectWithKeyValues:json];
                
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }


}

@end
