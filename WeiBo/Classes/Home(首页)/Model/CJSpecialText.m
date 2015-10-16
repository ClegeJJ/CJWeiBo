//
//  CJSpecialText.m
//  WeiBo
//
//  Created by mac527 on 15/10/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  特殊文字

#import "CJSpecialText.h"

@implementation CJSpecialText
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
    
}
@end
