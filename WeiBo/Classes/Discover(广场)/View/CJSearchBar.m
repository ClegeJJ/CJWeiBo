//
//  CJSearchBar.m
//  WeiBo
//
//  Created by mac527 on 15/9/11.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJSearchBar.h"

@implementation CJSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景图片
        [self setBackground:[UIImage resizedImageWithName:@"searchbar_textfield_background"]];
        
        // 设置搜索图标
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        iconView.frame = CGRectMake(0, 0, 30, 30);
        iconView.contentMode = UIViewContentModeCenter;
        
        // 设置字体大小
        self.font = [UIFont systemFontOfSize:15];
        
        // 设置占位符
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSForegroundColorAttributeName] = [UIColor grayColor];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:dict];
        
        // 设置清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置returinKey
        self.returnKeyType = UIReturnKeySearch;
        
        // 有文字才能输入
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

@end
