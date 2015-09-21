//
//  CJOAuthTool.m
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJOAuthTool.h"
#import "CJNetTool.h"
#import "MJExtension.h"
@implementation CJOAuthTool

+ (void)oauthWithParam:(CJOAuthParma *)parma success:(void (^)(CJOAuthResult *))success failure:(void (^)(NSError *))failure
{
    [CJNetTool postWithUrl:@"https://api.weibo.com/oauth2/access_token" parameters:parma.keyValues success:^(id json) {
        
        CJOAuthResult *result = [CJOAuthResult objectWithKeyValues:json];
        
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
