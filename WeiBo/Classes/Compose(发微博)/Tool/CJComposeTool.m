//
//  CJComposeTool.m
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJComposeTool.h"
#import "CJNetTool.h"
#import "MJExtension.h"
@implementation CJComposeTool


+(void)composeWithParameters:(CJComposeParma *)params success:(void (^)(CJComposeResult *))success failure:(void (^)(NSError *))failure
{
    [CJNetTool postWithUrl:@"https://api.weibo.com/2/statuses/update.json" parameters:params.keyValues success:^(id json) {
        
        CJComposeResult *result = [CJComposeResult objectWithKeyValues:json];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];


}


+ (void)composeWithparameters:(CJComposeParma *)params farmDatas:(NSArray *)farmDatas success:(void (^)(CJComposeResult *))success failure:(void (^)(NSError *))failure
{
    [CJNetTool postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params.keyValues farmDatas:farmDatas success:^(id json) {
        
        CJComposeResult *result = [CJComposeResult objectWithKeyValues:json];
        if (success) {
            success(result);
        }
        
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];



}
@end
