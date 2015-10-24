//
//  CJStatusContentPart.h
//  WeiBo
//
//  Created by mac527 on 15/10/14.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  微博正文的一部分

#import <Foundation/Foundation.h>

@interface CJStatusContentPart : NSObject
/**
 *  这段文字的内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  这段文字的范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  是否是特殊文字
 */
@property (nonatomic, assign, getter = isSpecial) BOOL special;

/**
 *  是否是表情
 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;
@end
