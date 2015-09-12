//
//  CJAccountTool.h
//  WeiBo
//
//  Created by mac527 on 15/9/12.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  帐号工具类

#import <Foundation/Foundation.h>
@class CJAccount;
@interface CJAccountTool : NSObject


+ (void)saveAccount:(CJAccount *)account;


+ (CJAccount *)account;


@end
