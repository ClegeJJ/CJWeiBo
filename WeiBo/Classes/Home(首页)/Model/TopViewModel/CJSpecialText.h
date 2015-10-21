//
//  CJSpecialText.h
//  WeiBo
//
//  Created by mac527 on 15/10/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJSpecialText : NSObject

/**
 *  特殊文字内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  特殊文字的范围
 */
@property (nonatomic, assign) NSRange range;

@end
