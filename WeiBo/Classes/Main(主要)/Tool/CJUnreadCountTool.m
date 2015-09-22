//
//  CJUnreadCountTool.m
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJUnreadCountTool.h"
#import "MJExtension.h"
#import "CJNetTool.h"
@implementation CJUnreadCountTool

+ (void)unreadCountWithParam:(CJUnreadCountParma *)parma success:(void (^)(CJUnreadCountResult *))success failure:(void (^)(NSError *))failure
{

    [CJNetTool getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parma.keyValues success:^(id json) {
        CJUnreadCountResult *result = [CJUnreadCountResult objectWithKeyValues:json];
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
