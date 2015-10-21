//
//  CJDetailCommentParam.h
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJBaseParma.h"
#warning id关键字需要处理!!!!!
@interface CJDetailCommentParam : CJBaseParma
/**
 *  需要查询的微博ID。
 */

@property (nonatomic ,strong) NSNumber *ID;
@end
