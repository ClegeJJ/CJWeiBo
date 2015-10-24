//
//  CJHomeStatusesResult.m
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJHomeStatusesResult.h"
#import "MJExtension.h"
#import "CJStatus.h"
@implementation CJHomeStatusesResult

+ (NSDictionary *)objectClassInArray
{

    return @{@"statuses" : [CJStatus class]};

}
@end
