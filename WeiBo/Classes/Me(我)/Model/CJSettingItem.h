//
//  CJSettingItem.h
//  WeiBo
//
//  Created by mac527 on 15/10/4.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CJSettingItemOpreation)();


@interface CJSettingItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic, copy) CJSettingItemOpreation opreation;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)item;
@end
