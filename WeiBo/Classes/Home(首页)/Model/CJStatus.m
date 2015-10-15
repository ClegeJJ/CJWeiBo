//
//  CJStatus.m
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "DateTools.h"
#import "CJStatus.h"
#import "MJExtension.h"
#import "CJPhoto.h"
#import "RegexKitLite.h"
#import "CJStatusContentPart.h"
@implementation CJStatus

/**
 *  重写set方法 根据普通文字 获取 给属性文字赋值
 */
- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5\\.]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    NSMutableArray *partArray = [NSMutableArray array];
    
    // 遍历所有特殊文字
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        CJStatusContentPart *part = [[CJStatusContentPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [partArray addObject:part];
        
    }];
    
    // 遍历所有非特殊文字
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        CJStatusContentPart *part = [[CJStatusContentPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [partArray addObject:part];
    }];
    
    [partArray sortedArrayUsingComparator:^NSComparisonResult(CJStatusContentPart *part1, CJStatusContentPart *part2) {
       
        return  part1.range.location > part2.range.location ? NSOrderedAscending : NSOrderedDescending;
        
    }];
    NSLog(@"%@",partArray);
    
#warning TODO
    
//    NSTextAttachment *attac = [[NSTextAttachment alloc] init];
//    attac.image = [UIImage imageNamed:@"d_aini"];
//    attac.bounds = CGRectMake(0, -4, 15, 15);
//    [attributedString insertAttributedString:[NSAttributedString attributedStringWithAttachment:attac] atIndex:0];
    
    //设置属性文字字体
    [attributedString addAttribute:NSFontAttributeName value:CJStatusContentFont range:NSMakeRange(0, text.length)];
    self.attributedString = attributedString;
    
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [CJPhoto class]};
}
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
    long jianLoc = [source rangeOfString:@">"].location;
    
    if (jianLoc == NSNotFound) {
        _source = source;
    }else{
        
        long loc = jianLoc + 1;
        long length = [source rangeOfString:@"</"].location - loc;
        source = [source substringWithRange:NSMakeRange(loc, length)];
        
        _source = [NSString stringWithFormat:@"来自%@", source];
    }

}

@end
