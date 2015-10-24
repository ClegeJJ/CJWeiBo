//
//  CJRepostResult.h
//  WeiBo
//
//  Created by mac527 on 15/10/24.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJDetailRepostResult : NSObject
/** 转发数组 */
@property (nonatomic, strong) NSArray *reposts;
/** 转发总数 */
@property (nonatomic, assign) int total_number;
@end
