//
//  CJUserInfoParma.h
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJBaseParma.h"
/*
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 uid	false	int64	需要查询的用户ID。
 screen_name	false	string	需要查询的用户昵称。
 */
@interface CJUserInfoParma : CJBaseParma

/**
 *  需要查询的用户ID
 */
@property (nonatomic ,strong) NSNumber *uid;


@property (nonatomic ,copy) NSString *screen_name;
@end
