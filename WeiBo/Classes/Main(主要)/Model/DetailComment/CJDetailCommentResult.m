//
//  CJDetailCommentResult.m
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJDetailCommentResult.h"
#import "MJExtension.h"
#import "CJComment.h"
@implementation CJDetailCommentResult
+ (NSDictionary *)objectClassInArray
{
    
    return @{@"comments" : [CJComment class]};
    
}
@end
