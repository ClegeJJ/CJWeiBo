//
//  CJBaseParma.h
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  基本参数模型

#import <Foundation/Foundation.h>

@interface CJBaseParma : NSObject

/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
 */
@property (nonatomic ,copy) NSString *access_token;


+ (instancetype)parma;

@end
