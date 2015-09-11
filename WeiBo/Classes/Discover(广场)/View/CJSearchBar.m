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
        
        [self setBackground:[UIImage resizedImageWithName:@"searchbar_textfield_background"]];
        
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        iconView.frame = CGRectMake(0, 0, 30, 30);
        iconView.contentMode = UIViewContentModeCenter;
        self.font = [UIFont systemFontOfSize:15];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSForegroundColorAttributeName] = [UIColor grayColor];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:dict];
        self.clearButtonMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
