//
//  CJSettingGroup.h
//  WeiBo
//
//  Created by mac527 on 15/10/4.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJSettingGroup : NSObject

@property (nonatomic, copy) NSString *header;

@property (nonatomic, copy) NSString *footer;

@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;

@end
