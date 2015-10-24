//
//  CJRepostResult.m
//  WeiBo
//
//  Created by mac527 on 15/10/24.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJDetailRepostResult.h"
#import "MJExtension.h"
#import "CJStatus.h"
@implementation CJDetailRepostResult
- (NSDictionary *)objectClassInArray
{
    return @{@"reposts" : [CJStatus class]};
}
@end
