//
//  CJDetailCommentTool.m
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJDetailTool.h"
#import "CJNetTool.h"
#import "MJExtension.h"
#import "CJComment.h"
@implementation CJDetailTool
+ (void)detailCommentWithParam:(CJDetailCommentParam *)param success:(void (^)(CJDetailCommentResult *result))success failure:(void (^)(NSError *error))failure
{
    [CJNetTool getWithUrl:@"https://api.weibo.com/2/comments/show.json" parameters:param.keyValues success:^(id json) {
        if (success) {
            CJDetailCommentResult *result = [[CJDetailCommentResult alloc] init];
            result = [CJDetailCommentResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)detailRepostWithParam:(CJDetailRepostParma *)param success:(void (^)(CJDetailRepostResult *result))success failure:(void (^)(NSError *error))failure
{
    [CJNetTool getWithUrl:@"https://api.weibo.com/2/statuses/repost_timeline.json" parameters:param.keyValues success:^(id json) {
        if (success) {
            CJDetailRepostResult *result = [[CJDetailRepostResult alloc] init];
            result = [CJDetailRepostResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
