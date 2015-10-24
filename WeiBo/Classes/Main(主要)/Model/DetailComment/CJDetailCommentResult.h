//
//  CJDetailCommentResult.h
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJDetailCommentResult : NSObject

/** 评论模型 */
@property (nonatomic ,strong) NSArray *comments;

/** 评论总数 */
@property (nonatomic, assign) int total_number;
@end
