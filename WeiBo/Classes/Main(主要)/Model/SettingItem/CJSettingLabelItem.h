//
//  CJSettingLabelItem.h
//  WeiBo
//
//  Created by mac527 on 15/10/4.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJSettingItem.h"

@interface CJSettingLabelItem : CJSettingItem
/** 要展示的文字*/
@property (nonatomic, copy) NSString *text;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title text:(NSString *)text;
+ (instancetype)itemWithTitle:(NSString *)title text:(NSString *)text;

@end
