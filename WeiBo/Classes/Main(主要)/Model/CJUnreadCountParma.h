//
//  CJUnreadCountParma.h
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJBaseParma.h"

@interface CJUnreadCountParma : CJBaseParma
/**
 *  需要获取消息未读数的用户UID，必须是当前登录用户
 */
@property (nonatomic , strong) NSNumber *uid;

@end
