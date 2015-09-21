//
//  CJBaseParma.m
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJBaseParma.h"
#import "CJAccount.h"
#import "CJAccountTool.h"

@implementation CJBaseParma

/**
 *  创建出就有access_token
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.access_token = [CJAccountTool account].access_token;
    }
    return self;
}



+ (instancetype)parma
{

    return [[self alloc] init];

}

@end
