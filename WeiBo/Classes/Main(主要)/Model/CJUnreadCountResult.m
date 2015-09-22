//
//  CJUnreadCountResult.m
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJUnreadCountResult.h"

@implementation CJUnreadCountResult
- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

- (int)count
{
    return self.messageCount + self.status + self.follower;
}
@end
