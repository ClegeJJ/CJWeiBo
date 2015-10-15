//
//  CJStatusContentPart.m
//  WeiBo
//
//  Created by mac527 on 15/10/14.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusContentPart.h"

@implementation CJStatusContentPart
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
//    return [NSString stringWithFormat:@"%@----%ld",self.text,self.range.location];
    
}
@end
