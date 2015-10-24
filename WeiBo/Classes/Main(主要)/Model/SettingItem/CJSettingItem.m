//
//  CJSettingItem.m
//  WeiBo
//
//  Created by mac527 on 15/10/4.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJSettingItem.h"

@implementation CJSettingItem

+ (instancetype)item
{
    
    return [[self alloc] init];

}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    CJSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{

    return [self itemWithIcon:nil title:title];
    
}

@end
