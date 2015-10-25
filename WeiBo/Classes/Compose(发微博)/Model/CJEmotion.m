//
//  CJEmotion.m
//  WeiBo
//
//  Created by mac527 on 15/9/22.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJEmotion.h"
#import "MJExtension.h"
@implementation CJEmotion

// 实现ancoding // encoding
MJCodingImplementation


/**
 *  从文件中解析对象时调用
 */
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    if (self = [super init]) {
//        self.chs = [decoder decodeObjectForKey:@"chs"];
//        self.png = [decoder decodeObjectForKey:@"png"];
//        self.code = [decoder decodeObjectForKey:@"code"];
//    }
//    return self;
//}
//
///**
// *  将对象写入文件的时候调用
// */
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.chs forKey:@"chs"];
//    [encoder encodeObject:self.png forKey:@"png"];
//    [encoder encodeObject:self.code forKey:@"code"];
//}


#warning - tips
/**
 *  比较两个对象的内存地址是否一致
    重写此方法 骗过操作系统
 */
- (BOOL)isEqual:(CJEmotion *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}


@end
