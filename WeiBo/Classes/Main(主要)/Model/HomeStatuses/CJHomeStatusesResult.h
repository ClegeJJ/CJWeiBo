//
//  CJHomeStatusesResult.h
//  WeiBo
//
//  Created by mac527 on 15/9/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>
//"previous_cursor": 0,                   // 暂未支持
//"next_cursor": 11488013766,    // 暂未支持
//"total_number": 81655
@interface CJHomeStatusesResult : NSObject

@property (nonatomic, assign ,getter=isDisk) BOOL disk;

@property (nonatomic ,strong) NSArray *statuses;


@property (nonatomic ,assign) int previous_cursor;


@property (nonatomic ,assign) long long next_cursor;


@property (nonatomic ,assign) long long total_number;
@end
