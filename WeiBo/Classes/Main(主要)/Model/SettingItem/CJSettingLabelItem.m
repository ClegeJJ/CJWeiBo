//
//  CJSettingLabelItem.m
//  WeiBo
//
//  Created by mac527 on 15/10/4.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJSettingLabelItem.h"

@implementation CJSettingLabelItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title text:(NSString *)text
{
    
    CJSettingLabelItem *item =  [self itemWithIcon:icon title:title];
    item.text = text;
    return item;

}
+ (instancetype)itemWithTitle:(NSString *)title text:(NSString *)text
{
    return [self itemWithIcon:nil title:title text:text];
}


@end
