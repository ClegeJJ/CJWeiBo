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
#import "CJUser.h"
#import "CJEmotionTool.h"
#import "CJSpecialText.h"
@implementation CJStatus



- (NSAttributedString *)attributedStringWithText:(NSString *)text;
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5\\.]+#";
    // url链接的规则
//    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *urlPattern = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    NSMutableArray *partArray = [NSMutableArray array];
    
    // 遍历所有特殊文字
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSLog(@"%@",*capturedStrings);
        CJStatusContentPart *part = [[CJStatusContentPart alloc] init];
        part.special = YES;
        part.emotion = [*capturedStrings hasPrefix:@"["] && [*capturedStrings hasSuffix:@"]"];
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
    
    // 数组内按照 CJStatusContentPart 模型 的 range.location 排序
    [partArray sortUsingComparator:^NSComparisonResult(CJStatusContentPart *part1, CJStatusContentPart *part2) {
        // part1>part2
        // part1放后面, part2放前面 (降序)
        return  part1.range.location > part2.range.location ? NSOrderedDescending : NSOrderedAscending;
        
    }];
    
    /***********************************************************************************************/
    
    // 根据字体 计算表情 图片 宽高
    UIFont *font = CJStatusContentFont;
    NSMutableArray *specialTexts = [NSMutableArray array];
    // 遍历数组 添加特殊属性~
    for (CJStatusContentPart *part in partArray) {
        // 等会需要拼接的子串
        NSAttributedString *subStr = nil;
        if (part.isEmotion) { // 表情
            NSTextAttachment *attac = [[NSTextAttachment alloc] init];
            UIImage *image = [CJEmotionTool emotionWithChs:part.text];
            if (image == nil) { // 表情库中 找不到对应的表情
                subStr = [[NSMutableAttributedString alloc] initWithString:part.text];
            }else { // 表情库中 找到了对应的表情
                attac.image = image;
                attac.bounds = CGRectMake(0, -4, font.lineHeight, font.lineHeight);
                subStr = [NSAttributedString attributedStringWithAttachment:attac];
            }
        } else if (part.isSpecial){ // 特殊文字
            subStr = [[NSMutableAttributedString alloc] initWithString:part.text
                                                            attributes:@{
                                                                         NSForegroundColorAttributeName :
                                                                        [UIColor redColor]
                                                                         }];
            CJSpecialText *special = [[CJSpecialText alloc] init];
            special.text = part.text;
            NSUInteger lenth = part.text.length;
            NSUInteger loc = attributedString.length;
            special.range = NSMakeRange(loc, lenth);
            [specialTexts addObject:special];
        }else { // 普通文字
            subStr = [[NSMutableAttributedString alloc] initWithString:part.text];
        }
        // 拼接属性自负
        [attributedString  appendAttributedString:subStr];
    }
    //设置属性文字字体
    [attributedString addAttribute:NSFontAttributeName value:CJStatusContentFont range:NSMakeRange(0, attributedString.length)];
    
    //
    [attributedString addAttribute:@"special" value:specialTexts range:NSMakeRange(0, 1)];
    
    return attributedString;
}


/**
 *  重写set方法 根据普通文字 获取 给属性文字赋值
 */
- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    // 利用text 生成对应的 attributedSting
    self.attributedString = [self attributedStringWithText:text];

}

- (void)setRetweeted_status:(CJStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    // 拼接用户名
    NSString *contentText = [NSString stringWithFormat:@"@%@ : %@",retweeted_status.user.name, retweeted_status.text];
    
    // 利用text 生成对应的 attributedSting
    retweeted_status.retweetedAttributedSting = [self attributedStringWithText:contentText];
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
