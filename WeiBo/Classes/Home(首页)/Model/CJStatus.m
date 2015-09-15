//
//  CJStatus.m
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//
#import "NSDate+MJ.h"

#import "CJStatus.h"

@implementation CJStatus
/**
 *  get方法截取时间字符串
 */
- (NSString *)created_at
{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得微博的发送时间
//    NSString *time = @"Fri May 09 16:30:34 +0800 2014";
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    [fmt setLocale:[[NSLocale currentLocale] initWithLocaleIdentifier:@"en_US"]];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
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
