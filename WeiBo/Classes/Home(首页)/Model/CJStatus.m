//
//  CJStatus.m
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "DateTools.h"
#import "CJStatus.h"

@implementation CJStatus
/**
 *  get方法截取时间字符串
 */
- (NSString *)created_at
{
    // 1.获得微博的发送时间

    //    fmt.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
    [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *createdDate = [fmt dateFromString:_created_at];

    if (createdDate.timeIntervalSinceNow > -60) {
        return @"刚刚";
    }else{
        return createdDate.timeAgoSinceNow;
    }
    

}


/**
 *  截取来源字符串
 */
- (void)setSource:(NSString *)source
{
    long loc = [source rangeOfString:@">"].location + 1;
    long length = [source rangeOfString:@"</"].location - loc;
    source = [source substringWithRange:NSMakeRange(loc, length)];
    
    _source = [NSString stringWithFormat:@"来自%@", source];
}

@end
