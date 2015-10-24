//
//  CJHomeStatusesParam.h
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJBaseParma.h"


@interface CJHomeStatusesParam : CJBaseParma

/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
 */
@property (nonatomic ,strong) NSNumber *since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0
 */
@property (nonatomic ,strong) NSNumber *max_id;
/**
 *  单页返回的记录条数，最大不超过100，默认为20
 */
@property (nonatomic ,strong) NSNumber *count;

@end
