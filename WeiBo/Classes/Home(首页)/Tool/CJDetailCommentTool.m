//
//  CJDetailCommentTool.m
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJDetailCommentTool.h"
#import "CJNetTool.h"
#import "MJExtension.h"
#import "CJDetail.h"
@implementation CJDetailCommentTool
+ (void)detailCommentWithParam:(CJDetailCommentParam *)param success:(void (^)(CJDetailCommentResult *result))success failure:(void (^)(NSError *error))failure
{
    [CJNetTool getWithUrl:@"https://api.weibo.com/2/comments/show.json" parameters:param.keyValues success:^(id json) {
        if (success) {
            CJDetailCommentResult *result = [[CJDetailCommentResult alloc] init];
            
            result.comments = [CJDetail objectArrayWithKeyValuesArray:json];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
